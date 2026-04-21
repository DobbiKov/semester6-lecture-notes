#import "preamble.typ": *

= Consensus et tolérance byzantine

Le *consensus* est le problème le plus fondamental de l'algorithmique distribuée
tolérante aux fautes. Son énoncé est d'une simplicité trompeuse : plusieurs processus
démarrent chacun avec une valeur initiale, et ils doivent tous se mettre d'accord sur une
même valeur finale. Cette tâche banale dans un système centralisé devient extraordinairement
difficile dès que certains composants peuvent tomber en panne — qu'il s'agisse d'arrêts
simples (_crash failures_) ou de comportements malveillants (_Byzantine failures_).

Les résultats présentés dans ce chapitre forment le cœur théorique des systèmes
distribués tolérants aux fautes. Nous verrons d'abord la définition formelle du consensus
et ses exigences précises, puis le célèbre problème des généraux byzantins, avant
d'établir l'impossibilité fondamentale de Fischer, Lynch et Paterson (FLP) dans les
systèmes asynchrones. Nous terminerons par l'algorithme Flood-Set, qui montre que le
consensus est soluble dans les systèmes synchrones.

== Le problème du consensus

Formellement, le problème du consensus implique $n$ processus $P_1, P_2, dots, P_n$,
chacun possédant une valeur initiale $v_i in {0, 1}$ (ou plus généralement dans un
domaine $V$). Les processus communiquent par échange de messages, et l'objectif est
que chaque processus finisse par *décider* (_decide_) une valeur, de sorte que toutes
les décisions soient identiques et reflètent les entrées initiales.

#defn(info: "Problème du consensus")[
  Un algorithme de consensus doit satisfaire les trois propriétés suivantes pour tous les
  processus *corrects* (non défaillants) :

  + *Accord (_Agreement_).* Deux processus corrects quelconques décident la même valeur :
    si $P_i$ décide $d_i$ et $P_j$ décide $d_j$, alors $d_i = d_j$.

  + *Validité (_Validity_).* La valeur décidée est la valeur initiale de l'un des
    processus corrects. En particulier, si tous les processus corrects ont la même valeur
    initiale $v$, ils doivent décider $v$.

  + *Terminaison (_Termination_).* Tout processus correct décide en un temps fini.
]

Ces trois propriétés semblent raisonnables, voire minimales. La propriété d'accord
garantit l'*utilité* du consensus : tous les processus coordonnés aboutissent au même
résultat. La propriété de validité empêche les solutions triviales — un algorithme qui
décide toujours $0$ satisferait l'accord, mais violerait la validité si les entrées
sont toutes égales à $1$. La terminaison assure que l'algorithme progresse effectivement.

#rmk[
  La difficulté fondamentale vient de la combinaison de ces trois propriétés face aux
  pannes. En leur absence, le consensus est trivial : chaque processus diffuse sa valeur,
  collecte toutes les valeurs, et prend le minimum. En présence de pannes, certains
  processus peuvent ne jamais répondre. Comment distinguer un processus lent d'un processus
  tombé ? Dans un système asynchrone, cette distinction est impossible — c'est précisément
  ce qu'exploite le résultat d'impossibilité FLP.
]

== Problème des généraux byzantins

Le modèle de panne le plus général — et le plus dangereux — est la *faute byzantine*.
Un processus byzantin peut se comporter de manière arbitraire : il peut envoyer des
messages contradictoires à des processus différents, envoyer des messages contenant des
valeurs erronées, ou ne rien envoyer du tout. Ce modèle a été introduit par Lamport,
Shostak et Pease (1982) sous la métaphore militaire des généraux byzantins : des généraux
d'une armée doivent se coordonner pour attaquer ou se retirer, mais certains d'entre eux
sont des traîtres qui cherchent à empêcher l'accord.

#defn(info: "Faute byzantine")[
  Un processus est dit *byzantin* (ou *défaillant de manière arbitraire*) s'il peut
  s'écarter arbitrairement de son comportement spécifié. Un processus byzantin peut :
  envoyer des messages avec des contenus erronés, envoyer des messages différents à des
  destinataires différents pour le même événement, retarder ou omettre des messages, ou
  encore se coordonner avec d'autres processus byzantins pour compromettre le système.
]

