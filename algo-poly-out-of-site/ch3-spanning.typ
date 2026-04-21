#import "preamble.typ": *

= Construction d'arbres couvrants

Les arbres couvrants occupent une place centrale dans les algorithmes distribués. Comme nous l'avons vu au chapitre précédent, disposer d'un arbre couvrant permet d'effectuer des diffusions optimales en $N-1$ messages et d'organiser des calculs collectifs (réductions, vagues d'acquittements) de manière structurée. Ce chapitre étudie comment construire un tel arbre de façon distribuée, c'est-à-dire sans qu'aucun nœud ne connaisse à l'avance la topologie globale du réseau.

Nous présentons trois familles d'approches aux caractéristiques très différentes :
1. L'*exploration séquentielle* par jeton DFS, qui visite les nœuds un par un avec une garantie de profondeur ;
2. L'*exploration parallèle* par inondation BFS, qui construit un arbre de plus courts chemins très rapidement ;
3. Les *vagues synchronisées* de Bellman-Ford, qui généralisent aux graphes pondérés.

On suppose dans tout ce chapitre que le réseau est modélisé par un graphe connexe non orienté $G = (V, E)$ avec $|V| = N$ et $|E| = M$.

#defn(info: "Arbre couvrant")[
  Un *arbre couvrant* (_spanning tree_) de $G = (V, E)$ est un sous-graphe $T = (V, E_T)$ tel que :
  - $E_T subset.eq E$ (les arêtes de $T$ sont des arêtes de $G$) ;
  - $T$ est connexe ;
  - $T$ est acyclique.

  Tout graphe connexe admet au moins un arbre couvrant. Un arbre couvrant à $N$ nœuds possède exactement $N-1$ arêtes.

  Étant donné une racine $s in V$, on parle d'*arbre couvrant enraciné* : chaque nœud $v eq.not s$ possède un unique *parent* $"parent"(v)$ sur le chemin de $v$ à $s$ dans $T$, et les nœuds directement reliés à $v$ en dessous de $s$ sont ses *fils*.
]

== Exploration séquentielle : parcours en profondeur avec jeton

=== Motivation

L'approche la plus intuitive consiste à simuler un *parcours en profondeur* (DFS — _Depth-First Search_) de manière distribuée. Un jeton (_token_) physique circule dans le réseau ; à tout instant, exactement un nœud détient le jeton, ce qui garantit une exploration séquentielle sans conflits. Cette approche est particulièrement utile lorsque l'on doit visiter chaque nœud exactement une fois (par exemple pour compter les nœuds, vérifier une propriété globale, ou construire un identifiant unique pour chaque nœud).

=== L'algorithme DFS avec jeton

#algo("DFS distribué avec jeton")[
  *État de chaque nœud $v$* : un booléen $"visité"(v)$ (initialement $"faux"$) et une liste $"non_visités"(v) = N(v)$ de voisins non encore explorés depuis $v$.

  *À l'initiateur $s$* :
  1. Marquer $"visité"(s) <- "vrai"$.
  2. Choisir un voisin $w in N(s)$ quelconque et envoyer le jeton $chevron.l "jeton", s chevron.r$ à $w$. Retirer $w$ de $"non_visités"(s)$.

  *À tout nœud $v$, à la réception du jeton $chevron.l "jeton", "père" chevron.r$* :
  - *Si $"visité"(v) = "vrai"$* (le nœud a déjà été visité, c'est un retour arrière depuis un chemin alternatif) :
    - Renvoyer le jeton à $"père"$ immédiatement (retour arrière, arête non-arbre).
  - *Si $"visité"(v) = "faux"$* :
    1. Marquer $"visité"(v) <- "vrai"$ ; enregistrer $"parent"(v) = "père"$.
    2. Si $"non_visités"(v) eq.not emptyset$ : choisir $w in "non_visités"(v)$, retirer $w$, envoyer $chevron.l "jeton", v chevron.r$ à $w$.
    3. Sinon (tous les voisins explorés depuis $v$) : envoyer le jeton à $"parent"(v)$ (retour arrière).

  *Le jeton revient à $s$* (et $"non_visités"(s) = emptyset$) : le DFS est terminé. L'arbre est constitué des arêtes $(u, "parent"(u))$.
]

#thm(info: "Correction du DFS distribué")[
  À la fin de l'algorithme DFS avec jeton, le graphe $T = (V, E_T)$ où $E_T = {(v, "parent"(v)) | v eq.not s}$ est un arbre couvrant de $G$ enraciné en $s$, et il s'agit d'un arbre DFS.

  *Preuve (esquisse).* On montre par invariant que le jeton ne visite jamais un nœud déjà intégré dans l'arbre via le même chemin. Chaque nœud $v$ est visité au plus une fois (le booléen $"visité"(v)$ l'empêche d'être intégré deux fois). Comme $G$ est connexe, tous les nœuds sont atteignables depuis $s$ et seront éventuellement visités. L'absence de cycle résulte du fait que les arêtes de l'arbre vont toujours de parent à fils. $square$
]

