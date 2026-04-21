#import "preamble.typ": *

= Instantanés globaux

Un système distribué en cours d'exécution est, par nature, un objet difficile à observer.
Chaque processus possède un état local qui évolue continuellement, et les canaux de
communication transportent des messages dont ni l'expéditeur ni le destinataire ne connaît
exactement la position dans le réseau à un instant donné. Pourtant, de nombreuses tâches
essentielles — la vérification d'invariants globaux, la détection de blocages (_deadlocks_),
la reprise sur erreur (_checkpointing_), ou encore le débogage — nécessitent de prendre
une « photographie » cohérente de l'état global du système à un instant donné.

Le problème de l'*instantané global* (_global snapshot_) consiste précisément à capturer
cet état de manière cohérente, c'est-à-dire de façon à ce que la photo résultante
corresponde à un état que le système aurait pu effectivement traverser dans une exécution
séquentielle. La difficulté fondamentale est qu'il est impossible d'arrêter le système
pour le photographier : les processus continuent d'envoyer et de recevoir des messages
pendant la procédure de capture. Il faut donc concevoir un protocole distribué qui
coordonne la prise de photo *sans perturber le calcul en cours*.

Ce chapitre développe les notions de coupe cohérente et d'état global cohérent, puis
présente deux algorithmes classiques : Chandy–Lamport pour les canaux FIFO, et Lai–Yang
pour les canaux non-FIFO.

== État global et coupe cohérente

Pour formaliser ce que signifie un « état global cohérent », nous devons d'abord
introduire le vocabulaire des historiques de processus et des coupes.

#defn(info: "Historique d'un processus")[
  L'*historique* du processus $P_i$, noté $h_i$, est la séquence (totalement ordonnée)
  de tous les événements que $P_i$ a exécutés :

  $ h_i = (e_i^1, e_i^2, e_i^3, dots) $

  où $e_i^k$ désigne le $k$-ième événement de $P_i$. Un événement est soit une action
  locale, soit un envoi de message, soit une réception de message.
]

#defn(info: "Coupe")[
  Une *coupe* $C$ d'un système à $n$ processus est un tuple $C = (c_1, c_2, dots, c_n)$
  où $c_i in bb(N)$ représente le nombre d'événements de $P_i$ inclus dans la coupe.
  La coupe $C$ sélectionne le préfixe $(e_i^1, dots, e_i^(c_i))$ de chaque historique
  local $h_i$.

  L'*état global* associé à la coupe $C$ est la collection des états locaux
  $(s_1^(c_1), s_2^(c_2), dots, s_n^(c_n))$ où $s_i^(c_i)$ est l'état de $P_i$ après
  son $c_i$-ième événement.
]

Une coupe sépare le passé du futur pour chaque processus, mais elle ne garantit pas en
elle-même la cohérence. Un problème se pose quand un message semble avoir été reçu avant
d'avoir été envoyé : cela signifie que l'envoi se situe *après* la coupe sur le processus
émetteur, mais la réception se situe *avant* la coupe sur le processus récepteur. Un tel
état global ne peut jamais avoir existé dans une exécution réelle.

#defn(info: "Coupe cohérente")[
  Une coupe $C = (c_1, dots, c_n)$ est dite *cohérente* si et seulement si : pour tout
  couple d'événements $e$ et $f$,

  $ f in C space "et" space e arrow.r f space.quad arrow.r.double space.quad e in C. $

  Autrement dit, si un événement $f$ est inclus dans la coupe et qu'un événement $e$
  précède causalement $f$, alors $e$ est également inclus dans la coupe.
]

Cette condition peut s'énoncer de manière équivalente en termes de messages : une coupe
est cohérente si et seulement si *aucun message envoyé après la coupe n'est reçu avant
la coupe*. Cette formulation est plus opératoire pour concevoir des algorithmes.

#thm(info: "Caractérisation des coupes cohérentes")[
  Une coupe $C = (c_1, dots, c_n)$ est cohérente si et seulement si : pour tout canal
  $c_(i j)$ de $P_i$ vers $P_j$, le nombre de messages envoyés sur $c_(i j)$ et inclus dans
  $C$ (c'est-à-dire envoyés lors des $c_i$ premiers événements de $P_i$) est supérieur
  ou égal au nombre de messages reçus sur $c_(i j)$ et inclus dans $C$ (c'est-à-dire reçus
  lors des $c_j$ premiers événements de $P_j$).
]

#proof[
  ($arrow.r.double$) Supposons la coupe cohérente. Soit $m$ un message reçu par $P_j$ lors de
  son $k$-ième événement, avec $k lt.eq c_j$ (réception dans la coupe). Alors la réception
  est dans $C$. L'envoi $e$ précède causalement la réception $f$ (règle de communication
  de $arrow.r$). Par cohérence, $e in C$, donc l'envoi a lieu parmi les $c_i$ premiers
  événements de $P_i$. Tout message reçu dans la coupe a donc été envoyé dans la coupe.

  ($arrow.l.double$) Réciproquement, si tout message reçu dans $C$ a été envoyé dans $C$, alors
  il n'y a aucun message envoyé après la coupe et reçu avant, ce qui est précisément la
  définition d'une coupe cohérente.
]

