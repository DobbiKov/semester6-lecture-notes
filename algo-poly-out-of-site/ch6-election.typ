#import "preamble.typ": *

= Élection de chef

Dans de nombreux algorithmes distribués, il est commode de disposer d'un processus particulier jouant le rôle de *coordinateur* ou de *chef* : il peut centraliser les décisions, initier un protocole, ou servir de point de synchronisation. Or, dans un système distribué symétrique, tous les processus démarrent dans le même état ; aucun ne joue de rôle privilégié a priori.

Le problème de l'*élection de chef* consiste à faire converger un système distribué vers un état dans lequel exactement un processus se déclare élu, et tous les autres processus reconnaissent ce choix. La seule hypothèse permettant de briser la symétrie est l'existence d'*identifiants uniques* pour les processus.

#defn(info: "Problème de l'élection de chef")[
  Soit un réseau de $n$ processus $P_1, dots, P_n$, chacun possédant un identifiant unique $id(P_i) in NN$. Un algorithme d'élection est *correct* s'il garantit, à partir de tout état initial :

  1. *Terminaison* : en temps fini, tous les processus terminent.
  2. *Accord* : exactement un processus se trouve dans l'état "élu".
  3. *Validité* : le processus élu est celui ayant le plus grand (ou le plus petit) identifiant parmi tous les processus corrects.
]

Les deux algorithmes classiques présentés dans ce chapitre s'appliquent à des topologies en *anneau*, où les processus sont disposés en cercle et communiquent avec leurs voisins.

== Algorithme de Chang-Roberts (extinction sélective)

L'algorithme de Chang et Roberts, publié en 1979, s'applique à un *anneau unidirectionnel* : chaque processus ne peut envoyer des messages que dans un sens (par exemple, dans le sens des aiguilles d'une montre). Le principe est celui de l'*extinction sélective* : chaque processus envoie son identifiant dans l'anneau, et un identifiant est *éliminé* dès qu'il rencontre un processus avec un identifiant plus grand. Seul l'identifiant maximal survit et fait le tour complet de l'anneau, désignant son émetteur comme chef.

#figure(
  include "figures/chang-roberts.typ",
  caption: [Algorithme de Chang-Roberts sur un anneau de 5 processus. L'identifiant id=5 (P2) est transféré par tous les processus et revient à son émetteur, le désignant chef. Les identifiants plus petits sont éliminés dès qu'ils rencontrent un identifiant supérieur.]
)

#algo("Algorithme de Chang-Roberts")[
  *Initialisation* : tous les processus sont "actifs".

  *Phase d'envoi* : chaque processus $P_i$ envoie $id(P_i)$ à son successeur dans l'anneau.

  *Règle de traitement* : lorsque $P_i$ reçoit un identifiant $j$ :
  - Si $j > id(P_i)$ : transférer $j$ au successeur ($P_i$ est dominé, $j$ survit).
  - Si $j < id(P_i)$ : supprimer $j$ (message éliminé, $P_i$ est toujours candidat).
  - Si $j = id(P_i)$ : $P_i$ se déclare *ÉLU* (son propre message a fait le tour complet).

  *Diffusion du résultat* : le processus élu diffuse un message $sans("LEADER")(id)$ à tous les processus pour les informer du résultat.
]

#thm(info: "Correction de Chang-Roberts")[
  L'algorithme de Chang-Roberts est correct : il termine, élit exactement un processus, et ce processus est celui ayant l'identifiant maximal.

  *Preuve* : Le message portant l'identifiant maximal $M = max_i id(P_i)$ ne peut jamais être éliminé (aucun processus n'a un identifiant supérieur à $M$). Il fait donc le tour complet de l'anneau et revient à $P_(max)$, qui se déclare élu. Tout autre message $j < M$ est éventuellement éliminé lorsqu'il atteint le processus dont l'identifiant est supérieur à $j$. Donc exactement un processus — $P_(max)$ — se déclare élu. $square$
]

=== Analyse de complexité

La complexité de Chang-Roberts dépend de la disposition des identifiants sur l'anneau.

#prop(info: "Complexité de Chang-Roberts")[
  - *Pire cas* : $Theta(n^2)$ messages (identifiants disposés en ordre décroissant).
  - *Cas moyen* : $O(n log n)$ messages (pour une permutation aléatoire des identifiants).
]

#ex(info: "Pire cas de Chang-Roberts en Θ(n²)")[
  Considérons $n$ processus disposés en anneau avec les identifiants dans l'ordre *décroissant* dans le sens de circulation : $n, n-1, n-2, dots, 1$.

  Numérotons les processus $P_1, P_2, dots, P_n$ dans le sens de circulation, avec $id(P_k) = n+1-k$. Ainsi $P_1$ a l'identifiant $n$ (le maximum), $P_2$ a $n-1$, etc.

  Analysons combien de sauts chaque message effectue avant d'être éliminé :
  - $id(P_n) = 1$ : éliminé immédiatement à $P_1$ (1 saut).
  - $id(P_(n-1)) = 2$ : éliminé à $P_1$ après 2 sauts.
  - $dots$
  - $id(P_2) = n-1$ : éliminé à $P_1$ après $n-1$ sauts.
  - $id(P_1) = n$ : fait le tour complet, $n$ sauts.

  Total de messages : $1 + 2 + dots + n = n(n+1)/2 = Theta(n^2)$.

  Cette configuration est bien le pire cas : dans toute autre configuration, certains messages sont éliminés plus tôt.
]

