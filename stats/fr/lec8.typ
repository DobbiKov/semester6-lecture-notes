
#import "preamble.typ": *

= Introduction aux tests statistiques

== Exemple
=== Contrôle de qualité: industriel. 
Produit des "pièces" 
- $arrow.curve$ de bonne qualité
- $arrow.curve$ défectueuses

Pour l'industriel, on suppose acceptable une proportion de $20%$ de pièces déféctueuses.

Pour contrôler: prélever "au hasard" $n$ pièces, vérifiées  ($p <= 20%$)

=== Modélisation
$i^"ème"$ pièce  $X_i = cases(0 "si bonne qualité", 1 "si défectueuse")$
$p = P(X_i = 1)$

$arrow.curve$ on prélève  $n$ pièces et on observe un échantillon  $(X_1, ..., X_n)$ dont les valeurs obsérvées sont  $(x_1, ..., x_n)$.

#align(center)[#canvas({
  import draw: *

  // Left node: circle with X, p, "inconnu"
  circle((0, 0), radius: 1.2, stroke: black, fill: white)
  content((0, 0.35), $X$)
  content((0, -0.1), $p$)
  content((0, -0.55), [inconnu])

  // Right node: rectangle with X_1, ..., X_n and hat(p)
  rect((3.3, -0.9), (6.3, 0.9), stroke: black, fill: white, radius: 0.15)
  content((4.8, 0.2), $(X_1, dots, X_n)$)
  content((4.8, -0.35), $hat(p)$)

  // Arrow 1: left circle → right rect (top arrow)
  line((1.2, 0.35), (3.3, 0.35), mark: (end: ">"), stroke: black)

  // Arrow 2: left circle → right rect (bottom arrow)
  line((1.2, -0.35), (3.3, -0.35), mark: (end: ">"), stroke: black)

  // Arrow 3: right rect → left circle, curved above, with "inférence" label
  bezier(
    (3.3, 0.9),
    (1.2, 0.9),
    (3.0, 2.0),
    (1.5, 2.0),
    mark: (end: ">"),
    stroke: black
  )
  content((2.25, 2.1), [inférence])
})]

Que vaut $p$? $->$ on éstime
- proportion empirique
-  $X_i ~_"indep" #math.op("Bernouili") (p)$ $->$  $hat(p) = overline(X)$

On observe  $overline(x) = 0.22$,  $n=100$

