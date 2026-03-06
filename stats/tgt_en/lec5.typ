// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 52d73345c67ba675d43e7fec7a8bdf3c16a79ff6c9e2d7c3956e6463c6aa3844
// --- CHUNK_METADATA_END ---
= Empirical distribution function// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0fb7f75a6eff6284b4aa3b3da8804809eea2c36cacf898d15998e6e4c317c27e
// --- CHUNK_METADATA_END ---
$(X_1, ..., X_n)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 59d7ada48a8bd371c82ed9881fae2189886cfeb1264ee717a582076df1fb62b9
// --- CHUNK_METADATA_END ---
i.i.d. real-valued sample from a distribution// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ece49feba00b8a1812ded074f725361efa66b3c98a069a56aeb4b360bb7aee93
// --- CHUNK_METADATA_END ---
$F$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a8c8f6f853de2af926c6d1e73e8502c6d2de70c027eadce12544eadd84101ed3
// --- CHUNK_METADATA_END ---
unknown.// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7f43ec93bc3f7fbd66b7b9869c19ca875b754d66278bd58cf4fdae802928602d
// --- CHUNK_METADATA_END ---
$
forall x in RR, F(x) = P(X_1 <= x) = E[bb(1)_(X_1 <= x)]
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 1496fa79cc1a9ed45de819086240699575367d25a26b94d88d081a018c08d38b
// --- CHUNK_METADATA_END ---
#defn[
  The distribution function #underline[empirical] associated with $(X_1, ..., X_n)$ is defined by:
   $
  hat(F)_n: RR &--> [0, 1] \
            x &|-> 1/n sum_(i=1)^n bb(1)_(X_i <= x)
  $ 
  $forall x in RR, hat(F)_n (x)$ is a random variable, an estimator of $F(x)$. 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a7007491407e17f3b1e4d66b285855e75934dd332d4a5bb11cc3f786824140bb
// --- CHUNK_METADATA_END ---
#defn[
  Empirical distribution $P_n = 1/n sum_(i=1)^n delta_X_i$ is a uniform discrete distribution over ${X_1, ..., X_n}$.
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 847525a1819e2e63ba4ef552a0b285f7f3f4a51ffbcbaf8be27bfc30e7b6322e
// --- CHUNK_METADATA_END ---
Graphical representation// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: eb8fdb09945a3e7ccdb86e8821693026b553e87343df8c6e8e38deee49d8d5e4
// --- CHUNK_METADATA_END ---
Conditioning// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 24a54ab5181ab765fc9998ba6e3ad83619df0c912ce59fe0a29d72bc70c3ee11
// --- CHUNK_METADATA_END ---
$X_1 = x_1, X_2 = x_2, ..., X_n = x_n$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 28ece12437e65cab856fd2c17a9a32c0ae1bdab8cd9704df1a2cd58b9168b13d
// --- CHUNK_METADATA_END ---


 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ea7d3eccfae1042436fb4de8de110caee33c25aec3af9df591741193b2a67596
// --- CHUNK_METADATA_END ---
$
x_((1)) <= x_((2)) <= ... <= x_((n)) " ordered values"
$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 16647954c146404e2b7418ad84f45ea5430a2b844ae367ccb8ad371b8b8465f5
// --- CHUNK_METADATA_END ---
 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9df0541db323e201ae68bb69caf43eca5062196b1574a3dccc43179e629a15f6
