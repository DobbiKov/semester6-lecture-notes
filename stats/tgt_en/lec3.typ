// --- CHUNK_METADATA_START ---
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// needs_review: True
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// src_checksum: ea261629f98b0b8868d993e03ac8cb53aca961ea380784787475299d7694d6cf
// needs_review: True
// --- CHUNK_METADATA_END ---
= Fisher Information, efficiency

Let $(P_theta)_(theta in Theta)$, $Theta subset RR^p$ (identifiable, given). Let $f_theta$ be the density of $P_theta$
$ op("Supp") f_theta = { x in E, \, f_theta(x) > 0 } $

Given $(X_1, ..., X_n)$, i.i.d. from distribution $P_theta$ and $theta mapsto L(theta) = product_(i=1)^n f_theta(X_i)$ as the likelihood of the sample. On $op("Supp") f_theta$ we can calculate
$ log L_n(theta) = sum_(i=1)^n log f_theta(X_i) $
$ hat(theta) = op("argmax")_(theta in Theta) log L_n(theta) $

// #prop(name: "propriété de l'EMV")[
//   Si $hat(theta)$ EMV#footnote[*EMV* = *E*stimateur de *M*aximum de *V* raisemblance] de $theta$, $g(hat(theta))$ est un EMV de $g(theta)$
// ]
#prop[
  If $hat(theta)$ MLE#footnote[*MLE* = Maximum Likelihood Estimator] for $theta$, $g(hat(theta))$ is an MLE for $g(theta)$
]

Objective: what "better" estimator can we have?
$-->$ regular model
// --- CHUNK_METADATA_START ---
// src_checksum: 43f867c9e008c03fa4c8c5f85c22fb172a877f9478df2e0f4d50a5d1d3da53f7
// needs_review: True
// --- CHUNK_METADATA_END ---
== Regular Model

#defn[
  The model $(P_(theta))_(theta in Theta)$ is said to be regular if
  1. $Theta$ is an open set and $theta |-> f_theta(x)$ is $C^1$
  2. $op("Supp") f_theta$ does not depend on $theta$: $S = { x, #h(0.4em)f_theta(x) >0}$
  3. For all $theta$, the mapping 
   $
  x |-> ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0)
  $ 
  is integrable $(L, mu)$ and the integral 
   $
  I(theta) = int_S ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0) d x
  $ 
  is continuous on $Theta$.
]

#notation[
  We denote the derivative of $f_theta(x)$ with respect to $theta$: $(partial f_theta)/(partial theta)(x)$
  The quantity $I(theta)$ is called the *Fisher Information of the model*.
]

#ex[
  - $f_theta(x) = theta e^(-x theta)$ density with respect to $mu(d x) = bb(1)_(x >= 0) d x$

   $theta |-> theta e^(-x theta)$ is $C^(infinity)$ on $Theta = ]0, +infinity[$, $op("Supp") f_theta = RR_+$

    $
   (partial f_theta)/(partial theta)(x) = (1 - x theta)e^(-x theta)
   $ 

   $
   ((1 - x theta)^2 (e^(-x theta))^2)/(theta e^(-x theta)) = ((1 - x theta)^2)/theta e^(-x theta)
   $ 
   $
   I(theta) &= int_theta^infinity ((1 - x theta)^2)/(theta^2) theta e^(-x theta) d x \
   &= 1/(theta^2) E_theta (1 - X theta)^2 \
   &= 1/(theta^2) [ 1 - 2 theta E(X) + theta^2 E(X^2) ] = 1/(theta^2)
   $ 
   continuous on $]0, +infinity[$
] 

#ex[
  $op("Bernoulli")(theta)$, $x = 0.1$, $f_theta(0) = 1 - theta$, $f_theta(1) = theta$, density with respect to $delta_0 + delta_1$


  For all $x in { 0, 1}$, $theta |-> f_theta(x)$ is $C^1$ 
  $
  (( (partial f_theta(0))/(partial theta) )^2)/(f_theta(0)) = 1/(1 - theta)
  $ 
  $
  (( (partial f_theta(1))/(partial theta) )^2)/(f_theta(1)) = 1/(theta) => I(theta) = 1/(1 - theta) + 1/(theta) = 1/(theta (1 - theta))
  $ 
  continuous on $]0, 1[$
  
]

