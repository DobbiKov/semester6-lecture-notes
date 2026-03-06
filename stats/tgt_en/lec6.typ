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
4. Example 2// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 1e8bd00398fdf9e9409abd473c26a06904f9e489e4a3f79c63facf832d01ac1a
// --- CHUNK_METADATA_END ---
== Asymptotic properties of a sequence of estimators $(hat(theta)_n)_(n >= 1)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: e16f1596201850fd4a63680b27f603cb64e67176159be3d8ed78a4403fdb1700
// --- CHUNK_METADATA_END ---
 
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9f638c4ea243fcd90cebb0064ab2789539b4ce63b765f9987c334a7978c9a2c7
// --- CHUNK_METADATA_END ---
- Consistency $hat(theta)_n -->^P theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 4f5b9caef85dc11903a6561347b321de2490231d1abb25035cf6d516165c2527
// --- CHUNK_METADATA_END ---
- Asymptotic normality, if there exists  $sigma^2 > 0$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 77414a5e8a5a314ff69eedcca99e7479241134710a38e27ff85a6b1ed86d6fb3
// --- CHUNK_METADATA_END ---
$
  sqrt(n)(hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2)
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 754355c7c86daf44d54a9f3c9c368480ff0abed4b5b78620877382d24566d200
// --- CHUNK_METADATA_END ---
Generally, s// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 265fda17a34611b1533d8a281ff680dc5791b0ce0a11c25b35e11c8e75685509
// --- CHUNK_METADATA_END ---
'// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: fdbe2a7f123483e60445023ea4597fb977bb28cd9ee2d2e7d94bdb16bdcb0caa
// --- CHUNK_METADATA_END ---
there exists// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 633b8d45f3529cc9962d29fe6a572e099e71a13700636896c3dac07feb0c2d37
// --- CHUNK_METADATA_END ---
$v_n -->_(n -> +infinity) +infinity$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d009b285a68c50c9616d4de598d0e0270e1173017e7d7c85646d15647de27685
// --- CHUNK_METADATA_END ---
$
  v_n(hat(theta)_n - theta) -->^(cal(L)) Y
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 249bddf915eaa9ae1d048c644a8b296473723b47dccf559c0cd485a3d20a0925
// --- CHUNK_METADATA_END ---
It is said that// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 48851e09f467fb538d903ccc80730229b6b6b6d133a9cf873f7a60e1856c7720
// --- CHUNK_METADATA_END ---
$hat(theta)_n$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9a6776cfa7e1baf070728c857a0f953ebd8d145ea6250287ef00b0c874b87f83
// --- CHUNK_METADATA_END ---
converges at the speed// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 13245940e6f07e9fe55f407129b775e0b3ee2883ba1002d819009eb18d3c9074
// --- CHUNK_METADATA_END ---
$1/v_n$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 29befa655a2370130651212faaf5092418232278e65e3bc6f34ab7104ab3caa6
// --- CHUNK_METADATA_END ---
#rmk[
  If $hat(theta)_n$ asymptotically normal  $=>$  $hat(theta)_n$ consistent 
  $
    hat(theta)_n - theta = underbrace( 1/sqrt(n), -> 0 )underbrace(sqrt(n)(hat(theta)_n - theta), ->^(cal(L)) cal(N) (0, sigma^2)) -->^(cal(L) "ou" P)_("Slutsky") 0
  $ 
  $
  U_n = 1/sqrt(n) -> 0
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d0cdd77d083c8f9f8346e660b511c389cbccf7f439ca78a38eafb6409cc8eb4c
// --- CHUNK_METADATA_END ---
#underline[ $delta$-method ]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 5d3d321750d18db9f9ca66e7b1ab099da838fb9de1b9d6b44d9ddb44f21cac00
// --- CHUNK_METADATA_END ---

 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7eeaa0187fd049249729b5d793b473bcb939970658b9e93a2ab22296777fedd4
// --- CHUNK_METADATA_END ---
$
 sqrt(n)(X_n - 1) -->^(cal(L)) cal(N) (0, 1) \
 sqrt(n)(X_n - 1) approx^(cal(L)) Z ~ cal(N) (0, 1) \
 X_n approx^(cal(L)) 1 + 1/sqrt(n) Z
 $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: aa8feb7ac7f7857042b5456f34ee2b41dfe7a108f47d56b2ff8449213b02e5cf
