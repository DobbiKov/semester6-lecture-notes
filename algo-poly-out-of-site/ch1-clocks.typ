#import "preamble.typ": *

= Horloges logiques

Les systèmes distribués posent une difficulté fondamentale qui n'existe pas dans les
systèmes centralisés : en l'absence d'une mémoire partagée et d'une horloge physique
commune, il est impossible de savoir, en toute généralité, dans quel ordre absolu se sont
produits les événements répartis sur plusieurs processus. Ce chapitre construit, pas à pas,
les outils conceptuels qui permettent de raisonner sur le temps dans un système distribué :
la relation de causalité de Lamport, les horloges scalaires, et les horloges vectorielles.

== Causalité et relation « happens-before »

Dans un système distribué, les processus n'ont accès à aucune horloge globale. La
seule information temporelle fiable qu'un processus $P_i$ possède est l'ordre dans lequel
*il* a lui-même exécuté ses propres événements. Pour comparer des événements appartenant
à des processus différents, il faut donc s'appuyer sur une notion plus abstraite : la
*causalité*, c'est-à-dire la possibilité qu'un événement ait pu influencer un autre.

#defn(info: "Système distribué")[
  Un *système distribué* est un ensemble de $n$ processus $P_1, P_2, dots, P_n$ qui
  communiquent exclusivement par échange de messages (il n'y a pas de mémoire partagée).
  Chaque processus $P_i$ possède une *histoire locale* $h_i$, c'est-à-dire une séquence
  totalement ordonnée d'*événements* : des événements locaux (calculs internes), des
  envois de messages (_send_) et des réceptions de messages (_receive_).
]

L'ensemble des événements de tous les processus forme l'*histoire globale* du système.
La question centrale est : peut-on définir un ordre partiel sur ces événements qui reflète
fidèlement les relations de cause à effet ? C'est précisément ce qu'a proposé Leslie
Lamport en 1978 avec la relation « _happens-before_ ».

#defn(info: "Relation happens-before (→)")[
  La relation *happens-before*, notée $arrow.r$, est le plus petit ordre strict sur les
  événements du système vérifiant les trois règles suivantes :

  + *Ordre local.* Si $e$ et $f$ sont deux événements d'un même processus $P_i$ et que
    $e$ précède $f$ dans l'histoire locale de $P_i$, alors $e arrow.r f$.

  + *Communication.* Si $e$ est l'envoi d'un message $m$ et $f$ est la réception de ce
    même message $m$ (par un processus éventuellement différent), alors $e arrow.r f$.

  + *Transitivité.* Si $e arrow.r f$ et $f arrow.r g$, alors $e arrow.r g$.
]

#rmk[
  La relation $arrow.r$ définit un *ordre strict partiel* sur l'ensemble des événements :
  elle est *irréflexive* (aucun événement ne précède lui-même), *asymétrique* (si
  $e arrow.r f$ alors il est impossible que $f arrow.r e$) et *transitive* par
  construction. Elle ne définit pas un ordre total : deux événements peuvent ne pas être
  comparables.
]

Lorsque deux événements ne sont reliés ni dans un sens ni dans l'autre par la relation
$arrow.r$, on dit qu'ils sont *concurrents*. Cette notion est fondamentale : elle exprime
qu'aucune information ne peut avoir circulé de l'un vers l'autre, et donc que ces deux
événements ont pu se produire « simultanément » du point de vue du système.

#defn(info: "Événements concurrents")[
  Deux événements $e$ et $f$ sont dits *concurrents*, noté $e parallel f$, si et
  seulement si

  $ not (e arrow.r f) quad "et" quad not (f arrow.r e). $
]

