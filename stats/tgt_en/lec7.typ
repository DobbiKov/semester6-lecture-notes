// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---

#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 1ce9737cd1eb75ebb1616c3a4f16696080c06a8fcfe7d4e4db0a83a31bd84e68
// --- CHUNK_METADATA_END ---
= Estimation in Gaussian samples

1. Normal distribution and derived distributions
2. Distribution of empirical estimators
3. CI of parameters
4. Exercise

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f84224cbfe080d5c5ac13e8318c137691542974f40044ffaeb0eb232ad0cab53
// --- CHUNK_METADATA_END ---
== Normal distribution and derived distributions


#defn[
  $Z$ is said to be standard Gaussian (normal) if its distribution has the density function
  $
  f(x) = 1/sqrt(2 pi) e^(-x^2/2), x in RR
  $ 
  We denote $Z ~ cal(N) (0, 1)$.

  $X$ is said to follow a normal distribution with parameters  $mu in RR$ and $sigma^2 > 0$ if and only if 
  $ X = mu + sigma Z $ denoted 
  $
  X ~ cal(N)(mu, sigma^2)
  $ 
]

Other characterizations of the normal distribution:
- by its density function
  $
  f_X (x) = 1/(sqrt(2 pi sigma^2)) e^(-1/(2 sigma^2) (x - mu)^2)
  $ 
- by the moment generating function
  $
    M(t) = E[e^(t X)] = e^(t mu + 1/2 sigma^2 t^2), forall t in RR
  $ 

#rmk[
  - If $sigma^2 = 0$  $->$  $X = mu$ almost surely
  - if  $X_1 ~ cal(N) (mu_1, sigma_1^2)$, $X_2 ~ cal(N) (mu_2, sigma_2^2)$ and $lambda in RR$, then\ $lambda X_1 + X_2 ~ cal(N) (lambda mu_1 + mu_2, lambda^2 sigma_1^2 + sigma_2^2)$
]

Central moments: symmetric density with respect to $mu$

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

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 04c2d836906cc497c61b9e77f6b76c08b5273497a6fdba9e03d6bb53230251fe
// --- CHUNK_METADATA_END ---
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

centered moments:  $E[(X - mu)^k]$

- all odd-order centered moments are zero
-  $mu_(2 k) = ((2k)!)/(2^k k!) sigma^(2 k)$
  - $E[(X - mu)^4] = 3 sigma^4$
  -  $Var(X) = E[(X - mu)^2] = sigma^2$
 
#defn[
  $(X_1, ..., X_d)$ i.i.d. sample from  $cal(N) (0, 1)$. The distribution of  $X_1^2 +
  X_2^2 + ... + X_d^2$ is called the $chi^2$ (chi-squared) distribution with $d$ degrees of freedom (df).
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
 - if $Y$ follows a $chi^2 (d)$ distribution,  $E[Y] = d$,  $Var(Y) = 2 d$
  $
 Var(X_1^2 + ... + X_d^2) underbrace(=, "indep") d underbrace(Var(X_i^2), E X_i^h = E[X_i^2]^2 = 3 - 1 = 2) 
 $ 
 - support $RR_+$
 -  $M(t) = (1 - 2t)^(-d/2)$,  $(t < 1/2)$
]

#defn[
  if $X ~ cal(N) (0, 1)$ and $Y ~ chi^2 (d)$ are independent, the distribution of $Z = X/sqrt(Y/d)$ is called Student's t-distribution with $d$ df.
]

#rmk[
  if $d -> +infinity$, Student's t-distribution converges to the distribution  $cal(N) (0, 1)$

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b80b824cadc3ecfe5c7560b39a57d1e40bddfb00d984158c7590ef38bfe2b79a
// --- CHUNK_METADATA_END ---
   $
   Y/d =^(cal(L))_"def" 1/d sum_(i=1)^d U_i^2 "where" U_i ~ cal(N) (0, 1) "are mutually independent, such that" X \
   -->^P_"LGN" E(U_i^2) = 1
   $
   therefore (LAC)
   $
   g(x) = sqrt(x) 1/(sqrt(Y/d)) -->^P 1
   $ by Slutsky's Lemma $Z -->^cal(L) 1 dot X ~ cal(N) (0, 1)$
]