#prop(info: "Complexité du DFS distribué")[
  L'algorithme DFS avec jeton satisfait les bornes suivantes :
  - *Messages* : exactement $2M$ messages, où $M = |E|$. En effet, chaque arête $(u,v)$ est traversée exactement deux fois par le jeton : une fois dans chaque direction (aller et retour). Les arêtes de l'arbre sont traversées une fois vers l'avant (arête arbre DFS) et une fois en retour arrière ; les arêtes non-arbre sont traversées immédiatement en retour (car le nœud visité renvoie le jeton aussitôt).
  - *Temps* : $O(M)$ étapes de communication (séquentiel — le jeton parcourt toutes les arêtes une par une).
  - *Caractère séquentiel* : à tout instant, un seul nœud est actif (celui qui détient le jeton). Cela simplifie certaines propriétés de sécurité mais peut être lent sur de grands graphes.
]

#ex(info: "Trace DFS sur 4 nœuds")[
  Considérons $V = {A, B, C, D}$ avec les arêtes $A B$, $B C$, $C D$, $D A$, $A C$, $B D$ (graphe complet $K_4$). L'initiateur est $A$.

  - Étape 1 : $A$ envoie le jeton à $B$. Arête arbre : $A → B$.
  - Étape 2 : $B$ (non visité) enregistre $"parent"(B) = A$, envoie le jeton à $C$. Arête arbre : $B → C$.
  - Étape 3 : $C$ (non visité) enregistre $"parent"(C) = B$, envoie le jeton à $D$. Arête arbre : $C → D$.
  - Étape 4 : $D$ (non visité) enregistre $"parent"(D) = C$. $D$ n'a plus de voisins non visités (tous déjà marqués). Retour arrière : $D → C$.
  - Étape 5 : $C$ reçoit le jeton en retour, plus de voisins non visités. Retour arrière : $C → B$.
  - Étape 6 : $B$ reçoit le jeton en retour, plus de voisins non visités. Retour arrière : $B → A$.
  - Étape 7 : $A$ reçoit le jeton. Plus de voisins non visités. DFS terminé.

  Arbre DFS construit : $A — B — C — D$ (chemin). Total : $2 times 6 = 12$ messages pour $M = 6$ arêtes de $K_4$.
]

#figure(
  include "figures/dfs-token.typ",
  caption: [DFS distribué avec jeton sur un graphe à 4 nœuds. Les flèches bleues épaisses représentent les arêtes de l'arbre DFS (aller) ; les flèches grises tiretées représentent les retours arrière. Le jeton $tau$ (cercle doré) est montré en position initiale à $A$.]
)

== Exploration parallèle : BFS par inondation

=== Motivation

L'algorithme DFS est séquentiel : la progression est lente car le jeton visite les nœuds un à un. Dans de nombreuses applications, on préfère exploiter le *parallélisme inhérent* au réseau pour construire l'arbre couvrant le plus rapidement possible. L'approche par inondation BFS (_Breadth-First Search_) atteint cet objectif : tous les voisins de l'initiateur sont explorés simultanément, puis tous leurs voisins, etc.

=== L'algorithme BFS par inondation

#algo("BFS distribué par inondation")[
  *État de chaque nœud $v$* : un booléen $"visité"(v)$ et une référence $"parent"(v)$ (indéfinie initialement).

  *À l'initiateur $s$* :
  1. Marquer $"visité"(s) <- "vrai"$.
  2. Envoyer $chevron.l "explore", s chevron.r$ à *tous* les voisins de $s$ simultanément.

  *À tout nœud $v eq.not s$, à la réception de $chevron.l "explore", u chevron.r$* :
  - *Si $"visité"(v) = "faux"$* (premier message reçu) :
    1. Marquer $"visité"(v) <- "vrai"$ ; enregistrer $"parent"(v) = u$.
    2. Envoyer $chevron.l "explore", v chevron.r$ à tous les voisins de $v$ sauf $u$.
  - *Si $"visité"(v) = "vrai"$* : ignorer le message (arête non-arbre, connexion transversale).
]

