// --- CHUNK_METADATA_START ---
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// needs_review: True
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// src_checksum: e1e720dcf50c073efebcda14e7fa3914466b7361d06791b76426f7464d7dedfc
// needs_review: True
// --- CHUNK_METADATA_END ---
= Empirical Distribution Function
$(X_1, ..., X_n)$ i.i.d. real-valued sample from an unknown distribution $F$.
 $
forall x in RR, F(x) = P(X_1 <= x) = E[bb(1)_(X_1 <= x)]
$ 

#defn[
  The #underline[empirical] distribution function associated with $(X_1, ..., X_n)$ is defined by:
   $
  hat(F)_n: RR &--> [0, 1] \
            x &|-> 1/n sum_(i=1)^n bb(1)_(X_i <= x)
  $
  $forall x in RR, hat(F)_n (x)$ is a random variable, an estimator of $F(x)$.
]

#defn[
  Empirical Law $P_n = 1/n sum_(i=1)^n delta_X_i$ is a discrete uniform law on ${X_1, ..., X_n}$.
]

Graphical Representation

Conditionally $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$

 $
x_((1)) <= x_((2)) <= ... <= x_((n)) " ordered values"
$ 

#import "figures/repr-graphique-repartition-empirique.typ":diagram as repr-graphique-repartition-empirique
#repr-graphique-repartition-empirique(width: 400pt)

// --- CHUNK_METADATA_START ---
// src_checksum: 34828b439b560284a22a94ed9275ee0e28fab3154a3039a2cb838166871d6d2b
// needs_review: True
// --- CHUNK_METADATA_END ---
#prop(info: "Immediate Properties")[
  - $n hat(F)_n (x) = sum_(i=1)^n bb(1)_(X_i <= x)$ follows the binomial law$(n, F(x))$
  - $R(hat(F)_n (x), F(x)) = 0 + 1/(n^2) Var(sum_(i=1)^n bb(1)_(X_i <= x)) underbrace(=, "indep") 1/n F(x) (1 - F(x)) -->_(n -> +infinity) 0$
     therefore $forall x in RR, hat(F)_n (x) -->^P F(x)$
  - or #underline[LLN]: $hat(F)_n (x)$ estimator #underline[consistent] of $F(x)$.
  - We have a uniform convergence result:
     $
    sup_(x in RR) |hat(F)_n (x) - F(x)| -->_(n -> +infinity)^P 0 " (Glivenko-Cantelli Theorem)"
    $
    .#footnote[Glivenko-Cantelli Thm: #link("https://fr.wikipedia.org/wiki/Th%C3%A9or%C3%A8me_de_Glivenko-Cantelli")]
  - $hat(F)_n (x)$ is it asymptotically normal?
    
     $
    hat(F)_n (x) = 1/n sum_(i=1)^n bb(1)_(X_i <= x)
    $
    CLT: the $X_i$ are i.i.d., so the ${bb(1)_(X_i <= x) = Y_i}$ are i.i.d.
     $
    forall x, F(x) in ]0, 1[, #h(1em) sqrt(n)(hat(F)_n (x) - F(x)) -->^(cal(L))_(n -> +infinity) cal(N)(0, F(x)(1 - F(x)))
    $
    $
    <==> (hat(F)_n (x) - F(x))/(sqrt((F(x)(1 - F(x)))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
    $
]

// --- CHUNK_METADATA_START ---
// src_checksum: cebc3a2dab879021a16c99dc33a2e7a15b26eed8903e875313106205fa2d5d0d
// needs_review: True
// --- CHUNK_METADATA_END ---
== Empirical Estimation
"plug-in" or substitution method, parameter of interest $theta = c(F)$, the empirical method defines $hat(theta)$, an empirical estimator by replacing $F$ with $hat(F)_n -> hat(theta)_n = c(hat(F)_n)$.

#ex[
  $theta = E_F (X) -> hat(theta)_n = E_(hat(F)_n)(X) = sum_(i=1)^n X_i times 1/n = overline(X)$ if $X_i$ are distinct

   $
  theta = Var_F (X) -> hat(theta)_n = Var_(hat(F)_n)(X) = 1/n sum (X_i - overline(X))^2
  $ 
]
// --- CHUNK_METADATA_START ---
// src_checksum: 3c9872e903c5d398e6667322d88aac44df0c41a6b63c7dadb9d2aef30accb444
// needs_review: True
// --- CHUNK_METADATA_END ---
== Generalized Inverse
#defn[
  The generalized inverse of $F$ is defined by:
   $
  F^(-1): [0, 1] --> RR
  $ 
  $
  forall alpha in [0, 1], F^(-1)(alpha) = inf{x in RR, F(x) >= alpha}
  $ 
  If $F$ is strictly increasing,  $inf x$ such that  $F(x) >= a <=> x >= F^(-1) (alpha)$, if  $F$ is the function of a discrete distribution.

]
#pagebreak()
#import "figures/inverse-generalise.typ":diagram as inverse-generalise
#inverse-generalise(width: 400pt)