Le résultat central sur le consensus byzantin est une condition nécessaire et suffisante
sur le nombre de processus.

#thm(info: "Condition nécessaire et suffisante — Lamport-Shostak-Pease (1982)")[
  Dans un système de $n$ processus dont au plus $f$ sont byzantins, le consensus
  byzantin est *soluble* si et seulement si

  $ n gt.eq 3f + 1. $
]

La preuve de ce théorème comporte deux parties : la borne inférieure (impossibilité
pour $n lt.eq 3f$) et la borne supérieure (existence d'un protocole pour $n gt.eq 3f+1$).

*Borne inférieure : impossibilité pour $n = 3f$.*

Supposons $n = 3f$ processus divisés en trois groupes $A$, $B$, $C$ de taille $f$ chacun.
Supposons que le groupe $C$ est byzantin. Voici le nœud de l'argument : du point de vue
des processus de $A$, le groupe $C$ byzantin peut se faire passer pour un groupe honnête
ayant une valeur différente de celle que $C$ présente à $B$. Plus précisément :

- $C$ envoie « $v_C = 1$ » aux processus de $A$ et $B$.
- $C$ envoie « $v_C = 0$ » aux processus de $D$ (dans une variante à 4 processus).

Les processus de $A$ et $B$ ne peuvent pas distinguer ce scénario d'un scénario où $C$
est honnête et a réellement la valeur que $C$ leur a communiquée. Avec seulement $f$
processus dans chaque groupe, il est impossible de former une majorité fiable pour
démasquer les traîtres. On peut construire formellement une contradiction : si un
algorithme tolère $f$ fautes byzantines avec $n = 3f$, on peut trouver deux exécutions
indiscernables par certains processus mais où ces processus doivent décider des valeurs
différentes pour satisfaire validité et accord — une contradiction.

*Borne supérieure : protocole avec $f+1$ tours pour $n gt.eq 3f+1$.*

Pour $n gt.eq 3f+1$, il existe des protocoles qui atteignent le consensus byzantin.
L'idée générale est de faire tourner $f+1$ rounds d'échange d'informations : dans chaque
round, chaque processus diffuse toutes les valeurs qu'il a collectées jusqu'alors.
Après $f+1$ rounds, les processus corrects ont suffisamment de redondance pour distinguer
les informations cohérentes (venant de processus corrects) des informations incohérentes
(venant de processus byzantins), et peuvent appliquer un vote majoritaire.

#ex(info: "Cas n=4, f=1")[
  Considérons $n = 4$ processus : $A$, $B$, $D$ (honnêtes, avec $v = 1$) et $C$
  (byzantin). $C$ envoie « 1 » à $A$ et $B$, mais envoie « 0 » à $D$.

  *Round 1 — vote naïf.* Chaque processus diffuse sa valeur initiale, puis effectue un
  vote majoritaire sur les valeurs reçues.

  - $A$ reçoit : {$A$:1, $B$:1, $C$:1, $D$:1} → vote majorité → décide *1*.
  - $B$ reçoit : {$A$:1, $B$:1, $C$:1, $D$:1} → vote majorité → décide *1*.
  - $D$ reçoit : {$A$:1, $B$:1, $C$:0, $D$:1} → vote majorité → décide *1*.

  Ici l'accord est atteint par chance : $C$ n'a pas semé assez de discorde.
  Mais si $C$ coordonne ses mensonges différemment (envoie « 1 » à $A$, « 0 » à $B$ et
  $D$), alors $B$ et $D$ peuvent aboutir à des décisions différentes. Un seul tour est
  insuffisant en général pour $f = 1$. Il faut $f+1 = 2$ tours pour garantir l'accord.
]

#figure(
  include "figures/byzantine.typ",
  caption: [
    Scénario byzantin avec $n = 4$, $f = 1$. Le processus $C$ (encadré en rouge) envoie
    « 1 » à $A$ et $B$ mais « 0 » à $D$. Avec un simple vote naïf en un tour, $A$ et $B$
    peuvent décider différemment de $D$, violant la propriété d'accord. La condition
    $n gt.eq 3f+1$ est nécessaire mais un protocole multi-tours est indispensable.
  ],
)

== Impossibilité FLP