// --- CHUNK_METADATA_END ---
#import "figures/repr-graphique-repartition-empirique.typ":diagram as repr-graphique-repartition-empirique// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 488e53a6b63662ffc0030fe598bdf57c8f84341c07742a61bda351efda761b5d
// --- CHUNK_METADATA_END ---
#repr-graphique-repartition-empirique(width: 400pt)// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b8de1c2935a3794cdd75bc82e407d57bd157384069c76ee7a420bbf3c2ac8a0a
// --- CHUNK_METADATA_END ---
fdsa// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a5331188e3401b0b9f59ba41dce94e9615c6dabe7657aef50354c9f5c21b57c9
// --- CHUNK_METADATA_END ---
#prop(info: "Immediate properties")[
  - $n hat(F)_n (x) = sum_(i=1)^n bb(1)_(X_i <= x)$ follows the binomial distribution$(n, F(x))$ 
  - $R(hat(F)_n (x), F(x)) = 0 + 1/(n^2) Var(sum_(i=1)^n bb(1)_(X_i <= x)) underbrace(=, "indep") 1/n F(x) (1 - F(x)) -->_(n -> +infinity) 0$
    therefore  $forall x in RR, hat(F)_n (x) -->^P F(x)$
  - or #underline[LGN]:  $hat(F)_n (x)$ consistent #underline[estimator] of  $F(x)$.
  - We have a uniform convergence result :
     $
    sup_(x in RR) |hat(F)_n (x) - F(x)| -->_(n -> +infinity)^P 0 " (Glivenko-Cantelli Theorem)"
    $ 
    .#footnote[Thm de Glivenko-Cantelli: #link("https://fr.wikipedia.org/wiki/Th%C3%A9or%C3%A8me_de_Glivenko-Cantelli")]
  - $hat(F)_n (x)$ is it asymptotically normal?
    
     $
    hat(F)_n (x) = 1/n sum_(i=1)^n bb(1)_(X_i <= x)
    $ 
    TLC: the $X_i$ are i.i.d., so the  ${bb(1)_(X_i <= x) = Y_i}$ are i.i.d.
     $
    forall x, F(x) in ]0, 1[, #h(1em) sqrt(n)(hat(F)_n (x) - F(x)) -->^(cal(L))_(n -> +infinity) cal(N)(0, F(x)(1 - F(x)))
    $ 
    $
    <==> (hat(F)_n (x) - F(x))/(sqrt((F(x)(1 - F(x)))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
    $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: cebc3a2dab879021a16c99dc33a2e7a15b26eed8903e875313106205fa2d5d0d
// --- CHUNK_METADATA_END ---
== Empirical estimation
"plug-in" or substitution method, parameter of interest  $theta = c(F)$, the
empirical method defines  $hat(theta)$, empirical estimator by replacing
$F$ by  $hat(F)_n -> hat(theta)_n = c(hat(F)_n)$.

#ex[
  $theta = E_F (X) -> hat(theta)_n = E_(hat(F)_n)(X) = sum_(i=1)^n X_i times 1/n = overline(X)$ if $X_i$ are distinct

   $
  theta = Var_F (X) -> hat(theta)_n = Var_(hat(F)_n)(X) = 1/n sum (X_i - overline(X))^2
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 3c9872e903c5d398e6667322d88aac44df0c41a6b63c7dadb9d2aef30accb444
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
  If $F$ is strictly increasing,  $inf x$ such that  $F(x) >= a <=> x >= F^(-1) (alpha)$; this applies if  $F$ is a discrete distribution function.

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
- $F^(-1)$ is also called the #underline[fonction quantile]
-  $F^(-1) (alpha) = $ quantile of order  $alpha$, of the distribution  $F$
-  $F^(-1) (1/4) = $ 1st quartile
-  $F^(-1)(1/2) = $ median
-  $F^(-1) (3/4) = $ 3rd quartile

#lem[
  $U$ random variable on $[0, 1]$,  $F$ d.f., then  $F^(-1)(U)$ is a random variable with distribution  $F$
] 
- If $F$ bijective: 
 $
P(F^(-1)(U) <= x) underbrace(=, F "bijective") P(U <= F(x)) underbrace(=, "car" P(U <= x) = x "sur" [0, 1]) F(x)
$ 
- If $F$ discrete: $F^(-1)$ generalized inverse:  $F^(-1)(y) <= x <=> y <= F(x)$

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f667f6c8e11448d8893b3de5db31780e3a611807e3195ed7d8831b69b5201f4e
// --- CHUNK_METADATA_END ---
== Empirical Quantile

#defn[
  We define the #underline[empirical quantile] (sample quantile) of order
  $alpha$, as the quantile of  $hat(F)_n$: 
  $
  hat(q)_(n, alpha) = hat(F)_n^(-1)(alpha) = inf{x, hat(F)_n (x) >= alpha}
  $ 
] 

#prop[
  - It can be shown that $hat(q)_(n, alpha) = X_(([n alpha]))$ where  $X_((1)) <=
    X_((2)) <= ... <= X_((n))$ is the ordered sample of the  $(X_i)_(1 <= i <
    n)$
    $
    [u] = "the smallest integer" >= u
    $ 
]
#ex[
  $alpha = 1/2$,  $[n/2]$,
   $
  cases(
    "si" n=2k #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k)),
    "si" n=2k+1 #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k+1)))
  $ 
  - Consistency
    
    if $alpha in ]0,1[$, if  $F$ is strictly increasing in the neighborhood of  $alpha$
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 704a0af81b7d1f09a4c7c23e227046d44f332fb69d463594fb4492014476e483
// --- CHUNK_METADATA_END ---
= Confidence Intervals// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ef9a514a12d201313dc6fa6c54081efcafd1c911dda4e802398c1e6c89c96e7a
// --- CHUNK_METADATA_END ---
== Definitions
$(X_1, ..., X_n)$ i.i.d. with distribution  $P in {P_theta, theta in Theta subset RR^p}$,
we are interested in  $theta in RR$ or  $g(theta): RR^p --> RR$. 

A confidence interval for $theta$, with confidence level  $1 - alpha,
alpha in ]0, 1[$ is an interval whose bounds are #underline[random],
functions of the sample and does NOT depend on the unknown parameters of the model, such that
 $
 P([B inf (X_1, ..., X_n); B sup (X_1, ..., X_n)] in.rev theta) >= 1 - alpha
$ 
#footnote[$B inf$ for lower bound and $B sup$ for upper bound]
- A CI can be calculated from the data 
- if the inequality is an equality $=$ the confidence level is  #underline[exact].
- if we have $P(theta in [B inf, B sup]) -->_(n -> +infinity) 1 - alpha$, the level is #underline[asymptotic].
- generally  $alpha = 1%, 5%$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7feb4aaa8f7ed83598ea2a7fa4b270c7562eabff3de9087464e681b8d714ea64
// --- CHUNK_METADATA_END ---
== Interpretation
// fig 1 here

#grid(columns: (50%, 50%),
[
  #image("figures/interv-confiance.png")
],
[
 $I C = [B inf(X_1, ..., X_n), B sup(X_1, ..., X_n)]$ mathematical formula that guarantees the level  $1 - alpha$.
 We observe  $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$, a realization of the random sample. We calculate 
 $I C = [2.3; 5.1]$ with a confidence level of $95%$ ($alpha = 5%$).

 On average, for 100 calculated intervals (using the same formula), there are 5
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
// needs_review: True
// src_checksum: b7489a5808454697c4056bedbd6d78c8ebd47f27f6689dde2e27c88f72bd53e3
// --- CHUNK_METADATA_END ---
== Pivotal Method
$(X_1, ..., X_n)$ i.i.d. with expectation  $theta in RR$, with variance  $sigma^2(theta)$. Let  $hat(theta)$ be asymptotically normal: 
 $
sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2(theta)) \
<=> (sqrt(n) (hat(theta)_n - theta))/(sigma(theta)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
$ 

By definition of Gaussian quantiles, $q_alpha = Phi^(-1) (alpha)$ where  $Phi$ is the c.d.f. of  $cal(N) (0, 1)$

#grid(columns: (50%, 50%),
[
$
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/sigma(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha
$ 
],
[
  #image("figures/methode-pivotale.png")
]
)

- *pivot or pivotal statistic* = $(sqrt(n) (hat(theta) - theta))/(hat(sigma))$ standardized statistic derived from  $hat(theta)$, where  $sigma^2(theta)$ is estimated by  $hat(sigma)^2$, #underline[consistent] for estimating $sigma^2(theta)$. 

  If this is the case, 
  $
  underbrace( (sqrt(n) (hat(theta) - theta))/(sigma(theta)), -->^(cal(L))_(hat(theta) "as. normal") cal(N) (0, 1) ) times underbrace( (sigma^2(theta))/(hat(sigma)^2), -->^(P)_("estimateur consistant") 1) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1) " by Slutsky's lemma"
  $ 
- we deduce 
  $
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/hat(sigma)(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
P(hat(theta) - 1/(sqrt(n))hat(sigma)q_(1 - alpha/2) <= theta <= hat(theta) - 1/(sqrt(n)) hat(sigma) q_(alpha/2)) --> 1 - alpha
  $ 

