// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 43ba1e95b0f2e64be6fac94c25d8fdb5b386caebf2cd3d4814c8bbd79975b312
// --- CHUNK_METADATA_END ---
= Introduction// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c87ca8d91c1d06fb49b63aa12ea9acceb250ba93a9cb8e835ba0b03bd85e09bb
// --- CHUNK_METADATA_END ---
== Evaluation
- $0.4$ Continuous Assessment $+ 0.6$ Exam.
- Breakdown : $80\%$ midterm, $20\%$ Quiz (scheduled for 26/01).// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f304a7eac8fabbf4c839d8e355944d0fd595aa4b05ebf113a14157388d4c230a
// --- CHUNK_METADATA_END ---
== Statistical Model

#defn(info: "Statistical Model")[
  A statistical model is a probability space $(Omega, cal(A), cal(P))$ where $cal(P)$ is a family of probability distributions ${P_theta; theta in Theta}$.
]

- If $exists p in NN^*, Theta subset RR^p$ : parametric model.
- Otherwise : non-parametric model.

#ex(info: "Families of Distributions")[
  - Poisson distributions : $cal(P) = {P(lambda); lambda > 0}$.
  - Regular density : $cal(P) = {PP; PP " whose density admits a bounded second derivative"}$.
]

#defn(info: "Observation")[
  An observation is a random variable (r.v.) whose distribution belongs to ${P_theta, theta in Theta}$.
  Our observation will have a structure of $n$-samples $X_1, ..., X_n$ i.i.d. (independent and identically distributed) with a common distribution $in {P_theta, theta in Theta}$.
]

#rmk[
  $(X_1, ..., X_n)$ has distribution $P_theta^(times.o n)$. The sample contains all information about $P_theta$, thus about $theta$. //times.o
]

#defn(info: "Identifiability")[
  A model is identifiable if and only if (iff) the mapping $theta mapsto P_theta$ is injective.
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6f02be46d3cd08ea80269742d031d50c1d27a4e2f1f43609cf4598883180fe65
// --- CHUNK_METADATA_END ---
== Estimators

*Hypothesis :* We observe $X_1, ..., X_n$ i.i.d. from a common distribution $in {P_theta, theta in Theta subset RR^p}$ (identifiable parametric model). Let $theta^*$ be the true unknown value such that $P_(X_i) = P_(theta^*)$.

#defn(info: "Estimator")[
  An estimator of $theta$ is a measurable function of the sample $(X_1, ..., X_n)$ and independent of $theta$ (computable from the data).
]

*Notation :* $hat(theta) = hat(theta)_n = h(X_1, ..., X_n)$. It is a random variable. \
Examples : $hat(theta) = overline(X)$, $hat(theta) = X_1 - X_3$, etc.

Fundamental Questions :
+ How to define a good estimator ?
+ How to construct a good estimator ?// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 14df5690760448fc7088aa24a6ce62dbfe4cff637754de078d71fea69fe6d508
// --- CHUNK_METADATA_END ---
== Quadratic Risk

*Idea :* On average, $hat(theta)$ should be close to $theta$. We look at $EE[hat(theta) - theta]$.

#defn(info: "Bias")[
  The bias of $hat(theta)$ is defined by :
  $ B(hat(theta), theta) = EE[hat(theta)] - theta $
  We say that $hat(theta)$ is *unbiased* if $B(hat(theta), theta) = 0$.
]

#defn(info: "Quadratic Risk / MSE")[
  $ R(hat(theta), theta) = EE[(hat(theta) - theta)^2] $
  This is the *Mean Squared Error (MSE)* in English.
]

We say that $hat(theta)_1$ is better than $hat(theta)_2$ if and only if $R(hat(theta)_1, theta) <= R(hat(theta)_2, theta)$.// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0416d9d933540514f2cf5759107bc489ebdd5d6204b9f631671f44b862285c11
// --- CHUNK_METADATA_END ---
=== Example : Poisson Model
Let $X_1, ..., X_n$ be distributed according to a $P_theta$ Poisson law, with $theta > 0$. We seek an estimator for $theta = EE[X_i]$.

