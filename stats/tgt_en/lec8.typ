// --- CHUNK_METADATA_START ---
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---

#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// src_checksum: 9d745ba03a208d998d6f310b8f305bffb146c72a4f40262ef59cfbe74964c77e
// needs_review: True
// --- CHUNK_METADATA_END ---
= Introduction to Statistical Tests

// --- CHUNK_METADATA_START ---
// src_checksum: ecb9376a113eaf7a572b4f7c53f201994c265c72fe180e2ca9488b3ab80e6996
// needs_review: True
// --- CHUNK_METADATA_END ---
== Example
// --- CHUNK_METADATA_START ---
// src_checksum: cd6a5bca4549638109b34f1fdc531c91b992a379e50baaa213508734caafe90d
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Quality control: industrial.
Produces "parts"
- $arrow.curve$ of good quality
- $arrow.curve$ defective

For the manufacturer, a proportion of $20%$ defective parts is assumed acceptable.

To control: randomly select $n$ parts, verified ($p <= 20%$)

// --- CHUNK_METADATA_START ---
// src_checksum: a9f463472cfab1bddbfc426b601d23ed7199f21688f9ec54dd478d33fc5f8dfa
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Modeling
$i^"ème"$ item $X_i = cases(0 "si bonne qualité", 1 "si défectueuse")$
$p = P(X_i = 1)$

$arrow.curve$ we sample $n$ items and observe a sample $(X_1, ..., X_n)$ whose observed values are $(x_1, ..., x_n)$.

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

What is $p$? $->$ we estimate
- empirical proportion
-  $X_i ~_"indep" #math.op("Bernouili") (p)$ $->$  $hat(p) = overline(X)$

We observe  $overline(x) = 0.22$,  $n=100$

We proceed with a confidence interval for $p$.
 We define $hat(p) = overline(X)$, 
 CLT:
 $
 (overline(X) - p)/(sqrt((p(1-p))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
 $ 
 we estimate the standard deviation by $(hat(p)(1 - hat(p)))/n$ (consistent). Slutsky's Lemma: 
  $
 ( overline(X) - p )/sqrt((overline(X)(1 - overline(X)))/n) = (overline(X) - p)/(sqrt( (p(1-p))/n )) times (overbrace( underbrace( sqrt( (p(1-p))/n ), -->^P 1 ), "LGN:" overline(X) -->^P p ", LAC:" g(x) = sqrt((x(1-x))/n) ))/(sqrt((overline(X)(1 - overline(X)))/n)) -->^(cal(L))_(n -> +infinity) 1 . cal(N) (0, 1)
 $ 

 
// --- CHUNK_METADATA_START ---
// src_checksum: 792690151e3633b0bcd6a7257b143d24585a0b0e0f8967971a80277da0e40ed2
// needs_review: True
// --- CHUNK_METADATA_END ---
$
 P(#math.op("qnorm")_(alpha/2) <= (overline(X) - p)/(sqrt((overline(X)(1 - overline(X)))/n)) <= #math.op("qnorm")_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha
 $ 
 $
 <=> P(overline(X) - q_(1 - alpha/2)sqrt((overline(X)(1 - overline(X)))/n) <= p <= overline(X) - q_(alpha/2) sqrt((overline(X)(1 - overline(X)))/n)) -->_n 1 - alpha
 $ 

 $#math.op("IC") (p) = overline(X) pm #math.op("qnorm")_(1 - alpha/2) sqrt((overline(X)(1 - overline(X)))/n)$ with an asymptotic level  $1 - alpha$. 

 Ex:  $overline(x) = 0.22$,  $alpha = 5%$,  $n = 100$,  $#math.op("IC") = [0.14, 0.30]$

 Question: is $p <= 0.2$ or  $p > 0.2$ ?


// --- CHUNK_METADATA_START ---
// src_checksum: 9f2d0fc5fe349f62a7a4ea6d429b798d4e60de4a2e6a672480ff39162d2952f6
// needs_review: True
// --- CHUNK_METADATA_END ---

== Principle of a test
 $Theta subset ]0, 1[$. We want to test if $p <= 0.2$ or $p > 0.2$.

  $Theta = underbrace( Theta_0, ]0\, 0.2] ) union underbrace( Theta_1, ]0 \, 1
  \[ )$ disjoint subsets. 

  We test $H_0$: $p in Theta_0$, $p <= 0.2$ against $H_1$: $p in Theta_1$, $p > 0.2$ 

  Conclusion: 
  - Either we retain $H_0$: ($p <= 0.2$) 
  - Or we reject $H_0$ (we conclude $p > 0.2$)

 #defn[
   A test of $H_0$ against $H_1$ is defined by the construction of a rejection region for $H_0$, $cal(R)$
   - if $(X_1, ..., X_n) in cal(R)$, we reject $H_0$ (in favor of $H_1$)
   - if $(X_1, ..., X_n) cancel(in) cal(R)$, we retain $H_0$
 ]
 Often $cal(R) = {(X_1, ..., X_n), T(X_1, ..., X_n) > c}$
 - $T$: test statistic (real-valued)
 - $c$: test threshold

 #rmk[
   the decision of a test is random (depends on random $T$)
 ] 

 How to relate $cal(R)$ to the tested hypotheses?

 