#ex[
  $
  F^(-1) (alpha) = x <=> F(x) = alpha <=> P(X <= x) = alpha <=> P(X > x) = 1 - alpha
  $ 
  #image("figures/inv-gen.JPG", width: 300pt)
]

Vocabulary: 
- $F^(-1)$ is also called the #underline[quantile function]
-  $F^(-1) (alpha) = $ $alpha$-order quantile, of the distribution $F$
-  $F^(-1) (1/4) = $ 1st quantile
-  $F^(-1)(1/2) = $ median
-  $F^(-1) (3/4) = $ 3rd quantile

#lem[
  $U$ a random variable on $[0, 1]$,  $F$ a c.d.f., then  $F^(-1)(U)$ is a random variable with distribution  $F$
] 
- If $F$ is bijective: 
 $
P(F^(-1)(U) <= x) underbrace(=, F "bijective") P(U <= F(x)) underbrace(=, "car" P(U <= x) = x "sur" [0, 1]) F(x)
$ 
- If $F$ is discrete: $F^(-1)$ generalized inverse:  $F^(-1)(y) <= x <=> y <= F(x)$
// --- CHUNK_METADATA_START ---
// src_checksum: a8b431b997975285c5ce8b1f574ddf98df43fffb504832de49903d613c226d62
// needs_review: True
// --- CHUNK_METADATA_END ---
== Empirical Quantile

#defn[
  We define the #underline[empirical quantile] (sample quantile) of order
  $alpha$, as the quantile of $hat(F)_n$:
  $
  hat(q)_(n, alpha) = hat(F)_n^(-1)(alpha) = inf{x, hat(F)_n (x) >= alpha}
  $
] 

#prop[
  - It can be shown that $hat(q)_(n, alpha) = X_(([n alpha]))$ where $X_((1)) <=
    X_((2)) <= ... <= X_((n))$ is the ordered sample of $(X_i)_(1 <= i <
    n)$
    $
    [u] = "the smallest integer" >= u
    $
]
#ex[
  $alpha = 1/2$, $[n/2]$,
   $
  cases(
    "si" n=2k #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k)),
    "si" n=2k+1 #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k+1)))
  $
  - Consistency
    
    if $alpha in ]0,1[$, if $F$ is strictly increasing in the neighborhood of $alpha$
]

// --- CHUNK_METADATA_START ---
// src_checksum: 704a0af81b7d1f09a4c7c23e227046d44f332fb69d463594fb4492014476e483
// needs_review: True
// --- CHUNK_METADATA_END ---
= Confidence Intervals
// --- CHUNK_METADATA_START ---
// src_checksum: ef9a514a12d201313dc6fa6c54081efcafd1c911dda4e802398c1e6c89c96e7a
// needs_review: True
// --- CHUNK_METADATA_END ---
== Definitions
$(X_1, ..., X_n)$ i.i.d. from distribution $P in {P_theta, theta in Theta subset RR^p}$,
we are interested in $theta in RR$ or $g(theta): RR^p --> RR$. 

