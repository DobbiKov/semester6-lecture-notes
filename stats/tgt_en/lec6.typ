// --- CHUNK_METADATA_START ---
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// needs_review: True
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// src_checksum: d7c7fbf33f81b2fe4bac026d585021f8cefb747b633324aa5de4c0c9e5d3fb4a
// needs_review: True
// --- CHUNK_METADATA_END ---
= Supplements (before midterm)
1. Review of asymptotic normality
2. Example
3. Asymptotic pivot
4. Example 2
// --- CHUNK_METADATA_START ---
// src_checksum: 7bd56918af0db5da78db6287995a8dada1b2d40a0a30b27c79c25bdb8b10b3ad
// needs_review: True
// --- CHUNK_METADATA_END ---
== Asymptotic properties of a sequence of estimators $(hat(theta)_n)_(n >= 1)$ 
- Consistency $hat(theta)_n -->^P theta$
- Asymptotic normality, if there exists $sigma^2 > 0$
$
  sqrt(n)(hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2)
$ 

In general, if there exists $v_n -->_(n -> +infinity) +infinity$

$
  v_n(hat(theta)_n - theta) -->^(cal(L)) Y
$ 

We say that $hat(theta)_n$ converges at rate $1/v_n$

#rmk[
  If $hat(theta)_n$ is asymptotically normal $=>$ $hat(theta)_n$ is consistent 
  $
    hat(theta)_n - theta = underbrace( 1/sqrt(n), -> 0 )underbrace(sqrt(n)(hat(theta)_n - theta), ->^(cal(L)) cal(N) (0, sigma^2)) -->^(cal(L) "ou" P)_("Slutsky") 0
  $ 
  $
  U_n = 1/sqrt(n) -> 0
  $ 
] 

#underline[ $delta$-method ]
 $
 sqrt(n)(X_n - 1) -->^(cal(L)) cal(N) (0, 1) \
 sqrt(n)(X_n - 1) approx^(cal(L)) Z ~ cal(N) (0, 1) \
 X_n approx^(cal(L)) 1 + 1/sqrt(n) Z
 $
 If $g$ is differentiable at $1$, 
 $ g(1 + h) = g(1) + h g(1) $ 
 $
 g(X_n) approx g(1) + 1/sqrt(n) g'(1) Z
 $ 
 $
 sqrt(n) (g(X_n) - g(1)) approx g'(1) Z
 $ 


#underline[ $delta$-method ]
$
sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, 1)
$ 
g differentiable at $theta$
 $
g(x) = g(theta) + g'(theta)[(x - theta) + r(x)] "where" r(x) ->_(x->0) 0
$ 

$hat(theta)_n -->^P theta$ thus (LAC) $r(hat(theta)_n) --> r(theta) = 0$
 $
