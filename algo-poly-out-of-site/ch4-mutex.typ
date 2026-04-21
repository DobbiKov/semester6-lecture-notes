#import "preamble.typ": *

= Exclusion mutuelle distribuée

Dans un système à mémoire partagée, l'exclusion mutuelle s'obtient facilement grâce à des primitives comme les sémaphores ou les verrous matériels. La situation est radicalement différente dans un système distribué : il n'existe aucune mémoire commune, et les processus ne communiquent qu'en s'échangeant des messages. Le problème de l'exclusion mutuelle distribuée consiste à garantir qu'au plus un processus à la fois exécute une *section critique* (SC), c'est-à-dire un fragment de code accédant à une ressource partagée.

Ce chapitre présente cinq approches classiques, du plus simple au plus élaboré. Chacune réalise un compromis entre le nombre de messages échangés par entrée en SC, la robustesse aux pannes et la complexité de mise en œuvre.

#defn(info: "Section critique et exclusion mutuelle distribuée")[
  Soit $n$ processus $P_1, dots, P_n$ se partageant une ressource. On dit qu'un protocole d'exclusion mutuelle est *correct* s'il satisfait simultanément :

  1. *Sûreté* : à tout instant, au plus un processus se trouve en section critique.
  2. *Vivacité* : toute demande d'entrée en SC est éventuellement accordée (absence d'interblocage et d'attente infinie).
  3. *Équité* : les demandes sont traitées dans un ordre juste, idéalement FIFO selon leurs horodatages.
]

La métrique standard pour comparer ces algorithmes est le *nombre de messages échangés par entrée en SC*.

== Solution centralisée

La solution la plus immédiate est d'élire un processus coordinateur qui gère l'accès à la ressource. Lorsque $P_i$ souhaite entrer en SC, il envoie une requête au coordinateur. Celui-ci maintient une file d'attente des demandes en suspens et accorde l'accès selon l'ordre FIFO. Quand $P_i$ a terminé, il notifie le coordinateur par un message de libération.

Cette approche nécessite trois messages par entrée en SC, indépendamment du nombre de processus. Elle est donc extrêmement économique en termes de communication. En revanche, elle crée un *point unique de défaillance* : si le coordinateur tombe en panne, tout le système est bloqué. De plus, le coordinateur devient un goulot d'étranglement à mesure que le nombre de processus croît.

#algo("Solution centralisée")[
  *Initialisation* : un processus $P_c$ est désigné coordinateur.

  *Protocole pour $P_i$ (demandeur)* :
  + Envoyer $sans("REQ")(i)$ au coordinateur.
  + Attendre la réception de $sans("GRANT")$.
  + Exécuter la section critique.
  + Envoyer $sans("RELEASE")(i)$ au coordinateur.

  *Protocole pour $P_c$ (coordinateur)* :
  + À la réception de $sans("REQ")(i)$ : si SC libre, envoyer $sans("GRANT")$ à $P_i$, sinon mettre $i$ en file d'attente.
  + À la réception de $sans("RELEASE")(i)$ : retirer $P_i$ de la SC ; s'il y a des demandes en attente, envoyer $sans("GRANT")$ au premier de la file.
]

#prop(info: "Complexité de la solution centralisée")[
  La solution centralisée nécessite exactement *3 messages* par entrée en SC :
  - 1 message $sans("REQ")$ de $P_i$ vers le coordinateur,
  - 1 message $sans("GRANT")$ du coordinateur vers $P_i$,
  - 1 message $sans("RELEASE")$ de $P_i$ vers le coordinateur.
]

#rmk[
  L'algorithme centralisé est correct (sûreté et vivacité garanties par la gestion FIFO de la file). Cependant, son déploiement suppose qu'un coordinateur ait préalablement été élu — ce qui est lui-même un problème non trivial dans un système distribué (voir Chapitre 6). La panne du coordinateur nécessite un mécanisme de recouvrement.
]

== Algorithme de Lamport (1978)

L'algorithme de Lamport est la première solution entièrement distribuée à l'exclusion mutuelle. Chaque processus maintient une *file locale* des demandes en cours, ordonnée par les horodatages de Lamport. L'idée centrale est que chaque processus peut calculer localement quel processus a la priorité, à condition d'avoir connaissance de toutes les demandes en circulation.