#thm(info: "L'arbre résultant est un arbre BFS")[
  À la fin de l'algorithme BFS par inondation, le sous-graphe $T$ des arêtes $(v, "parent"(v))$ est un *arbre couvrant BFS* de $G$ enraciné en $s$ : pour tout nœud $v$, la distance dans $T$ entre $s$ et $v$ est égale à la distance dans $G$ (en nombre de sauts).

  *Preuve.* Montrons que le premier message $chevron.l "explore" chevron.r$ reçu par $v$ arrive par un voisin $u$ situé à distance $d_G(s, v) - 1$ de $s$, ce qui garantit que $"parent"(v)$ est sur un plus court chemin de $s$ à $v$.

  On procède par récurrence sur $d = d_G(s, v)$. Si $d = 1$, $v$ est voisin de $s$ et reçoit le message directement de $s$ au premier tour. Supposons la propriété vraie pour tout nœud à distance $< d$. Un nœud $v$ à distance $d$ est voisin d'au moins un nœud $u$ à distance $d-1$. Par hypothèse d'induction, $u$ a été visité au tour $d-1$ et envoie le message au tour $d$. Aucun nœud plus proche ne peut envoyer de message à $v$ avant le tour $d$ (car ils n'ont été visités qu'à partir du tour $d-1$). Donc $v$ est visité au tour $d$ par un nœud à distance $d-1$, ce qui est bien un plus court chemin. $square$
]

#prop(info: "Complexité du BFS par inondation")[
  L'algorithme BFS par inondation satisfait :
  - *Messages* : $O(M)$. Chaque arête $(u,v)$ porte au plus deux messages : un dans chaque direction (l'un des deux est toujours ignoré).
  - *Temps* : $O("diam"(G))$ tours de communication. Chaque nœud à distance $d$ de la racine est visité au tour $d$, et le nœud le plus éloigné est à distance $"diam"(G)$.
]

#rmk[
  Contrairement au DFS, le BFS par inondation est *entièrement parallèle* : plusieurs nœuds peuvent être actifs simultanément. En conséquence, le temps de construction est considérablement réduit — $O("diam")$ au lieu de $O(M)$ — mais le nombre de messages reste similaire. En pratique, sur des réseaux à faible diamètre (par exemple des graphes expanders), le BFS est beaucoup plus rapide que le DFS. En revanche, le BFS ne garantit pas l'ordre de visite des nœuds au sein d'un même niveau, ce qui peut être une limitation pour certaines applications.
]

#figure(
  include "figures/flooding-tree.typ",
  caption: [BFS par inondation sur un graphe à 4 nœuds. Les flèches bleues épaisses indiquent l'arbre BFS (A est la racine, B, C et D sont ses fils directs). Les flèches rouges tiretées indiquent les messages rejetés (arêtes transversales). Résultat : arbre étoile, reflet de la structure BFS.]
)

== Vagues synchronisées : Bellman-Ford distribué

=== Motivation

Les deux algorithmes précédents construisent un arbre couvrant quelconque (DFS) ou un arbre de plus courts chemins en nombre de sauts (BFS). Cependant, dans de nombreuses applications réelles, les arêtes du réseau ont des *poids* (latences, débits, coûts) et l'on souhaite construire un *arbre de plus courts chemins pondérés*. C'est l'objectif de l'algorithme de Bellman-Ford distribué.

=== L'algorithme Bellman-Ford distribué

Soit $G = (V, E, w)$ un graphe connexe pondéré (avec poids $w(u,v) > 0$ pour toute arête $(u,v)$). On cherche à construire un arbre couvrant enraciné en $s$ où la distance de $s$ à tout nœud $v$ est minimale.

#algo("Bellman-Ford distribué")[
  *Initialisation.* Chaque nœud $v$ maintient :
  - $d(v)$ : estimation courante de la distance de $s$ à $v$ ; initialement $d(s) = 0$ et $d(v) = +infinity$ pour tout $v eq.not s$.
  - $"parent"(v)$ : parent courant dans l'arbre ; indéfini initialement.

  *Chaque tour $k = 1, 2, dots$* :
  1. *Diffusion locale.* Chaque nœud $v$ envoie sa distance courante $d(v)$ à tous ses voisins : pour tout $u in N(v)$, envoyer $chevron.l d(v) chevron.r$ à $u$.
  2. *Mise à jour.* Chaque nœud $u$ reçoit les distances de tous ses voisins et calcule :
     $ d'(u) = min_(v in N(u)) (d(v) + w(u,v)) $
     Si $d'(u) < d(u)$ : mettre à jour $d(u) <- d'(u)$ et $"parent"(u) <- arg min_(v in N(u)) (d(v) + w(u,v))$.
  3. *Condition d'arrêt.* Si aucune distance n'a changé lors de ce tour, l'algorithme converge : l'arbre est constitué des arêtes $(u, "parent"(u))$.
]

