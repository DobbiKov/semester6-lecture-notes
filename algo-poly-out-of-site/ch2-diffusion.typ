#import "preamble.typ": *

= Algorithmes de diffusion

Dans un système distribué, les nœuds ne partagent pas de mémoire commune et ne peuvent communiquer qu'en échangeant des messages via les canaux du réseau. L'une des opérations fondamentales est la *diffusion* (_broadcast_) : un nœud initiateur souhaite transmettre une information à l'ensemble des nœuds du réseau. Ce chapitre étudie plusieurs algorithmes permettant d'accomplir cette tâche, en analysant leur correction, leur complexité en messages et en temps, ainsi que la question de la *détection de terminaison* globale.

On suppose tout au long de ce chapitre que le réseau est modélisé par un graphe connexe non orienté $G = (V, E)$, où $|V| = N$ désigne le nombre de nœuds et $|E|$ le nombre d'arêtes. Les canaux de communication sont supposés fiables (pas de perte de message) et FIFO.

== Diffusion de base : inondation

=== Formulation du problème

Avant de présenter l'algorithme, précisons le problème que nous cherchons à résoudre.

#defn(info: "Problème de diffusion (broadcast)")[
  Étant donné un réseau $G = (V, E)$ connexe et un nœud initiateur $s in V$ qui détient une valeur $m$, le *problème de diffusion* consiste à concevoir un algorithme distribué garantissant que tout nœud $v in V$ reçoit finalement la valeur $m$, même si les nœuds n'ont aucune connaissance préalable de la topologie du réseau.
]

=== L'algorithme d'inondation

L'idée centrale de l'inondation (_flooding_) est d'une simplicité remarquable : chaque nœud, dès la première réception du message, le retransmet à tous ses voisins. Les messages en double (reçus par un nœud déjà informé) sont silencieusement ignorés.

#algo("Inondation (Flooding)")[
  *Initialisation.* Chaque nœud $v in V$ maintient un booléen $"informé"(v)$, initialisé à $"faux"$ pour tout nœud sauf l'initiateur.

  *À l'initiateur $s$* :
  1. Marquer $"informé"(s) <- "vrai"$.
  2. Envoyer le message $m$ à tous les voisins de $s$ : pour tout $w in N(s)$, envoyer $chevron.l m chevron.r$ sur le canal $(s, w)$.

  *À tout nœud $v eq.not s$*, à la réception d'un message $chevron.l m chevron.r$ depuis un voisin $u$ :
  - Si $"informé"(v) = "vrai"$ : ignorer le message (doublon).
  - Si $"informé"(v) = "faux"$ :
    1. Marquer $"informé"(v) <- "vrai"$.
    2. Pour tout voisin $w in N(v) without {u}$ : envoyer $chevron.l m chevron.r$ sur le canal $(v, w)$.
]

#prop(info: "Correction de l'inondation")[
  Si le graphe $G$ est connexe, alors l'algorithme d'inondation garantit que tout nœud $v in V$ reçoit le message $m$ en temps fini.

  *Preuve.* Puisque $G$ est connexe, il existe un chemin $s = v_0, v_1, dots, v_k = v$ entre l'initiateur et tout nœud $v$. On montre par induction sur $i$ que $v_i$ reçoit le message. L'initiateur $v_0 = s$ envoie $m$ à tous ses voisins, en particulier à $v_1$ ; $v_1$ reçoit donc $m$ et, étant alors non informé, le retransmet à ses voisins, dont $v_2$ ; et ainsi de suite. Le nœud $v_k = v$ reçoit ainsi $m$ à l'étape $k$. $square$
]

#prop(info: "Complexité de l'inondation")[
  L'algorithme d'inondation satisfait les bornes de complexité suivantes :
  - *Messages* : au plus $2|E|$ messages sont échangés au total. En pratique, chaque arête $(u,v)$ peut porter au plus un message dans chaque direction : lorsque $u$ informe $v$ et que $v$ rétransmet à $u$, ce dernier message est simplement ignoré. Donc le nombre de messages est exactement le nombre d'arêtes du réseau couvertes par la diffusion, multiplié par 2, soit $O(|E|)$.
  - *Temps* : la diffusion se termine en $O("diam"(G))$ unités de temps, où $"diam"(G)$ est le diamètre du graphe (longueur maximale d'un plus court chemin entre deux nœuds). En effet, chaque nœud à distance $d$ de l'initiateur reçoit le message au plus $d$ tours après le départ.
]

#rmk[
  La règle d'ignorer les messages dupliqués est essentielle pour la terminaison. Sans elle, un nœud pourrait retransmettre indéfiniment des messages reçus par des chemins différents, créant des boucles de diffusion. Le booléen $"informé"(v)$ joue exactement le rôle de garde-fou contre cette situation.
]

=== Exemple : réseau à 4 nœuds