Le résultat de Fischer, Lynch et Paterson (1985) est l'un des théorèmes les plus
importants — et les plus surprenants — de l'informatique distribuée. Il établit qu'il est
*impossible* de résoudre le consensus dans un système asynchrone, même si les seules
pannes possibles sont des *crashs* (arrêts définitifs) et qu'une seule panne peut survenir.

Ce résultat peut sembler paradoxal : un seul processus peut tomber, les autres
fonctionnent parfaitement, et pourtant aucun algorithme déterministe ne peut garantir
la terminaison. La clé est l'*asynchronisme* : dans un système asynchrone, il n'existe
aucune borne sur les délais de transmission des messages. Un processus qui ne répond pas
est-il tombé en panne ou simplement lent ? Il est impossible de le savoir.

#thm(info: "Impossibilité FLP (Fischer-Lynch-Paterson, 1985)")[
  Dans un système distribué *asynchrone*, il n'existe aucun algorithme *déterministe*
  qui résout le consensus même avec au plus *une* panne de type crash.
]

La preuve formelle repose sur la notion de *configuration bivalente* : une configuration
est *bivalente* si les deux valeurs de décision ($0$ et $1$) sont encore possibles à
partir de cet état, selon la suite des événements futurs. Une configuration est
*univalente* si une seule valeur de décision est encore accessible.

*Esquisse de preuve.*

On montre deux lemmes :

+ *Existence d'une configuration initiale bivalente.* Si une configuration initiale
  $C_0$ était univalente pour toutes les valeurs des processus, il suffirait de modifier
  la valeur d'un processus (possiblement en panne) pour passer d'une configuration
  0-valente à une configuration 1-valente. On montre qu'il doit exister une configuration
  initiale bivalente en considérant des chemins entre configurations 0-valentes et
  1-valentes.

+ *Depuis toute configuration bivalente, il existe un événement qui maintient la
  bivalence.* Un algorithme qui tente de décider doit passer d'une configuration bivalente
  à une configuration univalente. Mais quel que soit le prochain événement exécuté
  (réception d'un message), on peut construire un ordonnancement des événements qui
  maintient la bivalence, en retardant indéfiniment le message déterminant. L'asynchronisme
  permet précisément ce report : il est toujours possible de prétendre qu'un message est
  simplement retardé plutôt que perdu.

La combinaison de ces deux lemmes montre qu'un algorithme déterministe ne peut jamais
forcer la terminaison : il y aura toujours des exécutions où l'algorithme est maintenu
indéfiniment dans une configuration bivalente.

#rmk[
  Le théorème FLP explique pourquoi tous les algorithmes de consensus pratiques —
  Paxos de Lamport, Raft de Ongaro et Ousterhout, Zab de Zookeeper — reposent sur des
  hypothèses supplémentaires qui sortent du cadre purement asynchrone :
  - *Synchronie partielle* (_partial synchrony_) : il existe une borne sur les délais,
    mais elle n'est pas connue à l'avance.
  - *Aléatoire* : certains algorithmes utilisent des bits aléatoires pour briser la
    symétrie et échapper aux configurations bivalentes.
  Dans ces modèles étendus, le consensus est soluble, mais FLP rappelle que cette
  solvabilité repose toujours sur des hypothèses non triviales concernant le modèle.
]

#insight[
  L'impossibilité FLP n'est pas un problème de complexité (« le problème est trop dur à
  calculer ») mais un problème de *calculabilité* dans un modèle spécifique. Il ne s'agit
  pas de trouver un algorithme plus efficace : *aucun* algorithme déterministe ne peut
  résoudre le consensus dans le modèle asynchrone avec crashs, quelle que soit sa
  complexité en temps ou en messages. C'est une limite fondamentale du modèle lui-même,
  comparable à l'indécidabilité du problème de l'arrêt pour les machines de Turing.
]

== Algorithme Flood-Set (synchrone, $f+1$ phases)

Le résultat FLP ferme la porte au consensus asynchrone, mais ouvre la voie à une
question naturelle : le consensus est-il soluble dans un modèle *synchrone* ? La réponse
est oui — et l'algorithme Flood-Set en donne une construction simple et élégante.

Dans le modèle synchrone, les processus s'exécutent en *rondes* : à chaque ronde,
chaque processus envoie des messages, puis reçoit tous les messages envoyés pendant cette
ronde (sauf ceux des processus crashés). Le système garantit une borne connue sur les
délais. Les processus peuvent crasher (arrêt définitif), mais au plus $f$ d'entre eux.