L'*état du canal* $c_(i j)$ dans une coupe cohérente $C$ est l'ensemble des messages envoyés
sur $c_(i j)$ dans la coupe mais pas encore reçus dans la coupe : ce sont les messages
qui étaient en transit au moment de l'instantané.

#ex(info: "Coupe cohérente et incohérente")[
  Considérons trois processus $P_1$, $P_2$, $P_3$ avec les événements suivants :
  $P_1$ envoie $m_1$ à $P_2$ lors de son $3^e$ événement ; $P_2$ reçoit $m_1$ lors de
  son $2^e$ événement.

  - *Coupe cohérente :* $C = (3, 2, 2)$ — l'envoi de $m_1$ (événement 3 de $P_1$) est
    inclus, et la réception de $m_1$ (événement 2 de $P_2$) l'est aussi. Cohérente.

  - *Coupe cohérente avec message en transit :* $C = (3, 1, 2)$ — l'envoi de $m_1$ est
    inclus, mais la réception ne l'est pas ($c_2 = 1$). L'état du canal $c_(12)$ contient
    $m_1$. C'est toujours cohérent : il n'y a pas de message reçu avant d'avoir été envoyé.

  - *Coupe incohérente :* $C = (2, 2, 2)$ — la réception de $m_1$ (événement 2 de $P_2$)
    est incluse, mais l'envoi (événement 3 de $P_1$) ne l'est pas ($c_1 = 2 < 3$). Cela
    correspond à un état global impossible.
]

#figure(
  include "figures/consistent-cut.typ",
  caption: [
    Diagramme espace-temps illustrant une coupe cohérente. Les événements et messages
    *avant* la coupe sont en bleu ; ceux *après* sont en gris. Le message en tirets ambrés
    est envoyé avant la coupe (sur $P_1$) mais reçu après (sur $P_2$) : il constitue l'état
    du canal $c_(12)$. La coupe est cohérente car aucun message n'est reçu avant d'avoir été
    envoyé.
  ],
)

== Algorithme de Chandy–Lamport (canaux FIFO)

L'algorithme de Chandy et Lamport (1985) est la première solution pratique au problème de
l'instantané global. Il suppose que les canaux de communication sont *FIFO* : les messages
émis sur un canal sont reçus dans l'ordre dans lequel ils ont été envoyés. Cette hypothèse
est satisfaite par la grande majorité des protocoles de transport (TCP, par exemple).

L'idée directrice est d'utiliser des messages spéciaux appelés *marqueurs* pour
délimiter la frontière de la coupe sur chaque canal. Un marqueur envoyé par $P_i$ sur le
canal $c_(i j)$ signifie : « J'ai enregistré mon état ; tous les messages que j'ai envoyés
sur ce canal *avant* ce marqueur font partie de l'instantané ; ceux envoyés *après* n'en
font pas partie. » Grâce à la propriété FIFO, $P_j$ sait exactement quels messages de
$c_(i j)$ précèdent la coupe (ceux arrivés avant le marqueur) et lesquels la suivent.

#algo("Chandy–Lamport")[
  Chaque processus $P_i$ maintient un ensemble $"rec"(c_(j i))$ pour chaque canal
  d'entrée $c_(j i)$ : les messages à inclure dans l'état du canal.

  + *Déclenchement (par n'importe quel processus $P_i$).*
    - $P_i$ enregistre son état local $s_i$.
    - $P_i$ envoie un *MARQUEUR* sur chacun de ses canaux de sortie.
    - $P_i$ commence à enregistrer les messages reçus sur chacun de ses canaux d'entrée.

  + *Réception d'un MARQUEUR par $P_i$ sur le canal $c_(j i)$.*
    - *Si $P_i$ n'a pas encore enregistré son état :*
      - Enregistrer l'état local $s_i$ maintenant.
      - L'état du canal $c_(j i)$ est *vide* (le marqueur arrive avant tout message
        post-coupe de $P_j$).
      - Envoyer un MARQUEUR sur tous les canaux de sortie.
      - Commencer l'enregistrement sur tous les autres canaux d'entrée.
    - *Si $P_i$ a déjà enregistré son état :*
      - L'état du canal $c_(j i)$ est l'ensemble des messages reçus sur $c_(j i)$ depuis
        l'enregistrement de l'état de $P_i$ jusqu'à la réception de ce marqueur.
      - Arrêter l'enregistrement sur $c_(j i)$.

  + *Terminaison.* L'algorithme se termine quand tous les processus ont enregistré leur
    état et quand l'état de chaque canal a été déterminé.
]