#ex[
  $f_theta(x) = 1/theta bb(1)_[0, theta] (x) = 1/theta bb(1)_[x, +infinity[ (theta)$ non-regular model
]
// --- CHUNK_METADATA_START ---
// src_checksum: fec51159001d31362a23a99fd60d517d14635c4487b12fe61fd822d7cb4b880b
// needs_review: True
// --- CHUNK_METADATA_END ---
== Score and Fisher Information
$(X_1, ..., X_n)$ i.i.d. following the law of $P_theta, #h(0.3em) f_theta$

#defn[
  We call *score* or *score vector* the derivative of the log-likelihood $partial/(partial theta) log L_n(theta) = S_n(theta) = sum_(i=1)^n partial/(partial theta) log f_theta (X_i)$
] 

#ex[
  $X_i ~  cal(E)(theta)$, $L_n(theta) = theta^n e^(-theta sum_i X_i)$, $log L_n (theta) = n log theta - theta sum_i X_i$, hence $S-n(theta) = n/theta - sum_(i=1)^n X-i$
]

#rmk[
  $
  E(S_n (theta)) = E[ n(1/theta - (sum X_i)/n)]
  $ 
]

Supplementary regularity hypothesis:
$(H)$ for any estimator $h(X)$ and any $theta$, the following integrals exist and are equal:
 $
partial/(partial theta) int_S h(x) f_theta (x) d x = int_S h(x) ( partial f_theta)/(partial theta) (x) d x
$ 
#rmk[
  condition for applying Lebesgue's differentiation theorem.

  $
  h sup_(tilde(theta) in V_theta) |(partial f_theta)/(partial theta) (x)| in L_1 (mu)
  $ 
] 

#prop[
  Under $(H)$, the score is centered $(P_theta)$, $n=1$

   $
  E_theta [partial/(partial theta) log L_1(theta)] = int_S partial/(partial
  theta) log f_theta (x) d x = int_S ( partial/(partial theta) f_theta(x)
)/cancel(f_theta (x)) cancel(f_theta (x)) d x = int_S (partial
f_theta)/(partial theta) (x) d x underbrace(=, (H)) partial/(partial theta)
overbracket(int f_theta (x) d x, = 1) = 0
  $ 
]

#defn[
  The Fisher information associated with $(X_1, dots, X_n)$ 
   $
  I_n (theta) underbrace(=, "def") E_theta [ (partial/(partial theta) log L_n(theta))^2] overbrace(=, "cor. de la prop 1") = op("Var")_theta [(partial log L_n (theta))/(partial theta)]
  $ 

  $
  (*) E_theta [ partial/(partial theta) log f_theta (X_1)]^2 = int_S ( (partial/(partial theta) f_theta (x))/(f_theta (x)) )^2 f_theta (x) d x = int_S ((partial/(partial theta) f_theta (x))^2)/(f_theta (x)) = "\"expression from definition 1\""
  $ 
]
// --- CHUNK_METADATA_START ---
// src_checksum: 9a815d0b3641e58af530b4555641f783c511528dae467c7f0067e9c0e9350726
// needs_review: True
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n) ~  cal(E)(theta)$, $partial/(partial theta) log L_n (theta) = n/theta - sum_(i=1)^n X_i$
   $
  I_n (theta) = E( (n/theta - sum X_i)^2) = n^2 E[(1/theta - (sum X_i)/n)^2] = n^2 op("Var")(overline(X)) = n^2 1/n 1/(theta^2) = n/(theta^2)
  $
]

#prop[
  $
  I_n (theta) = n I(theta)
  $
  indeed,
  $
  I_n (theta) = op("Var")(partial/(partial theta) log L_n (theta)) = op("Var") (sum_(i=1)^n partial/(partial theta) log f_theta (X_i)) underbrace(=, "independance") = sum_(i=1)^n op("Var")(partial/(partial theta) log f_theta (X_i)) = \
  = n underbrace(op("Var")(partial/(partial theta) log f_theta (X_1))) = n I (theta)
  $
]