// --- CHUNK_METADATA_START ---
// src_checksum: efd030e4b7a7676afcd5df898d305dc7ea1b940d427c947a5d250304c5646a33
// needs_review: True
// --- CHUNK_METADATA_END ---
== Error Risk
 #defn[
   Type $1^"ère"$ error or Type I risk is the function defined on
   $
   Theta_0 &--> [0, 1] \
         p &|-> P_p (( X_1, ..., X_n ) in cal(R)) = P_p ("we reject" H_0)
   $
   The test is said to be of level $alpha$ if $
   sup_(p in Theta_0) P_p ("rejection of "H_0) <= a
   $
 ]
 $R_q$ Type I error $= P("rejection of" H_0 "wrongly")$ 

 #align(center)[
 #table(columns: 3,
 [reality / decision], [$H_0$ true], [$H_1$ true],
 [$H_0$ true], [ok], [Type I error],
 [$H_1$ true], [Type II error], [ok]
 )]

 #defn[
   The Type II error is the function defined on Type II risk
   $
   Theta_1 &--> [0, 1] \
         beta: p &|-> P_p ( (X_1, ..., X_n) cancel(in) cal(R) ) = P_p ("we retain" H_0)
   $
 ]
 #rmk[
   Type II error is $P("to retain" H_0 "wrongly")$
 ]

 power of the test: = 1 - Type II error

 $
 product : p in Theta_1 --> P_p ((X_1, ..., X_n) in cal(R))
 $
 Choice: the 2 errors cannot be minimized simultaneously. In general, $alpha$ increases when $beta$ decreases.

 Test: We choose to control the Type $1^"ere"$ error ($=>$ the Type II error is generally unknown)

// --- CHUNK_METADATA_START ---
// src_checksum: d6358b26fdab92a27dd620bb6acef38f239bd8a05332cd948bb8bbe6be4ebb97
// needs_review: True
// --- CHUNK_METADATA_END ---
== Construction of a Test
Principle: determine $cal(R)$ such that the type I error $<= alpha$ (if
we have multiple tests, we will choose (from a theoretical point of view) the one whose
type II error is the smallest (or whose power is the greatest)). Based
on an asymmetry between $H_0$ and $H_1$ in the construction. 


// --- CHUNK_METADATA_START ---
// src_checksum: 093f349ed45f82487ca19281afc380e4cf34408ed47d7d8f27f7a1c0ac4f834d
// needs_review: True
// --- CHUNK_METADATA_END ---
#ex[
  $H_0: p<= 0.2$ versus  $H_1: p > 0.2$ ($overline(x) = 0.22$)

  - $p$ is unknown, so we estimate it as  $hat(p) = overline(X)$
  - Idea: under  $H_1$,  $hat(p)$ takes larger values than under $H_0$ 

  $arrow.curve$  $cal(R)$ of the form  $hat(p) > c$ with  $c$ such that  $P_p (hat(p) > c) <= alpha$ ? (calculation? limit distribution of parameter $p$?)

  $
  hat(p) = overline(X) --> (hat(p) - p)/sqrt((p(1-p))/n)
  $ 
  is approximately distributed as $cal(N) (0, 1)$

  $
  P(hat(p) > c) = P( (hat(p) - p)/sqrt((p(1-p))/n) > overbrace(c, = ( (c-p)/sqrt((p(1-p))/n) )) )
  $ 
  We want that
  $
  sup_(p in Theta_0 \ p <= 0.2) P ((hat(p) - p)/sqrt((p(1-p))/n) > c) <= alpha
  $ 
  $arrow.curve$ the supremum is reached at  $p = 0.2$

  $
  cal(R) = { (X_1, ..., X_n), (hat(p) - 0.2)/(sqrt((0.2(1 - 0.2))/n)) > c }
  $ 
  Find $c$ such that  $P((X_1, ..., X_n) in cal(R)) -->_(n -> +infinity) alpha$
   $
  P((hat(p) - 0.2)/sqrt((0.2(1 - 0.2))/n) > c) -->_(n -> +infinity) alpha "iff" c = #math.op("qnorm")_(1 - alpha)
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
- rejection of $H_0$ iff 
 $
T = underbrace( (hat(p) - 0.2)/sqrt((0.2(1 - 0.2))/n), "statstique" \ "de test" ) > #math.op("qnorm")_(1 - alpha)
$ 

Numerical Application: $alpha = 5%$,  $#math.op("qnorm")_(1 - alpha) = 1.645$, $n = 100$,  $hat(p) = overline(x) = 0.22$

 $arrow.curve$  
 $
 T = (overline(x) - 0.2)/sqrt((0.2(1 - 0.2))/100) = 0.02/sqrt((0.2 (1-0.2))/100) = 0.2/sqrt(0.2 dot 0.8) = 0.2/0.4 = 1/2 < 1.645
 $ 

 Conclusion: we retain $H_0$ (the associated risk is unknown)

 $
 "rejection" H_0 &<=> overline(x) > 0.2 + 1.645 sqrt((0.2(1 - 0.2))/100) \
             &<=> overline(x) > 0.266
 $ 
  
]
// --- CHUNK_METADATA_START ---
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