Pour entrer en SC, $P_i$ diffuse sa demande à tous les processus et attend deux conditions : (a) sa demande est minimale dans toutes les files locales, et (b) il a reçu un accusé de réception de chaque autre processus postérieur à sa propre demande. La sortie est également diffusée afin que tous les processus retirent la demande de leurs files.

#figure(
  include "figures/lamport-mutex.typ",
  caption: [Diagramme espace-temps de l'algorithme de Lamport pour $n=3$. Les trois phases (diffusion de la demande, acquittements, diffusion de la sortie) produisent $3(n-1) = 6$ messages.]
)

#algo("Algorithme de Lamport")[
  *Structures de données* : chaque $P_i$ maintient une file $Q_i$ et une horloge logique $C_i$.

  *Règle 1 — Demande d'entrée* : $P_i$ incrémente $C_i$, diffuse $sans("DEMANDE")(C_i, i)$ à tous les autres processus, et ajoute $(C_i, i)$ à $Q_i$.

  *Règle 2 — Réception de $sans("DEMANDE")(t, j)$* : $P_i$ met à jour $C_i <- max(C_i, t) + 1$, ajoute $(t, j)$ à $Q_i$, et répond par $sans("ACK")(C_i, i)$ à $P_j$.

  *Condition d'entrée en SC pour $P_i$* : $(C_i, i)$ est le minimum de $Q_i$ *et* $P_i$ a reçu un message de chaque $P_j$ ($j != i$) avec horodatage strictement supérieur à $C_i$.

  *Règle 3 — Sortie de SC* : $P_i$ diffuse $sans("SORTIE")(C_i, i)$ à tous ; à la réception, chaque $P_j$ retire $(C_i, i)$ de $Q_j$.
]

#thm(info: "Correction de l'algorithme de Lamport")[
  L'algorithme de Lamport satisfait les propriétés de sûreté, de vivacité et d'équité (ordre FIFO par horodatage).

  *Sûreté* : Supposons par l'absurde que $P_i$ et $P_j$ soient simultanément en SC, avec $C_i < C_j$ (ou $C_i = C_j$ et $i < j$). Alors $(C_i, i) <_("lex") (C_j, j)$. Lorsque $P_j$ entre en SC, il doit avoir reçu un message de $P_i$ postérieur à $C_i$, donc $P_i$ a déjà reçu l'accusé de réception de $P_j$ — mais cela est impossible si $P_j$ est entré avant d'avoir acquitté $P_i$.

  *Vivacité* : Le bon ordre de la file et la propagation des ACK garantissent qu'aucune demande ne reste bloquée indéfiniment, en l'absence de panne.
]

#prop(info: "Complexité de l'algorithme de Lamport")[
  L'algorithme de Lamport nécessite $3(n-1)$ messages par entrée en SC :
  - Phase 1 (diffusion DEMANDE) : $n-1$ messages,
  - Phase 2 (ACK) : $n-1$ messages,
  - Phase 3 (diffusion SORTIE) : $n-1$ messages.
]

#rmk[
  La phase de sortie est coûteuse : diffuser $sans("SORTIE")$ à $n-1$ processus n'est nécessaire que pour maintenir les files cohérentes. Ricart et Agrawala ont observé que cette phase pouvait être éliminée grâce aux *réponses différées*.
]

== Algorithme de Ricart et Agrawala (1981)

L'algorithme de Ricart et Agrawala optimise celui de Lamport en supprimant la diffusion de sortie. L'idée clé est la suivante : lorsqu'un processus $P_i$ est en SC (ou a une demande prioritaire), il *diffère* sa réponse aux demandes concurrentes. Quand $P_i$ sort de la SC, il envoie directement ses réponses différées — ce qui revient implicitement à notifier les processus concernés sans diffusion globale.

Deux processus $P_i$ et $P_j$ ont des priorités comparables via leurs horodatages : la demande avec le plus petit horodatage (et, à égalité, le plus petit identifiant) est prioritaire. Si $P_i$ reçoit la demande de $P_j$ et que $P_i$ est prioritaire, il diffère sa réponse jusqu'à sa propre sortie de SC. Sinon, il répond immédiatement.

#figure(
  include "figures/ricart-agrawala.typ",
  caption: [Diagramme espace-temps de l'algorithme de Ricart-Agrawala. P1 (ts=3) est prioritaire sur P2 (ts=5). P2 répond immédiatement à P1 ; P1 diffère sa réponse à P2, qu'il envoie en sortant de SC. Total : $2(n-1)=4$ messages.]
)

