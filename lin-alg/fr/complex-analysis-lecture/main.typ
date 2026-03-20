// ─────────────────────────────────────────────────────────────────────────────
//  Analyse complexe et applications à l'algèbre linéaire — Notes de cours
// ─────────────────────────────────────────────────────────────────────────────

#import "@local/dobbikov:1.0.0": *

// ── Page setup ───────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.8cm, y: 3cm),
  numbering: "1",
  number-align: center,
)

#set text(font: "New Computer Modern", size: 11pt, lang: "fr")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// ── Language & theorem rules ──────────────────────────────────────────────────
#_dobbikov-lang.update(_ => "fr")
#show: thm-rules.with(qed-symbol: $square$)

// ── Figure helper ─────────────────────────────────────────────────────────────
#let fig(path, cap, width: 60%) = {
  figure(
    image(path, width: width),
    caption: cap,
  )
  v(4pt)
}

// ═════════════════════════════════════════════════════════════════════════════
//  TITLE PAGE
// ═════════════════════════════════════════════════════════════════════════════
#let accent = rgb("#1a4f82")
#align(center)[
  #v(1.5cm)
  #text(size: 22pt, weight: "bold", fill: accent)[
    Analyse complexe\
    et applications à l'algèbre linéaire
  ]
  #v(0.6cm)
  #text(size: 13pt, fill: rgb("#555"))[Cours d'Antoine Levitte. Notes de cours prises par Yehor Korotenko]
  #v(2cm)
  #line(length: 60%, stroke: 1.5pt + accent)
  #v(2cm)
]

#outline(indent: 1em)

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
= Résolvante et spectre
// ═════════════════════════════════════════════════════════════════════════════

== Définitions

#defn("Spectre et résolvante")[
  Soit $A in M_n (CC)$.  On appelle *spectre* de $A$ l'ensemble
  $
    "Sp"(A) = {mu in CC bar.v A - mu I "n'est pas inversible"}.
  $
  Pour tout $lambda in CC without "Sp"(A)$, la matrice $A - lambda I$ est inversible.
  On note
  $
    R_A (lambda) = (A - lambda I)^(-1)
  $
  et on l'appelle la *résolvante* de $A$ en $lambda$.
]

#rmk[
  On dispose d'une expression alternative.  Posons
  $
    B_A (z) = (I - z A)^(-1), quad
    z in CC without {1/mu bar.v mu in "Sp"(A)}.
  $
  Un calcul direct donne
  $
    R_A (lambda) = -1/lambda space B_A (1/lambda).
  $
]

== Norme d'opérateur

On munit $CC^n$ de la norme euclidienne $norm(dot)_2$.
La *norme d'opérateur* (norme subordonnée) de $A in M_n (CC)$ est
$
  norm(A) = sup_(v in CC^n, v != 0) norm(A v)_2 / norm(v)_2.
$
Elle satisfait $norm(A B) <= norm(A) norm(B)$.  De plus, si $norm(A) < 1$ alors
$I - A$ est inversible et
$
  (I - A)^(-1) = sum_(n=0)^(+infinity) A^n.
$

== Développement en série entière de la résolvante

#prop("Poly, Prop. 4.8")[
  La série suivante converge (localement uniformément pour la norme d'opérateur)
  sur le disque $DD(0, 1/norm(A))$ :
  $
    B_A (z) = sum_(n=0)^(+infinity) z^n A^n.
  $
]

#fig(
  "figures/fig_resolvent_disk.png",
  [Zone de convergence de $B_A(z)=sum_(n=0)^(+infinity) z^n A^n$.
   Les croix marquent les singularités $1\/mu_i$ pour $mu_i in "Sp"(A)$.],
  width: 55%,
)

#rmk[
  Au voisinage de tout pintegral.cont de son domaine de définition, $B_A$ est
  développable en série entière :
  $
    B_A (z) = sum_(n=0)^(+infinity) (z - z_0)^n B_A (z_0) [A B_A (z_0)]^n.
  $
  *But :* étudier ce type de fonction d'une variable complexe.
]