#ex(info: "Trace d'inondation sur 4 nœuds")[
  Considérons le graphe $G$ avec $V = {A, B, C, D}$ et les arêtes $E = {A B, A C, B C, B D, C D}$. L'initiateur est $A$.

  - *Tour 1.* $A$ se marque informé et envoie $m$ à $B$ et $C$ (ses deux voisins).
  - *Tour 2.* $B$ reçoit $m$ de $A$ : se marque informé, retransmet à $C$ et $D$ (en excluant $A$). $C$ reçoit $m$ de $A$ : se marque informé, retransmet à $B$ et $D$ (en excluant $A$).
  - *Tour 3.* $D$ reçoit $m$ de $B$ (et/ou de $C$) : se marque informé, aucune retransmission utile. $B$ reçoit $m$ de $C$ : déjà informé, ignore. $C$ reçoit $m$ de $B$ : déjà informé, ignore.

  Au final, 4 messages utiles sont échangés ($A→B$, $A→C$, $B→D$, $C→D$) et 2 messages dupliqués ($B→C$ et $C→B$) sont ignorés. On a bien $|E| = 5$ arêtes et au plus $2 times 5 = 10$ messages possibles ; ici seulement 6 sont effectivement envoyés.
]

#figure(
  include "figures/flooding.typ",
  caption: [Inondation sur un graphe à 4 nœuds. Les nœuds colorés en bleu foncé (initiateur) et bleu clair (informés) montrent l'état final. Les flèches bleues indiquent le flot de messages effectivement transmis.]
)

== Diffusion sur arbre couvrant

=== Motivation

L'algorithme d'inondation, bien que simple et robuste, souffre d'un défaut : il génère des messages redondants (les doublons ignorés représentent un gaspillage de bande passante). Si le réseau dispose d'un *arbre couvrant* pré-calculé enraciné en l'initiateur, on peut diffuser de manière bien plus économique, sans aucun doublon.

Un arbre couvrant de $G$ est un sous-graphe $T = (V, E_T)$ qui est un arbre (connexe et acyclique) et qui contient tous les nœuds de $G$. Tout graphe connexe admet au moins un arbre couvrant.

=== L'algorithme de diffusion sur arbre

#algo("Diffusion sur arbre couvrant")[
  *Hypothèse.* Chaque nœud $v$ connaît son père $"parent"(v)$ dans l'arbre $T$ (indéfini pour la racine $s$) ainsi que l'ensemble de ses fils $"fils"(v) subset.eq N(v)$.

  *À la racine $s$* :
  1. Envoyer $m$ à chaque fils $f in "fils"(s)$.

  *À tout nœud interne $v eq.not s$*, à la réception de $m$ depuis son père :
  1. Traiter le message (mémoriser $m$).
  2. Pour tout fils $f in "fils"(v)$ : envoyer $m$ à $f$.

  *Aux feuilles* $ell$ (nœuds sans fils), à la réception de $m$ :
  1. Traiter le message. Aucune retransmission.
]

#thm(info: "Optimalité de la diffusion sur arbre")[
  Tout algorithme distribué de diffusion dans un réseau à $N$ nœuds doit envoyer au moins $N-1$ messages. La diffusion sur arbre couvrant est donc optimale en nombre de messages, car elle en envoie exactement $N-1$.

  *Preuve.* Considérons l'état initial : seul l'initiateur $s$ détient le message $m$. Pour qu'un nœud $v eq.not s$ reçoive $m$, il doit recevoir au moins un message le contenant (ou le permettant de le reconstruire). Ces réceptions doivent être *distinctes* : si on supprime tous les messages envoyés, aucun nœud sauf $s$ ne peut être informé. Il faut donc au moins un message par nœud non-initiateur, soit $N-1$ messages au minimum.

  La diffusion sur arbre envoie exactement un message par arête de l'arbre, soit $N-1$ messages (un arbre à $N$ nœuds a $N-1$ arêtes). L'algorithme est donc optimal. $square$
]

#rmk[
  La diffusion sur arbre suppose que l'arbre couvrant est *connu à l'avance* par tous les nœuds participants. En pratique, il faut donc d'abord exécuter un algorithme de construction d'arbre couvrant (voir Chapitre 3). Le coût total inclut alors la construction de l'arbre plus la diffusion elle-même. Néanmoins, si l'arbre peut être réutilisé pour plusieurs diffusions successives, l'investissement initial est largement amorti.
]

#figure(
  include "figures/tree-diffusion.typ",
  caption: [Diffusion sur arbre couvrant à 5 nœuds ($N=5$, donc $N-1=4$ messages en descente). Les flèches bleues pleines représentent la phase de diffusion ; les flèches tiretées teal représentent la phase d'acquittement (détaillée à la section suivante).]
)

== Détection de terminaison par vague d'acquittements

=== Le problème de terminaison