// --- CHUNK_METADATA_END ---
If// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: bdec6f8ff124d571df3a2dee0103aebc84e550c6966ff2e7a79c7ace5bf91753
// --- CHUNK_METADATA_END ---
$g$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 83a22546e83ce4acff08fed8347761a761abf61950f85f9c9279b1c985539dcc
// --- CHUNK_METADATA_END ---
differentiable at// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 72bc3c1b3553a71d525d8715f4963adfb2b8e7e18c32f0b1b651f3e841526770
// --- CHUNK_METADATA_END ---
$1$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a51f7fbd99074eab41e9c38ff1de19c54de3f8ba12a529b45c91eac4e17b38dc
// --- CHUNK_METADATA_END ---
,// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 697c4203a024eb062912143b243ed885567379c964d17f8f5be147ca3d0be4e5
// --- CHUNK_METADATA_END ---
$ g(1 + h) = g(1) + h g(1) $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: cd686159289a5e43faaaa62c47b7ade385f9d234ea501782d39959d35a8183f6
// --- CHUNK_METADATA_END ---
 
 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d1d3f52db89bf3fdef613a0238305f80368746c5e3cd289700dae0e16a34b152
// --- CHUNK_METADATA_END ---
$
 g(X_n) approx g(1) + 1/sqrt(n) g'(1) Z
 $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: cd686159289a5e43faaaa62c47b7ade385f9d234ea501782d39959d35a8183f6
// --- CHUNK_METADATA_END ---
 
 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 4e41c0fa612cb92d935986cfa1585da37a8770d6e345a7902a287ebbdd305031
// --- CHUNK_METADATA_END ---
$
 sqrt(n) (g(X_n) - g(1)) approx g'(1) Z
 $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ff2dc9018b2c43a9793444552abcf83560daf5f7b1733bf7dbcaed4ee97db60e
// --- CHUNK_METADATA_END ---
 


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: d0cdd77d083c8f9f8346e660b511c389cbccf7f439ca78a38eafb6409cc8eb4c
// --- CHUNK_METADATA_END ---
#underline[ $delta$-method ]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 3628611b7e0f065b8dd2a073ac99144f02b60141d2f9c0f626f3d5bbaf3054c9
// --- CHUNK_METADATA_END ---
$
sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, 1)
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16d19172c03949ed1026109ee84fe51206506ccc22147c2bbab74309bf88583d
// --- CHUNK_METADATA_END ---
g differentiable at// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c7306518523986c1c42120bdd35c3c4f446af47a15fa3ae538440f629cddf010
// --- CHUNK_METADATA_END ---
$theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 5d3d321750d18db9f9ca66e7b1ab099da838fb9de1b9d6b44d9ddb44f21cac00
// --- CHUNK_METADATA_END ---

 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7ddccfd1d7ae2d66b2eeb999383d7a25d8f9ba8b7abb4cc0f63bc5c23c539603
// --- CHUNK_METADATA_END ---
$
g(x) = g(theta) + g'(theta)[(x - theta) + r(x)] "where" r(x) ->_(x->0) 0
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 54e1135aebf00654899304bca4712cfc8afbf821527d01db4f4cf1f1248d7712
// --- CHUNK_METADATA_END ---
$hat(theta)_n -->^P theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 77b10ca88337aa024579cf30319a836c0951ae72f590bb2e69588ceab4939f23
// --- CHUNK_METADATA_END ---
therefore (LAC)// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 85ff459571cecab6fd924c3c583ef0018bfd47a3cc6eb711763f1cadeabcd288
// --- CHUNK_METADATA_END ---
$r(hat(theta)_n) --> r(theta) = 0$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 5d3d321750d18db9f9ca66e7b1ab099da838fb9de1b9d6b44d9ddb44f21cac00
// --- CHUNK_METADATA_END ---

 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0a0a81f7a23c77010edbfdb3548ed83d94ca9ee399ed6226c54a82a794f762b3