g(hat(theta)_n) = g(theta) + (hat(theta)_n - theta)[g'(theta) + r(hat(theta)_n)] \
sqrt(n)(g(hat(theta)_n) - g(theta)) = underbrace(sqrt(n) (hat(theta)_n -
theta), -->^(cal(L)) Z) [ underbrace(g'(theta) + r(hat(theta)_n), -->^P
g'(theta)) ] =>_("Slutsky") sqrt(n)(g(hat(theta)_n) - g(theta)) -->^(cal(L)) g'(theta) Z ~ cal(N) (0, (g'(theta))^2)
$ 

// --- CHUNK_METADATA_START ---
// src_checksum: 64faf470763e65741c66978e1d946d5fea36c77670011b8a1ebd8d282a9a4d3b
// needs_review: True
// --- CHUNK_METADATA_END ---
#ex[
  $X_1, .., X_n$ with density law $f(x) = 1/mu e^(-x/mu), x >= 0, mu = E[X_i] > 0$

   $mu$

   $hat(mu) = overline(X)$ estimated by $log L_n (mu) = - n log mu - 1/mu sum_(i=1)^n X_i $ efficient? $
   Var(hat(mu)) = 1/n^2 Var(sum_i X_i) underbrace(=, "indép") 1/n^2 sum_i Var(X_i) underbrace(=, "i.i.d.") 1/n Var(X_i) = mu^2/n, E[hat(mu)] = mu
   $ 

   $
   partial/( partial mu )(log L_n)(mu) = -n/mu + 1/(mu^2)sum(X_i)
   $
    $
   I_n(mu) &= Var( -n/mu + 1/(mu^2)sum X_i ) \
           &= 1/(mu^4) Var( sum X_i ) \
           &= n/(mu^4) Var( X_i )
   $
   $
   I_n(mu) = n/(mu^2)
   $
   $hat(mu)$
   $Var(hat(mu)) = 1/(I_n(mu))$ is unbiased and $hat(mu)$. Therefore,  

    is efficient.$sqrt(n)(hat(mu)_n - mu) -->^(cal(L)) cal(N) (0, mu^2) => Var(hat(mu)_n) = mu^2/n = $ CLT: 

    $( sqrt(n)(hat(mu)_n - mu) )/mu$ variance of the asymptotic Gaussian distribution$cal(N) (0, 1)$ 

  - has the asymptotic distribution $(X_1, ..., X_n)$ another parametrization: $f(x) = theta e^(-theta x), x >= 0$ i.i.d. $
  E X_i = 1/theta, Var X_i = 1/theta^2
  $
   $
  log L_n (theta) = n log theta - theta sum_(i=1)^n X_i \
  partial/(partial theta)(log L_n)(theta) = n/theta - sum X_i arrow.hook hat(theta)^"MV" = 1/(overline(X)) \
  arrow.hook I_n(theta) = Var(n/theta - sum X_i) = Var(sum X_i) = n/theta^2
  $
  #rmk[
  $n overline(X) ~ Gamma (n, theta)$
    cf. TD1:
    $
    E[1/(n overline(X))] = theta/(n-1) "
     " Var(1/((n overline(X))^2)) = theta^2/((n-1)(n-2))
    $ and]
  $
  E[1/overline(X)] = n theta/(n-1)
  $
  $
  arrow.hook tilde(theta) = (n-1)/n hat(theta) "
  "
  $ unbiased$
  Var(tilde(theta)) &= ((n-1)/n)^2 Var(1/overline(X)) = (n-1)^2/n^2
  [E[1/(overline(X))^2] - (E[1/overline(X)])^2] \
  &= cancel((n-1)^2)/cancel(n^2) times (cancel(n^2)theta^2)/(cancel((n-1))(n-2)) - (n-1)^2/n^2 n^2/(n-1)^2 theta^2 \
  &=  theta^2 (n-1)/(n-2) - theta^2 = theta^2/(n-2) underbrace(> , "BCR" ) 1/(I_n(theta)) " not efficient"
  $ 

  $
  sqrt(n) (overline(X) - 1/theta) -->^(cal(L)) cal(N) (0, 1/theta^2)
  $
  $hat(theta)$ is asymptotically efficient

  $overline(X)$ asymptotically normal (CLT).
  $g(x) = 1/x$ on  $]0, +infinity[, g'(x) = -1/x^2 != 0$, delta method:
   $
  sqrt(n) (1/overline(X) - theta) -->^(cal(L)) underbrace(g'(1/theta), = theta^2) cal(N) (0, 1/theta^2) = cal(N) (0, theta^4/theta^2= theta^2)
  $
]
// --- CHUNK_METADATA_START ---
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// src_checksum: bbd1c5494c646a053c8d5e1ea254f6ce4764944bfb3fddf3bfa9f5f2c51040e9
// needs_review: True
// --- CHUNK_METADATA_END ---
== Pivotal (asymptotic) or pivotal statistic

#defn[
  A statistic whose distribution does not depend on unknown parameters
]

#ex[
 $X_1, ..., X_n$ i.i.d. $"Bernoulli"(theta)$ with $theta in ]0, 1[$:
 $
 &sqrt(n)(overline(X) - theta) -->^(cal(L))_("TLC") cal(N) (0, theta(1 - theta)) \
 <=> & underbrace( sqrt(n) (overline(X) - theta)/(sqrt(theta(1-theta))), "pivot ou stat. pivotale" ) -->^(cal(L)) cal(N) (0, 1)
 $
Pivotal method for confidence intervals:
We estimate $sqrt(theta(1 - theta))$ by $sqrt(hat(theta)(1 - hat(theta)))$ using the "plug-in" method with the continuous function $g(x) = sqrt(x(1 -x))$ where $x in ]0, 1[$, $sqrt(hat(theta)(1 - hat(theta)))$ is a consistent estimator of $sqrt(theta(1 - theta))$
 $
 sqrt(n) (hat(theta) - theta)/(sqrt(hat(theta)(1 - hat(theta)))) = underbrace( sqrt(n) (hat(theta) - theta)/(sqrt(theta(1 - theta))), -->^(cal(L))_("TLC") cal(N) (0, 1)) times underbrace( (sqrt(theta(1-theta)))/(sqrt(hat(theta)(1 - hat(theta)))), -->^P_("consistant") 1)
 $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 297f49c2ce189629c1ad39c4e75063886cd6125017dbb4c1fd8a079e6324d8cc
// needs_review: True
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n)$ with density $theta > 0$. $f_theta (x) = 3/theta x^2 exp(- x^3/theta)bb(1)_(x >= 0)$

  . MLE?
  $
  log L_n (theta) = n(log^3 - log theta) + sum_(i=1)^n log(X_i^2) - 1/theta sum_(i=1)^n X_i^3
  $
  $
  (log L_n)'(theta) = - n/theta + 1/theta^2 sum X_i^3 => hat(theta) = (sum X_i^3)/n
  $
  $
  (log L_n)''(theta) = n/theta^2 - 2/theta^3 sum X_i^3; (log L_n)''(hat(theta)) = n/hat(theta)^2 - 2/hat(theta)^3 n hat(theta) = - n/hat(theta)^2 < 0 + "uniqueness"
  $
  $=>$ global maximum 

   CLT:
  $
  sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) cal(N) (0, theta^2) \
  underbrace( <=>, "pivot asymptotique" ) (sqrt(n)(hat(theta) - theta))/theta -->^(cal(L)) cal(N) (0, 1) \
  underbrace( =>, "Slutsky") (sqrt(n)(hat(theta) - theta))/hat(theta) -->^(cal(L)) cal(N) (0, 1) 
  $
  $q_(alpha/2)$ and $q_(1 - alpha/2)$ quantiles of $cal(N) (0, 1)$

   $
  P(q_(alpha/2) <= (sqrt(n)(hat(theta) - theta))/hat(theta) <= 1_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
  P(q_(alpha/2) hat(theta)/sqrt(n) <= hat(theta) - theta <= q_(1 - alpha/2) hat(theta)/(sqrt(n))) --> 1 - alpha \
  P(underbrace( hat(theta) - q_(1 - alpha/2) hat(theta)/sqrt(n) <= theta <= hat(theta) - q_(alpha/2) hat(theta)/(sqrt(n)), => I C (theta) "de niveau asymptotique" (1 - alpha) )) --> 1 - alpha \
  $
]
