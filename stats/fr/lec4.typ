#import "preamble.typ": *
= Étude asymptotique des estimateurs

Dans un moddèle paramétrique #underline([régulier]), si $hat(theta)_n$ estimateur de $theta$, alors 
$
Var(hat(theta)_n) >= 1/(I_n(theta)) = 1/(n I(theta))
$ 
si $Var(hat(theta)_n) = 1/(n I(theta))$ sans biais,  $hat(theta)_n$ est efficace #underline([efficace]) 

Asymptotique: $n -> +infinity$, 
 $
n Var(hat(theta)_n) -->_(n -> +infinity) 1/(I(theta))
$ 

== Convergences
$(X_n)_(n >= 0)$ suite de variables aléatoires réelles  $(RR^d)$

- convergence en loi:  $X_n -->_(n -> +infinity)^(cal(L)) X$ ssi  $P(X_n <= x)
  --> P(X <= x)$ en tout point de continuité de $x$.

#lem(info: "lemme de Portmanteau")[
  Caractérisations équivalentes:
  - Pour toute fonction continue bornée $h$, 
    $
    E[h(X_n)] --> E[h(X)]
    $ 

    $=>$ la convergence en loi est stable par passage aux fonctions continues
    (LAC) #underline([MAIS]) il est en général #underline([faux]) que si $X_n -->^(cal(L)) X$ et  $Y_n -->^(cal(L)) Y$ alors  $mat(X_n ; Y_n) -->^(cal(L)) mat(X; Y)$

    Cela est vrai dans 3 cas:
    1. 
      $
      "si " cases(forall n\, X_n " et " Y_n " sont indépendantes", X " et " Y " sont indépendantes ") " alors " cases(" convergence en loi de " X_n " et " Y_n, " convergence en loi du couple " mat(X_n;Y_n))
      $ 
    2.  
    $
    "si " cases(X_n -->^P X, Y_n -->^p Y) ==> mat(X_n; Y_n) -->^P mat(X; Y) ==> mat(X_n; Y_n) -->^(cal(L)) mat(X; Y) 
    $ 
    3. (Lemme de Slutsky) (le plus important)
    $
    "si " cases(X_n -->^(cal(L)) X, Y_n -->^(cal(L)) c) " alors " mat(X_n; Y_n) -->^(cal(L)) mat(X; c)
    $ 
    en appliquant le LAX,
    $
      h(x, y) &= x + y #h(40pt) X_n + Y_n -->^(cal(L)) X + c \
              &= x y #h(40pt) X_n Y_n -->^(cal(L)) -->^(cal(L)) c X \
              &= x/y #h(40pt) X_n/Y_n -->^(cal(L)) X/c
    $ 
]

== Consistance des estimateurs
#defn[
  $hat(theta)_n$ asymptotiquement sans biais si et seulement si
  $
  #math.op("Biais") (hat(theta)_n, theta) = E[hat(theta)_n] - theta -->_(n -> +infinity) 0
  $ 
]
#rmk[
  La convergence en proba n'implique pas la convergence des espérances.

  Si $X_n -->^P X$,  $|X_n| <= Y in L'$, alors par convergence dominée  $X_n --> X$ dans  $L_1$
]

#ex[
  $hat(tau)_n = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum X_i^2 - (overline(X))^2$ estimateur des moments de $tau^2 = E[X^2)] - (E[X])^2$
   $
  #math.op("Biais") (hat(tau)_n^2, tau^2) = - 1/n tau^2 " asymptotiqument sans biais"
  $ 
  Consistance de $hat(tau)_n^2$?

  Outils pour montrer la consistance:
  - LGN
  - si  $R(hat(theta)_n, theta) --> 0$ alors  $hat(theta)_n$ consistant  car convergence  $L^2 => $ convergence en probas
  - revenir à la définition de convergence en probas
  \ \ \ 
  - si  $(X_i)$ sont i.i.d., alors  $(X_i^2)$ est i.i.d.
     $
    E[X_i^2] < +infinity
    $ 
    LGN: $1/n sum_i X_i^2 -->^P E[X^2] = tau^2 - mu^2$ 
  - $overline(X) -->^P mu$ (LGN), LAC avec  $h(x) = x^2$: $(overline(X))^2 -->^P mu^2$
  - Donc  $mat(1/n sum_(i=1)^n X_i^2; 1/n sum X_i) -->^P mat(tau^2 - mu^2; mu)$
  - LAC  $h(x, y) = x - y^2$

  Donc  $1/n sum X_i^2 - (overline(X))^2 -->^P tau^2 + mu^2 - mu^2 = tau^2$
]

== Normalité asymptotique
$hat(theta)_n$ pour  $theta$. 

$->$ Question: quelle est la vitesse de convergence de  $hat(theta)_n$ vers  $theta$ ?

$(X_1, ..., X_n)$ i.i.d., d'espérance  $theta$,  $hat(theta) = overline(X)$ de variance  $tau^2(theta)$

#underline([TLC])  $sqrt(n)(overline(X) - theta) -->^(cal(L)) Z ~ cal(N)(0, tau^2(theta))$ #underline[quelle que soit la loi des $X_i$]

