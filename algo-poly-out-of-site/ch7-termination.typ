#import "preamble.typ": *

= Détection de terminaison

Dans un système distribué, la notion même de « fin du calcul » est beaucoup plus
subtile que dans un programme séquentiel. Lorsqu'un processus unique termine sa
boucle principale, on sait immédiatement que le calcul est achevé. Dans un système
distribué, en revanche, plusieurs processus s'exécutent en parallèle et se transmettent
des messages : un processus peut devenir inactif, puis être réveillé par un message qu'un
autre processus lui avait envoyé avant même de s'endormir. De l'extérieur, il est
impossible de distinguer ce cas d'une terminaison effective.

Ce chapitre étudie le problème de la *détection de terminaison* : comment un
observateur extérieur — ou l'un des processus lui-même — peut-il déterminer de manière
sûre que le calcul distribué a globalement terminé, sans interrompre le calcul ni disposer
d'une horloge globale ? Nous présenterons trois approches classiques : le jeton de
Dijkstra–Safra pour les anneaux synchrones, l'algorithme de Safra avec compteurs pour les
systèmes asynchrones, et le schéma de crédit de Mattern pour les calculs diffusants.

== Le problème de la terminaison

Considérons un ensemble de $n$ processus $P_1, dots, P_n$ qui participent à un calcul
distribué. À tout instant, chaque processus est soit *actif* (il calcule ou vient d'envoyer
un message), soit *inactif* (il n'effectue aucun calcul local). Un processus inactif peut
redevenir actif à tout moment s'il reçoit un message.

L'approche naïve consiste à vérifier périodiquement si tous les processus sont inactifs.
Cette vérification est cependant insuffisante, et ce pour une raison fondamentale : un
message peut être *en transit* dans le réseau. Si $P_1$ a envoyé un message à $P_2$ avant
de s'endormir, et si $P_2$ est également inactif au moment de la vérification, alors
l'observateur peut conclure à tort que le calcul est terminé. Mais dès que $P_2$ recevra
le message, il se réveillera et continuera le calcul.

#defn(info: "Terminaison globale")[
  Un calcul distribué est dit *globalement terminé* si et seulement si les deux conditions
  suivantes sont simultanément satisfaites :

  + *Tous les processus sont inactifs* : pour tout $i in {1, dots, n}$, le processus $P_i$
    n'effectue aucune action locale.

  + *Aucun message n'est en transit* : pour tout couple $(i, j)$, il n'existe aucun
    message envoyé par $P_i$ à $P_j$ qui n'ait pas encore été reçu par $P_j$.
]

Cette définition met en lumière la difficulté fondamentale : les messages en transit sont
*invisibles* à un observateur externe. Un gestionnaire qui ne surveille que les états des
processus ne peut pas savoir combien de messages circulent encore dans le réseau.

#ex(info: "Échec de la détection naïve")[
  Supposons deux processus $P_1$ et $P_2$. $P_1$ est actif, envoie un message $m$ à
  $P_2$ à l'instant $t = 1.5$, puis devient inactif à $t = 2$. $P_2$, de son côté,
  termine ses propres calculs et devient inactif à $t = 2.5$.

  Un gestionnaire qui vérifie les états à $t = 2.5$ constate : $P_1$ inactif, $P_2$
  inactif. Il déclare la terminaison. C'est une erreur : le message $m$ n'a pas encore
  été délivré. À $t = 3$, $P_2$ reçoit $m$, se réactive, et reprend le calcul.
]

#figure(
  include "figures/termination-problem.typ",
  caption: [
    Illustration de l'échec de la détection naïve. $P_1$ envoie un message $m$ à $t=1.5$
    puis devient inactif à $t=2$ ; $P_2$ devient inactif à $t=2.5$. Le gestionnaire déclare
    à tort la terminaison — mais $m$ est encore en transit et réactivera $P_2$ à $t=3$.
  ],
)

#insight[
  La difficulté fondamentale est que l'état global visible (les états des processus) et
  l'état global réel (incluant les messages en transit) divergent. Toute solution au
  problème doit donc, d'une façon ou d'une autre, *comptabiliser les messages en vol*.
  Les trois algorithmes que nous allons étudier utilisent des mécanismes différents pour
  réaliser ce comptage : un jeton coloré, des compteurs par processus, ou une fraction de
  « crédit ».
]

== Jeton de Dijkstra–Safra

La première solution que nous présentons est applicable dans un modèle synchrone où les
processus sont organisés en *anneau* : $P_1 arrow.r P_2 arrow.r dots.c arrow.r P_n arrow.r P_1$, chaque
processus n'ayant pour voisin de droite que le processus suivant. Le processus $P_1$
joue le rôle d'*initiateur* : c'est lui qui déclenche la détection et interprète le résultat.

L'idée centrale est de faire circuler un *jeton* sur l'anneau. Lorsque le jeton revient à
$P_1$ après un tour complet, $P_1$ peut tenter de conclure à la terminaison. Pour détecter
les messages envoyés « à rebours » dans l'anneau (c'est-à-dire d'un processus $P_i$ vers
un processus $P_j$ avec $j < i$, ce qui pourrait réactiver un processus déjà visité par
le jeton), on utilise une *couleur* associée au jeton.