#thm(info: "Convergence de Bellman-Ford distribué")[
  L'algorithme Bellman-Ford distribué converge en au plus $N-1$ tours. À la convergence, pour tout nœud $v$, $d(v)$ est égal à la distance pondérée minimale $delta(s, v)$ entre $s$ et $v$ dans $G$.

  *Preuve.* On montre par récurrence sur $k$ qu'après $k$ tours, pour tout chemin $s = v_0, v_1, dots, v_k = v$ de longueur $k$, on a $d(v) lt.eq w(v_0, v_1) + dots + w(v_(k-1), v_k)$.

  - *Base ($k = 0$)* : $d(s) = 0 = delta(s, s)$. Correct.
  - *Hérédité* : Au tour $k$, le nœud $v$ reçoit $d(u)$ de chaque voisin $u$. Par hypothèse, $d(u)$ est au plus le poids du plus court chemin de longueur $lt.eq k-1$ de $s$ à $u$. Alors $d(u) + w(u,v)$ est au plus le poids d'un chemin de longueur $lt.eq k$ de $s$ à $v$ via $u$. En prenant le minimum sur tous les voisins, $d(v)$ atteint le poids du plus court chemin de longueur $lt.eq k$.

  Tout plus court chemin (sans cycle, puisque les poids sont positifs) comporte au plus $N-1$ arêtes. Donc après $N-1$ tours, toutes les distances sont convergeantes. $square$
]

#prop(info: "Complexité de Bellman-Ford distribué")[
  L'algorithme Bellman-Ford distribué satisfait :
  - *Messages* : $O(N dot M)$. À chaque tour, chaque nœud envoie un message à chacun de ses voisins, soit $2M$ messages par tour. Sur $N-1$ tours : $O(N dot M)$ messages au total.
  - *Temps* : $O(N)$ tours de communication.
  - *Résultat* : arbre couvrant de plus courts chemins pondérés depuis $s$.
]

#cor[
  Dans le cas non pondéré (tous les poids égaux à 1), l'algorithme Bellman-Ford distribué produit le même résultat que le BFS par inondation, mais en $O(N)$ tours au lieu de $O("diam")$. Le BFS est donc préférable pour les graphes non pondérés.
]

#rmk[
  L'algorithme de Bellman-Ford distribué est à la base du protocole de routage *RIP* (_Routing Information Protocol_), l'un des premiers protocoles de routage Internet. Dans ce contexte, les nœuds sont des routeurs, les arêtes sont des liens réseau avec des métriques (nombre de sauts, latences), et chaque routeur calcule sa table de routage en exécutant Bellman-Ford de manière continue. La convergence lente ($O(N)$ tours dans le pire cas) est l'une des limitations connues de RIP, surtout en présence de pannes (le phénomène de « count to infinity »).
]

#figure(
  include "figures/bellman-ford.typ",
  caption: [Bellman-Ford distribué sur un graphe linéaire à 4 nœuds avec un raccourci $A$–$C$. Les étiquettes de distance ($d = 0, 1, 1, 2$) sont calculées après convergence. Les flèches bleues indiquent l'arbre de plus courts chemins résultant ; la courbe teal représente le raccourci qui améliore le chemin vers $C$.]
)

== Tableau comparatif des algorithmes de construction

#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, center, center, left, left),
    stroke: 0.5pt,
    inset: 6pt,
    table.header(
      [*Algorithme*],
      [*Messages*],
      [*Temps*],
      [*Résultat*],
      [*Particularité*],
    ),
    [DFS avec jeton],
    [$2|E|$],
    [$O(|E|)$],
    [Arbre DFS],
    [Séquentiel ; visite chaque arête exactement deux fois ; garantit un ordre DFS],

    [BFS par inondation],
    [$O(|E|)$],
    [$O("diam")$],
    [Arbre BFS (plus courts chemins en sauts)],
    [Parallèle ; très rapide ; ne gère pas les poids],

    [Bellman-Ford distribué],
    [$O(N dot |E|)$],
    [$O(N)$],
    [Arbre de plus courts chemins pondérés],
    [Gère les poids ; lent ; base de RIP],
  ),
  caption: [Comparaison des trois algorithmes distribués de construction d'arbre couvrant. $N = |V|$, $|E|$ = nombre d'arêtes, $"diam"$ = diamètre du graphe.]
)

En résumé, le choix de l'algorithme dépend du contexte applicatif :
- Si l'on souhaite un arbre de façon séquentielle et garantie, le *DFS avec jeton* est simple et robuste.
- Si la rapidité de construction est prioritaire et le graphe non pondéré, le *BFS par inondation* est optimal en temps.
- Si le réseau est pondéré et que l'on a besoin de plus courts chemins, *Bellman-Ford distribué* est le choix naturel, au prix d'un plus grand nombre de messages.
