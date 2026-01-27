
#import "preamble.typ": *

= Estimateurs
== Cadre paramétrique
=== Modèle statistique paramétrique
On dispose d'une observation ($X_1, ..., X_n$), un échantillon de variable aléatoire i.i.d (indépendantes, identiquement distribuées) de loi commune $P$ appartenant à une famille de lois de probabilités paramétrée ${ P_(theta, theta in Theta subset RR^p) }$.

#rmk[
  Si $Theta subset$ espace de dimension infinie $arrow.r$ modèle non-paramétré.
]

Estimer $P$ c'est estimer $theta in RR^p$.

#ex[
  #Bern ($theta$), #Exp ($theta$), $cal(N)(mu, sigma^2)$, loi de densité $f_theta (x) = theta x^(theta - 1) 1_(x in [0, 1])$
]

#notation[
  $E_(theta_n)[h(X_1, ..., X_n)]$, $Theta [h(X_1, ..., X_n)]$ \
  Loi de $(X_1, ..., X_n) arrow.r P_theta^(times.o n)$ //times.o
]

#defn(info: "Estimateur")[
  $ hat(theta) = hat(theta)_n = h(X_1, ..., X_n) $
]

#defn(info: "Qualité")[
  - Risque
    $ R(hat(theta), theta) = E_theta [(hat(theta) - theta)^2] $
  - Consistance
    $ hat(theta)_n ->_(n -> +infinity)^P theta $
]

#defn(info: "Modèle identifiable")[
  $ theta -> P_theta quad "injective" $
]

== Méthode des moments
#defn[
  On appelle *moment théorique* de la loi de $X_i$ d'ordre $k$:
  $ mu_k = E[X_i^k], quad k >= 1 $
]

#defn[
  On appelle *moment empirique* de la loi des $X_i$ d'ordre $k$:
  $ hat(mu)_k = 1/n sum_(i=1)^n X_i^k $
]

Par la loi des grands nombres $hat(mu)_k -->_(n -> +infinity)^P mu_k$.

La méthode des moments: si on peut écrire $theta$ ou $g(theta)$ paramètre d'intérêt comme une fonction des $k$ premiers moments théoriques.
$ theta = cal(L)(mu_1, ..., mu_k) $
alors l'estimateur
$ hat(theta) = cal(L)(hat(mu)_1, ..., mu_k) $
est obtenu par la méthode.

#ex(info: "Des calculs des estimateurs en utilisant la méthode des moments")[
  - $X_i tilde Bern(theta)$ à valeurs 0-1,
    $ theta = P(X_i = 1) = E[X_i] arrow.r 1/n sum_(i=1)^n X_i = overline(X) $
  - $X_i tilde Exp(theta), \, f_theta (x) = theta e^(-theta x) 1_(x >= 0)$, $E[X] = 1/theta <==> theta = 1/mu_1$, par la méthode des moments,
    $ hat(theta) = 1/(hat(mu)_1) = 1/(overline(X)) $
    $
      Theta (X_i) = 1/theta^2 &<==> theta^2 = 1/(E[X_i^2] - E[X_i]^2) \
      &<==> theta = 1/(sqrt(mu_2 - mu_1^2)) \
      &==> hat(theta)_2 = 1/(sqrt(1/n sum_(i=1)^n X_i^2 - (overline(X))^2))
    $
  - $X_1, ..., X_n$ i.i.d. de la loi $P_theta$ de densité
    $ f_theta (x) = theta x^(theta - 1) 1_(x in [0, 1]) $
    $ E_theta [X_i] = theta integral_0^1 x^theta dif x = theta/(theta + 1) $
    Méthode des moments:
    $
      (theta + 1)mu_1 = theta &<==> theta(1 - mu_1) = mu_1 <==> theta = (E[X_i])/(1 - E[X_i]) \
      &==> hat(theta)_(MM) = (overline(X))/(1 - overline(X)), \, P_theta (overline(X) = 1) = P_theta (X_1 = X_2 = ... = X_n = 1) = 0
    $
]