#thm(info: "Correction de Chandy–Lamport")[
  L'état global enregistré par l'algorithme de Chandy–Lamport est une *coupe cohérente* :
  il correspond à un état global que le système a pu effectivement traverser dans une
  exécution correcte.
]

#proof[
  Il suffit de montrer que l'état enregistré ne contient aucun message reçu avant son
  envoi. Soit $m$ un message envoyé par $P_i$ à $P_j$. Deux cas se présentent :

  - *$m$ est envoyé avant que $P_i$ n'enregistre son état.* Alors $m$ est envoyé avant
    le marqueur de $P_i$ sur $c_(i j)$. Par FIFO, $m$ arrive avant le marqueur chez $P_j$.
    Soit $P_j$ enregistre son état à la réception du marqueur : $m$ est arrivé avant, donc
    il est dans l'état du canal $c_(i j)$ si $P_j$ avait déjà enregistré son état, ou il
    est inclus implicitement dans l'état local de $P_j$ sinon. Dans les deux cas, la
    réception de $m$ est dans la coupe.
  - *$m$ est envoyé après que $P_i$ a enregistré son état.* Alors $m$ est envoyé après
    le marqueur de $P_i$. Par FIFO, $m$ arrive après le marqueur chez $P_j$, donc après
    que $P_j$ a enregistré son propre état. La réception de $m$ n'est pas dans la coupe.

  Dans les deux cas, il n'y a pas de message reçu dans la coupe mais envoyé hors de la
  coupe. La coupe est donc cohérente.
]

#rmk[
  L'hypothèse FIFO est *indispensable* à la correction. Si les messages pouvaient se
  dépasser sur un canal, un message $m$ envoyé après le marqueur pourrait arriver avant
  lui chez $P_j$. $P_j$ enregistrerait alors $m$ dans l'état du canal, alors que $m$
  est postérieur à la coupe sur $P_i$ — produisant une coupe incohérente.
]

#ex(info: "Trace de l'algorithme de Chandy–Lamport")[
  Considérons trois processus $P_1$, $P_2$, $P_3$ dans un réseau quelconque.

  + $P_1$ décide d'initier le snapshot. Il enregistre son état local $s_1$, puis envoie
    un MARQUEUR sur $c_(12)$ et sur $c_(13)$.

  + Avant l'arrivée du MARQUEUR, $P_2$ reçoit un message applicatif $m_2$ de $P_1$.

  + $P_2$ reçoit le MARQUEUR de $P_1$. Comme $P_2$ n'a pas encore enregistré son état,
    il enregistre $s_2$ maintenant. L'état du canal $c_(12)$ est vide (le MARQUEUR est le
    premier message post-coupe). $P_2$ envoie un MARQUEUR sur $c_(23)$.

  + $P_3$ reçoit le MARQUEUR de $P_1$ en premier. Il enregistre $s_3$ et commence à
    enregistrer les messages reçus sur $c_(23)$.

  + $P_3$ reçoit le message $m_3$ de $P_2$ (envoyé avant le MARQUEUR de $P_2$). Ce
    message est ajouté à l'état du canal $c_(23)$.

  + $P_3$ reçoit le MARQUEUR de $P_2$. L'état du canal $c_(23)$ est ${m_3}$.

  L'instantané global est $(s_1, s_2, s_3)$ avec état de canal $c_(12) = emptyset$,
  $c_(13) = emptyset$, $c_(23) = {m_3}$.
]

#figure(
  include "figures/chandy-lamport.typ",
  caption: [
    Trace de l'algorithme de Chandy–Lamport sur trois processus. Les lignes verticales
    pointillées vertes indiquent les moments d'enregistrement des états locaux. Les flèches
    violettes sont les MARQUEURS. Le rectangle ambré délimite l'état du canal $c_(23)$ :
    le message $m_2$ envoyé par $P_2$ avant son enregistrement mais reçu par $P_3$ après
    que $P_3$ a enregistré son état.
  ],
)

== Lai–Yang (canaux non-FIFO)

Lorsque les canaux de communication ne sont *pas FIFO*, l'approche de Chandy–Lamport
échoue : un message $m$ envoyé après le marqueur pourrait arriver avant lui chez le
destinataire, brouillant la frontière de la coupe. L'algorithme de Lai et Yang (1987)
contourne ce problème en supprimant entièrement les marqueurs explicites, au profit d'un
mécanisme de *coloration* et de *piggybacking* (ajout d'informations aux messages
applicatifs).