#ex[
  $(X_1, ..., X_n)$ i.i.d  $cal(P)(theta)$,  $f_theta (x) = e^(- theta)(theta^x)/(x!)$
   $
  log L_n (theta) = -n theta + (sum X_i) log theta - log product_(i=1)^n X_i !
  $
  $
  partial/(partial theta) log L_n (theta) = -n + (sum X_i)/theta => I_n (theta) = op("Var")((sum X_i)/theta) = 1/(theta^2) n theta = n/theta
  $
]
// --- CHUNK_METADATA_START ---
// src_checksum: c85a73d5c9c7868f0d365e6a16b3b724dc1d0da05df618da87545186fa45a6c9
// needs_review: True
// --- CHUNK_METADATA_END ---
== Fisher Information and Second Derivative
#prop[
  Adding that $theta |-> f_theta (x)$ is $C^2$ and that $(H)$ holds for $(theta^2)/(partial theta^2)$, then Fisher's information can also be written as
   $
  I_n (theta) = -E_theta [ (partial^2 log L_n (theta))/(partial theta^2) ]
  $
  if $hat(theta)$ is MLE, $I_n(hat(theta)) > 0$

  $n=1$
  
   $(partial^2)/(partial theta^2) log f_theta (x) = (( (partial^2 f_theta (x))/(partial theta^2) )^2)/(f_theta (x)) - (( (partial f_theta)/(partial theta)(x) )^2)/(f_theta^2 (x))$ 

    $
   E[ (partial^2)/(partial theta^2) log f_theta (X_1)] = int_S ((partial^2 f_theta(x))/(partial theta^2))/(cancel(f_theta (x))) cancel(f_theta (x)) d x - underbrace(int_S (( (partial f_theta (x))/partial theta )^2)/(f_theta^2 (x)) d x, I (theta))
   $ 
]

#import "figures/visual-example-for-info-fisher.typ":diagram as visual-example-for-info-fisher
#visual-example-for-info-fisher(width: 400pt)

If the curve is very "peaked" at the MLE (i.e., Fisher information is large), then the MLE is precisely localized.
// --- CHUNK_METADATA_START ---
// src_checksum: 2eacd4ed04abb0acd533684cde6bd097e7cb106356ccc543169a09b3888e66d2
// needs_review: True
// --- CHUNK_METADATA_END ---
== Cramer-Rao Inequality
Let $g(theta)$ be the parameter of interest where $g: Theta -> RR$

#prop[
  Under the assumptions of a regular model, if for all $theta$, $I(theta) > 0$, then for any #underline("sans biais") estimator $T = T(X_1, ..., X_n)$, $E_theta T^2 < +infinity$, we have
   $
  forall theta in Theta, underbracket( op("Var")_theta (T) >= ((g'(theta)^2))/(I_n (theta)) ) = ((g'(theta))^2)/(n I(theta))
  $
]
#proof[
  $
  &forall theta #h(0.5em) E_theta(T) = g(theta) \
  =>& partial/(partial theta) E_theta (T) = g'(theta) \
  script(T=T(X_1)) <=>& partial/(partial theta) int_S T(x) f_theta (x) d x = g'(theta) \
  script((H)) <=>& int_S T(x) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g' (theta) \
  <=>& int_S (T(x) - g(theta)) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g'(theta)
  $
]
Cauchy-Schwarz Inequality for $angle.l h_1, h_2 angle.r = int h_1(x) h_2(x) f_theta (x) d x$ with $h_1(X)$ and $h_2(X)$ centered

 $
( angle.l T(X) - g(theta), (partial/(partial theta) f_theta (x))/(f_theta (x)) angle.r_theta )^2 = (g'(theta))^2 underbrace(=, "c.s") underbrace(int (T(x) - g(theta))^2 f_theta (x) d x, = op("Var")_theta (T)) times underbrace(int ((partial/(partial theta) f_theta (x))/(f_theta (x)))^2 f_theta (x) d x, = I(theta))
$ 

#defn[
  If $T$ attains the equality, then $T$ is called *efficient*.
]