Chaque processus est coloré *blanc* (inactif, n'a envoyé aucun message depuis qu'il a
tenu le jeton) ou *rouge* (actif, ou a envoyé un message à un processus en amont dans
l'anneau depuis la dernière fois qu'il a tenu le jeton). Le jeton lui-même est blanc ou
noir.

#algo("Jeton de Dijkstra–Safra")[
  Chaque processus $P_i$ maintient une couleur locale : *blanc* ou *rouge*.

  + *Initialisation.* $P_1$ crée un jeton *blanc* et le transmet à $P_2$.

  + *Réception du jeton par $P_i$ ($i > 1$).*
    - Si $P_i$ est *rouge* (actif) : $P_i$ attend de devenir inactif.
    - Si $P_i$ a envoyé des messages depuis son dernier passage du jeton :
      le jeton devient *noir* (contamination irréversible).
    - $P_i$ transmet le jeton (possiblement noirci) à $P_(i+1)$.

  + *Réception du jeton par $P_1$.*
    - Si le jeton est *blanc* et $P_1$ a été inactif pendant tout le tour :
      *terminaison détectée*.
    - Sinon : $P_1$ détruit le jeton et en recrée un blanc ; recommencer.
]

#thm(info: "Correction du jeton de Dijkstra–Safra")[
  L'algorithme du jeton de Dijkstra–Safra est *correct* : si $P_1$ détecte la terminaison
  (jeton blanc revenant à $P_1$ avec $P_1$ inactif pendant tout le tour), alors le calcul
  est effectivement globalement terminé.

  Réciproquement, si le calcul termine, $P_1$ détectera la terminaison en un nombre fini
  de tours.
]

#proof[
  *Sûreté (pas de fausse détection).* Supposons que $P_1$ reçoive un jeton blanc alors
  qu'il était inactif pendant tout le tour. Un jeton blanc signifie qu'aucun processus
  $P_i$ visité n'a envoyé de message à un processus $P_j$ avec $j < i$ (sinon le jeton
  serait noir). Tous les processus ayant passé le jeton étaient inactifs au moment du
  passage. Aucun message envoyé à rebours n'a pu réactiver un processus déjà visité.
  Donc, au moment où $P_1$ conclut, tous les processus sont bien inactifs et aucun message
  vers un processus antérieur n'est en transit.

  *Vivacité (détection éventuelle).* Si le calcul termine à un instant $T$, alors à
  partir de $T$ tous les processus restent inactifs et n'envoient plus de messages. Le
  prochain tour de jeton initié après $T$ sera entièrement blanc, et $P_1$ détectera la
  terminaison.
]

#rmk[
  Le mécanisme de contamination par la couleur noire est la clef de la correction. Un
  processus $P_i$ qui envoie un message à $P_j$ avec $j < i$ *après* que le jeton ait
  déjà visité $P_j$ pourrait faire croire à tort que $P_j$ est définitivement inactif.
  En noircissant le jeton, $P_i$ force $P_1$ à lancer un nouveau tour, permettant ainsi
  à $P_j$ d'être observé à nouveau après réception du message.
]

#figure(
  include "figures/dijkstra-safra.typ",
  caption: [
    Jeton de Dijkstra–Safra sur un anneau de trois processus. *Gauche :* le jeton reste
    blanc tout au long du tour — tous les processus étaient inactifs et aucun message
    n'a été envoyé à rebours ; $P_1$ conclut à la terminaison. *Droite :* un processus
    contamine le jeton en noir car il a envoyé des messages depuis son dernier passage ;
    $P_1$ lance un nouveau tour avec un jeton blanc.
  ],
)

== Algorithme de Safra (asynchrone)

Le jeton de Dijkstra–Safra suppose un modèle synchrone et une topologie en anneau. Dans
un système *asynchrone* de topologie quelconque, on ne peut pas garantir que les messages
sont délivrés dans un ordre connu. Safra a proposé une généralisation qui remédie à ces
limitations en associant à chaque processus un *compteur de messages* qui trace
explicitement le nombre de messages envoyés et reçus.

L'idée est la suivante : si la somme de tous les compteurs vaut zéro, alors le nombre de
messages envoyés est exactement égal au nombre de messages reçus — autrement dit, tous les
messages en transit ont été délivrés. Couplée à la condition « tous les processus
inactifs », cette observation suffit à garantir la terminaison globale.

