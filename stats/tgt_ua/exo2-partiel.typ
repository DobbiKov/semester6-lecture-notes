#import "preamble.typ": *
#show: dobbikov.with(
  title: [Partiel 2026],
  author: "Yehor KOROTENKO",
  date: datetime.today(),
  report-style: true,
  language: "fr"
)
= Correction de l'exercice 2 du partiel
- $X_1, ..., X_n$ i.i.d. de densité  $f(x) = theta (1 - x)^(theta - 1)$ si  $x in ]0, 1[$
- Test:  $theta = 2$ contre  $theta > 2$ ?

_Solution_:
1. EMV
$
L_n (theta)     &= product_(i=1)^(n) f_theta (X_i) = product_(i=1)^n [theta(1 - X_i)^(theta - 1)]\
log L_n (theta) &= sum_(i=1)^(n) log f_theta (X_i) = sum_(i=1)^n [ log theta + (theta - 1) log (1 - X_i)] \
                &= n log theta + (theta - 1) sum_(i=1)^n log (1 - X_i)
$ 

Pour trouver l'EMV, on résout l'équation de vraisemblance:
$
(log L_n)'(theta) = 0 <=> n/theta + sum_(i=1)^n log(1 - X_i) = 0 <=> theta = - n/(sum log(1 - X_i)) > 0
$ 

On vérifie qu'on a bien un max:
$
(log L_n)''(theta) = -n/(theta^2) < 0 #h(5pt) forall theta > 0
$ 
donc $log L_n$ est concave donc  $hat(theta)$ est un max global.

2. Consistance
$
hat(theta) = -n/(sum_i log(1 - X_i)) = g(overline(Y))
$ 

$0 < Y_i = - log(1 - X_i)$ i.i.d. car les $X_i$ le sont.  $E[Y_i]$ ? $E[Y_i] = 1/theta$ ($Y_i ~ #math.op("Exp") (theta)$) 

LGN: $1/n sum Y_i -->^P 1/theta$. Comme  $hat(theta) = 1/(1/n sum Y_i)$,  $g(x) = 1/x$ continue et LAC,
 $
g(1/n sum Y_i) -->^P g(1/theta)
$ 
