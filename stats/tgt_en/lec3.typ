// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ea261629f98b0b8868d993e03ac8cb53aca961ea380784787475299d7694d6cf
// --- CHUNK_METADATA_END ---
= Fisher Information, Efficiency

Let $(P_theta)_(theta in Theta)$, $Theta subset RR^p$ (identifiable, given). We denote $f_theta$ the density of $P_theta$
$ op("Supp") f_theta = { x in E, \, f_theta(x) > 0 } $

Given $(X_1, ..., X_n)$, i.i.d. from the distribution $P_theta$ and $theta mapsto L(theta) = product_(i=1)^n f_theta(X_i)$ as the likelihood of the sample. On $op("Supp") f_theta$ , we can calculate
$ log L_n(theta) = sum_(i=1)^n log f_theta(X_i) $
$ hat(theta) = op("argmax")_(theta in Theta) log L_n(theta) $

// #prop(name: "propriété de l'EMV")[
// If $hat(theta)$ is an MLE#footnote[*MLE* = *M*aximum *L*ikelihood *E*stimator] of $theta$, $g(hat(theta))$ is an MLE of $g(theta)$
// ]
#prop[
  If $hat(theta)$ is an MLE#footnote[*MLE* = Maximum Likelihood Estimator] of $theta$, $g(hat(theta))$ is an MLE of $g(theta)$
]

Objective: what can we have that is "better" as an estimator?
$-->$ regular model

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 43f867c9e008c03fa4c8c5f85c22fb172a877f9478df2e0f4d50a5d1d3da53f7
// --- CHUNK_METADATA_END ---
== Regular Model

#defn[
  The model $(P_(theta))_(theta in Theta)$ is said to be regular if
  1.  $Theta$ is an open set and  $theta |-> f_theta(x)$ is  $C^1$
  2. $op("Supp") f_theta$ does not depend on  $theta$:  $S = { x, #h(0.4em)f_theta(x) >0}$
  3. For all $theta$, the application 
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
  We denote the derivative of $f_theta(x)$ with respect to  $theta$:  $(partial f_theta)/(partial theta)(x)$
  The quantity  $I(theta)$ is called *Fisher Information of the model*.
]