La diffusion sur arbre garantit que tous les nœuds reçoivent le message en exactement $N-1$ messages. Cependant, un problème pratique demeure : *l'initiateur ne sait pas quand la diffusion est terminée*. Il sait qu'il a envoyé ses messages, mais il n'a aucune information sur le moment où le dernier nœud a été informé. Ce problème est particulièrement aigu lorsque la diffusion sert à déclencher une action distribuée et que l'initiateur doit attendre la fin de cette action avant de continuer.

#defn(info: "Terminaison globale de la diffusion")[
  On dit que la diffusion est *globalement terminée* au moment où le dernier nœud $v in V$ a reçu et traité le message $m$. La *détection de terminaison* consiste à permettre à l'initiateur (ou à un observateur désigné) de savoir avec certitude quand cet instant est atteint.
]

=== La vague d'acquittements

La solution classique repose sur une *deuxième phase* qui remonte l'arbre en sens inverse sous forme d'*acquittements* (ACK). L'invariant fondamental est le suivant : un nœud $u$ envoie un ACK à son père si et seulement si $u$ lui-même a reçu le message *et* tous les nœuds du sous-arbre enraciné en $u$ l'ont également reçu.

#algo("Vague d'acquittements (ACK wave)")[
  *Phase 1 — Descente (diffusion standard sur arbre).*
  Exécuter l'algorithme de diffusion sur arbre couvrant décrit à la section précédente.

  *Phase 2 — Remontée (vague ACK).*

  *Aux feuilles* $ell$, immédiatement après avoir reçu $m$ :
  1. Envoyer $chevron.l "ACK" chevron.r$ au père $"parent"(ell)$.

  *À tout nœud interne $v eq.not s$*, après avoir reçu $m$ :
  1. Attendre de recevoir un ACK de *chacun* de ses fils : $forall f in "fils"(v)$, attendre $chevron.l "ACK" chevron.r$ de $f$.
  2. Une fois tous les ACKs reçus : envoyer $chevron.l "ACK" chevron.r$ à $"parent"(v)$.

  *À la racine $s$* :
  1. Attendre de recevoir un ACK de chacun de ses fils.
  2. Lorsque tous les ACKs sont reçus : *déclarer la diffusion globalement terminée*.
]

#thm(info: "Correction de la vague d'acquittements")[
  Lorsque l'initiateur $s$ reçoit un ACK de tous ses fils, la diffusion est effectivement terminée, c'est-à-dire que tout nœud $v in V$ a reçu et traité le message $m$.

  *Preuve.* On montre par induction structurelle sur l'arbre $T$ que, pour tout nœud $u$, le nœud $u$ envoie un ACK à son père si et seulement si (a) $u$ a reçu $m$ et (b) tous les nœuds du sous-arbre $T_u$ enraciné en $u$ ont reçu $m$.

  - *Base.* Pour une feuille $ell$ : $T_ell = {ell}$. La feuille envoie un ACK dès qu'elle reçoit $m$ ; il n'y a pas de sous-arbre non trivial. La propriété est vérifiée.

  - *Induction.* Soit $u$ un nœud interne de fils $f_1, dots, f_k$. Par hypothèse d'induction, $f_i$ envoie un ACK à $u$ si et seulement si tout le sous-arbre $T_(f_i)$ a reçu $m$. Le nœud $u$ attend les ACKs de *tous* ses fils, donc il envoie un ACK à son père si et seulement si $u$ a reçu $m$ ET $T_(f_1), dots, T_(f_k)$ ont tous reçu $m$, ce qui est exactement $T_u$ tout entier.

  À la racine, $T_s = V$ tout entier. Donc quand $s$ reçoit les ACKs de tous ses fils, $V$ tout entier a reçu $m$. $square$
]

#prop(info: "Complexité de la vague d'acquittements")[
  La vague d'acquittements utilise exactement $2(N-1)$ messages au total :
  - $N-1$ messages lors de la phase de descente (un par arête de l'arbre, descendante).
  - $N-1$ messages lors de la phase de remontée (un ACK par arête de l'arbre, montante).

  Le temps de terminaison est $O(h)$ où $h$ est la hauteur de l'arbre, car la descente et la remontée parcourent chacune au maximum $h$ niveaux.
]

#rmk[
  Ce schéma de diffusion suivie d'une vague d'acquittements est extrêmement général. Il peut être adapté à n'importe quel calcul distribué sur arbre : chaque nœud peut effectuer un calcul local et remonter un résultat (par exemple une somme, un minimum, un vote) plutôt qu'un simple ACK. On parle alors de *réduction distribuée* (_distributed reduce_), qui constitue la brique fondamentale de nombreux algorithmes parallèles et distribués.
]

#figure(
  include "figures/ack-wave.typ",
  caption: [Vague d'acquittements sur un arbre à 4 nœuds ($N = 4$). Les flèches bleues pleines indiquent la phase de descente (diffusion) ; les flèches tiretées teal indiquent la remontée des ACKs. Au total : $2(N-1) = 6$ messages.]
)