We introduce $(X_1, ..., X_n)$ i.i.d.  $cal(N) (mu, sigma^2)$ where  $mu$ and $sigma^2$ are unknown parameters.
- $arrow.hook$  $mu = E[X_i]$ $arrow.squiggly$  $hat(mu) = overline(X)$
- $arrow.hook$  $sigma^2 = Var(X_i)$ $arrow.squiggly$  $hat(sigma^2) = 1/n sum(X_i - overline(X))^2$

Let $S_n^2 = 1/(n-1) sum_(i=1)^n (X-i - overline(X))^2$ #underline[unbiased]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9a4a4d5421c6b0bf7e573748a257afa25ef3402e7eac17f43df864f9a0e6a965
// --- CHUNK_METADATA_END ---
== Law of Empirical Estimators

#thm(info: [law of $hat(mu)$ and $hat(sigma)^2$])[
  - $overline(X)$ and $sum_(i=1)^n (X_i - overline(X))^2$ are random variables #underline[independent]
  -  $overline(X) ~ cal(N) (mu, sigma^2/n)$
  -  $1/(sigma^2) sum_(i=1)^n (X_i - overline(X))^2 ~ chi^2 (n-1) => (n hat(sigma)^2)/(sigma^2) ~ chi^2 (n-1)$ and $((n-1) S_n^2)/sigma^2 ~ chi^2 (n-1)$
  - $(overline(X) - mu)/(S_n/sqrt(n)) ~ #math.op("Student") (n-1)$
  - $overline(X)$ and $overbrace( (overline(X), X_1 - overline(X), ..., X_n - overline(X)), T )$ are independent
]
#proof[
  $
  M(u, t_1, ..., t_n) &= E[e^(u overline(X) + t_1 (X_1 - overline(X)) + ... + t_n (X_n - overline(X)))] \
                      &= E[e^((u/n + (underbrace( (t_1 + t_2 + ... + t_n)/n, overline(t)))) X_1) ... e^((u/n + overline(t))X_n)] \
                      &= E[product_(i=1)^n e^((u/n + t_i - overline(t))X_i)] \
          X_i "indep." &= product_(i=1)^n underbrace(E[e^((u_n + t_i - overline(t)) X_i)], M(u_n + t_i - overline(t))) \
                      &= product_(i=1)^n e^(mu (u/n + t_i - overline(t)) + sigma^2/2 (u_n + t_i - overline(t))^2) \
                      &= e^(sum_(i=1)^n mu (u/n + t_i - overline(t)) + sigma^2/2 (u_n + t_i - overline(t))^2 ) \
                      &= e^(mu u + mu overbrace(sum_i (t_i - overline(t)), 0) + sigma^2/2 sum_i ( u^2/n^2 + (t_i - overline(t))^2 + 2 u/n (t_i - overline(t)))) \
                      &= e^(mu u + sigma^2/2 (u^2/n + sum_i (t_i - overline(t))^2)) \
                      &= underbrace( e^(mu u + ( sigma^2 u^2 )/(2 n)), M_(overline(X)) (u) ) underbrace( e^(sigma^2/2 sum_i (t_i - overline(t))^2), M_T (t_1, ..., t_n) )
  $

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: bd56c18a2539d6830958d81e9002ce1643cb701dbb7470653cb3187d0c165f83
// --- CHUNK_METADATA_END ---
  $
  1/sigma^2 sum_(i=1)^n (X_i - mu)^2 &= 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2 + n/sigma^2 (overline(X) - mu)^2 + 2/sigma^2 sum_i (X_i - overline(X))(overline(X) - mu) \
                                     &= 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2 + n/sigma^2 (overline(X) - mu)^2 + 2/sigma^2 (overline(X) - mu) underbrace( sum_i (X_i - overline(X)), =0 ) \
                                     &= underbrace( 1/sigma^2 sum_(i=1)^n (X_i - overline(X))^2, = sum_(i=1)^n ((X_i - mu)/sigma)^2 ~ chi^2 (n)) + underbrace( n/sigma^2 (overline(X) - mu)^2, = ((overline(X) - mu)/(sigma/sqrt(n)))^2 ~ chi^2 (1) ) 
  $ 
  $
  "by independence" => M_(chi^2 (n)) (t) = M_? (t) M_(chi^2 (1)) (t) => M_? (t) = ((1 - 2t)^(-n/2))/((1 - 2t)^(-1/2)) = (1 - 2t)^(- (( n-1 ))/2)
  $ 
  which characterizes the $chi^2 (n-1)$

   $
  (overline(X) - mu)/(S_n/sqrt(n)) = ((overline(X) - mu)/(sigma/sqrt(n)))/(S_n/sqrt(n) times sqrt(n)/sigma) = ((overline(X) - mu)/(sigma/sqrt(n)))/(sqrt((S_n^2)/sigma^2))
  $ 
  $
  S_n^2/sigma^2 = ((sum (X_i - overline(X))^2)/sigma^2) ~ chi^2 (n-1)
  $ 
  therefore $overline(X) + S_n^2$ are independent  $underbrace(=>, "def Student")$  $#math.op("Student") (n-1)$
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f419955b87016ae30fbc03aa2ed3332f60c16e0857c0555349f44fb25f8448b2
// --- CHUNK_METADATA_END ---
== CI of parameters
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

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 34a66cfcd07983c04382b2ece5855f71d094024b189f5b7bd4f5099a973e203d
// --- CHUNK_METADATA_END ---
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
        
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d96959401c9a2e240b5660ba1de3195f96d791cb0cc618b84c3d967083411959
// --- CHUNK_METADATA_END ---
domain: (q-hi, q-hi), samples: 2,
        style: (stroke: ( thickness: 1pt, paint: blue, dash: "dashed" )),
        x => if x == q-hi { normal(q-hi) } else { 0 },
      )
    }
  )
})]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: fe3ec83f983a2248d631b57a22135fe41cfa98868e34e3905d5956cb9b760be6
// --- CHUNK_METADATA_END ---
 $
   &P(q_(alpha/2) t (n-1)) <= (overline(X) - mu)/(S_n/sqrt(n)) <= q_(1 - alpha/2) t (n-1) ) \