#ex(info: "Chaîne causale et concurrence")[
  Considérons trois processus $P_1$, $P_2$, $P_3$. $P_1$ produit un événement $e_1$,
  puis envoie un message à $P_2$. La réception de ce message par $P_2$ constitue
  l'événement $e_2$. $P_2$ envoie ensuite un message à $P_3$, reçu par $P_3$ comme
  événement $e_3$. On a donc la *chaîne causale*

  $ e_1 arrow.r e_2 arrow.r e_3. $

  Par transitivité, $e_1 arrow.r e_3$. Séparément, $P_1$ produit un événement $e_4$
  postérieur à $e_1$ dans son histoire locale, mais *aucun message* ne relie $e_4$ à
  $e_2$ ou à $e_3$. On a donc $e_4 parallel e_2$ et $e_4 parallel e_3$ : ni $e_4$ n'a
  pu influencer $e_2$, ni $e_2$ n'a pu influencer $e_4$.
]

#figure(
  include "figures/causality.typ",
  caption: [Diagramme espace-temps illustrant la causalité. Les flèches bleues
    représentent la chaîne causale $e_1 arrow.r e_2 arrow.r e_3$ ; la ligne pointillée
    verte indique la concurrence $e_4 parallel e_2$.],
)

== Horloges de Lamport (scalaires)

Disposer d'une relation de causalité est utile sur le plan conceptuel, mais les
algorithmes distribués ont souvent besoin de *timestamps* — des entiers attachés aux
événements — qui respectent la causalité et permettent des comparaisons simples. Lamport
a proposé à cet effet une construction remarquablement simple : l'*horloge logique
scalaire*.

L'idée directrice est la suivante. Chaque processus maintient un compteur entier qui
représente sa vision locale du « temps logique ». Avant tout événement, ce compteur est
incrémenté ; lors d'une réception, le compteur est mis à jour pour tenir compte de
l'estampille reçue. Ainsi, si un message porte l'estampille $t$, le processus récepteur
sait qu'au moins $t$ événements ont eu lieu causalement avant cet instant.

#algo("Horloge de Lamport")[
  Chaque processus $P_i$ maintient un compteur entier $C_i$, initialisé à $0$. Les règles
  de mise à jour sont :

  + *Avant tout événement local ou envoi :* $C_i := C_i + 1$.

  + *Envoi d'un message :* $P_i$ attache la valeur courante $C_i$ au message sous forme
    d'estampille $"ts"$.

  + *Réception d'un message portant l'estampille* $"ts"$ : $C_i := max(C_i, "ts") + 1$.
]

La règle de réception garantit que le compteur du processus récepteur dépasse
strictement l'estampille du message reçu, ce qui encode le fait que la réception est
postérieure à l'envoi.

#thm(info: "Cohérence des horloges de Lamport")[
  Pour tout couple d'événements $e$ et $f$,

  $ e arrow.r f space.med arrow.r.double space.med L(e) < L(f), $

  où $L(e)$ désigne l'estampille de Lamport de l'événement $e$.
]

#proof[
  On raisonne par induction sur la définition de $arrow.r$.

  - *Règle 1 (ordre local).* Si $e$ et $f$ sont deux événements successifs de $P_i$ avec
    $e$ avant $f$, alors $C_i$ a été incrémenté au moins une fois entre $e$ et $f$, donc
    $L(f) > L(e)$.

  - *Règle 2 (communication).* Si $e$ est l'envoi et $f$ la réception du même message,
    alors $L(f) = max(L(f'), L(e)) + 1 gt.eq L(e) + 1 > L(e)$, où $L(f')$ est la valeur
    du compteur avant la mise à jour.

  - *Règle 3 (transitivité).* Si $e arrow.r g arrow.r f$, par hypothèse d'induction
    $L(e) < L(g)$ et $L(g) < L(f)$, donc $L(e) < L(f)$.
]

#rmk(info: "Limitation fondamentale")[
  La réciproque du théorème précédent est *fausse* en général :

  $ L(e) < L(f) space.med arrow.r.not space.med e arrow.r f. $

  Deux événements concurrents $e parallel f$ peuvent très bien recevoir des estampilles
  telles que $L(e) < L(f)$. Les horloges de Lamport permettent de savoir qu'un événement
  est *peut-être* antérieur à un autre, mais elles ne permettent pas de détecter la
  concurrence.
]

