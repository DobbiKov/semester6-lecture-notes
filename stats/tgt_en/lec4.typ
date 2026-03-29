// --- CHUNK_METADATA_START ---
// src_checksum: b847744a1a0b38c4a68a842a1c9b662503616079d7bb62a4fb1135b6bc70c36d
// needs_review: True
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// src_checksum: f50245ab868ac4c9a0c2b2505204781ac8a8cf0d66ca9f4924235a079162fcf4
// needs_review: True
// --- CHUNK_METADATA_END ---
= Asymptotic study of estimators

In a #underline([regular]) parametric model, if $hat(theta)_n$ is an estimator of $theta$, then 
$
Var(hat(theta)_n) >= 1/(I_n(theta)) = 1/(n I(theta))
$ 
if $Var(hat(theta)_n) = 1/(n I(theta))$ and it is unbiased, $hat(theta)_n$ is efficient #underline([efficient]) 

Asymptotic: $n -> +infinity$, 
 $
n Var(hat(theta)_n) -->_(n -> +infinity) 1/(I(theta))
$
// --- CHUNK_METADATA_START ---
// src_checksum: 713139145d99aac2e688a7163c7942fee95fc5b6aec171c544f70201d9529081
// needs_review: True
// --- CHUNK_METADATA_END ---
== Convergences
$(X_n)_(n >= 0)$ sequence of real random variables $(RR^d)$

-
- convergence in distribution: $X_n -->_(n -> +infinity)^(cal(L)) X$ iff $P(X_n <= x)
  --> P(X <= x)$ at every continuity point of $x$.

#lem(info: "lemme de Portmanteau")[
  Equivalent characterizations:
  - For any bounded continuous function $h$, 
    $
    E[h(X_n)] --> E[h(X)]
    $ 

    $=>$ convergence in distribution is stable under continuous mappings
    (CMT) #underline([MAIS]) it is generally #underline([faux]) that if $X_n -->^(cal(L)) X$ and  $Y_n -->^(cal(L)) Y$ then  $mat(X_n ; Y_n) -->^(cal(L)) mat(X; Y)$

    This is true in 3 cases:
    1. 
      $
      "si " cases(forall n\, X_n " et " Y_n " sont indépendantes", X " et " Y " sont indépendantes ") " alors " cases(" convergence en loi de " X_n " et " Y_n, " convergence en loi du couple " mat(X_n;Y_n))
      $ 
    2.  
    $
    "si " cases(X_n -->^P X, Y_n -->^p Y) ==> mat(X_n; Y_n) -->^P mat(X; Y) ==> mat(X_n; Y_n) -->^(cal(L)) mat(X; Y) 
    $ 
    3. (Slutsky's Lemma) (the most important)
    $
    "si " cases(X_n -->^(cal(L)) X, Y_n -->^(cal(L)) c) " alors " mat(X_n; Y_n) -->^(cal(L)) mat(X; c)
    $ 
    by applying the CMT,
    $
      h(x, y) &= x + y #h(40pt) X_n + Y_n -->^(cal(L)) X + c \
              &= x y #h(40pt) X_n Y_n -->^(cal(L)) -->^(cal(L)) c X \
              &= x/y #h(40pt) X_n/Y_n -->^(cal(L)) X/c
    $ 
]
// --- CHUNK_METADATA_START ---
// src_checksum: 79aafe1277bc71b7f9e4a7f2123b7a2a9f8aee571979653b9f6966ad52d35b12
// needs_review: True
// --- CHUNK_METADATA_END ---
== Consistency of Estimators
#defn[
  $hat(theta)_n$ is asymptotically unbiased if and only if
  $
  #math.op("Biais") (hat(theta)_n, theta) = E[hat(theta)_n] - theta -->_(n -> +infinity) 0
  $ 
]
#rmk[
  Convergence in probability does not imply convergence of expectations.

  If $X_n -->^P X$, $|X_n| <= Y in L'$, then by dominated convergence $X_n --> X$ in $L_1$
]

