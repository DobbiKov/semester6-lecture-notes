// --- CHUNK_METADATA_START ---
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// src_checksum: b654ee226f4feb560a63ff86fa98b67eba1b6beebc8066e92509f487425fd444
// needs_review: True
// --- CHUNK_METADATA_END ---
= Hypothesis Tests (on a parameter)

// --- CHUNK_METADATA_START ---
// src_checksum: 14aae3fb1d1a4359b6cf76df498cb702683e01dd8e15c4ed1a5d5ead91733309
// needs_review: True
// --- CHUNK_METADATA_END ---
== Test Formalism
// --- CHUNK_METADATA_START ---
// src_checksum: bcbaa0ca3f72cfbb3174a08c1d60f0adf5c6385b26e7facf79130c59fbea6945
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Introduction

#defn(info: "statistical test")[
  A hypothesis test is a (measurable) function of the sample $(X_1, ..., X_n)$ taking values in  ${0, 1}$.
  - $H_0$ is accepted if  $phi(X_1, ..., X_n) = 0$
  - $H_0$ is rejected if $phi(X_1, ..., X_n) = 1$

  The domain ${(X_1, ..., X_n), #h(6pt) phi(X_1, ..., X_n) = 1} =: cal(R)$ is
  the rejection region of the test, $cal(R)^c$ is the acceptance region. We can
  write: $phi(X_1, ..., X_n) = bb(1)_(cal(R)) (X_1, ..., X_n)$
]<def:statistique-de-test>

Very often, $cal(R)$ is constructed from $T = T(X_1, ..., X_n)$, a
test statistic @def:statistique-de-test, itself based on an estimator
$hat(theta)_n$ of  $theta$, the parameter of interest.

$arrow.curve$ The question is: how to construct $cal(R)$?

// --- CHUNK_METADATA_START ---
// src_checksum: 20e5ce12de888b50870eecc1415d1131880623e938b4e86c3c37f86d27ad97fb
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Risks of test error

Risk of $1^"ere"$ kind.



Generally, we will test  
$
&H_0 ": "  theta = a_(a in Theta) "against"  H_1 ":"  theta != a \
&H_0 ": "  theta <= a "against" H_1: theta > a "(e.g., quality control)"
$ 
If we consider a partition $Theta_0 union Theta_1 = Theta_("espace des paramètres")$,  $Theta_0 inter Theta_1 = emptyset$, then the hypotheses are:
   $H_0$: $theta in Theta_0$ against  $H_1$:  $theta in Theta_1$

#rmk(info: "Vocabulary")[
- Two-sided test
  -  $Theta_0 = {a}$  $H_0$ is a simple hypothesis.
  -  $Theta_1 = Theta without {a}$,  $H_1$ is a two-sided hypothesis 
- One-sided test
  -  if $Theta_0 = ]- infinity, a]$ and $Theta_1 = ]a, +infinity[$  $H_1$ and  $H_0$ are one-sided

 $H_0 = theta = a$ against $H_0$:  $theta > a$  $-->$ One-sided test
]

#defn(info: [error of $1^"ere"$ kind])[
-- the one we want to control
 $
alpha: Theta_0 &--> [0, 1] \
       theta &|-> &P_theta ((X_1, ..., X_n) in cal(R)) = E_theta [ phi(X) ] &\
       & &= P_(H_0 \ "vrai") ("rejection of " H_0) &
$ 

- level $alpha$ iff 
 $
sup_(theta in Theta_0) P_theta ((X_1, ..., X_n) in cal(R)) "op" alpha
$ 
where for  $
"op" = cases(
  <= "pour lois discrètes",
  = "pour lois continues exactes",
  --> "pour lois asymptotiques"
)
$ 
]

#defn(info: [error of $2^"nde"$ kind])[
 $
beta: Theta_1 &--> [0, 1]\
       theta &|-> P_theta ((X_1, ..., X_n) in cal(R)^c) = P_(H_1 \ "vrai") ("retaining " H_0)
$ 
]

#defn(info: [Power functions])[
$
Pi: Theta &--> [0, 1]\
    theta &|-> P_theta ( (X_1, ..., X_n) in cal(R) )
$ 
- if $theta in Theta_0$:  $Pi(theta) = alpha (theta)$
- if $theta in Theta_1$:  $Pi(theta) = P_theta ((X_1, ..., X_n) in cal(R)) = 1 - P_(H_1)( (X_1, ..., X_n) in cal(R)^c ) = 1 - beta (theta)$ 
]

// --- CHUNK_METADATA_START ---
// src_checksum: 0be32127e7a9bde29c83f97de2b99b2f35c3a70c4bb3d699de74cc71615d13dc
// needs_review: True
// --- CHUNK_METADATA_END ---
== Example
$(X_1, ..., X_n)$ are i.i.d. from distribution $cal(N) (theta, 1)$. Hypotheses to test:
 $
H_0 ": " theta <= 0 " versus " H_1 ": " theta > 0
$
Since $E[X_i] =: theta$ is unknown, we estimate it with $hat(theta) = overline(X)$.
1. First idea: rejection of $H_0$ if $hat(theta) > 0$
$
  cal(R) = {(X_1, ..., X_n), hat(theta)(X_1, ..., X_n) > 0}
$ 

Let $theta <= 0$,
 $