#rmk[
  Le pire cas $Theta(n^2)$ se réalise exactement lorsque les identifiants décroissent dans le sens de circulation. Dans ce cas, chaque message doit "remonter" contre tous les identifiants inférieurs avant d'être arrêté par le maximum. Pour des applications pratiques où $n$ est grand, on préférera l'algorithme de Peterson qui garantit $O(n log n)$ dans tous les cas.
]

== Algorithme de Peterson (anneau bidirectionnel)

L'algorithme de Peterson, publié en 1982, s'applique à un *anneau bidirectionnel* et garantit une complexité de $O(n log n)$ messages dans le pire cas. L'idée centrale est une élimination *par phases* : à chaque phase, au moins la moitié des processus encore candidats sont éliminés, ce qui garantit $O(log n)$ phases, chacune utilisant $O(n)$ messages.

Initialement, tous les processus sont *actifs* (candidats à l'élection). Au cours de chaque phase, chaque processus actif envoie son identifiant courant à ses deux voisins directs et consulte l'identifiant de son voisin gauche et de son "demi-voisin" gauche (le voisin du voisin). Si l'identifiant du voisin direct est le plus grand des trois, ce voisin "survit" et devient le représentant pour la phase suivante ; sinon il est éliminé.

#algo("Algorithme de Peterson")[
  *Initialisation* : tous les processus $P_i$ sont actifs, avec identifiant courant $a_i = id(P_i)$.

  *Phase répétée jusqu'à élection* :

  Pour chaque processus actif $P_i$ (simultanément) :
  + Envoyer $a_i$ à droite.
  + Recevoir $a_("left")$ du voisin gauche actif.
  + Envoyer $a_("left")$ à droite (relayer).
  + Recevoir $a_("left,left")$ (le relais du voisin gauche du voisin gauche).
  + Si $a_("left") > max(a_i, a_("left,left"))$ : $a_i <- a_("left")$ (le voisin gauche survit, devient représentant de $P_i$).
  + Sinon : $P_i$ est éliminé (passe en mode passif, se contentant de relayer).

  *Terminaison* : lorsqu'un seul processus actif reste, il se déclare élu et diffuse $sans("LEADER")$.
]

#thm(info: "Complexité de Peterson en O(n log n)")[
  L'algorithme de Peterson nécessite $O(n log n)$ messages dans le pire cas.

  *Preuve (argument de division par deux)* :
  À chaque phase, considérons les processus actifs. Parmi deux processus actifs consécutifs $P_i$ et son voisin gauche actif $P_j$, au plus l'un des deux peut "survivre" : $P_j$ survit seulement si son identifiant est strictement supérieur à ceux de ses deux voisins actifs. En particulier, $P_i$ et $P_j$ ne peuvent pas survivre tous les deux simultanément (si $P_j$ survit, c'est que son identifiant est plus grand que celui de $P_i$, donc $P_i$ ne survit pas, et réciproquement). Ainsi, *au moins la moitié des processus actifs sont éliminés à chaque phase*.

  Avec $n$ processus actifs initialement, après $k$ phases il reste au plus $n / 2^k$ candidats. Le nombre de phases est donc au plus $ceil(log_2 n) = O(log n)$.

  Chaque phase consomme au plus $2n$ messages (chaque processus actif envoie et reçoit un nombre constant de messages, et les processus passifs relaient). Le total est donc $O(n log n)$. $square$
]

#insight(info: "Intuition de la division par deux")[
  L'argument clé de Peterson est que la condition de survie ($a_("left") >  max(a_i, a_("left,left"))$) est "strictement locale à deux voisins consécutifs" : deux candidats adjacents ne peuvent pas tous deux remplir cette condition simultanément. Cela garantit que le nombre de survivants est au plus la moitié du nombre de candidats, indépendamment de la configuration des identifiants. En $O(log n)$ phases, on converge nécessairement vers un unique élu.

  Comparer avec Chang-Roberts, où l'absence de mécanisme d'élimination local garantie conduit au pire cas $Theta(n^2)$ : un seul identifiant (le maximum) "balaie" séquentiellement l'anneau, éliminant tous les autres en les rencontrant.
]

=== Comparaison des deux algorithmes

#figure(
  caption: [Comparaison des algorithmes d'élection sur anneau.],
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, center, center, center, left),
    table.header(
      [*Algorithme*], [*Topologie*], [*Pire cas*], [*Cas moyen*], [*Élu*]
    ),
    [Chang-Roberts], [Unidirectionnel], [$Theta(n^2)$], [$O(n log n)$], [id max],
    [Peterson], [Bidirectionnel], [$O(n log n)$], [$O(n log n)$], [id max],
  )
)

#rmk[
  La bidirectionnalité de l'anneau est essentielle pour Peterson : l'algorithme nécessite de consulter deux voisins dans la même phase, ce qui requiert une communication dans les deux sens. Sur un anneau strictement unidirectionnel, le meilleur algorithme connu a une complexité de $O(n log n)$ en moyenne mais $Theta(n^2)$ dans le pire cas (Chang-Roberts). Sur un graphe général, des algorithmes d'élection existent avec une complexité de $O(m + n log n)$ où $m$ est le nombre d'arêtes.
]

#rmk[
  L'élection de chef est une primitive fondamentale pour de nombreux autres algorithmes distribués. En particulier, la solution centralisée à l'exclusion mutuelle (Chapitre 4) et certains protocoles de consensus (Chapitre 9) supposent l'existence d'un coordinateur préalablement élu. Dans des systèmes dynamiques où les processus peuvent tomber en panne et redémarrer, l'élection doit être périodiquement relancée — c'est le rôle des *détecteurs de pannes* et des protocoles de *ré-élection*.
]