On procède avec un intervalle de confiance pour $p$.
 On définie $hat(p) = overline(X)$, 
 TLC:
 $
 (overline(X) - p)/(sqrt((p(1-p))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
 $ 
 on estime l'écart-type par $(hat(p)(1 - hat(p)))/n$ (consistant). Lemme de Slutsky: 
  $
 ( overline(X) - p )/sqrt((overline(X)(1 - overline(X)))/n) = (overline(X) - p)/(sqrt( (p(1-p))/n )) times (overbrace( underbrace( sqrt( (p(1-p))/n ), -->^P 1 ), "LGN:" overline(X) -->^P p ", LAC:" g(x) = sqrt((x(1-x))/n) ))/(sqrt((overline(X)(1 - overline(X)))/n)) -->^(cal(L))_(n -> +infinity) 1 . cal(N) (0, 1)
 $ 

 $
 P(#math.op("qnorm")_(alpha/2) <= (overline(X) - p)/(sqrt((overline(X)(1 - overline(X)))/n)) <= #math.op("qnorm")_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha
 $ 
 $
 <=> P(overline(X) - q_(1 - alpha/2)sqrt((overline(X)(1 - overline(X)))/n) <= p <= overline(X) - q_(alpha/2) sqrt((overline(X)(1 - overline(X)))/n)) -->_n 1 - alpha
 $ 

 $#math.op("IC") (p) = overline(X) pm #math.op("qnorm")_(1 - alpha/2) sqrt((overline(X)(1 - overline(X)))/n)$ de niveau asymptotique  $1 - alpha$. 

 ex:  $overline(x) = 0.22$,  $alpha = 5%$,  $n = 100$,  $#math.op("IC") = [0.14, 0.30]$

 Question: est-ce que $p <= 0.2$ ou bien  $p > 0.2$ ?


== Principe d'un test
 $Theta subset ]0, 1[$. On veut tester si  $p <= 0.2$ ou  $p > 0.2$.

  $Theta = underbrace( Theta_0, ]0\, 0.2] ) union underbrace( Theta_1, ]0 \, 1
  \[ )$ sous-ensembles disjoints. 

  On teste $H_0$:  $p in Theta_0$, $p <= 0.2$ contre  $H_1$:  $p in Theta_1$,  $p > 0.2$ 

  Conclusion: 
  - Soit on conserve $H_0$: ($p <= 0.2$) 
  - Soit on rejet $H_0$ (on conclut $p > 0.2$)

 #defn[
   Un test de $H_0$ contre  $H_1$ est défini par la construction d'une région de rejet de  $H_0$,  $cal(R)$
   - si  $(X_1, ..., X_n) in cal(R)$, on rejette  $H_0$ (au profit de $H_1$)
   - si $(X_1, ..., X_n) cancel(in) cal(R)$, on conserve  $H_0$
 ]
 Souvent $cal(R) = {(X_1, ..., X_n), T(X_1, ..., X_n) > c}$
 -  $T$: statistique de test (à valeur réelle)
 -  $c$: seuil du test

 #rmk[
   la décision d'un test est aléatoire (dépend de $T$ aléatoire)
 ] 

 Comment relier $cal(R)$ aux hypothèses testées ?

 == Risque d'erreur
 #defn[
   Erreure de $1^"ère"$ espèce ou risque de type I est la fonction définie sur  
   $
   Theta_0 &--> [0, 1] \
         p &|-> P_p (( X_1, ..., X_n ) in cal(R)) = P_p ("on rejette" H_0)
   $ 
   Le test est dit de niveaux $alpha$ si  $
   sup_(p in Theta_0) P_p ("rejet de "H_0) <= a
   $ 
 ] 
 $R_q$ erreur de premiere espece $= P("rejet de" H_0 "à tort")$ 

 #align(center)[
 #table(columns: 3, 
 [réalité / décision], [$H_0$ vraie], [$H_1$ vraie],
 [$H_0$ vraie], [ok], [erreure de première espèce],
 [$H_1$ vraie], [erreure de seconde espece], [ok]
 )]

 #defn[
   L'erreure de seconde espèce est la fonction définie sur risque de type  II
   $
   Theta_1 &--> [0, 1] \
         beta: p &|-> P_p ( (X_1, ..., X_n) cancel(in) cal(R) ) = P_p ("on conserve" H_0)
   $ 
 ]
 #rmk[
   erreur de sconde espèce est $P("conserver" H_0 "à tort")$
 ]

 puissance du test: = 1-erreur 2nde espèce

 $
 product : p in Theta_1 --> P_p ((X_1, ..., X_n) in cal(R))
 $ 
 Choix: les 2 erreurs ne peuvent pas être minimiser simultanément. En général $alpha$ augmente quand  $beta$ diminue.

 Test:  On choisit de contrôler l'erreur de $1^"ere"$ espèce ($=>$ l'erreur de seconde espèce est inconnue en général)

== Construction d'un test
Principe: déterminer $cal(R)$ tel que erreur de première espèce $<= alpha$ (si
on a plusieurs tests, on choisira (point de vue théorique) celui dont l'erreur
de seconde espèce est la plus petite (ou de puissance la plus grande)). Basé
sur une dissymétrie de $H_0$ et  $H_1$ dans la construction. 