A confidence interval for $theta$, with a confidence level of $1 - alpha,
alpha in ]0, 1[$ is an interval whose bounds are #underline[random],
functions of the sample and do NOT depend on the unknown parameters of the model, and such that
 $
 P([B inf (X_1, ..., X_n); B sup (X_1, ..., X_n)] in.rev theta) >= 1 - alpha
$ 
#footnote[$B inf$ for lower bound and $B sup$ for upper bound]
- A CI is computable from the data
- if the inequality is an equality $=$, the confidence level is #underline[exact].
- if we have $P(theta in [B inf, B sup]) -->_(n -> +infinity) 1 - alpha$, the level is #underline[asymptotic].
- generally $alpha = 1%, 5%$
// --- CHUNK_METADATA_START ---
// src_checksum: e00d75886a46aaa7ef97dc8bdf174c853ed2761fba239e2e8beb6324208bd272
// needs_review: True
// --- CHUNK_METADATA_END ---
== Interpretation
// fig 1 here

#grid(columns: (50%, 50%),
[
  #image("figures/interv-confiance.png")
],
[
 $I C = [B inf(X_1, ..., X_n), B sup(X_1, ..., X_n)]$ mathematical formula that guarantees the level $1 - alpha$.
 We observe $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$, a realization of the random sample. We calculate
 $I C = [2.3; 5.1]$ with a confidence level $95%$ ($alpha = 5%$).

 On average, out of 100 calculated intervals (using the same formula), there are 5
 intervals that do not contain $theta$. 

 $
 P(theta in [B inf, B sup]) = 1 - alpha
 $
 $
 cancel(P(theta in [2.3, 5.1]) = 95%) "because " theta "is a number"
 $
]
)

// --- CHUNK_METADATA_START ---
// src_checksum: 73a42a8c181b6995d15aa28f915da5da281a19a9e0f4ef87f21e8ae8df9e17d8
// needs_review: True
// --- CHUNK_METADATA_END ---
== Pivotal Method
$(X_1, ..., X_n)$ i.i.d. with expectation $theta in RR$, with variance $sigma^2(theta)$. Let $hat(theta)$ be asymptotically normal:
 $
sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2(theta)) \
<=> (sqrt(n) (hat(theta)_n - theta))/(sigma(theta)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
$ 

By definition of Gaussian quantiles, $q_alpha = Phi^(-1) (alpha)$ where $Phi$ is the c.d.f. of $cal(N) (0, 1)$

#math.equation(numbering: "(1)", block: true, $
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/sigma(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha
$ )<eq:intervalle-de-confiance>

#align(center)[
  #image(width: 50%, "figures/methode-pivotale.png")
]

- *pivot or pivotal statistic* = $(sqrt(n) (hat(theta) - theta))/(hat(sigma))$ a centered and reduced statistic derived from $hat(theta)$, where $sigma^2(theta)$ is estimated by $hat(sigma)^2$, #underline[consistent] for estimating $sigma^2(theta)$. 

  If this is the case,
  $
  underbrace( (sqrt(n) (hat(theta) - theta))/(sigma(theta)), -->^(cal(L))_(hat(theta) "as. normal") cal(N) (0, 1) ) times underbrace( (sigma^2(theta))/(hat(sigma)^2), -->^(P)_("estimateur consistant") 1) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1) " by Slutsky's lemma"
  $
- we deduce
  $
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/hat(sigma)(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
P(hat(theta) - 1/(sqrt(n))hat(sigma)q_(1 - alpha/2) <= theta <= hat(theta) - 1/(sqrt(n)) hat(sigma) q_(alpha/2)) --> 1 - alpha
  $ 

#rmk(info: [why $alpha/2$?])[
  We can observe that the quantiles in @eq:intervalle-de-confiance are
  of order $alpha/2$ and $1-alpha/2$. To understand why, it is enough
  to perform a simple calculation. First, we note $( sqrt(n) (hat(theta)
  - theta) )/sigma(theta) =: Z ~ cal(N) (0, 1)$.
  $
  P(q_(alpha/2) <= Z <= q_(1 - alpha/2)) = P(Z <= q_(1 - alpha/2)) - P(Z <= q_(alpha/2)) = 1 - alpha/2 - alpha/2 = 1 - alpha
  $
]
