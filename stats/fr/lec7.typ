
#import "preamble.typ": *

= Estimation dans les échnatillons gaussiens

1. Loi normale et lois dérivées
2. Loi des estimateurs empririques
3. IC des paramètres
4. Exercice

== TL&DR
$(X_1, ..., X_d)$ des variables aléatoires i.i.d. qui suivent  $cal(N) (0, 1)$ et $X ~ cal(N) (0, 1)$,
$
Y = X_1^2 + ... + X_d^2 ~ chi^2 (d)
$ 

$
X/sqrt(Y/d) ~ #math.op("Student") (d)
$
== Loi normale et lois dérivées


#defn[
  $Z$ est dite gauissienne (normale) centrée réduite si sa loi admet pour densité
  $
  f(x) = 1/sqrt(2 pi) e^(-x^2/2), x in RR
  $ 
  On note $Z ~ cal(N) (0, 1)$.

  $X$ est dite de loi normale de paramètres  $mu in RR$ et $sigma^2 > 0$ ssi 
  $ X = mu + sigma Z $ notée 
  $
  X ~ cal(N)(mu, sigma^2)
  $ 
]

Autres caractérisations de la loi normale:
- par densité
  $
  f_X (x) = 1/(sqrt(2 pi sigma^2)) e^(-1/(2 sigma^2) (x - mu)^2)
  $ 
- par la fonction génératrice des moments
  $
    M(t) = E[e^(t X)] = e^(t mu + 1/2 sigma^2 t^2), forall t in RR
  $ 

#rmk[
  - $sigma^2 = 0$  $->$  $X = mu$ presque surement
  - si  $X_1 ~ cal(N) (mu_1, sigma_1^2)$, $X_2 ~ cal(N) (mu_2, sigma_2^2)$ et $lambda in RR$, alors\ $lambda X_1 + X_2 ~ cal(N) (lambda mu_1 + mu_2, lambda^2 sigma_1^2 + sigma_2^2)$
]

Moments centrés: densité symétrique par rapport à $mu$

// image 1
// Gamma function approximation (Lanczos)
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

// Student t-distribution PDF with nu degrees of freedom
#let student(x, nu) = {
  let coeff = gamma((nu + 1) / 2) / (calc.sqrt(nu * calc.pi) * gamma(nu / 2))
  coeff * calc.pow(1 + x * x / nu, -(nu + 1) / 2)
}

#let chi2(x, k) = {
  if x <= 0 { 0 } else {
    let half-k = k / 2
    calc.pow(x, half-k - 1) * calc.exp(-x / 2) / (calc.pow(2, half-k) * gamma(half-k))
  }
}

#align(center)[
#canvas({
  plot.plot(
    size: (8, 3),
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
      plot.add(
        domain: (-4, 4),
        samples: 200,
        style: (stroke: blue + 1.5pt),
        label: $cal(N) (0, 1)$,
        x => calc.exp(-x * x / 2) / calc.sqrt(2 * calc.pi),
      )
          // Student t, nu = 3
      plot.add(
        domain: (-4, 4),
        samples: 200,
        label: $#math.op("Student") (3)$,
        style: (stroke: orange + 1.5pt),
        x => student(x, 3),
      )
    }
  )
})
]

moments centrés:  $E[(X - mu)^k]$

- tous les moments centrés d'ordre impaire sont nuls
-  $mu_(2 k) = ((2k)!)/(2^k k!) sigma^(2 k)$
  - $E[(X - mu)^4] = 3 sigma^4$
  -  $Var(X) = E[(X - mu)^2] = sigma^2$
 
#defn[
  $(X_1, ..., X_d)$ échantillon i.i.d.  $cal(N) (0, 1)$. La loi de  $X_1^2 +
  X_2^2 + ... + X_d^2$ est appelée loi du $chi^2$ (chi 2) à $d$ degrés de liberté (ddl) (degrees of freedom (df)).
]

// fig 2
#align(center)[
#canvas({
  plot.plot(
    size: (8, 4),
    x-label: $x$,
    y-label: $f(x)$,
    axis-style: "school-book",
    x-min: 0,
    x-max: 12,
    y-min: 0,
    y-max: 0.30,
    x-tick-step: 2,
    y-tick-step: none,
    y-ticks: (),
    {
      plot.add(
        domain: (0.01, 12), samples: 300,
        label: $chi^2_7$,
        style: (stroke: green + 1.5pt),
        x => chi2(x, 4),
      )
    }
  )
})
]