Un calcul algébrique montre que, en posant $C = I - z_0 A$ et $D = (z - z_0) A$ :
$
  B_A (z)
  = (I - z A)^(-1)
  = (I - z_0 A - (z - z_0) A)^(-1)
  = (C - D)^(-1)
  = sum_(n=0)^(+infinity) C^(-1) (D C^(-1))^n.
$

// ═════════════════════════════════════════════════════════════════════════════
= Fonctions holomorphes
// ═════════════════════════════════════════════════════════════════════════════

== Définition

#defn("Fonction holomorphe")[
  Soit $Omega subset CC$ un ouvert et $f : Omega -> CC$.
  On dit que $f$ est *holomorphe* lorsque
  $
    forall z_0 in Omega, quad
    exists epsilon > 0 "et" (a_n)_(n in NN) "tels que" quad
    forall z in DD(z_0, epsilon), quad
    f(z) = sum_(n=0)^(+infinity) a_n (z - z_0)^n.
  $
]

== Rappel : convergence des séries entières

#prop("Piqûre de rappel")[
  Si $(|a_n|^(1\/n))_(n in NN)$ est bornée par $M > 0$, alors la série entière
  $z |-> sum_(n in NN) a_n z^n$
  converge localement uniformément sur $DD(0, 1\/M)$, et définit une fonction
  $C^infinity$ en tant que fonction de deux variables réelles.

  En particulier, si $R < 1/M$ et $z in DD(0, R)$ :
  $
    sum_(n in NN) |a_n z^n| <= sum_(n in NN) (R M)^n < +infinity.
  $
]

== L'opérateur $overline(partial)$

#rmk[
  En écrivant $z = x + i y$, on calcule :
  $
    diff/(diff x) (x + i y)^n = n (x + i y)^(n-1),
    quad quad
    diff/(diff y) (x + i y)^n = i n (x + i y)^(n-1).
  $
  En particulier, pour tout $n in NN$ :
  $
    (diff/(diff x) + i diff/(diff y))(x + i y)^n = 0.
  $
  On note $overline(partial) = diff/(diff overline(z)) = 1/2 (diff/(diff x) + i diff/(diff y))$
  (aussi noté $diff/(diff overline(z))$).
]

#prop[
  Si $f$ est holomorphe, alors $overline(partial) f = 0$.
]

== Exemples

Les fonctions suivantes sont holomorphes :
- la résolvante $lambda |-> R_A (lambda)$,
- les polynômes,
- l'exponentielle $z |-> exp(z)$,
- la matrice-exponentielle $z |-> exp(z A)$.

#ex("Non-exemple")[
  La fonction $z |-> overline(z)$ n'est *pas* holomorphe car
  $
    diff/(diff x)(x - i y) = 1 != 0 = overline(partial) overline(z).
  $
]

// ═════════════════════════════════════════════════════════════════════════════
= Intégrales de contour
// ═════════════════════════════════════════════════════════════════════════════

== Formule de Stokes / Théorème d'Ampère

=== Version 1D

Si $f in C^1([a,b], RR)$, alors
$
  integral_a^b f'(x) dif x = f(b) - f(a).
$

=== Version 2D

Soit $Omega subset RR^2$ un ouvert dont le bord est une courbe régulière simple $gamma$.
On parcourt $gamma$ à vitesse $1$ ; on note $T = "Longueur"(gamma)$.

#fig(
  "figures/fig_contour_simple.png",
  [Contour simple $gamma = diff Omega$ orienté dans le sens direct.],
  width: 42%,
)

#thm("Stokes / Green-Riemann")[
  Soit $arrow(A) : Omega -> RR^2$ un champ de vecteurs $C^1$, avec
  $
    arrow(A)(x,y) = A_x (x,y) arrow(e)_x + A_y (x,y) arrow(e)_y.
  $
  On définit le rotationnel scalaire
  $
    "rot"(arrow(A)) = (diff A_y)/(diff x) - (diff A_x)/(diff y).
  $
  Alors
  $
    integral.double_Omega "rot"(arrow(A)) dif x dif y
    = integral_0^T arrow(A)(gamma(s)) dot arrow(T)(gamma(s)) dif s,
  $
  où $arrow(T)(s) = gamma'(s)$ est le vecteur tangent.
]