#algo("Algorithme de Ricart-Agrawala")[
  *Structures de données* : chaque $P_i$ maintient une horloge $C_i$, un compteur $sans("nb_ack")_i$ et un ensemble $sans("diffères")_i$.

  *Demande d'entrée de $P_i$* :
  + $C_i <- C_i + 1$ ; mémoriser $t_i = C_i$.
  + Diffuser $sans("REQ")(t_i, i)$ à tous les $P_j$ ($j != i$).
  + Attendre $n-1$ réponses $sans("OK")$.
  + Entrer en SC.

  *Réception de $sans("REQ")(t_j, j)$ par $P_i$* :
  - Si $P_i$ *n'est pas* en train de demander la SC, ou si $P_i$ demande la SC mais $(t_j, j) <_("lex") (t_i, i)$ (i.e. $P_j$ est prioritaire) : répondre immédiatement $sans("OK")$ à $P_j$.
  - Sinon ($P_i$ en SC ou prioritaire sur $P_j$) : ajouter $j$ à $sans("diffères")_i$.

  *Sortie de SC de $P_i$* :
  + Pour chaque $j in sans("diffères")_i$ : envoyer $sans("OK")$ à $P_j$.
  + Vider $sans("diffères")_i$.
]

#thm(info: "Correction de Ricart-Agrawala")[
  L'algorithme de Ricart-Agrawala satisfait la sûreté et la vivacité.

  *Sûreté* : Si $P_i$ et $P_j$ demandent la SC simultanément avec $(t_i, i) <_("lex") (t_j, j)$, alors $P_j$ recevra le $sans("REQ")$ de $P_i$ et répondra immédiatement (car $P_i$ est prioritaire), mais $P_i$ ne répondra à $P_j$ qu'après sa sortie de SC. Donc $P_j$ ne pourra pas entrer avant $P_i$, et a fortiori pas en même temps.

  *Vivacité* : En l'absence de panne, les réponses différées sont toujours finalement envoyées, garantissant la progression.
]

#prop(info: "Complexité de Ricart-Agrawala")[
  L'algorithme de Ricart-Agrawala nécessite $2(n-1)$ messages par entrée en SC :
  - Phase 1 (diffusion REQ) : $n-1$ messages,
  - Phase 2 (réponses OK, immédiates ou différées) : $n-1$ messages.

  Gain par rapport à Lamport : $n-1$ messages (la phase SORTIE est supprimée).
]

== Ricart-Agrawala avec jeton explicite

Les deux algorithmes précédents sont dits *sans jeton* : chaque processus décide localement de son droit d'entrée. Une variante populaire utilise un *jeton* (token) matérialisant explicitement le droit d'accès. Un seul jeton existe dans le système ; le posséder est une condition nécessaire et suffisante pour entrer en SC.

Le jeton est un tableau $J$ de taille $n$ où $J[i]$ enregistre le nombre de fois que $P_i$ est entré en SC depuis la création du jeton. Chaque $P_i$ maintient également un tableau $D$ de *demandes* où $D[i]$ est le numéro de séquence de la dernière demande de $P_i$.

#algo("Ricart-Agrawala avec jeton")[
  *Structures de données* : tableau global $J[1..n]$ (porté par le jeton), tableau local $D_i[1..n]$ pour chaque processus.

  *Demande d'entrée de $P_i$* :
  + Si $P_i$ détient déjà le jeton : entrer directement en SC.
  + Sinon : incrémenter $D_i[i]$, diffuser $sans("DEMANDE")(D_i[i], i)$ à tous.
  + Attendre la réception du jeton.
  + Entrer en SC.

  *Réception de $sans("DEMANDE")(k, i)$ par $P_k$ (détenteur du jeton)* :
  - Si $P_k$ n'est pas en SC et $D_k[i] > J[i]$ : envoyer le jeton à $P_i$.

  *Sortie de SC de $P_i$ (détenteur du jeton)* :
  + $J[i] <- J[i] + 1$.
  + Parcourir $j = (i+1) mod n, dots$ jusqu'à trouver $j$ tel que $D_i[j] > J[j]$ : envoyer le jeton à $P_j$.
  + Si aucun $j$ trouvé : conserver le jeton.
]