#cor[
 - si $Y$ de loi $chi^2 (d)$,  $E[Y] = d$,  $Var(Y) = 2 d$
  $
 Var(X_1^2 + ... + X_d^2) underbrace(=, "indep") d underbrace(Var(X_i^2), E X_i^h = E[X_i^2]^2 = 3 - 1 = 2) 
 $ 
 - support $RR_+$
 -  $M(t) = (1 - 2t)^(-d/2)$,  $(t < 1/2)$
]

#defn[
  si $X ~ cal(N) (0, 1)$ et $Y ~ chi^2 (d)$ indépendantes, la loi de $Z = X/sqrt(Y/d)$ est appelée loi de Student à $d$ ddl.
]

#rmk[
  si $d -> +infinity$, la loi de Student converge vers la loi  $cal(N) (0, 1)$

   $
   Y/d =^(cal(L))_"def" 1/d sum_(i=1)^d U_i^2 "où" U_i ~ cal(N) (0, 1) "indép entre elles de" X \
   -->^P_"LGN" E(U_i^2) = 1
   $ 
   donc (LAC)
   $
   g(x) = sqrt(x) 1/(sqrt(Y/d)) -->^P 1
   $ par le Lemme de Slutsky $Z -->^cal(L) 1 dot X ~ cal(N) (0, 1)$
]

On introduit $(X_1, ..., X_n)$ i.i.d.  $cal(N) (mu, sigma^2)$ où  $mu$ et $sigma^2$ paramètres inconnus.
- $arrow.hook$  $mu = E[X_i]$ $arrow.squiggly$  $hat(mu) = overline(X)$
- $arrow.hook$  $sigma^2 = Var(X_i)$ $arrow.squiggly$  $hat(sigma^2) = 1/n sum(X_i - overline(X))^2$

Soit $S_n^2 = 1/(n-1) sum_(i=1)^n (X-i - overline(X))^2$ #underline[non biaisé]

== Loi des estimateurs empritiques

#thm(info: [loi de $hat(mu)$ et  $hat(sigma)^2$])[
  - $overline(X)$ et  $sum_(i=1)^n (X_i - overline(X))^2$ sont des variables aléatoires #underline[indépendantes]
  -  $overline(X) ~ cal(N) (mu, sigma^2/n)$
  -  $1/(sigma^2) sum_(i=1)^n (X_i - overline(X))^2 ~ chi^2 (n-1) => (n hat(sigma)^2)/(sigma^2) ~ chi^2 (n-1)$ et $((n-1) S_n^2)/sigma^2 ~ chi^2 (n-1)$
  - $(overline(X) - mu)/(S_n/sqrt(n)) ~ #math.op("Student") (n-1)$
  - $overline(X)$ et $overbrace( (overline(X), X_1 - overline(X), ..., X_n - overline(X)), T )$ sont indépendantes
]
#proof[
  $
  M(u, t_1, ..., t_n) &= E[e^(u overline(X) + t_1 (X_1 - overline(X)) + ... + t_n (X_n - overline(X)))] \
                      &= E[e^((u/n + (underbrace( (t_1 + t_2 + ... + t_n)/n, overline(t)))) X_1) ... e^((u/n + overline(t))X_n)] \
                      &= E[product_(i=1)^n e^((u/n + t_i - overline(t))X_i)] \
          X_i "indép" &= product_(i=1)^n underbrace(E[e^((u_n + t_i - overline(t)) X_i)], M(u_n + t_i - overline(t))) \
                      &= product_(i=1)^n e^(mu (u/n + t_i - overline(t)) + sigma^2/2 (u_n + t_i - overline(t))^2) \
                      &= e^(sum_(i=1)^n mu (u/n + t_i - overline(t)) + sigma^2/2 (u_n + t_i - overline(t))^2 ) \
                      &= e^(mu u + mu overbrace(sum_i (t_i - overline(t)), 0) + sigma^2/2 sum_i ( u^2/n^2 + (t_i - overline(t))^2 + 2 u/n (t_i - overline(t)))) \
                      &= e^(mu u + sigma^2/2 (u^2/n + sum_i (t_i - overline(t))^2)) \
                      &= underbrace( e^(mu u + ( sigma^2 u^2 )/(2 n)), M_(overline(X)) (u) ) underbrace( e^(sigma^2/2 sum_i (t_i - overline(t))^2), M_T (t_1, ..., t_n) )
  $

  $
  1/sigma^2 sum_(i=1)^n (X_i - mu)^2 &= 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2 + n/sigma^2 (overline(X) - mu)^2 + 2/sigma^2 sum_i (X_i - overline(X))(overline(X) - mu) \
                                     &= 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2 + n/sigma^2 (overline(X) - mu)^2 + 2/sigma^2 (overline(X) - mu) underbrace( sum_i (X_i - overline(X)), =0 ) \
                                     &= underbrace( 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2, = sum_(i=1)^n ((X_i - mu)/sigma)^2 ~ chi^2 (n)) + underbrace( n/sigma^2 (overline(X) - mu)^2, = ((overline(X) - mu)/(sigma/sqrt(n)))^2 ~ chi^2 (1) ) 
  $ 
  $
  "par indép" => M_(chi^2 (n)) (t) = M_? (t) M_(chi^2 (1)) (t) => M_? (t) = ((1 - 2t)^(-n/2))/((1 - 2t)^(-1/2)) = (1 - 2t)^(- (( n-1 ))/2)
  $ 
  qui caractérise la loi $chi^2 (n-1)$

   $
  (overline(X) - mu)/(S_n/sqrt(n)) = ((overline(X) - mu)/(sigma/sqrt(n)))/(S_n/sqrt(n) times sqrt(n)/sigma) = ((overline(X) - mu)/(sigma/sqrt(n)))/(sqrt((S_n^2)/sigma^2))
  $ 
  $
  S_n^2/sigma^2 = ((sum (X_i - overline(X))^2)/sigma^2) ~ chi^2 (n-1)
  $ 
  donc $overline(X) + S_n^2$ indépendantes  $underbrace(=>, "def Student")$  $#math.op("Student") (n-1)$
]