// --- CHUNK_METADATA_END ---
$
g(hat(theta)_n) = g(theta) + (hat(theta)_n - theta)[g'(theta) + r(hat(theta)_n)] \
sqrt(n)(g(hat(theta)_n) - g(theta)) = underbrace(sqrt(n) (hat(theta)_n -
theta), -->^(cal(L)) Z) [ underbrace(g'(theta) + r(hat(theta)_n), -->^P
g'(theta)) ] =>_("Slutsky") sqrt(n)(g(hat(theta)_n) - g(theta)) -->^(cal(L)) g'(theta) Z ~ cal(N) (0, (g'(theta))^2)
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 64faf470763e65741c66978e1d946d5fea36c77670011b8a1ebd8d282a9a4d3b
// --- CHUNK_METADATA_END ---
#ex[
  $X_1, .., X_n$ with probability density function  $f(x) = 1/mu e^(-x/mu), x >= 0, mu = E[X_i] > 0$

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
   $hat(mu)$ unbiased and  $Var(hat(mu)) = 1/(I_n(mu))$. Therefore  $hat(mu)$ is efficient. 

   CLT: $sqrt(n)(hat(mu)_n - mu) -->^(cal(L)) cal(N) (0, mu^2) => Var(hat(mu)_n) = mu^2/n = $ variance of the asymptotic Gaussian distribution

    $( sqrt(n)(hat(mu)_n - mu) )/mu$ has an asymptotic distribution of $cal(N) (0, 1)$ 

  - another parameterization: $(X_1, ..., X_n)$ i.i.d.  $f(x) = theta e^(-theta x), x >= 0$
   $
  E X_i = 1/theta, Var X_i = 1/theta^2
  $ 
  $
  log L_n (theta) = n log theta - theta sum_(i=1)^n X_i \
  partial/(partial theta)(log L_n)(theta) = n/theta - sum X_i arrow.hook hat(theta)^"MV" = 1/(overline(X)) \
  arrow.hook I_n(theta) = Var(n/theta - sum X_i) = Var(sum X_i) = n/theta^2
  $ 
  #rmk[
    see Tutorial 1: 
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

  $overline(X)$ asymptotically normal (CLT).
  $g(x) = 1/x$ on  $]0, +infinity[, g'(x) = -1/x^2 != 0$, delta method:
   $
  sqrt(n) (1/overline(X) - theta) -->^(cal(L)) underbrace(g'(1/theta), = theta^2) cal(N) (0, 1/theta^2) = cal(N) (0, theta^4/theta^2= theta^2)
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 84dfe8c89d596df7d7f47b8937a8b3321b94a33e1968575d9adc8254055f585a
// --- CHUNK_METADATA_END ---
== Pivot (asymptotic) or pivotal statistic// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c504ae6330c2bad2016ca38ed02c17b2b065449b10e856238cf22d9c9a9ed8eb
// --- CHUNK_METADATA_END ---
#defn[
  Statistic whose distribution does not depend on unknown parameters
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7f489c369ad5ba085cbf2f72d1bc64e6ccbb69ca5470c15ea220c7ec86216276
// --- CHUNK_METADATA_END ---
#ex[
 $X_1, ..., X_n$ i.i.d.  $"Bernoulli"(theta)$ with  $theta in ]0, 1[$: 
  $
 &sqrt(n)(overline(X) - theta) -->^(cal(L))_("TLC") cal(N) (0, theta(1 - theta)) \
 <=> & underbrace( sqrt(n) (overline(X) - theta)/(sqrt(theta(1-theta))), "pivot ou stat. pivotale" ) -->^(cal(L)) cal(N) (0, 1)
 $ 
 Pivotal method for CI:
 We estimate $sqrt(theta(1 - theta))$ by  $sqrt(hat(theta)(1 - hat(theta)))$ "plug-in" using the LAC  $g(x) = sqrt(x(1 -x))$ with  $x in ]0, 1[$,  $sqrt(hat(theta)(1 - hat(theta)))$ a consistent estimator of  $sqrt(theta(1 - theta))$
  $
 sqrt(n) (hat(theta) - theta)/(sqrt(hat(theta)(1 - hat(theta)))) = underbrace( sqrt(n) (hat(theta) - theta)/(sqrt(theta(1 - theta))), -->^(cal(L))_("TLC") cal(N) (0, 1)) times underbrace( (sqrt(theta(1-theta)))/(sqrt(hat(theta)(1 - hat(theta)))), -->^P_("consistant") 1)
 $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 43702acac41e0ae3ab4760c5a8d7ff58ec7e0cdbebf16cb8cd9e4a483940e355
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n)$ with density  $theta > 0$.  $f_theta (x) = 3/theta x^2 exp(- x^3/theta)bb(1)_(x >= 0)$

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

   $
  P(q_(alpha/2) <= (sqrt(n)(hat(theta) - theta))/hat(theta) <= 1_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
  P(q_(alpha/2) hat(theta)/sqrt(n) <= hat(theta) - theta <= q_(1 - alpha/2) hat(theta)/(sqrt(n))) --> 1 - alpha \
  P(underbrace( hat(theta) - q_(1 - alpha/2) hat(theta)/sqrt(n) <= theta <= hat(theta) - q_(alpha/2) hat(theta)/(sqrt(n)), => I C (theta) "de niveau asymptotique" (1 - alpha) )) --> 1 - alpha \
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