== Rendu sur le L.A.C.
(L.A.C = lemme des applications continues)
$(X_n)_(n >= 1)$ suite de variables aléatoires. Si $X_n$ converge vers $X$, que peut-on dire de $g(X_n)_(n >= 1)$? Si $g$ continue, LAC.
- si $X_n -->^P X$ alors $g(X_n) -->^P g(X)$
- si $X_n -->^(cal(L)) X$ alors $g(X_n) -->^(cal(L)) g(X)$

#rmk(info: "Condition suffisante")[
  $ D_g = { "points de discontinuité de " g } $
  si $P(X in D_g) = 0$, le LAC est vrai.
]

#ex[
  $ g(x) = x/(1 - x) $
  - LGN: $overline(X) -->^P E[X]$
  - LAC: $g(overline(X)) = hat(theta)_n -->_(n -> +infinity)^P g(E[X]) = theta$
]

LAC pour des couples de suites de variables aléatoires:
- si $(X_n, Y_n) -->^P (X, Y)$, alors $g(X_n, Y_n) -->^P g(X, Y)$, si $g: RR^2 -> RR$ ou $RR^2$ continue
- si $(X_n, Y_n) -->^(cal(L)) (X, Y)$, alors $g(X_n, Y_n) -->^(cal(L)) g(X, Y)$

#ex[
  $ hat(theta)_2 = 1/(sqrt(1/n sum_(i=1)^n X_i^2 - (overline(X))^2)) quad "consistant?" $
  LGN:
  - $overline(X) -->^P mu_1$
  - $1/n sum_(i=1)^n X_i^2 -->^P mu_2$
  donc
  $ mat(overline(X); 1/n sum_(i=1)^n X_i^2) -->^P mat(mu_1; mu_2) $
  $g(x, y) = 1/(sqrt(y - x^2)) ==> hat(theta)^(MM)$ constant de $theta$, $g$ continue sauf en ${ (x, y) in RR^2, y = x^2 }$ de mesure nulle.

  Mais c'est faux pour une converge en loi.
]

#prop(info: "Convergence de couples")[
  $ vec(X_n, Y_n) -->^P vec(X, Y) text(" ssi ") cases(X_n -->^P X, Y_n -->^P Y) $
]

#proof[
  - $==>$ alors LAC $g(x, y) = x$ continue donc $X_n -> X$ et $Y_n -> Y$
  - $<==$ convergence du couple?
    $ forall epsilon > 0, P(|X_n - X| + |Y_n - Y| > epsilon) <= underbrace(P(|X_n - X| > epsilon/2), -> 0) + underbrace(P(|Y_n - Y| > epsilon/2), -> 0) $
    #underline[Cette réciproque est fausse pour la converge en loi!]
]

=== Variance empirique
Si la $X_i$ admettent une esperance $mu$ et une variance $sigma^2$, on appelle variance empirique
$
  hat(sigma)_n^2 &= 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n X_i^2 + 1/n sum_(i=1)^n overline(X)^2 - 2/n sum_(i=1)^n X_i overline(X) \
  &= 1/n sum_(i=1)^n X_i^2 + overline(X)^2 - 2 overline(X) overline(X) = tilde(sigma)^2
$
estimateur des moments:
$ sigma^2 = E[X_i^2] - E[X_i]^2 $
On remplace les moments théoriques par les moments empiriques
$ arrow.r tilde(sigma^2)^(MM) = 1/n sum_(i=1)^n X_i^2 - (overline(X))^2 $

Consistance:
$hat(sigma)^2 = 1/n sum_(i=1)^n X_i^2 - (overline(X))^2$,
$
  cases(overline(X) -->^P E[X], 1/n sum_(i=1)^n X_i^2 -->^P E[X^2])
  -->^("cv en proba")
  vec(overline(X), 1/n sum_(i=1)^n X_i^2)
  -->^("LAC") hat(sigma)^2 " consistant de " Var(X) = E[X^2] - E[X]^2
$

#ex[
  - calculer le biais de $hat(sigma)_n^2$
  - calculer le risque de $hat(sigma)_n^2$
]