== IC des paramètres
Pivot. $(overline(X) - mu)/(S_n/sqrt(n)) ~_"loi exacte" #math.op("Student") (n-1)$
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
      plot.add-fill-between(
  domain: (-4, q-lo),
  samples: 200,
  style: (fill: red.transparentize(60%), stroke: none),
  x => student(x, 3),
  x => 0,
)
// Right tail: rejection region
plot.add-fill-between(
  domain: (q-hi, 4),
  samples: 200,
  style: (fill: red.transparentize(60%), stroke: none),
  x => student(x, 3),
  x => 0,
)
// Acceptance region
plot.add-fill-between(
  domain: (q-lo, q-hi),
  samples: 200,
  style: (fill: blue.transparentize(75%), stroke: none),
  x => student(x, 3),
  x => 0,
)
      // Student curves
      plot.add(
        domain: (-4, 4), samples: 200,
        label: $t_3$,
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

 $
   &P(q_(alpha/2) t (n-1)) <= (overline(X) - mu)/(S_n/sqrt(n)) <= q_(1 - alpha/2) t (n-1) ) \
<=>&P(overline(X) - S_n/sqrt(n) q_(1 - alpha/2) t (n-1) <= mu <= overline(X) + S_n/sqrt(n) q_(1 - alpha/2) t (n-1)) = 1-alpha
$ 

IC $(sigma^2)$,  $( n hat(sigma)^2 )/sigma^2 ~ chi^2 (n-1)$

 $
P(q_(alpha/2) chi^2 (n-1) <= ( n hat(sigma)^2 )/sigma^2 <= q_(1 - alpha/2) chi^2 (n-1)) = 1 -alpha \
= P((n hat(sigma)^2)/( q_(1 - alpha/2) chi^2 (n-1) ) <= sigma^2 <= (n hat(sigma)^2)/( q_(alpha/2) chi^2 (n-1) )) = alpha - 1
$ 
$arrow.squiggly$ IC $= [(n hat(sigma)^2)/( q_(1 - alpha/2) chi^2 (n-1)) , (n hat(sigma)^2)/( q_(alpha/2) chi^2 (n-1) )]$

#rmk[
  $(n hat(sigma)^2)/sigma^2 ~ chi^2 (n-1)$ et  $((n-1) S_n^2)/sigma^2 ~ chi^2 (n-1)$

   $
  (overline(X) - mu)/(S_n/sqrt(n)) ~ #math.op("Student") (n-1)
  $ 
]

== Exercice
- Montrez que  $(hat(mu), hat(sigma^2))$ sont les EMV de  $mu$ et  $sigma^2$
-  $R(S_n^2, sigma^2) > R(hat(sigma_n)^2, sigma^2)$ où  $R$ représente une risque

