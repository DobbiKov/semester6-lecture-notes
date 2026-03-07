// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d7c7fbf33f81b2fe4bac026d585021f8cefb747b633324aa5de4c0c9e5d3fb4a
// --- CHUNK_METADATA_END ---
= Supplements (before midterm)
1. Review of asymptotic normality
2. Example
3. Asymptotic pivot
4. Example 2

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b405340052e1c0b080321488ecb53e06bb4ae59a98d3ba1ac7828218393fb073
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

#ex[
  $X_1, .., X_n$ with density distribution $f(x) = 1/mu e^(-x/mu), x >= 0, mu = E[X_i] > 0$

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 05de47c8c5e6fec1cad6e586f3afc936f44aac97a1db4e6beef86f8daf8b4682
// --- CHUNK_METADATA_END ---
   $mu$ estimated by  $hat(mu) = overline(X)$ efficient?  $log L_n (mu) = - n log mu - 1/mu sum_(i=1)^n X_i $
    $
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
   $hat(mu)$ is unbiased and  $Var(hat(mu)) = 1/(I_n(mu))$. Therefore,  $hat(mu)$ is efficient. 

   CLT: $sqrt(n)(hat(mu)_n - mu) -->^(cal(L)) cal(N) (0, mu^2) => Var(hat(mu)_n) = mu^2/n = $ variance of the asymptotic Gaussian distribution

    $( sqrt(n)(hat(mu)_n - mu) )/mu$The asymptotic distribution for 

    $( sqrt(n)(hat(mu)_n - mu) )/mu$ is $cal(N) (0, 1)$ 

  - another parametrization: $(X_1, ..., X_n)$ i.i.d.  $f(x) = theta e^(-theta x), x >= 0$
   $
  E X_i = 1/theta, Var X_i = 1/theta^2
  $ 
  $
  log L_n (theta) = n log theta - theta sum_(i=1)^n X_i \
  partial/(partial theta)(log L_n)(theta) = n/theta - sum X_i arrow.hook hat(theta)^"MV" = 1/(overline(X)) \
  arrow.hook I_n(theta) = Var(n/theta - sum X_i) = Var(sum X_i) = n/theta^2
  $ 
  #rmk[
    cf. TD1: 
    $n overline(X) ~ Gamma (n, theta)$
     $
    E[1/(n overline(X))] = theta/(n-1) "and" Var(1/((n overline(X))^2)) = theta^2/((n-1)(n-2))
    $ 
  ]
  $
  E[1/overline(X)] = n theta/(n-1)
  $ 
  $
  arrow.hook tilde(theta) = (n-1)/n hat(theta) "unbiased"
  $ 
  $
  Var(tilde(theta)) &= ((n-1)/n)^2 Var(1/overline(X)) = (n-1)^2/n^2
  [E[1/(overline(X))^2] - (E[1/overline(X)])^2] \
  &= cancel((n-1)^2)/cancel(n^2) times (cancel(n^2)theta^2)/(cancel((n-1))(n-2)) - (n-1)^2/n^2 n^2/(n-1)^2 theta^2 \
  &=  theta^2 (n-1)/(n-2) - theta^2 = theta^2/(n-2) underbrace(> , "BCR" ) 1/(I_n(theta)) "not efficient"
  $ 

  $
  sqrt(n) (overline(X) - 1/theta) -->^(cal(L)) cal(N) (0, 1/theta^2)
  $ 
  $hat(theta)$ is asymptotically efficient

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 87cd4e321e3dec65927b52ba856f8bda1053197c40348299ea83741b204f5c27
// --- CHUNK_METADATA_END ---
  $overline(X)$ asymptotically normal (CLT).
  $g(x) = 1/x$ on  $]0, +infinity[, g'(x) = -1/x^2 != 0$, delta method:
   $
  sqrt(n) (1/overline(X) - theta) -->^(cal(L)) underbrace(g'(1/theta), = theta^2) cal(N) (0, 1/theta^2) = cal(N) (0, theta^4/theta^2= theta^2)
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 79daf40586e3642fd887f59fb656751892e18bcc83424c89e026ea2e64ef2630
// --- CHUNK_METADATA_END ---
== Pivot (asymptotic) or pivotal statistic

#defn[
  A statistic whose distribution does not depend on unknown parameters
]

#ex[
 $X_1, ..., X_n$ i.i.d.  $"Bernoulli"(theta)$ with  $theta in ]0, 1[$: 
  $
 &sqrt(n)(overline(X) - theta) -->^(cal(L))_("TLC") cal(N) (0, theta(1 - theta)) \
 <=> & underbrace( sqrt(n) (overline(X) - theta)/(sqrt(theta(1-theta))), "pivot ou stat. pivotale" ) -->^(cal(L)) cal(N) (0, 1)
 $ 
 Pivotal method for CI:
 We estimate $sqrt(theta(1 - theta))$ by  $sqrt(hat(theta)(1 - hat(theta)))$ using the "plug-in" method with the LAC function  $g(x) = sqrt(x(1 -x))$ for  $x in ]0, 1[$, where  $sqrt(hat(theta)(1 - hat(theta)))$ is a consistent estimator of  $sqrt(theta(1 - theta))$
  $
 sqrt(n) (hat(theta) - theta)/(sqrt(hat(theta)(1 - hat(theta)))) = underbrace( sqrt(n) (hat(theta) - theta)/(sqrt(theta(1 - theta))), -->^(cal(L))_("TLC") cal(N) (0, 1)) times underbrace( (sqrt(theta(1-theta)))/(sqrt(hat(theta)(1 - hat(theta)))), -->^P_("consistant") 1)
 $ 
]

#ex[
  $(X_1, ..., X_n)$ from a density with  $theta > 0$.  $f_theta (x) = 3/theta x^2 exp(- x^3/theta)bb(1)_(x >= 0)$

  MLE?
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
  $q_(alpha/2)$ and  $q_(1 - alpha/2)$ quantiles of  $cal(N) (0, 1)$

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 96a5eee711e9f77e4602175943fcc6725a8ecb08611da69a0def23f4ddf1dff1
// --- CHUNK_METADATA_END ---
   $
  P(q_(alpha/2) <= (sqrt(n)(hat(theta) - theta))/hat(theta) <= 1_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
  P(q_(alpha/2) hat(theta)/sqrt(n) <= hat(theta) - theta <= q_(1 - alpha/2) hat(theta)/(sqrt(n))) --> 1 - alpha \
  P(underbrace( hat(theta) - q_(1 - alpha/2) hat(theta)/sqrt(n) <= theta <= hat(theta) - q_(alpha/2) hat(theta)/(sqrt(n)), => I C (theta) "de niveau asymptotique" (1 - alpha) )) --> 1 - alpha \
  $ 
]