#prop(info: "Complexité de R-A avec jeton")[
  L'algorithme R-A avec jeton nécessite *au plus $2(n-1)$* messages par entrée en SC :
  - $n-1$ messages pour la diffusion de la demande,
  - 1 message pour le transfert du jeton (depuis son détenteur actuel),
  - éventuellement des transferts successifs si le détenteur actuel passe le jeton (au plus $n-1$ sauts).

  Dans le meilleur cas (jeton disponible immédiatement), le coût est de $n-1 + 1$ messages.
]

#rmk[
  L'utilisation d'un jeton apporte une simplification conceptuelle importante : la décision d'entrer en SC est binaire (posséder ou non le jeton). En revanche, la perte du jeton (due à une panne du processus le détenant) est catastrophique et nécessite un protocole de régénération spécifique.
]

== Anneau à jeton

L'anneau à jeton est une solution élégante qui organise les processus en *anneau logique* $P_1 -> P_2 -> dots -> P_n -> P_1$. Un unique jeton circule en permanence dans cet anneau dans le sens des aiguilles d'une montre. Lorsqu'un processus reçoit le jeton, il peut l'utiliser pour entrer en SC ; s'il n'en a pas besoin, il le transfère immédiatement au processus suivant.

Cette approche est remarquable par sa simplicité : il n'y a aucune négociation ni aucun calcul de priorité. L'équité est garantie naturellement puisque le jeton fait le tour de tous les processus à chaque cycle. Le coût varie selon la position relative du jeton au moment de la demande.

#figure(
  include "figures/token-ring.typ",
  caption: [Anneau à jeton avec $N=4$ processus. Le jeton (T) est détenu par P2, qui entre en SC. Les flèches indiquent le sens de circulation unidirectionnel.]
)

#algo("Anneau à jeton")[
  *Initialisation* : Le jeton est remis à $P_1$. Tous les processus connaissent leur successeur dans l'anneau.

  *Protocole pour $P_i$ recevant le jeton* :
  + Si $P_i$ souhaite entrer en SC : entrer en SC, exécuter, puis sortir.
  + Transférer le jeton à $P_((i mod n) + 1)$.

  *Protocole pour $P_i$ ne souhaitant pas la SC* :
  + Transférer le jeton immédiatement à $P_((i mod n) + 1)$.
]

#prop(info: "Complexité de l'anneau à jeton")[
  - *Meilleur cas* : 0 message par entrée en SC (le jeton arrive exactement au bon moment).
  - *Pire cas* : $n-1$ messages par entrée en SC (le jeton vient d'être transmis au processus suivant, et doit faire presque tout le tour).
  - *En moyenne* : $n/2$ messages par entrée en SC.
]

#rmk[
  L'anneau à jeton génère du trafic en permanence, même si aucun processus ne souhaite la SC. Si $k$ processus utilisent fréquemment la SC, la circulation continue du jeton peut être avantageuse ; si les demandes sont rares, ce trafic de fond constitue un gaspillage. La perte du jeton (panne d'un processus en transit) exige un protocole de détection et de régénération.
]

== Comparaison des algorithmes

#insight(info: "Compromis fondamental")[
  Il existe un compromis fondamental entre le nombre de messages par entrée en SC et le degré de distribution du contrôle. La solution centralisée est la moins coûteuse en messages (3 par entrée) mais crée un point de défaillance unique. Les solutions distribuées comme Lamport et Ricart-Agrawala nécessitent $O(n)$ messages mais offrent une meilleure tolérance aux pannes. Le jeton (implicite ou explicite) représente un compromis intermédiaire.
]

#figure(
  caption: [Comparaison des algorithmes d'exclusion mutuelle distribuée.],
  table(
    columns: (auto, auto, auto, auto),
    align: (left, center, center, left),
    table.header(
      [*Algorithme*], [*Messages/entrée*], [*Centralisé ?*], [*Tolérance aux pannes*]
    ),
    [Centralisée], [3], [Oui], [Faible (SPOF)],
    [Lamport], [$3(n-1)$], [Non], [Moyenne],
    [Ricart-Agrawala], [$2(n-1)$], [Non], [Moyenne],
    [R-A avec jeton], [$≤ 2(n-1)$], [Non], [Perte du jeton],
    [Anneau à jeton], [$0 dots n-1$], [Non], [Perte du jeton],
  )
)

#rmk[
  Pour $n$ grand, le coût linéaire en $n$ des algorithmes distribués peut devenir prohibitif. Des solutions avancées basées sur des structures en arbre ou en quorum permettent de réduire ce coût à $O(sqrt(n))$ ou $O(log n)$ messages, au prix d'une complexité accrue de mise en œuvre.
]