alpha(theta) = P_theta (hat(theta) > 0) = P_theta (overline(X) > 0)
$
What is the distribution of $overline(X)$?

 $overline(X) ~_("loi" \ "exacte") cal(N) ()$ because any linear combination of Gaussian random variables is a Gaussian.

  $E[overline(X)] = E[X_i] = theta$, $Var(overline(X)) = 1/n Var(X_i) = 1/n$

  _reflex_: _standardize the normal distribution_:
   $
  alpha(theta) = P_theta ((overline(X) - theta)/(sqrt(1/n)) > - sqrt(n) theta) = P(cal(N) (0, 1) > - sqrt(n) theta) = 1 - Phi(- sqrt(n) theta) = Phi(sqrt(n) theta)
  $ 

Where $Phi$ is the cumulative distribution function of the $cal(N) (0, 1)$

#let custom_phi(x) = {
  let pi = 3.14159265358979
  let coeff = 1.0 / calc.sqrt(2.0 * pi)
  let x2 = x * x
  coeff * calc.exp(x2 / (-2.0))
}

#let cutoff = 1.2

 distribution.

#let custom_phi(x) = {
  let pi = 3.14159265358979
  let coeff = 1.0 / calc.sqrt(2.0 * pi)
  let x2 = x * x
  coeff * calc.exp(x2 / (-2.0))
}

#let cutoff = 1.2

// --- CHUNK_METADATA_START ---
// src_checksum: af134a73b058e89abd285d4e3094d7407658a087823ce5bfc526e73a7ef607c6
// needs_review: True
// --- CHUNK_METADATA_END ---
#align(center)[
#canvas({
  plot.plot(
    size: (8, 4),
    x-min: -4, x-max: 4,
    y-min: 0, y-max: 0.45,
    x-label: $x$,
    y-label: $phi(x)$,
    axis-style: "school-book",
    {
      // Shaded CDF area
      plot.add(
        domain: (-4, cutoff),
        samples: 200,
        custom_phi,
        fill: true,
        fill-type: "axis",
        style: (fill: rgb(100, 149, 237, 120), stroke: none),
      )

      // Normal curve
      plot.add(
        domain: (-4, 4),
        samples: 200,
        custom_phi,
        style: (stroke: rgb(30, 80, 200) + 2pt),
      )

      // Vertical line at cutoff
      plot.add(
        ((cutoff, 0), (cutoff, custom_phi(cutoff))),
        style: (stroke: (paint: red, thickness: 1.5pt, dash: "dashed")),
      )

      // Annotation label
      plot.annotate({
        draw.content(
          (cutoff, -0.03),
          anchor: "north",
          text(size: 10pt, fill: red)[$sqrt(n) hat(theta)$]
        )
        draw.content(
          ((cutoff + -4) / 2, custom_phi((cutoff + -4) / 2) / 2.5),
          text(size: 9pt, fill: rgb(30, 60, 180))[$Phi(sqrt(n) hat(theta))$]
        )
      })
    }
  )
})
]

$
"level" = sup_(theta <= 0) Phi(sqrt(n) theta) = Phi(0) = 1/2 = 50%
$
Therefore, we have a 1 in 2 chance of being wrong -- which is not acceptable!

$-->$ we want $alpha$ to be small: $alpha = 5%$:
- $cal(R) = {hat(theta) > 0}$ $-->$ $cal(R) = {hat(theta) > c}$ ($c > 0$)
- value of $c = c(alpha)$ such that $sup_(theta <= 0) alpha(theta) <= alpha$

$
alpha(theta) &= P_(theta <= 0) (overline(X) > c) = P_(theta <= 0) ((overline(X) - theta)/sqrt(1/n) > (c - theta)/sqrt(1/n))\
             &= P(cal(N) (0, 1) > sqrt(n) (c - theta))
$ 

#underline[Level Condition]:

// --- CHUNK_METADATA_START ---
// src_checksum: 8d54f4f6e0ddeec307a2437fee76782bc6ff91f721e2c1b0c11ca3cd5f4350d2
// needs_review: True
// --- CHUNK_METADATA_END ---
Find $c$ such that  
$
    &sup_(theta <= 0) P( cal(N) (0, 1) > sqrt(n) (c - theta)) =_("loi" \ "continue") alpha \
<=> &P(cal(N) (0, 1) > sqrt(n) c) = alpha \
<=> &1 - Phi(sqrt(n) c) \
<=> &Phi(sqrt(n) c) = 1 - alpha \
<=> &sqrt(n) c = Phi^(-1) (1 - alpha) => c_alpha = 1/sqrt(n) #math.op("qnorm")_(1-alpha)
$ 

We constructed a test of level $alpha$ with 
$
cal(R) = { (X_1, ..., X_n),  overline(X) > (#math.op("qnorm")_(1 - alpha))/sqrt(n)}
$ 

#underline[Numerical application]:
$alpha = 5% => #math.op("qnorm")_(1 - alpha) = 1.645, n = 100 -> c_alpha = 0.1645$
 
experiment $->$  $overline(X)^"obs" = $ realization of $overline(X)$ on my data
- if  $overline(X)^"obs" = 0.1 < c_alpha$ we do not reject  $H_0$
- if  $overline(X)^"obs" = 0.3 > c_alpha => $ rejection of  $H_0$

// --- CHUNK_METADATA_START ---
// src_checksum: 0a5583fde4892592fcdedbdd186a71dd99fb2c9773ed910b407ecb8bf022a7ef
// needs_review: True
// --- CHUNK_METADATA_END ---
== Construction of a test
1. 
  - Define the hypotheses $H_0$ and $H_1$
  - Identify the parameter of interest
2. 
  - Define the form of $cal(R)$; the form of $H_1$ $=>$ implies the form of $cal(R) = {T > c}$ or ${T < c}$
  - Find a test statistic
  - $T = $ normalized version of  
  $
  hat(theta) = (hat(theta) - theta)/sqrt(Var(hat(theta)))
  $
3. Find the threshold $c$ to obtain a level $alpha$