#ex[
  - $f_theta(x) = theta e^(-x theta)$ density with respect to  $mu(d x) = bb(1)_(x >= 0) d x$

   $theta |-> theta e^(-x theta)$ is $C^(infinity)$ on  $Theta = ]0, +infinity[$,  $op("Supp") f_theta = RR_+$

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
  $op("Bernoulli")(theta)$, $x = 0.1$,  $f_theta(0) = 1 - theta$,  $f_theta(1) = theta$, density with respect to  $delta_0 + delta_1$


  For all  $x in { 0, 1}$,  $theta |-> f_theta(x)$ is  $C^1$ 
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
// needs_review: True
// src_checksum: 319a64371c2d2909cacd2d0f2263c1274f0405d2ba65560d445863893fc1f6e3
// --- CHUNK_METADATA_END ---
== Fisher Score and Information// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0fb7f75a6eff6284b4aa3b3da8804809eea2c36cacf898d15998e6e4c317c27e
// --- CHUNK_METADATA_END ---
$(X_1, ..., X_n)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7418284c48bce8ce05896d4a8ea24fa60f80fd4735b5077821c4693f9c3379c3
// --- CHUNK_METADATA_END ---
i.i.d. with distribution of// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 4e636ee2a65991a1f53703dcfde7bd8352398a12db0c2cc07b2b4a4f727fa9e2
// --- CHUNK_METADATA_END ---
$P_theta, #h(0.3em) f_theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c9e48f7a8305dab14d9ab49b53e28d8db83db14048ee68c408ee465a52cec9d1
// --- CHUNK_METADATA_END ---
#defn[
  We call *score* or *score vector* the derivative of the log-likelihood $partial/(partial theta) log L_n(theta) = S_n(theta) = sum_(i=1)^n partial/(partial theta) log f_theta (X_i)$
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 83e3acbb7b9495d87e14ae222c60030a758ed9498d8746453a8a240e64cad4a7
// --- CHUNK_METADATA_END ---
#ex[
  $X_i ~  cal(E)(theta)$, $L_n(theta) = theta^n e^(-theta sum_i X_i)$,  $log L_n (theta) = n log theta - theta sum_i X_i$, therefore  $S-n(theta) = n/theta - sum_(i=1)^n X-i$
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0b4448a49da71d805ff0b9ea4bf08dc3fa46b208ac4a10cc22549df755a6fadb
// --- CHUNK_METADATA_END ---
#rmk[
  $
  E(S_n (theta)) = E[ n(1/theta - (sum X_i)/n)]
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6233eb96869e7f2d5ab8311c2f2d99f63f1fcd719f206870df78fb17d57f8329
// --- CHUNK_METADATA_END ---
Additional regularity hypothesis:// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 2689ccef9b50525c106a8f16c2bc7569cb99b9bf11d5fc2818a01f62b9646772
// --- CHUNK_METADATA_END ---
$(H)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9f8ba7e7e6aa0cb39868240ec8ed72137691a195fe9e1ee3cdcf630e92c8e633
// --- CHUNK_METADATA_END ---
for any estimator// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 45f2b8f81cd946377cb371f82ecb5f2d1113e078dc42165ef8b197b4a69b41b7
// --- CHUNK_METADATA_END ---
$h(X)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 36cec29e4080f3a5000700cf865a92821671dcba9623012efaba7c6f0e63b845
// --- CHUNK_METADATA_END ---
and everything// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c7306518523986c1c42120bdd35c3c4f446af47a15fa3ae538440f629cddf010
// --- CHUNK_METADATA_END ---
$theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 878fef6417cdb103d6052a9a2819e66da4d579899f7d41d3295a14a6a5b5313b
// --- CHUNK_METADATA_END ---
, the following integrals exist and are equal:// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b04785fcc389875d6b587f59701fb6d5538dd8a7887a93f5797fc2b8dd2da402
// --- CHUNK_METADATA_END ---
$
partial/(partial theta) int_S h(x) f_theta (x) d x = int_S h(x) ( partial f_theta)/(partial theta) (x) d x
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: e16f1596201850fd4a63680b27f603cb64e67176159be3d8ed78a4403fdb1700
// --- CHUNK_METADATA_END ---
 
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6dcb71b65805353b4abbb7446f701af67724e8df089ad8a1743a59a8028aa84f
// --- CHUNK_METADATA_END ---
#rmk[
  condition of application of the Lebesgue differentiation theorem.

  $
  h sup_(tilde(theta) in V_theta) |(partial f_theta)/(partial theta) (x)| in L_1 (mu)
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 3c52501c3520493e63e36ee6c676f5353c2b6e4e6a96a313fdb3912f47be9705
// --- CHUNK_METADATA_END ---
#prop[
  Under $(H)$, the score is centered  $(P_theta)$,  $n=1$

   $
  E_theta [partial/(partial theta) log L_1(theta)] = int_S partial/(partial
  theta) log f_theta (x) d x = int_S ( partial/(partial theta) f_theta(x)
)/cancel(f_theta (x)) cancel(f_theta (x)) d x = int_S (partial
f_theta)/(partial theta) (x) d x underbrace(=, (H)) partial/(partial theta)
overbracket(int f_theta (x) d x, = 1) = 0
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6e2224c3103c653db7436522215781399e7c8b5412a4b76712f9d8e35a13eab4
// --- CHUNK_METADATA_END ---
#defn[
  The Fisher information associated with $(X_1, dots, X_n)$ 
   $
  I_n (theta) underbrace(=, "def") E_theta [ (partial/(partial theta) log L_n(theta))^2] overbrace(=, "cor. de la prop 1") = op("Var")_theta [(partial log L_n (theta))/(partial theta)]
  $ 

  $
  (*) E_theta [ partial/(partial theta) log f_theta (X_1)]^2 = int_S ( (partial/(partial theta) f_theta (x))/(f_theta (x)) )^2 f_theta (x) d x = int_S ((partial/(partial theta) f_theta (x))^2)/(f_theta (x)) = "\"expression of definition 1\""
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 751bb278ef3e3f0a3fba9ee7dbc93d766fa6af1d45c3fb9bb2ed18803bbd072f
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n) ~  cal(E)(theta)$, $partial/(partial theta) log L_n (theta) = n/theta - sum_(i=1)^n X_i$
   $
  I_n (theta) = E( (n/theta - sum X_i)^2) = n^2 E[(1/theta - (sum X_i)/n)^2] = n^2 op("Var")(overline(X)) = n^2 1/n 1/(theta^2) = n/(theta^2)
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b8d1d399357664372c917920c8e3539273c36e585ebeb82d693ba344e0b46868
// --- CHUNK_METADATA_END ---
#prop[
  $
  I_n (theta) = n I(theta)
  $
  indeed,
  $
  I_n (theta) = op("Var")(partial/(partial theta) log L_n (theta)) = op("Var") (sum_(i=1)^n partial/(partial theta) log f_theta (X_i)) underbrace(=, "independance") = sum_(i=1)^n op("Var")(partial/(partial theta) log f_theta (X_i)) = \
  = n underbrace(op("Var")(partial/(partial theta) log f_theta (X_1))) = n I (theta)
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 153eb4afb7193b35509d1e734a6285a1fe3cbd06942bf24682aa0363a67bea70
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n)$ i.i.d  $cal(P)(theta)$,  $f_theta (x) = e^(- theta)(theta^x)/(x!)$
   $
  log L_n (theta) = -n theta + (sum X_i) log theta - log product_(i=1)^n X_i !
  $ 
  $
  partial/(partial theta) log L_n (theta) = -n + (sum X_i)/theta => I_n (theta) = op("Var")((sum X_i)/theta) = 1/(theta^2) n theta = n/theta
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c85a73d5c9c7868f0d365e6a16b3b724dc1d0da05df618da87545186fa45a6c9
// --- CHUNK_METADATA_END ---
== Fisher Information and Second Derivative
#prop[
  By further assuming that $theta |-> f_theta (x)$ is  $C^2$ and that  $(H)$ holds for  $(theta^2)/(partial theta^2)$ then the Fisher information can also be written as 
   $
  I_n (theta) = -E_theta [ (partial^2 log L_n (theta))/(partial theta^2) ]
  $ 
  if $hat(theta)$ is the MLE,  $I_n(hat(theta)) > 0$

  $n=1$
  
   $(partial^2)/(partial theta^2) log f_theta (x) = (( (partial^2 f_theta (x))/(partial theta^2) )^2)/(f_theta (x)) - (( (partial f_theta)/(partial theta)(x) )^2)/(f_theta^2 (x))$ 

    $
   E[ (partial^2)/(partial theta^2) log f_theta (X_1)] = int_S ((partial^2 f_theta(x))/(partial theta^2))/(cancel(f_theta (x))) cancel(f_theta (x)) d x - underbrace(int_S (( (partial f_theta (x))/partial theta )^2)/(f_theta^2 (x)) d x, I (theta))
   $ 
]