#ex[
  $H_0: p<= 0.2$ contre  $H_1: p > 0.2$ ($overline(x) = 0.22$)

  - $p$ inconnu donc on l'estime  $hat(p) = overline(X)$
  - idée: sous  $H_1$,  $hat(p)$ prend de plus grandes valeurs que sous $H_0$ 

  $arrow.curve$  $cal(R)$ du type  $hat(p) > c$ avec  $c$ tel que  $P_p (hat(p) > c) <= alpha$ ? (calcul? loi limite du paramètre $p$?)

  $
  hat(p) = overline(X) --> (hat(p) - p)/sqrt((p(1-p))/n)
  $ 
  a pour loi approché $cal(N) (0, 1)$

  $
  P(hat(p) > c) = P( (hat(p) - p)/sqrt((p(1-p))/n) > overbrace(c, = ( (c-p)/sqrt((p(1-p))/n) )) )
  $ 
  On veut que
  $
  sup_(p in Theta_0 \ p <= 0.2) P ((hat(p) - p)/sqrt((p(1-p))/n) > c) <= alpha
  $ 
  $arrow.curve$ le sup est atteint en  $p = 0.2$

  $
  cal(R) = { (X_1, ..., X_n), (hat(p) - 0.2)/(sqrt((0.2(1 - 0.2))/n)) > c }
  $ 
  Trouver $c$ tel que  $P((X_1, ..., X_n) in cal(R)) -->_(n -> +infinity) alpha$
   $
  P((hat(p) - 0.2)/sqrt((0.2(1 - 0.2))/n) > c) -->_(n -> +infinity) alpha "ssi" c = #math.op("qnorm")_(1 - alpha)
  $ 

#let gamma(z) = {
  let p = (676.5203681218851, -1259.1392167224028, 771.32342877765313,
           -176.61502916214059, 12.507343278686905, -0.13857109526572012,
           9.9843695780195716e-6, 1.5056327351493116e-7)
  let x = z - 1
  let t = x + 7.5
  let s = 0.99999999999980993
  s += p.at(0) / (x + 1)
  s += p.at(1) / (x + 2)
  s += p.at(2) / (x + 3)
  s += p.at(3) / (x + 4)
  s += p.at(4) / (x + 5)
  s += p.at(5) / (x + 6)
  s += p.at(6) / (x + 7)
  s += p.at(7) / (x + 8)
  calc.sqrt(2 * calc.pi) * calc.pow(t, x + 0.5) * calc.exp(-t) * s
}
#let student(x, nu) = {
  let coeff = gamma((nu + 1) / 2) / (calc.sqrt(nu * calc.pi) * gamma(nu / 2))
  coeff * calc.pow(1 + x * x / nu, -(nu + 1) / 2)
}