#ex[
  $hat(tau)_n = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum X_i^2 - (overline(X))^2$ moment estimator for $tau^2 = E[X^2)] - (E[X])^2$
   $
  #math.op("Biais") (hat(tau)_n^2, tau^2) = - 1/n tau^2 " asymptotically unbiased"
  $ 
  Consistency of $hat(tau)_n^2$?

  Tools to show consistency:
  - LLN
  - if $R(hat(theta)_n, theta) --> 0$ then $hat(theta)_n$ is consistent because $L^2 => $ convergence implies convergence in probability
  - return to the definition of convergence in probability
  \ \ \ 
  - if $(X_i)$ are i.i.d., then $(X_i^2)$ is i.i.d.
     $
    E[X_i^2] < +infinity
    $ 
    LLN: $1/n sum_i X_i^2 -->^P E[X^2] = tau^2 - mu^2$ 
  - $overline(X) -->^P mu$ (LLN), CMT with $h(x) = x^2$: $(overline(X))^2 -->^P mu^2$
  - Therefore $mat(1/n sum_(i=1)^n X_i^2; 1/n sum X_i) -->^P mat(tau^2 - mu^2; mu)$
  - CMT $h(x, y) = x - y^2$

  Therefore $1/n sum X_i^2 - (overline(X))^2 -->^P tau^2 + mu^2 - mu^2 = tau^2$
]
// --- CHUNK_METADATA_START ---
// src_checksum: c185422258ac1db52f4e8867eb0f0d89c71cac9789c409994bd5d7b9c245cb2c
// needs_review: True
// --- CHUNK_METADATA_END ---
== Asymptotic normality of $hat(theta)_n$ for $theta$. 

$->$ Question: what is the convergence rate of $hat(theta)_n$ towards $theta$ ?

$(X_1, ..., X_n)$ i.i.d., with expectation $theta$, $hat(theta) = overline(X)$ with variance $tau^2(theta)$

#underline([CLT])  $sqrt(n)(overline(X) - theta) -->^(cal(L)) Z ~ cal(N)(0, tau^2(theta))$ #underline[regardless of the distribution of $X_i$]

#defn[
  $hat(theta)_n$ is an #underline([asymptotically normal]) estimator if and only if 
  - convergence rate in $sqrt(n)$
  - convergence in distribution
  - limiting distribution is normal

   $
  sqrt(n) (hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, tau^2(theta))
  $ 
]