L'idée centrale du Flood-Set est d'inonder le réseau avec toutes les valeurs initiales
connues. Après suffisamment de rondes, tous les processus vivants ont la même vue de
l'ensemble des valeurs initiales et peuvent donc appliquer la même fonction déterministe
pour décider.

#algo("Flood-Set (Hadzilacos)")[
  Chaque processus $P_i$ maintient un ensemble $W_i$ de valeurs, initialisé à ${v_i}$
  (sa propre valeur initiale).

  *Pour les rondes $r = 1$ à $f+1$ :*

  + *Diffusion.* $P_i$ envoie $W_i$ à tous les processus (y compris lui-même).

  + *Collecte.* $P_i$ reçoit les ensembles $W_j$ de tous les processus $P_j$ qui lui ont
    envoyé un message pendant cette ronde.

  + *Mise à jour.* $W_i := union.big_(j " reçu") W_j$.

  *Décision.* Après $f+1$ rondes, $P_i$ décide $min(W_i)$ (ou toute fonction
  déterministe fixée à l'avance).
]

#thm(info: "Correction du Flood-Set")[
  Après $f+1$ rondes, tous les processus corrects ont le même ensemble $W$. En
  conséquence, ils décident tous la même valeur.
]

#proof[
  Nous montrons que si un processus correct $P_i$ ajoute une valeur $v$ à son ensemble
  lors de la ronde $r$, alors tout autre processus correct $P_j$ aura $v$ dans son
  ensemble à la fin de la ronde $r+1$ (sauf si $P_i$ crashe dans la ronde $r$).

  Il y a au plus $f$ crashs. Par le principe des tiroirs, sur $f+1$ rondes, il existe au
  moins une ronde $r^*$ sans aucun crash. Pendant la ronde $r^*$, tous les processus
  corrects reçoivent le message de tous les autres processus corrects. Donc à la fin de
  la ronde $r^*$, tous ont le même ensemble (l'union de tous les ensembles avant la
  ronde $r^*$).

  Plus précisément : si une valeur $v$ est dans $W_i$ avant la ronde $r^*$, alors
  $P_i$ la diffuse pendant $r^*$ et tous les processus corrects la reçoivent. Si $v$
  est introduite pendant $r^*$ par un processus $P_k$ qui ne crashe pas (puisque $r^*$
  est sans crash), tous les processus la reçoivent. Donc après $r^*$, tous les processus
  corrects ont le même ensemble, et ils décident tous $min(W)$.
]

#prop(info: "Complexité")[
  L'algorithme Flood-Set effectue exactement $f+1$ rondes. À chaque ronde, chaque
  processus envoie son ensemble $W_i$ à tous les $n$ processus, soit $O(n)$ messages par
  processus et $O(n^2)$ messages par ronde. La taille de chaque message est $O(|W_i|)$
  où $|W_i| lt.eq n$ (l'ensemble contient au plus $n$ valeurs distinctes). La complexité
  totale en messages est donc $O(n^2 dot.c n) = O(n^3)$ valeurs transmises, sur $f+1$
  rondes.
]

#insight[
  Le nombre $f+1$ de rondes est *optimal*. Avec $f$ rondes seulement, il serait possible
  que $f$ processus crashent, un par ronde, chacun au moment précis où il vient d'envoyer
  son ensemble à certains processus mais pas à d'autres. Cela peut créer une asymétrie
  d'information entre les processus survivants, empêchant l'accord. Avec $f+1$ rondes, on
  garantit qu'il y a au moins une ronde « propre » (sans crash) après laquelle toute
  l'information est uniformément distribuée.
]

En résumé, ce chapitre a établi les résultats fondamentaux du consensus distribué :
la condition $n gt.eq 3f+1$ pour le consensus byzantin, l'impossibilité FLP dans le
modèle asynchrone avec crashs, et la constructivité du Flood-Set dans le modèle
synchrone. Ces résultats délimitent précisément ce qui est possible et ce qui ne l'est
pas en matière de tolérance aux fautes, et constituent la base théorique indispensable
à la conception des systèmes distribués robustes modernes.
