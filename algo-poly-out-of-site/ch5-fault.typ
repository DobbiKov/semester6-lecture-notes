#import "preamble.typ": *

= Tolérance aux pannes

Tout système distribué réel est soumis à des défaillances : un processus peut s'arrêter inopinément, un lien réseau peut perdre des paquets, ou un composant peut adopter un comportement erroné. La *tolérance aux pannes* désigne la capacité d'un système à continuer de fonctionner correctement — ou du moins à dégrader gracieusement son service — en présence de telles défaillances.

La question centrale est la suivante : combien de processus défaillants un système distribué peut-il tolérer tout en continuant à garantir ses propriétés ? La réponse dépend crucialement du *modèle de panne* adopté. Ce chapitre présente une hiérarchie de modèles de pannes, de la plus bénigne à la plus sévère, ainsi que les techniques de redondance permettant de les tolérer.

== Types de pannes

Les modèles de pannes forment une *hiérarchie d'inclusion* : les pannes les plus graves englobent les moins graves. Un algorithme conçu pour tolérer des pannes byzantines tolère automatiquement les pannes par omission et par crash.

#figure(
  include "figures/fault-types.typ",
  caption: [Hiérarchie des modèles de pannes. Chaque région englobe la précédente. Les seuils de tolérance indiqués donnent le nombre minimal de processus corrects nécessaires.]
)

=== Pannes par crash

La panne par crash est le modèle le plus simple et le plus étudié. Un processus qui tombe en panne par crash cesse immédiatement d'envoyer et de recevoir des messages, et ne reprend jamais son exécution (dans le modèle sans recouvrement). L'absence de messages peut être interprétée comme un signal de panne, ce qui rend ce type de défaillance relativement facile à gérer.

#defn(info: "Panne par crash (arrêt franc)")[
  Un processus $P_i$ subit une *panne par crash* si, à partir d'un certain instant $t$, $P_i$ n'envoie plus aucun message et ne traite plus aucun message reçu. Les messages envoyés avant $t$ peuvent avoir été ou non reçus par leurs destinataires.
]

Dans un système asynchrone pur, il est impossible de distinguer un processus en panne par crash d'un processus simplement lent. C'est pourquoi les détecteurs de pannes (basés sur des timeouts) sont souvent utilisés pour approximer cette distinction, au prix d'une possible erreur.

=== Pannes par omission

Une panne par omission est plus subtile : le processus continue d'exécuter son code, mais perd parfois des messages à l'émission ou à la réception. Un processus défaillant par omission *semble vivant* mais est peu fiable.

#defn(info: "Panne par omission")[
  Un processus $P_i$ subit une *panne par omission* s'il omet d'envoyer ou de recevoir certains messages. On distingue :
  - *Omission à l'émission* : $P_i$ devrait envoyer un message mais ne le fait pas.
  - *Omission à la réception* : $P_i$ devrait recevoir un message mais ne le traite pas.
  - *Omission générale* : les deux types peuvent se produire.

  Toute panne par crash est un cas particulier de panne par omission (toutes les émissions et réceptions sont omises à partir d'un certain moment).
]

Les pannes par omission modélisent notamment les pertes de paquets dans des réseaux non fiables, les tampons d'émission saturés, ou les problèmes transitoires de connectivité.

=== Pannes byzantines

Les pannes byzantines, introduites par Lamport, Shostak et Pease, représentent le cas le plus général et le plus difficile. Un processus byzantin peut se comporter de manière totalement arbitraire : envoyer des valeurs incorrectes, envoyer des valeurs différentes à des destinataires différents, ou se coordonner avec d'autres processus défaillants pour tromper les processus corrects.

#defn(info: "Panne byzantine (faute arbitraire)")[
  Un processus $P_i$ subit une *panne byzantine* s'il s'écarte arbitrairement de son comportement spécifié. Formellement, un processus byzantin peut :
  - envoyer des messages avec des valeurs incorrectes,
  - envoyer des messages différents à différents processus pour la même étape du protocole,
  - ne pas envoyer de messages qu'il devrait envoyer,
  - envoyer des messages non prévus par le protocole,
  - se coordonner avec d'autres processus défaillants.
]

#thm(info: "Hiérarchie des modèles de pannes")[
  Les ensembles de comportements de pannes satisfont :
  $ "Crash" subset "Omission" subset "Byzantin" $
  Cette inclusion est stricte : il existe des comportements d'omission qui ne sont pas des crashes (processus vivant mais perdant des messages), et des comportements byzantins qui ne sont pas des omissions (envoi de valeurs fausses).
]

=== Seuils de tolérance

Le nombre de processus défaillants qu'un système peut tolérer tout en garantissant ses propriétés dépend du modèle de panne et de la propriété souhaitée.

#thm(info: "Seuils minimaux de tolérance aux pannes")[
  Pour un système distribué de $n$ processus devant tolérer $f$ processus défaillants :

  - *Tolérance aux crashes* : il suffit de $n >= f + 1$ processus (mais la disponibilité nécessite souvent $n >= 2f + 1$ pour permettre la prise de décision majoritaire).

  - *Tolérance aux pannes byzantines* : il est nécessaire et suffisant d'avoir $n >= 3f + 1$ processus. Avec $n <= 3f$ processus, il n'existe *aucun* protocole capable de garantir l'accord en présence de $f$ processus byzantins.
]

La borne $n >= 3f + 1$ pour les pannes byzantines est fondamentale. Son intuition est la suivante : un groupe de $f$ processus byzantins peut se faire passer pour $f$ processus corrects tout en envoyant des informations contradictoires aux $n - f$ processus restants. Pour que ces derniers puissent se mettre d'accord malgré tout, il faut que le groupe des corrects soit suffisamment grand ($n - f > 2f$, soit $n > 3f$).