#ex[
  Is $hat(tau)_n^2$ asymptotically normal?

   $(X_1, dots, X_n)$ i.i.d. with expectation $mu$, with variance $tau^2$

    $
   hat(tau)_n^2 = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n (X_i - mu)^2 + (overline(X) - mu)^2 + underbrace(2/n sum_(i=1)^n (X_i - mu)(mu - overline(X)), = 2(mu - overline(X))(overline(X) - mu))
   $ 

  - CLT: if $(X_i)$ are i.i.d., then $(X_i - mu)^2$ are i.i.d. with expectation $tau^2$,
     $
    sqrt(n) (1/n sum_(i=1)^n (X_i - mu)^2 - tau^2) -->^(cal(L)) Z ~ cal(N) (0, u_4 - tau^4)
    $ 
    $
    Var(X_i - mu)^2 = E[(X_i - mu)^4] - mu^4 = mu_4 - tau^4
    $ 
  - CLT: $sqrt(n) (overline(X) - mu) -->^(cal(L)) cal(N)(0, tau^2)$ 
  - $sqrt(n) (hat(tau)_n^2 - tau^2) = sqrt(n) (1/n sum_i (X_i - mu)^2 - tau^2) - underbrace( sqrt(n)(overline(X) - mu)^2, sqrt(n) underbrace(( overline(X) - mu ), -->^(cal(L)) cal(N) (0, tau^2)) times underbrace( (overline(X) - mu), -->^(cal(L), P) 0 ))$ 
  $
  #math.cases([$overline(X) - mu -->^(cal(L)) 0$], [$sqrt(n) (overline(X) - mu) -->^(cal(L)) U ~ cal(N) (0, 1)$], reverse: true) ==>^("lemme de Slutsky") sqrt(n) (overline(X) - mu)^2 -->^(cal(L))_P 0
  $ 
  $
  sqrt(n) (hat(tau)_n^2 - tau^2) -->_(n -> +infinity)^(cal(L)) Z + 0
  $ 
  Therefore $hat(tau)_n^2$ is an asymptotically normal estimator
]
// --- CHUNK_METADATA_START ---
// src_checksum: 83f34bc0268e8062ba8ad9008b42125418ed0cfe4fd927b3d8246065326d240a
// needs_review: True
// --- CHUNK_METADATA_END ---
#rmk[
  $sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N)(0, tau^2) <==> (sqrt(n)(hat(theta)_n - theta))/tau -->^(cal(L))_(n -> +infinity) cal(N)(0, 1)$
  Application of Slutsky's Lemma: if $hat(tau)^2$ is a consistent estimator of $tau^2$, then we still have
  $ (sqrt(n)(hat(theta)_n - theta))/(hat(tau)) -->^(cal(L)) cal(N) (0, 1) $
]
#proof[
  $
  (sqrt(n) (hat(theta) - theta))/(hat(tau)) = underbrace(( sqrt(n) ((hat(theta) - theta))/tau), -->^(cal(L)) Z ~ cal(N)(0, 1) ) times underbrace( ( tau/hat(tau) ), -->^P 1 ) \
  -->^(cal(L)) 1 times Z "by Slutsky's Lemma and consistency of " hat(tau)
  $
]
// --- CHUNK_METADATA_START ---
// src_checksum: c82a5690416cb70cd2ab7d2889a786e73cb0659dff9fe911c194a0684e37c371
// needs_review: True
// --- CHUNK_METADATA_END ---
== $delta$-method 
$hat(theta)$ asymptotically normal estimator: what is the asymptotic distribution of $g(theta)$?

#lem(info: "méthode délta")[
  Let $Z_n$ be a sequence of real random variables s.t. 
   $
  sqrt(n) (Z_n - mu) -->^(cal(L)) Z ~ cal(N)(0, tau^2)
  $ 
  Let $g$ be a differentiable function, $g'(mu) != 0$. Under these assumptions, we have 
  $ 
  sqrt(n)[ g(Z_n) - g(mu) ] -->_(n -> +infinity)^(cal(L)) tilde(Z) ~ cal(N)(0, (g'(mu))^2 tau^2)
  $
   $
  g(x) = g(mu) + g'(mu)(x - mu) + (x - mu) R (x - mu) " where " R(y) ->_(y->0) 0
  $ 
  $
  sqrt(n)( g(Z_n) - g(mu) ) = underbrace( g'(mu) underbrace( sqrt(n) (Z_n -
  mu), -->^(cal(L)) Z ~ cal(N)(0, tau^2) ), --> cal(N) (0, (g'(mu))^2 tau^2)) +
  underbrace( underbrace( (sqrt(n)) (Z_n - mu), -->^(cal(L)) cal(N) (0, tau^2)) underbrace( R (Z_n - mu), -->^P 0 ? ),  )
  $ 
  Do we have $Z_n -->^P mu$ ?
   $
  P(|X_n - mu| > epsilon) &= P((sqrt(n)|Z_n - mu|)/tau > (sqrt(n) epsilon)/tau) \
  &= P((sqrt(n) (Z_n - mu))/tau > (sqrt(n) epsilon)/tau) + P( (sqrt(n) (Z_n - mu))/tau < - (sqrt(n) epsilon)/tau ) \
  &~= 1 - Phi_n ((sqrt(n) epsilon)/tau) + Phi_n (- (sqrt(n) epsilon)/tau) = 2(1 - Phi((sqrt(n) epsilon)/tau))
  $ 
]