L'intuition est simple : avant le snapshot, les processus sont *blancs* ; après avoir
décidé de participer au snapshot, ils deviennent *rouges*. Tout message envoyé par un
processus *rouge* est lui-même marqué rouge. Lorsqu'un processus blanc reçoit un message
rouge, il sait que l'expéditeur a déjà pris son snapshot : il doit donc prendre le sien
avant de traiter ce message (pour que sa coupe soit cohérente avec celle de l'expéditeur).

#algo("Lai–Yang")[
  Chaque processus est *blanc* au départ. Un processus qui a enregistré son état est dit
  *rouge*.

  + *Déclenchement du snapshot par $P_i$.*
    - $P_i$ passe à l'état rouge et enregistre son état local $s_i$.
    - À partir de maintenant, tous les messages envoyés par $P_i$ sont *rouges* (marqués
      en piggybacking).

  + *Envoi d'un message $m$ par $P_i$.*
    - Si $P_i$ est rouge : $m$ est marqué rouge.
    - Si $P_i$ est blanc : $m$ est marqué blanc.

  + *Réception d'un message rouge par $P_j$ (blanc).*
    - $P_j$ enregistre son état local $s_j$ *avant* de traiter $m$.
    - $P_j$ passe rouge.
    - Le message $m$ (rouge) n'est *pas* inclus dans l'état du canal (il est postérieur à
      la coupe de $P_i$).

  + *Réception d'un message blanc par $P_j$ (rouge).*
    - Ce message a été envoyé avant que l'expéditeur devienne rouge, donc avant la coupe
      de l'expéditeur. Mais $P_j$ est déjà rouge, donc ce message est en transit à travers
      la coupe.
    - $P_j$ l'ajoute à l'état du canal $c_(i j)$.
]

#thm(info: "Correction de Lai–Yang")[
  L'état global enregistré par l'algorithme de Lai–Yang est une coupe cohérente, même
  dans les systèmes à canaux non-FIFO.
]

#proof[
  Soit $m$ un message envoyé par $P_i$ à $P_j$. Quatre cas selon les couleurs à l'envoi
  et à la réception :

  - *$m$ blanc, $P_j$ blanc lors de la réception.* $m$ est envoyé et reçu avant les
    snapshots respectifs. L'envoi et la réception sont tous deux dans la coupe (ou tous
    deux hors de la coupe si les snapshots ont lieu après). Cohérent.

  - *$m$ blanc, $P_j$ rouge lors de la réception.* $m$ a été envoyé avant le snapshot de
    $P_i$, mais reçu après le snapshot de $P_j$. $P_j$ ajoute $m$ à l'état du canal :
    la coupe reconnaît que $m$ était en transit. Cohérent.

  - *$m$ rouge, $P_j$ blanc lors de la réception.* $P_j$ reçoit un message rouge alors
    qu'il est encore blanc : il doit *d'abord* enregistrer son état avant de traiter $m$.
    Donc le snapshot de $P_j$ est antérieur à la réception de $m$. $m$ est donc reçu après
    la coupe de $P_j$. Or $m$ rouge est envoyé après la coupe de $P_i$. Pas de problème.

  - *$m$ rouge, $P_j$ rouge lors de la réception.* Les deux snapshots sont antérieurs à
    l'envoi et à la réception de $m$. $m$ est hors coupe. Cohérent.

  Dans tous les cas, aucun message n'est reçu dans la coupe sans avoir été envoyé dans
  la coupe. La coupe est cohérente.
]

#rmk[
  L'algorithme de Lai–Yang évite d'envoyer des messages MARQUEUR supplémentaires sur
  chaque canal (ce qui nécessiterait $O(n^2)$ messages supplémentaires pour un graphe
  complet). En attachant les informations de couleur aux messages applicatifs
  (_piggybacking_), le surcoût en messages est nul : seul un bit de couleur est ajouté à
  chaque message. En revanche, l'algorithme requiert que chaque processus conserve en
  mémoire les messages blancs reçus après son passage au rouge, jusqu'à ce que tous les
  expéditeurs potentiels soient devenus rouges.
]

#insight[
  La couleur dans Lai–Yang joue le même rôle conceptuel que le marqueur dans
  Chandy–Lamport : elle délimite la frontière de la coupe sur chaque canal. La différence
  est que dans Chandy–Lamport, le marqueur est un message *explicite* qui se déplace dans
  le canal, tirant parti de l'ordre FIFO ; dans Lai–Yang, la couleur est une information
  *implicite* attachée à chaque message, ce qui permet de fonctionner sans hypothèse
  d'ordre sur les canaux.
]

Les deux algorithmes présentés dans ce chapitre illustrent un principe général important
en algorithmique distribuée : la même spécification (coupe cohérente) peut être réalisée
par des mécanismes très différents, chacun adapté aux hypothèses du modèle sous-jacent.
Dans les systèmes réels, le choix entre ces deux algorithmes — ou leurs nombreuses
variantes — dépend des garanties offertes par la couche réseau et du budget en messages
supplémentaires que l'application peut se permettre.