=== Preuve sur le carré

On prend $Omega = [0,1]^2$ et $A$ affine :
$
  A_x = c_x + a_(x x) x + a_(x y) y, quad
  A_y = c_y + a_(y x) x + a_(y y) y.
$
Donc $"rot"(arrow(A)) = a_(y x) - a_(x y)$ et
$integral.double_Omega "rot"(arrow(A)) = a_(y x) - a_(x y)$.

#fig(
  "figures/fig_square_stokes.png",
  [Le carré $Omega = [0,1]^2$ avec ses quatre côtés numérotés.],
  width: 42%,
)

On paramétrise les quatre côtés et on somme les contributions :

#block(
  width: 100%,
  fill: rgb("#f5f5f5"),
  radius: 4pt,
  inset: 10pt,
)[
$
  &(1): quad s |-> (s, 0), s in [0,1],
    &&integral_0^1 A_x (s,0) dif s = c_x + a_(x x)/2 \

  &(2): quad s |-> (1, s), s in [0,1],
    &&integral_0^1 A_y (1,s) dif s = c_y + a_(y x) + a_(y y)/2 \

  &(3): quad s |-> (1-s, 1), s in [0,1],
    &&-integral_0^1 A_x (1-s,1) dif s = -(c_x + a_(x y) + a_(x x)/2) \

  &(4): quad s |-> (0, 1-s), s in [0,1],
    &&-integral_0^1 A_y (0,1-s) dif s = -(c_y + a_(y y)/2)
$
]

En additionnant : $integral.cont_(diff Omega) arrow(A) dot dif arrow(T) = a_(y x) - a_(x y) = integral.double_Omega "rot"(arrow(A))$. $square$

*Chemin vers une vraie preuve :*
+ Vérifier d'abord pour des fonctions affines sur des triangles quelconques.
+ Approcher $gamma$ par une courbe polygonale, trianguler $Omega$, et approcher $A$ par une fonction affine sur chaque triangle.

== Intégrale complexe et formule de Green

Soit $f : Omega -> CC$ de classe $C^1$ et $gamma : [0,T] -> CC$ une courbe régulière.  On définit
$
  integral_gamma f = integral_0^T f(gamma(s)) gamma'(s) dif s.
$

En posant $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, on calcule :
$
  "rot"(arrow(A))
  = i diff_x f - diff_y f
  = i (diff_x f + i diff_y f)
  = 2 i space overline(partial) f.
$

#prop[
  Si $f : Omega -> CC$ est de classe $C^1$ avec $overline(partial) f = 0$, alors pour
  toute courbe $gamma$ fermée dans $Omega$,
  $
    integral.cont_gamma f = 0.
  $
]

#rmk[
  Vrai si on a une courbe simple et $f$ définie partout à l'intérieur.
  En général pour des contours homologues :
  $
    integral.cont_(gamma_1) f = 0,
    quad
    integral.cont_(gamma_2) f = integral.cont_(gamma_3) f,
    quad
    integral.cont_(gamma_5) f = integral.cont_(gamma_2) f + integral.cont_(gamma_4) f.
  $
]

#fig(
  "figures/fig_nested_contours.png",
  [Contours homologues : $gamma_1$ (petit contour isolé), $gamma_2, gamma_3$ (contours
   emboîtés), $gamma_4$ (contour avec trou), $gamma_5$ (grand contour extérieur).],
  width: 80%,
)

// ═════════════════════════════════════════════════════════════════════════════
= Formule de Cauchy
// ═════════════════════════════════════════════════════════════════════════════

== Énoncé

#thm("Formule de Cauchy")[
  Soit $f in C^1(Omega, CC)$ avec $overline(partial) f = 0$.
  Soit $z_0 in Omega$.  Alors, pour toute courbe $gamma$ qui fait un tour
  (dans le sens direct) autour de $z_0$,
  $
    integral.cont_gamma f(z)/(z - z_0) dif z = 2 pi i f(z_0).
  $
]