#fact(info: "Impossibilité avec n ≤ 3f")[
  Si $n <= 3f$, il n'existe pas de protocole d'accord distribué (consensus, broadcast fiable, etc.) tolérant $f$ pannes byzantines. Ce résultat est prouvé par un argument de partition : les $f$ processus byzantins peuvent partitionner les processus corrects en deux groupes qui reçoivent des informations incompatibles, sans que les corrects puissent les distinguer des byzantins.
]

== Redondance et réplication

Face aux pannes, la technique fondamentale est la *redondance* : maintenir plusieurs copies (répliques) de l'état et de la logique de traitement, de sorte qu'une panne isolée ne compromette pas l'ensemble du système. Deux grandes stratégies de réplication existent.

=== Réplication active

Dans la réplication active, *toutes* les répliques traitent chaque requête et maintiennent le même état. Les clients envoient leurs requêtes à toutes les répliques, et une décision de majorité est prise sur les réponses. Cette approche garantit une disponibilité maximale mais génère un trafic important.

#algo("Réplication active")[
  *Structure* : $n$ répliques $R_1, dots, R_n$ maintenant le même état.

  *Traitement d'une requête $q$ du client* :
  + Le client diffuse $q$ à toutes les répliques.
  + Chaque réplique $R_i$ exécute $q$ et répond avec son résultat $v_i$.
  + Le client attend $f+1$ réponses identiques et retient la valeur majoritaire.

  *Propriété* : si au plus $f$ répliques sont défaillantes (pannes byzantines), le client obtient la bonne réponse dès lors que $n >= 3f + 1$.
]

#rmk[
  La réplication active requiert que toutes les répliques traitent les requêtes dans le *même ordre total*. Garantir cet ordre est lui-même un problème non trivial, résolu par des protocoles de *diffusion atomique* (voir le chapitre sur le consensus).
]

=== Réplication passive (primaire-sauvegarde)

Dans la réplication passive, une seule réplique — le *primaire* — traite activement les requêtes. Les autres répliques (*sauvegardes*) reçoivent périodiquement l'état du primaire (points de reprise ou *checkpoints*). En cas de panne du primaire, une sauvegarde prend le relais.

#algo("Réplication passive (primaire-sauvegarde)")[
  *Structure* : 1 primaire $P$ et $k$ sauvegardes $S_1, dots, S_k$.

  *Traitement normal* :
  + Le client envoie sa requête au primaire $P$.
  + $P$ traite la requête, met à jour son état, diffuse un *checkpoint* aux sauvegardes.
  + $P$ répond au client après confirmation des sauvegardes.

  *Détection de panne du primaire* :
  + Les sauvegardes détectent la panne de $P$ (timeout).
  + Élire une nouvelle sauvegarde comme primaire (par un protocole d'élection).
  + Le nouveau primaire reprend à partir du dernier checkpoint.
  + Notifier les clients de la nouvelle adresse du primaire.
]

#rmk[
  La réplication passive génère moins de trafic que la réplication active (les sauvegardes ne traitent pas les requêtes). En contrepartie, le temps de reprise après panne peut être non négligeable (durée de l'élection + application des mises à jour manquantes depuis le dernier checkpoint). Elle tolère bien les pannes par crash mais est inadaptée aux pannes byzantines (le primaire peut envoyer des checkpoints falsifiés).
]

=== Synchronisation après recouvrement

Un nœud qui se remet d'une panne doit *resynchroniser* son état avec les nœuds corrects avant de reprendre sa participation normale au protocole. Cette phase de récupération est délicate :

#algo("Protocole de resynchronisation")[
  *Nœud $P_i$ en cours de recouvrement* :
  + Annoncer son redémarrage aux autres nœuds.
  + Demander l'état courant à un sous-ensemble de nœuds corrects.
  + Vérifier la cohérence des réponses reçues (vote majoritaire si nécessaire).
  + Appliquer les mises à jour manquantes depuis le dernier état connu.
  + Rejoindre le protocole normal.
]

#rmk[
  Le contexte du théorème CAP (Cohérence, Disponibilité, Tolérance aux Partitions) est pertinent ici : dans un système distribué sujet aux partitions réseau, il est impossible de garantir simultanément la cohérence forte et la disponibilité totale. La tolérance aux pannes impose donc des compromis, formalisés dans la pratique par des niveaux de cohérence variés (cohérence finale, lecture de ma propre écriture, etc.).
]

== Récapitulatif

Les différents modèles de pannes imposent des contraintes croissantes sur les algorithmes distribués. Tolérer des pannes byzantines est significativement plus coûteux que tolérer des crashes, tant en termes de nombre de processus nécessaires ($3f+1$ contre $2f+1$) qu'en termes de complexité des protocoles. En pratique, les systèmes choisissent leur modèle de panne en fonction des menaces réelles : les pannes par crash suffisent dans un datacenter de confiance, tandis que les pannes byzantines sont nécessaires pour des systèmes ouverts ou adversariaux (blockchain, etc.).

#insight(info: "Redondance et disponibilité")[
  La redondance est le seul mécanisme universel de tolérance aux pannes. Plus le modèle de panne est sévère, plus la redondance requise est importante. Cependant, la redondance introduit de nouveaux défis : cohérence des répliques, synchronisation après recouvrement, et gestion des partitions réseau. La conception d'un système tolérant aux pannes consiste essentiellement à trouver le bon équilibre entre redondance, performance et complexité.
]