Let's propose : $hat(theta) = overline(X) = 1/n sum_(i=1)^n X_i$.

*Bias Calculation :*
$
  B(hat(theta), theta) &= EE[1/n sum_(i=1)^n X_i] - theta \
  &= 1/n sum_(i=1)^n EE[X_i] - theta quad ("by linearity") \
  &= 1/n dot n dot EE[X_1] - theta \
  &= theta - theta = 0
$
Thus $EE[overline(X)] = theta$, is the unbiased estimator.

*Risk Calculation :*
$
  R(hat(theta), theta) &= EE[(overline(X) - theta)^2] = EE[(overline(X) - EE[overline(X)])^2] \
  &= Var(overline(X)) = Var(1/n sum X_i) \
  &= 1/n^2 sum Var(X_i) quad ("because i.i.d") \
  &= 1/n^2 dot n dot Var(X_1) = (Var(X_1))/n = theta/n
$

#thm(info: "Bias-Variance Decomposition of Risk")[
  $ R(hat(theta), theta) = (B(hat(theta), theta))^2 + Var(hat(theta)) $
]

#proof[
  $
    R(hat(theta), theta) &= EE[(hat(theta) - theta)^2] \
    &= EE[(hat(theta) - EE[hat(theta)] + EE[hat(theta)] - theta)^2] \
    &= EE[(hat(theta) - EE[hat(theta)])^2] + EE[(EE[hat(theta)] - theta)^2] + 2 EE[(hat(theta) - EE[hat(theta)])(EE[hat(theta)] - theta)] \
    &= Var(hat(theta)) + (B(hat(theta), theta))^2 + 2(EE[hat(theta)] - theta) underbrace(EE[hat(theta) - EE[hat(theta)]], 0) \
    &= Var(hat(theta)) + B(hat(theta), theta)^2
  $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 074abcf51803765b7713b0d3dcdb57d764201e2c289dc001247b518f59c18c01
// --- CHUNK_METADATA_END ---
== Consistency
Asymptotic property. We only consider consistent estimators.

#defn(info: "Consistency")[
  Let $(X_1, ..., X_n)$ be i.i.d. from distribution $P_theta$. Let $hat(theta)_n = h(X_1, ..., X_n)$.
  $hat(theta)_n$ is a consistent (or convergent) estimator of $theta$ if and only if :
  $ hat(theta)_n -->_(n -> +infinity)^(PP) theta $
]

#rmk[
  $hat(theta)_n$ is strongly consistent if and only if $hat(theta)_n -->_(n -> +infinity)^("p.s.") theta$.
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 082b3f3fd50fd6c42a745339d17d61c24015c6234ff322eef272ea1c43944332
// --- CHUNK_METADATA_END ---
=== Example : Revisiting the Poisson model
$Theta = RR_+^*$, $hat(theta)_n = overline(X)$.

- We can invoke the Law of Large Numbers (LLN) : $overline(X) -->^(PP) EE[X_i] = theta$.
- Via the quadratic risk :
  $ R(hat(theta)_n, theta) = Var(overline(X)) = theta/n -->_(n -> +infinity) 0 $
  According to Bienaymé-Chebyshev's inequality :
  $ P(|hat(theta)_n - theta| > epsilon) <= (EE[(hat(theta)_n - theta)^2])/epsilon^2 = (R(hat(theta)_n, theta))/epsilon^2 -> 0 $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8d18128e5d8de85fee63298356854cece7012ba4d0ab496f74e26ab97b7b68c0
// --- CHUNK_METADATA_END ---
=== "Plug-in" Method
Let $(X_1, ..., X_n)$ be i.i.d. Poisson$(theta)$. We want to estimate $beta = P(X_i = 0) = e^(-theta)$.
$ hat(beta) = e^(-hat(theta)) = e^(-overline(X)) $

$hat(beta)$ is consistent for estimating $beta$.

#lem(info: "Continuous Mapping Lemma")[
  If $Z_n -->^(PP) Z$, then $h(Z_n) -->^(PP) h(Z)$ for any continuous function $h$.
]