== Méthode de maximum de vraisemblance
=== Modèle donné
$(P_theta)_(theta in Theta)$ est donné s'il existe une mesure $mu$ (positive $sigma$ définie $arrow.r$ $X_i$ à valeurs dans $E$, $E = union E_n$ avec $mu(E_n)$ finie) telle que $forall theta, P_theta$ admet une densité par rapport à $mu$.

=== En pratique
- soit $E$ au plus dénombrable: $mu$ = mesure de comptage. Si $exists \, { a_1, a_2, ... }$ tq $sum_(k >= 1) P_theta (X_i = a_k) = 1$, alors $mu = sum_(k >= 1) delta_(a_k)$ avec $delta_a ({a}) = 1$ mesure de dirac.
  #ex[
    #Bern ($theta$), $X_i = 1$, probas $theta -> mu = delta_0 + delta_1$
    On écrira
    $ f_theta (x) = underbrace(P_theta ({x}), = 1 - theta) - P_theta (X_i = x) " avec " x in {a_1, a_2, ... } $
  ]
- soit $E = RR^p$, alors $f_theta$ est la densité usuelle

$f_theta$ densité de $P_theta$

#defn[
  On appelle vraisemblance de l'échantillon $(X_1, ..., X_n)$ la fonction
  $ theta -> L_n (theta) = product_(i=1)^n f_theta (X_i) " (variable aléatoire)" $
]

#defn[
  Un estimateur du max de vraisemblance $hat(theta)_(M V)$ est définie par:
  $ forall theta in Theta, L_n (theta) <= L_n (hat(theta)) $
]

On travaille souvent avec la *log-vraisemblance*
$ log L_n (theta) = sum_(i=1)^n ln f_theta (X_i) " somme de variables aléatoires" $
$ log L_n (hat(theta)) = sup_(theta in Theta) log L_n (theta) $

#rmk[
  $hat(theta)$ est une variable aléatoire
  #import "figures/remarque-max-vraisemblance.typ":diagram as remarque-max-vraisemblance
  #remarque-max-vraisemblance(width: 400pt)
  // Image placeholder: \incfig{remarque-max-vraisemblance-1}
  // #figure(
  //   caption: "remarque-max-vraisemblance-1"
  // ) <fig:remarque-max-vraisemblance-1>
]

#ex[
  - $Bern(theta)$, $f_theta (x) = theta^x (1 - theta)^(1 - x)$, $X_i$ à valeurs 0-1
    $ L_n (theta) = product_(i=1)^n theta^(X_i) (1 - theta)^(1 - X_i) = theta^(sum_(i=1)^n X_i) (1 - theta)^(n - sum_(i=1)^n X_i) $
    $ log L_n (theta) = (sum_(i=1)^n X_i) ln theta + (n - sum_(i=1)^n X_i) ln(1 - theta) $
    $ (log L_n)'(theta) = (sum_(i=1)^n X_i)/theta - (n - sum_(i=1)^n X_i)/(1 - theta) = (sum_(i=1)^n X_i - n theta)/(theta(1 - theta)) (overline(X) - theta) $
    Equation de vraisemblance:
    $
      (log L_n)'(theta) = 0 &<==> (1 - theta) sum_(i=1)^n X_i = (n - sum_(i=1)^n X_i)theta \
      &<==> sum_(i=1)^n X_i = n theta ==> theta = (sum_(i=1)^n X_i)/n
    $
    le point critique, est-il un maximum?
    - La dérivée change de signe en $overline(X)$ $arrow.r$ on a bien un max $arrow.r$ $hat(theta)^(M V) = overline(X)$
    - Condition du 2nd ordre, si $(log L_n)'' (theta) < 0$ pour tout $theta$ $==>$ $log L_n$ est concave $==>$ max global
    $ (log L_n)'' (theta) = - (sum_(i=1)^n X_i)/theta^2 - (n - sum_(i=1)^n X_i)/(1 - theta)^2 < 0, \, forall theta $
]