#defn[
  $hat(theta)_n$ est un estimateur #underline([asymptotiquement normal]) si et seulement si 
  - vitesse de convergence en  $sqrt(n)$
  - convergence en loi
  - loi limite est normale

   $
  sqrt(n) (hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, tau^2(theta))
  $ 
]

#ex[
  $hat(tau)_n^2$ est-elle asymptotiqument normale ?

   $(X_1, dots, X_n)$ i.i.d. d'espérance  $mu$, de variance $tau^2$

    $
   hat(tau)_n^2 = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n (X_i - mu)^2 + (overline(X) - mu)^2 + underbrace(2/n sum_(i=1)^n (X_i - mu)(mu - overline(X)), = 2(mu - overline(X))(overline(X) - mu))
   $ 

  - TLC: si $(X_i)$ i.i.d., alors les  $(X_i - mu)^2$ sont i.i.d. d'esperance  $tau^2$,
     $
    sqrt(n) (1/n sum_(i=1)^n (X_i - mu)^2 - tau^2) -->^(cal(L)) Z ~ cal(N) (0, u_4 - tau^4)
    $ 
    $
    Var(X_i - mu)^2 = E[(X_i - mu)^4] - mu^4 = mu_4 - tau^4
    $ 
  - TLC: $sqrt(n) (overline(X) - mu) -->^(cal(L)) cal(N)(0, tau^2)$ 
  - $sqrt(n) (hat(tau)_n^2 - tau^2) = sqrt(n) (1/n sum_i (X_i - mu)^2 - tau^2) - underbrace( sqrt(n)(overline(X) - mu)^2, sqrt(n) underbrace(( overline(X) - mu ), -->^(cal(L)) cal(N) (0, tau^2)) times underbrace( (overline(X) - mu), -->^(cal(L), P) 0 ))$ 
  $
  #math.cases([$overline(X) - mu -->^(cal(L)) 0$], [$sqrt(n) (overline(X) - mu) -->^(cal(L)) U ~ cal(N) (0, 1)$], reverse: true) ==>^("lemme de Slutsky") sqrt(n) (overline(X) - mu)^2 -->^(cal(L))_P 0
  $ 
  $
  sqrt(n) (hat(tau)_n^2 - tau^2) -->_(n -> +infinity)^(cal(L)) Z + 0
  $ 
  Donc $hat(tau)_n^2$ est un estimateur asymptotiqument normal
]

#rmk[
  $sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N)(0, tau^2) <==> (sqrt(n)(hat(theta)_n - theta))/tau -->^(cal(L))_(n -> +infinity) cal(N)(0, 1)$ 
  Application du lemme de Slutsky:  si $hat(tau)^2$ est un estimateur consistant de  $tau^2$, alors on a encore  
  $ (sqrt(n)(hat(theta)_n - theta))/(hat(tau)) -->^(cal(L)) cal(N) (0, 1) $
]
#proof[
  $
  (sqrt(n) (hat(theta) - theta))/(hat(tau)) = underbrace(( sqrt(n) ((hat(theta) - theta))/tau), -->^(cal(L)) Z ~ cal(N)(0, 1) ) times underbrace( ( tau/hat(tau) ), -->^P 1 ) \
  -->^(cal(L)) 1 times Z "par Slutsky et consistance de " hat(tau)
  $ 
]

== $delta$-méthode 
$hat(theta)$ estimateur asymptotiqument normal: quelle est la loi asymptotique de  $g(theta)$?

#lem(info: "méthode délta")[
  Soit $Z_n$ suite de variables aléatoires réelles t.q. 
   $
  sqrt(n) (Z_n - mu) -->^(cal(L)) Z ~ cal(N)(0, tau^2)
  $ 
  Soit $g$ une fonction dérivable, $g'(mu) != 0$. Sous ces hypothèses, on a 
  $ 
  sqrt(n)[ g(Z_n) - g(mu) ] -->_(n -> +infinity)^(cal(L)) tilde(Z) ~ cal(N)(0, (g'(mu))^2 tau^2)
  $
   $
  g(x) = g(mu) + g'(mu)(x - mu) + (x - mu) R (x - mu) " où " R(y) ->_(y->0) 0
  $ 
  $
  sqrt(n)( g(Z_n) - g(mu) ) = underbrace( g'(mu) underbrace( sqrt(n) (Z_n -
  mu), -->^(cal(L)) Z ~ cal(N)(0, tau^2) ), --> cal(N) (0, (g'(mu))^2 tau^2)) +
  underbrace( underbrace( (sqrt(n)) (Z_n - mu), -->^(cal(L)) cal(N) (0, tau^2)) underbrace( R (Z_n - mu), -->^P 0 ? ),  )
  $ 
  A-t-on $Z_n -->^P mu$ ?
   $
  P(|X_n - mu| > epsilon) &= P((sqrt(n)|Z_n - mu|)/tau > (sqrt(n) epsilon)/tau) \
  &= P((sqrt(n) (Z_n - mu))/tau > (sqrt(n) epsilon)/tau) + P( (sqrt(n) (Z_n - mu))/tau < - (sqrt(n) epsilon)/tau ) \
  &~= 1 - Phi_n ((sqrt(n) epsilon)/tau) + Phi_n (- (sqrt(n) epsilon)/tau) = 2(1 - Phi((sqrt(n) epsilon)/tau))
  $ 
]
