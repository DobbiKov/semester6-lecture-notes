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