#insight[
  Les horloges de Lamport produisent une *extension linéaire* de l'ordre partiel causal :
  elles placent tous les événements sur une droite numérique cohérente avec $arrow.r$,
  mais en « aplatissant » des événements concurrents qui n'avaient aucun lien. C'est
  suffisant pour certains algorithmes (exclusion mutuelle de Lamport, par exemple), mais
  insuffisant pour détecter la concurrence ou caractériser exactement la causalité.
]

#ex(info: "Trace d'horloge de Lamport")[
  Considérons deux processus $P_1$ et $P_2$ (compteurs initiaux $C_1 = C_2 = 0$).

  - $P_1$ produit un événement local : $C_1 := 1$, estampille $L = 1$.
  - $P_1$ envoie un message : $C_1 := 2$, estampille attachée $"ts" = 2$.
  - $P_1$ produit un autre événement local : $C_1 := 3$, estampille $L = 3$.
  - $P_2$ reçoit le message de $P_1$ ($"ts" = 2$) :
    $C_2 := max(0, 2) + 1 = 3$, estampille $L = 3$.
  - $P_2$ produit un événement local : $C_2 := 4$, estampille $L = 4$.

  On constate que l'événement local de $P_1$ (estampille $3$) et la réception par $P_2$
  (estampille $3$) sont *concurrents*, pourtant ils partagent la même valeur d'horloge.
  La distinction devient impossible avec les seules horloges scalaires.
]

#figure(
  include "figures/lamport-clocks.typ",
  caption: [Trace d'horloge de Lamport sur deux processus. Les valeurs $C$ encadrées
    indiquent l'estampille associée à chaque événement ; la flèche pointillée bleue
    représente le message.],
)

== Horloges vectorielles (Fidge–Mattern)

Les horloges de Lamport souffrent d'une asymétrie gênante : elles préservent la
causalité dans un sens ($e arrow.r f arrow.r.double L(e) < L(f)$) mais ne la
caractérisent pas dans l'autre. Pour pallier cette limitation, Colin Fidge et Friedemann
Mattern ont proposé indépendamment, en 1988, les *horloges vectorielles*, qui réalisent
une équivalence complète entre ordre causal et comparaison d'estampilles.

L'idée clé est que chaque processus ne maintient plus un simple entier, mais un *vecteur*
d'entiers de taille $n$ — un par processus. La $k$-ième composante du vecteur de $P_i$
représente le nombre d'événements de $P_k$ dont $P_i$ a connaissance (directement ou
par transitvité des messages reçus).

#defn(info: "Horloge vectorielle")[
  Chaque processus $P_i$ ($1 lt.eq i lt.eq n$) maintient un vecteur $V_i in bb(N)^n$,
  initialisé à $(0, 0, dots, 0)$. La composante $V_i [k]$ représente le nombre
  d'événements du processus $P_k$ que $P_i$ connaît causalement.

  L'*estampille vectorielle* d'un événement $e$ exécuté par $P_i$ est la valeur $V_i$
  *après* la mise à jour liée à $e$, notée $V(e)$.
]

#algo("Algorithme des horloges vectorielles")[
  Chaque processus $P_i$ maintient un vecteur $V_i in bb(N)^n$, initialisé à zéro.

  + *Avant tout événement local ou envoi :* $V_i [i] := V_i [i] + 1$.

  + *Envoi d'un message :* $P_i$ attache le vecteur courant $V_i$ au message.

  + *Réception d'un message de $P_j$ portant le vecteur $V_"msg"$ :* pour tout
    $k in {1, dots, n}$, mettre à jour

    $ V_i [k] := max(V_i [k], V_"msg" [k]), $

    puis incrémenter $V_i [i] := V_i [i] + 1$.
]

La mise à jour par maximum lors d'une réception est cruciale : elle propage la
connaissance causale du processus émetteur vers le processus récepteur. Après la
réception, $P_i$ connaît tous les événements que $P_j$ connaissait au moment de l'envoi,
ainsi que l'envoi lui-même.

