#import "preamble.typ": *

= Compléments (avant partiel)
1. Retour sur normalité asymptotique
2. Exemple
3. Pivot asymptotique
4. Exemple 2

== Propriétés asymptotiques d'une suite d'estimateurs $(hat(theta)_n)_(n >= 1)$ 
- Consistance $hat(theta)_n -->^P theta$
- Normalité asymptotique, s'il existe  $sigma^2 > 0$
$
  sqrt(n)(hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2)
$ 

De façon générale, s'il existe $v_n -->_(n -> +infinity) +infinity$

$
  v_n(hat(theta)_n - theta) -->^(cal(L)) Y
$ 

On dit que $hat(theta)_n$ converge à la vitesse  $1/v_n$

#rmk[
  Si $hat(theta)_n$ asymptotiqument normal  $=>$  $hat(theta)_n$ consistant 
  $
    hat(theta)_n - theta = underbrace( 1/sqrt(n), -> 0 )underbrace(sqrt(n)(hat(theta)_n - theta), ->^(cal(L)) cal(N) (0, sigma^2)) -->^(cal(L) "ou" P)_("Slutsky") 0
  $ 
  $
  U_n = 1/sqrt(n) -> 0
  $ 
] 

#underline[ $delta$-méthode ]
 $
 sqrt(n)(X_n - 1) -->^(cal(L)) cal(N) (0, 1) \
 sqrt(n)(X_n - 1) approx^(cal(L)) Z ~ cal(N) (0, 1) \
 X_n approx^(cal(L)) 1 + 1/sqrt(n) Z
 $
 Si  $g$ dérivable en  $1$, 
 $ g(1 + h) = g(1) + h g(1) $ 
 $
 g(X_n) approx g(1) + 1/sqrt(n) g'(1) Z
 $ 
 $
 sqrt(n) (g(X_n) - g(1)) approx g'(1) Z
 $ 


#underline[ $delta$-méthode ]
$
sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, 1)
$ 
g dérivable en $theta$
 $
g(x) = g(theta) + g'(theta)[(x - theta) + r(x)] "où" r(x) ->_(x->0) 0
$ 

$hat(theta)_n -->^P theta$ donc (LAC)  $r(hat(theta)_n) --> r(theta) = 0$
 $