#algo("Safra avec compteurs")[
  Chaque processus $P_i$ maintient un compteur entier $c_i$, initialisé à $0$, et une
  couleur locale *blanc* (inactif) ou *rouge* (actif).

  - *Envoi d'un message par $P_i$ :* $c_i := c_i + 1$.
  - *Réception d'un message par $P_i$ :* $c_i := c_i - 1$.

  Le jeton circule sur l'anneau et porte une *somme accumulée* $S$ (initialement $0$) et
  une couleur (blanc ou noir).

  + *Initialisation.* $P_1$ (inactif) crée un jeton avec $S = 0$, couleur *blanc*.

  + *Transmission par $P_i$.*
    - Si $P_i$ est rouge : attendre de devenir inactif (blanc).
    - Mettre à jour : $S := S + c_i$.
    - Si $P_i$ était rouge depuis le dernier passage : jeton $:=$ noir.
    - Transmettre le jeton à $P_(i+1)$.

  + *Réception par $P_1$.*
    - Si le jeton est blanc, $P_1$ est inactif, et $S + c_1 = 0$ : *terminaison détectée*.
    - Sinon : remettre le compteur à zéro, lancer un nouveau tour avec $S = 0$, blanc.
]

#thm(info: "Correction de Safra")[
  L'algorithme de Safra est correct. La condition $sum_(i=1)^(n) c_i = 0$ est
  équivalente à « aucun message n'est en transit » si tous les processus ont contribué
  leur compteur au jeton pendant le même tour.

  Formellement : la terminaison est détectée si et seulement si le calcul est
  globalement terminé.
]

#proof[
  Chaque envoi incrémente un $c_i$ de $1$, et chaque réception décrémente un $c_j$ de
  $1$. Si tout message envoyé a été reçu, alors pour chaque message $m$ envoyé par $P_i$
  et reçu par $P_j$, la contribution $+1$ à $c_i$ et $-1$ à $c_j$ se compensent. La
  somme globale $sum c_i$ est donc nulle si et seulement si le nombre de messages reçus
  est égal au nombre de messages envoyés, c'est-à-dire si aucun message n'est en transit.

  La condition de couleur blanche du jeton garantit qu'aucun processus n'a été réactivé
  après avoir transmis le jeton, de sorte que les compteurs collectés reflètent bien
  l'état au moment de la collecte.
]

#rmk[
  L'avantage majeur de l'algorithme de Safra sur le jeton de Dijkstra est qu'il fonctionne
  dans un modèle *asynchrone* : les processus n'ont pas besoin de se synchroniser sur un
  cycle d'horloge commun. Les messages peuvent être retardés arbitrairement. Cela rend
  l'algorithme applicable à une classe beaucoup plus large de systèmes distribués réels.
  En contrepartie, la preuve de correction est plus délicate car les compteurs sont
  collectés à des instants différents.
]

== Schéma de crédit de Mattern

L'algorithme de Mattern adopte une approche radicalement différente, inspirée de la
comptabilité financière : chaque processus et chaque message dispose d'une fraction de
*crédit*, et la terminaison est détectée quand l'initiateur a récupéré la totalité du
crédit distribué dans le système.

Ce schéma est particulièrement adapté aux *calculs diffusants* (_diffusing computations_),
c'est-à-dire les calculs qui démarrent à partir d'un seul processus initiateur et se
propagent en créant dynamiquement des « sous-tâches » qui peuvent elles-mêmes en créer
d'autres. L'arbre de calcul n'est pas connu à l'avance, ce qui rend inapplicables les
approches basées sur une topologie fixe.

#algo("Schéma de crédit de Mattern")[
  L'initiateur $P_1$ démarre avec un crédit total de $1$.

  + *Envoi d'un message par $P_i$ :* $P_i$ divise son crédit courant par $2$ ; il
    conserve la moitié et attache l'autre moitié au message.

  + *Réception d'un message par $P_j$ :* $P_j$ ajoute le crédit reçu à son crédit local.

  + *Fin de calcul de $P_i$ :* $P_i$ retourne son crédit résiduel à l'initiateur $P_1$
    (par un message de retour).

  + *Détection.* Quand $P_1$ a collecté un crédit total égal à $1$, le calcul est
    globalement terminé.
]

#insight[
  Le schéma de crédit est une astuce comptable élégante : chaque fraction de crédit
  représente une « dette » d'un processus ou d'un message envers l'initiateur. Aussi
  longtemps qu'un message est en transit ou qu'un processus est actif, une fraction du
  crédit est « immobilisée ». Quand le crédit total revient à $1$, cela signifie que toutes
  les dettes ont été remboursées — tous les processus ont terminé et tous les messages ont
  été reçus. La division par deux assure que le crédit total dans le système est toujours
  conservé (il se redistribue sans être créé ni détruit) et peut être arbitrairement
  petit pour les calculs très ramifiés, ce qui peut poser des problèmes de précision en
  virgule flottante. En pratique, on représente le crédit en notation exacte (fractions ou
  entiers binaires).
]

Les trois algorithmes présentés dans ce chapitre résolvent le même problème fondamental
avec des compromis différents. Le jeton de Dijkstra–Safra est simple et efficace pour
les anneaux synchrones. L'algorithme de Safra généralise au cas asynchrone au prix d'une
légère complexité supplémentaire. Le schéma de crédit de Mattern est le plus général : il
s'applique à n'importe quel calcul diffusant, sans supposer une topologie fixe ni un modèle
synchrone. Le choix entre ces approches dépend des hypothèses du modèle et de la structure
du calcul distribué considéré.