#import "figures/visual-example-for-info-fisher.typ":diagram as visual-example-for-info-fisher
#visual-example-for-info-fisher(width: 400pt)

If the curve is very "peaked" at the MLE (i.e., Fisher information is large), then the MLE is precisely localized

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 2eacd4ed04abb0acd533684cde6bd097e7cb106356ccc543169a09b3888e66d2
// --- CHUNK_METADATA_END ---
== Cramer - Rao Inequality
Let $g(theta)$ be the parameter of interest where  $g: Theta -> RR$

#prop[
  Under the assumptions of a regular model, if for all $theta$,  $I(theta) > 0$, then for any  $T = T(X_1, ..., X_n)$ #underline("sans biais") estimator,  $E_theta T^2 < +infinity$, we have
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
Cauchy-Schwarz Inequality for $angle.l h_1, h_2 angle.r = int h_1(x) h_2(x) f_theta (x) d x$ with  $h_1(X)$ and  $h_2(X)$ centered

 $
( angle.l T(X) - g(theta), (partial/(partial theta) f_theta (x))/(f_theta (x)) angle.r_theta )^2 = (g'(theta))^2 underbrace(=, "c.s") underbrace(int (T(x) - g(theta))^2 f_theta (x) d x, = op("Var")_theta (T)) times underbrace(int ((partial/(partial theta) f_theta (x))/(f_theta (x)))^2 f_theta (x) d x, = I(theta))
$ 

#defn[
  If $T$ achieves equality, then  $T$ is said to be *efficient*.
]
