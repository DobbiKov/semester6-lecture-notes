#import "preamble.typ": *

= Test de Student (t-test)

Soient $(X_1, ..., X_n_1)$ i.i.d.  $cal(N) (mu_1, sigma_1^2)$,  $(Y_1, ..., Y_n_2)$
i.i.d. $cal(N) (mu_2, sigma_2^2)$. De plus, on suppose que les deux
échantillons sont indépendants. Hypothèse supplémentaire: $sigma_1^2 =
sigma_2^2 = sigma^2$. On veut tester  $H_0$:  $mu_1=mu_2$ contre $H_1: mu_1 != mu_2$

#ex(info: "Efficacité traitement")[
  $mu_1 = mu_2$ contre $mu_2 < mu_1$ qui diminue le taux de cholestérol.
] 

== Statistique de test
$mu_1 - mu_2 = 0$?
_idée_: 
- $arrow.curve$ On estime  $hat(mu_1) - hat(mu_2)$ par  $overline(X) - overline(Y)$ 
- $arrow.curve$ Loi de  $overline(X) - overline(Y)$ 

$(X_n)$ et  $(Y_n)$ indépendantes donc CL de gaussiennes indépendantes =  $cal(N) (mu_1 - mu_2, sigma^2 (1/n_1 + 1/n_2))$ 
- $E[overline(X) - overline(Y)] = mu_1 - mu_2$ par linéarité de l'espérance +  $(X_j)$ et  $(Y_j)$ i.d. 
- $Var(overline(X) - overline(Y)) = Var(overline(X)) + Var(overline(Y)) = (sigma_1^2)/n_1 + (sigma_2^2)/n_2 = sigma^2(1/n_1 + 1/n_2)$ 

Si $sigma^2$ connue: 
 $
(overline(X) - overline(Y) - (mu_1 - mu_2))/(sigma/(sqrt(1/n_1 + 1/n_2))) ~_(H_0) cal(N) (0, 1)
$ 

// ask someone
#align(center)[
#canvas({
  import draw: *

  let gauss(x) = calc.exp(-x * x / 2) / calc.sqrt(2 * calc.pi) * 5
  let c = 1.8

  let curve-pts = range(-35, 36).map(i => (i / 10, gauss(i / 10)))
  let left-pts  = range(-35, -18).map(i => (i / 10, gauss(i / 10)))
  let right-pts = range(18, 36).map(i  => (i / 10, gauss(i / 10)))

  // Left shaded tail
  fill(gray.lighten(40%))
  stroke(none)
  line((-3.5, 0), ..left-pts, (-c, 0), close: true)

  // Right shaded tail
  line((c, 0), ..right-pts, (3.5, 0), close: true)

  // Normal curve
  fill(none)
  stroke(black + 1.2pt)
  line(..curve-pts)

  // Vertical markers at ±c
  line((-c, 0), (-c, gauss(-c)))
  line((c,  0), (c,  gauss(c)))

  // Axes
  stroke(black + 0.8pt)
  line((-4, 0), (4, 0), mark: (end: "stealth", fill: black))
  line((0, -0.2), (0, 2.5), mark: (end: "stealth", fill: black))

  // Labels
  content((0, 2.7),   $"loi de" T "sous" H_0$, anchor: "south")
  content((-c, -0.3), $-c$,  anchor: "north")
  content((c,  -0.3), $c$,   anchor: "north")
  content((0,  -0.6), $mu_1 - mu_2 = 0$, anchor: "north")
  content((c + 0.15, -0.55),
    $arrow.hook q_(1-alpha\/2)(t_(n_1+n_2-2))$,
    anchor: "north-west", padding: 0pt)

})
]

#prop[
  Sous les hypothèses de notre modèle
  - 2 échantillons gaussiens indépendants
  - $sigma_1^2 = sigma_2^2$
  alors  $S_n^2 = 1/(n_1 + n_2)( sum_(i=1)^n (X_i - overline(X))^2 + sum_(j=1)^n (Y_j - overline(Y))^2 )$ 
  est un estimateur sans biais de $sigma^2$ et 
  $
  T = (overline(X) - overline(Y) - (mu_1 - mu_2))/(S_n sqrt(1/n_1 + 1/n_2))
  $ 
  a pour loi exacte la loi $#math.op("Student") (n_1 + n_2 - 2)$
] 

#proof[
  admise
]

== Région de rejet

$cal(R) = {|T| > c}$ 

== Règle de decision
2 façcon équivalents:
1. calcul du seuil: $alpha$ fixé (condition de niveau) $P_(mu_1 = mu_2) (|T| > c_alpha) overbrace(=, T "de loi"\ "continue") alpha => c_alpha = #math.op("qt")_(1- alpha/2) (n_1 + n_2 - 2)$
2. Calcul de la p-valeur
$
#math.op("p-valeur") = P_H_0 (|T| >= |T^"obs"|) underbrace(=, "loi de " T\ "symmétrique") = 2 P_H_0 (T > |T^"obs"|) = 2 (1 - F(|T^"obs"|))\ 
$ 
où $F$ de loi $#math.op("Student") (n_1 + n_2 - 2)$

#ex(info: "Application numérique")[
  $n_1 = 12$,  $overline(x) = 1.50$,  $S_X^"obs" = 0.95 = sqrt(1/(n_1 - 1) sum (x_i - overline(x))^2)$,  $n_2 = 8$,
  $overline(y) = 2.35$,  $S_Y^"obs" = 1.35$

  $
  T^"obs" = (overline(x) - overline(y))/(S_((X, Y))^"obs" sqrt(1/12 + 1/8))
  $ 
  $
  S_((X, Y))^2 = 1/(n_1 + n_2 - 2)(underbrace(sum(x_i - overline(x))^2, (n_1 - 1)(S_X^"obs")^2) + underbrace(sum(y_i - overline(y))^2, (n_1 - 1)(S_Y^"obs")^2)) arrow.squiggly T^"obs" = 1.801
  $ 

  $alpha = 5%$, 
  $ 
  c_alpha = #math.op("qt")_(0.975) (overbrace(12 + 8 - 2, d d l = 18)) = 2.101$, $#math.op("p-valeur") = 2(1 - underbrace( F_(#math.op("Student") (12+8-2)) (1.801), approx 0.95 )) approx 0.10 > alpha
  $ donc on ne rejette pas $H_0$
  1. $|T^"obs"| < c_alpha = 2.101$ on ne rejette pas  $H_0$, les 2 échantillons n'ont pas des moyennes différentes.
]