== Preuve

La valeur de l'intégrale ne dépend pas de $gamma$, donc on prend $gamma_epsilon$
le cercle de rayon $epsilon$ autour de $z_0$ :
$
  integral.cont_(gamma_epsilon) f(z)/(z - z_0) dif z
  = integral.cont_(gamma_epsilon) f(z_0)/(z - z_0) dif z
  + O(epsilon dot 1/epsilon dot epsilon)
  = O(epsilon).
$

#fig(
  "figures/fig_cauchy_circle.png",
  [Le cercle $gamma_epsilon$ de rayon $epsilon$ centré en $z_0$,
   utilisé dans la preuve de la formule de Cauchy.],
  width: 48%,
)

On paramétrise $gamma_epsilon : theta |-> z_0 + epsilon e^(i theta)$,
$theta in [0, 2pi]$, donc $gamma_epsilon'(theta) = i epsilon e^(i theta)$ et
$
  integral.cont_(gamma_epsilon) 1/(z - z_0) dif z
  = integral_(theta=0)^(2pi)
      1/(epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta
  = integral_0^(2pi) i dif theta
  = 2 pi i.
$

== Caractérisation des fonctions holomorphes

#thm[
  Soit $Omega$ un ouvert de $CC$, $f : Omega -> CC$ de classe $C^1$ telle que
  $overline(partial) f = 0$.  Alors $f$ est holomorphe.
]

#proof[
  Soit $gamma$ une courbe simple dans $Omega$.  Pour tout $z_0$ à l'intérieur de
  $gamma$, la formule de Cauchy donne
  $
    f(z_0) = 1/(2 pi i) integral.cont_gamma f(z)/(z - z_0) dif z.
  $
  Pour tout $z in gamma$, la fonction $z_0 |-> 1/(z - z_0)$ est holomorphe sur
  $CC without {z}$.  Après intégration, $z_0 |-> 1/(2pi i) integral.cont_gamma f(z)/(z - z_0) dif z$
  est holomorphe sur $omega = "Int"(gamma)$.
]

// ═════════════════════════════════════════════════════════════════════════════
= Application à l'algèbre linéaire
// ═════════════════════════════════════════════════════════════════════════════

== Projecteur spectral

#prop("Projecteur sur un espace propre")[
  Soit $A in M_n (CC)$ diagonalisable, et soit $gamma$ une courbe qui fait un tour
  autour d'une valeur propre $mu$, sans encercler les autres.  Alors
  $
    1/(2 pi i) integral.cont_gamma R_A (z) dif z = Pi_mu,
  $
  où $Pi_mu$ est le *projecteur* sur l'espace propre $E_mu$, parallèlement aux
  autres espaces propres.
]

#fig(
  "figures/fig_eigenvalue_contour.png",
  [Contour $gamma$ entourant la valeur propre $mu$, sans encercler les autres
   valeurs propres (croix rouges).],
  width: 52%,
)

== Preuve

Puisque $A$ est diagonalisable, il existe $P$ inversible telle que
$
  A = P^(-1) mat(mu, 0; 0, D') P,
  quad mu in.not "Sp"(D').
$
Alors
$
  (A - lambda I)^(-1)
  = P^(-1)
    mat((mu - lambda)^(-1), 0; 0, (D' - lambda I)^(-1))
    P.
$
On intègre sur $gamma$ :
$
  1/(2 pi i) integral.cont_gamma (A - lambda I)^(-1) dif lambda
  &= P^(-1)
     mat(display(1/(2 pi i) integral.cont_gamma dif lambda/(mu - lambda)), 0;
         0, 0)
     P \
  &= P^(-1)
     mat(1, 0; 0, 0)
     P
  = Pi_mu.
$

Le bloc inférieur est nul car $(D' - lambda I)^(-1)$ est holomorphe à l'intérieur
de $gamma$ (puisque $mu in.not "Sp"(D')$).  Le bloc supérieur vaut $1$ par calcul
de résidu :
$
  1/(2 pi i) integral.cont_gamma 1/(mu - lambda) dif lambda = 1.
  quad square
$