#let normal-quantile(p) = {
  // Coefficients
  let a0 = -3.969683028665376e+01
  let a1 =  2.209460984245205e+02
  let a2 = -2.759285104469687e+02
  let a3 =  1.383577518672690e+02
  let a4 = -3.066479806614716e+01
  let a5 =  2.506628277459239e+00

  let b0 = -5.447609879822406e+01
  let b1 =  1.615858368580409e+02
  let b2 = -1.556989798598866e+02
  let b3 =  6.680131188771972e+01
  let b4 = -1.328068155288572e+01

  let c0 = -7.784894002430293e-03
  let c1 = -3.223964580411365e-01
  let c2 = -2.400758277161838e+00
  let c3 = -2.549732539343734e+00
  let c4 =  4.374664141464968e+00
  let c5 =  2.938163982698783e+00

  let d0 =  7.784695709041462e-03
  let d1 =  3.224671290700398e-01
  let d2 =  2.445134137142996e+00
  let d3 =  3.754408661907416e+00

  let p-low  = 0.02425
  let p-high = 1 - p-low

  if p < p-low {
    let q = calc.sqrt(-2 * calc.ln(p))
    let num = c0 + q*c1 + q*q*c2 + q*q*q*c3 + q*q*q*q*c4 + q*q*q*q*q*c5
    let den = 1 + q*d0 + q*q*d1 + q*q*q*d2 + q*q*q*q*d3
    num / den
  } else if p <= p-high {
    let q = p - 0.5
    let r = q * q
    let num = (a0 + r*a1 + r*r*a2 + r*r*r*a3 + r*r*r*r*a4 + r*r*r*r*r*a5) * q
    let den = b0 + r*b1 + r*r*b2 + r*r*r*b3 + r*r*r*r*r*b4 + r*r*r*r*r
    num / den
  } else {
    let q = calc.sqrt(-2 * calc.ln(1 - p))
    let num = c0 + q*c1 + q*q*c2 + q*q*q*c3 + q*q*q*q*c4 + q*q*q*q*q*c5
    let den = 1 + q*d0 + q*q*d1 + q*q*q*d2 + q*q*q*q*d3
    -(num / den)
  }
}
#let _alpha = 0.04
#let q-lo = normal-quantile(_alpha / 2)
#let q-hi = normal-quantile(1 - _alpha / 2)
#let normal(x) = calc.exp(-x * x / 2) / calc.sqrt(2 * calc.pi)
#align(center)[
  #canvas({
  plot.plot(
    size: (8, 5),
    x-label: $x$,
    y-label: $f(x)$,
    axis-style: "school-book",
    x-min: -4,
    x-max: 4,
    y-min: 0,
    y-max: 0.45,
    x-tick-step: 1,
    y-tick-step: none,
    y-ticks: (),
    {
//       plot.add-fill-between(
//   domain: (-4, q-lo),
//   samples: 200,
//   style: (fill: red.transparentize(60%), stroke: none),
//   x => student(x, 3),
//   x => 0,
// )
// Right tail: rejection region
// plot.add-fill-between(
//   domain: (q-hi, 4),
//   samples: 200,
//   style: (fill: red.transparentize(60%), stroke: none),
//   x => student(x, 3),
//   x => 0,
// )
// Acceptance region
plot.add-fill-between(
  domain: (q-lo, 4),
  samples: 200,
  style: (fill: blue.transparentize(75%), stroke: none),
  x => student(x, 3),
  x => 0,
)
      // Student curves
      plot.add(
        domain: (-4, 4), samples: 200,
        label: $cal(N) (0, 1)$,
        style: (stroke: red + 1.5pt),
        x => student(x, 3),
      )
      // Vertical lines at quantiles
      plot.add(
        domain: (q-lo, q-lo), samples: 2,
        style: (stroke: (thickness: 1pt, paint: blue, dash: "dashed")),
        x => if x == q-lo { normal(q-lo) } else { 0 },
      )
      plot.add(
        domain: (q-hi, q-hi), samples: 2,
        style: (stroke: ( thickness: 1pt, paint: blue, dash: "dashed" )),
        x => if x == q-hi { normal(q-hi) } else { 0 },
      )
    }
  )
})]
- rejet de $H_0$ ssi 
 $
T = underbrace( (hat(p) - 0.2)/sqrt((0.2(1 - 0.2))/n), "statstique" \ "de test" ) > #math.op("qnorm")_(1 - alpha)
$ 

A.N. $alpha = 5%$,  $#math.op("qnorm")_(1 - alpha) = 1.645$, $n = 100$,  $hat(p) = overline(x) = 0.22$

 $arrow.curve$  
 $
 T = (overline(x) - 0.2)/sqrt((0.2(1 - 0.2))/100) = 0.02/sqrt((0.2 (1-0.2))/100) = 0.2/sqrt(0.2 dot 0.8) = 0.2/0.4 = 1/2 < 1.645
 $ 

 Conclusion: on conserve $H_0$ (on ne connaît pas le risque associé)

 $
 "rejet" H_0 &<=> overline(x) > 0.2 + 1.645 sqrt((0.2(1 - 0.2))/100) \
             &<=> overline(x) > 0.266
 $ 
  
]