#defn(info: "Ordre componentwise")[
  Soient $V, W in bb(N)^n$ deux vecteurs d'estampilles. On définit :

  - $V lt.eq W$ si et seulement si $V[k] lt.eq W[k]$ pour tout $k in {1, dots, n}$.
  - $V < W$ si et seulement si $V lt.eq W$ et $V eq.not W$.
  - $V$ et $W$ sont *incomparables* si ni $V lt.eq W$ ni $W lt.eq V$.
]

#thm(info: "Caractérisation exacte de la causalité")[
  Pour tout couple d'événements $e$ et $f$,

  $ e arrow.r f space.med arrow.l.r space.med V(e) < V(f). $

  Autrement dit, les horloges vectorielles caractérisent *exactement* la relation
  happens-before.
]

Ce résultat est le point fort des horloges vectorielles : contrairement aux horloges de
Lamport, la comparaison des estampilles est une condition *nécessaire et suffisante* pour
la causalité. On peut ainsi décider algorithmiquement si deux événements sont dans une
relation causale ou s'ils sont concurrents, sans ambiguïté.

#cor[
  Deux événements $e$ et $f$ sont concurrents si et seulement si leurs estampilles
  vectorielles sont incomparables :

  $ e parallel f space.med arrow.l.r space.med V(e) "et" V(f) "sont incomparables". $
]

#rmk[
  Le coût des horloges vectorielles est proportionnel au nombre de processus $n$ :
  chaque processus stocke un vecteur de taille $n$, et chaque message transporte
  également un tel vecteur. Dans les grands systèmes distribués ($n$ de l'ordre de
  plusieurs milliers), ce surcoût peut devenir prohibitif. Des variantes compressées
  (horloges matricielles, plumb-bob clocks, etc.) ont été proposées pour réduire ce coût
  au prix de garanties affaiblies.
]

#ex(info: "Trace vectorielle sur trois processus")[
  Considérons trois processus $P_1$, $P_2$, $P_3$ (vecteurs initiaux
  $[0,0,0]$). Le déroulement suivant illustre le mécanisme :

  + $P_1$ produit $e_1$ : $V_1 = [1, 0, 0]$.
  + $P_1$ envoie un message à $P_2$ (événement $s_1$) : $V_1 = [2, 0, 0]$, vecteur
    $[2, 0, 0]$ attaché au message.
  + $P_2$ reçoit le message ($r_1$) : $V_2 := max([0,0,0], [2,0,0]) = [2,0,0]$, puis
    $V_2 [2]++ arrow.r V_2 = [2,1,0]$.
  + $P_2$ envoie un message à $P_3$ ($s_2$, avec $V_2 [2]++$) : $V_2 = [2,2,0]$,
    vecteur $[2,2,0]$ attaché.
  + $P_3$ reçoit le message ($r_2$) : $V_3 := max([0,0,0], [2,2,0]) = [2,2,0]$, puis
    $V_3 [3]++ arrow.r V_3 = [2,2,1]$.
  + $P_1$ produit un événement indépendant $e_2$ (pas de message) : $V_1 = [3,0,0]$.

  *Vérification :*

  - $V(e_1) = [1,0,0] < [2,2,1] = V(r_2)$ (componentwise) $arrow.r.double e_1 arrow.r r_2$. ✓
  - $V(e_2) = [3,0,0]$ et $V(r_1) = [2,1,0]$ : $3 > 2$ mais $0 < 1$, donc les vecteurs
    sont *incomparables* $arrow.r.double e_2 parallel r_1$. ✓
]

#figure(
  include "figures/vector-clocks.typ",
  caption: [Trace d'horloge vectorielle sur trois processus. Les boîtes bleues affichent
    le vecteur $V$ après chaque événement. La flèche pointillée rouge indique deux
    événements incomparables (concurrents) ; la note verte montre une relation $lt.eq$
    attestant la causalité.],
)