<=>&P(overline(X) - S_n/sqrt(n) q_(1 - alpha/2) t (n-1) <= mu <= overline(X) + S_n/sqrt(n) q_(1 - alpha/2) t (n-1)) = 1-alpha
$ 

CI $(sigma^2)$,  $( n hat(sigma)^2 )/sigma^2 ~ chi^2 (n-1)$

 $
P(q_(alpha/2) chi^2 (n-1) <= ( n hat(sigma)^2 )/sigma^2 <= q_(1 - alpha/2) chi^2 (n-1)) = 1 -alpha \
= P((n hat(sigma)^2)/( q_(1 - alpha/2) chi^2 (n-1) ) <= sigma^2 <= (n hat(sigma)^2)/( q_(alpha/2) chi^2 (n-1) )) = alpha - 1
$ 
$arrow.squiggly$ CI $= [(n hat(sigma)^2)/( q_(1 - alpha/2) chi^2 (n-1)) , (n hat(sigma)^2)/( q_(alpha/2) chi^2 (n-1) )]$

#rmk[
  $(n hat(sigma)^2)/sigma^2 ~ chi^2 (n-1)$ and  $((n-1) S_n^2)/sigma^2 ~ chi^2 (n-1)$

   $
  (overline(X) - mu)/(S_n/sqrt(n)) ~ #math.op("Student") (n-1)
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b1b4c059bc70dabb9d5bab3a45037ec98c6d54d7a51086ad8d9bee975198ddda
// --- CHUNK_METADATA_END ---
== Exercise
- Show that $(hat(mu), hat(sigma^2))$ are the MLEs of $mu$ and $sigma^2$
- $R(S_n^2, sigma^2) > R(hat(sigma_n)^2, sigma^2)$ where $R$ represents a risk