g(hat(theta)_n) = g(theta) + (hat(theta)_n - theta)[g'(theta) + r(hat(theta)_n)] \
sqrt(n)(g(hat(theta)_n) - g(theta)) = underbrace(sqrt(n) (hat(theta)_n -
theta), -->^(cal(L)) Z) [ underbrace(g'(theta) + r(hat(theta)_n), -->^P
g'(theta)) ] =>_("Slutsky") sqrt(n)(g(hat(theta)_n) - g(theta)) -->^(cal(L)) g'(theta) Z ~ cal(N) (0, (g'(theta))^2)
$ 

#ex[
  $X_1, .., X_n$ de loi de densité  $f(x) = 1/mu e^(-x/mu), x >= 0, mu = E[X_i] > 0$

   $mu$ estimé par  $hat(mu) = overline(X)$ efficace?  $log L_n (mu) = - n log mu - 1/mu sum_(i=1)^n X_i $
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
   $hat(mu)$ sans biais et  $Var(hat(mu)) = 1/(I_n(mu))$. Donc  $hat(mu)$ est efficace. 

   TLC: $sqrt(n)(hat(mu)_n - mu) -->^(cal(L)) cal(N) (0, mu^2) => Var(hat(mu)_n) = mu^2/n = $ variance de la loi gausienne asymptotique

    $( sqrt(n)(hat(mu)_n - mu) )/mu$ a pour loi asymptotique $cal(N) (0, 1)$ 

  - autre paramétrisation: $(X_1, ..., X_n)$ i.i.d.  $f(x) = theta e^(-theta x), x >= 0$
   $
  E X_i = 1/theta, Var X_i = 1/theta^2
  $ 
  $
  log L_n (theta) = n log theta - theta sum_(i=1)^n X_i \
  partial/(partial theta)(log L_n)(theta) = n/theta - sum X_i arrow.hook hat(theta)^"MV" = 1/(overline(X)) \
  arrow.hook I_n(theta) = Var(n/theta - sum X_i) = Var(sum X_i) = n/theta^2
  $ 
  #rmk[
    cd TD1: 
    $n overline(X) ~ Gamma (n, theta)$
     $
    E[1/(n overline(X))] = theta/(n-1) "et" Var(1/((n overline(X))^2)) = theta^2/((n-1)(n-2))
    $ 
  ]
  $
  E[1/overline(X)] = n theta/(n-1)
  $ 
  $
  arrow.hook tilde(theta) = (n-1)/n hat(theta) "non biaisé"
  $ 
  $
  Var(tilde(theta)) &= ((n-1)/n)^2 Var(1/overline(X)) = (n-1)^2/n^2
  [E[1/(overline(X))^2] - (E[1/overline(X)])^2] \
  &= cancel((n-1)^2)/cancel(n^2) times (cancel(n^2)theta^2)/(cancel((n-1))(n-2)) - (n-1)^2/n^2 n^2/(n-1)^2 theta^2 \
  &=  theta^2 (n-1)/(n-2) - theta^2 = theta^2/(n-2) underbrace(> , "BCR" ) 1/(I_n(theta)) "non efficace"
  $ 

  $
  sqrt(n) (overline(X) - 1/theta) -->^(cal(L)) cal(N) (0, 1/theta^2)
  $ 
  $hat(theta)$ est asymptotiqument efficace

  $overline(X)$ asymptotiqument normal (TLC).
  $g(x) = 1/x$ sur  $]0, +infinity[, g'(x) = -1/x^2 != 0$, méthode delta:
   $
  sqrt(n) (1/overline(X) - theta) -->^(cal(L)) underbrace(g'(1/theta), = theta^2) cal(N) (0, 1/theta^2) = cal(N) (0, theta^4/theta^2= theta^2)
  $ 
]

== Pivot (asymptotique) ou statistique pivotale

#defn[
  Statistique dont la loi ne dépend pas de paramètres inconnus
]

#ex[
 $X_1, ..., X_n$ i.i.d.  $"Bernoulli"(theta)$ avec  $theta in ]0, 1[$: 
  $
 &sqrt(n)(overline(X) - theta) -->^(cal(L))_("TLC") cal(N) (0, theta(1 - theta)) \
 <=> & underbrace( sqrt(n) (overline(X) - theta)/(sqrt(theta(1-theta))), "pivot ou stat. pivotale" ) -->^(cal(L)) cal(N) (0, 1)
 $ 
 méthode pivotale pour IC:
 On estime $sqrt(theta(1 - theta))$ par  $sqrt(hat(theta)(1 - hat(theta)))$ "plug-in" par le LAC  $g(x) = sqrt(x(1 -x))$ avec  $x in ]0, 1[$,  $sqrt(hat(theta)(1 - hat(theta)))$ estimateur consistant de  $sqrt(theta(1 - theta))$
  $
 sqrt(n) (hat(theta) - theta)/(sqrt(hat(theta)(1 - hat(theta)))) = underbrace( sqrt(n) (hat(theta) - theta)/(sqrt(theta(1 - theta))), -->^(cal(L))_("TLC") cal(N) (0, 1)) times underbrace( (sqrt(theta(1-theta)))/(sqrt(hat(theta)(1 - hat(theta)))), -->^P_("consistant") 1)
 $ 
]

#ex[
  $(X_1, ..., X_n)$ de densité  $theta > 0$.  $f_theta (x) = 3/theta x^2 exp(- x^3/theta)bb(1)_(x >= 0)$

  EMV?
   $
  log L_n (theta) = n(log^3 - log theta) + sum_(i=1)^n log(X_i^2) - 1/theta sum_(i=1)^n X_i^3
  $ 
  $
  (log L_n)'(theta) = - n/theta + 1/theta^2 sum X_i^3 => hat(theta) = (sum X_i^3)/n
  $ 
  $
  (log L_n)''(theta) = n/theta^2 - 2/theta^3 sum X_i^3; (log L_n)''(hat(theta)) = n/hat(theta)^2 - 2/hat(theta)^3 n hat(theta) = - n/hat(theta)^2 < 0 + "unicité"
  $ 
  $=>$ max global 

  TLC: 
  $
  sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) cal(N) (0, theta^2) \
  underbrace( <=>, "pivot asymptotique" ) (sqrt(n)(hat(theta) - theta))/theta -->^(cal(L)) cal(N) (0, 1) \
  underbrace( =>, "Slutsky") (sqrt(n)(hat(theta) - theta))/hat(theta) -->^(cal(L)) cal(N) (0, 1) 
  $ 
  $q_(alpha/2)$ et  $q_(1 - alpha/2)$ quantiles de  $cal(N) (0, 1)$

   $
  P(q_(alpha/2) <= (sqrt(n)(hat(theta) - theta))/hat(theta) <= 1_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
  P(q_(alpha/2) hat(theta)/sqrt(n) <= hat(theta) - theta <= q_(1 - alpha/2) hat(theta)/(sqrt(n))) --> 1 - alpha \
  P(underbrace( hat(theta) - q_(1 - alpha/2) hat(theta)/sqrt(n) <= theta <= hat(theta) - q_(alpha/2) hat(theta)/(sqrt(n)), => I C (theta) "de niveau asymptotique" (1 - alpha) )) --> 1 - alpha \
  $ 
]
