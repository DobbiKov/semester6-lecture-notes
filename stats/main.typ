// #import "@preview/lemmify:0.1.8": *
#import "@local/dobbikov:1.0.0": *

#show: dobbikov.with(
  title: [Notes de Cours d'Inférence Statistique],
  author: "Yehor KOROTENKO",
  date: datetime.today(),
  report-style: false
)
#set text(font: "New Computer Modern")

// #let (notation, rules) = new-theorems("group-id", (
//   "notation": "Notation"
// ))

// 2. Apply the rules to the document
// #show: rules



#set heading(numbering: "1.1.1.1.1")

#let argmax = math.op("argmax", limits: true)
#let Bern = math.op("Bernoulli")
#let Exp = math.op("Exp")
#let Var = math.op("Var")

// --- Document Content ---

= Lecture 2

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
  Loi de $(X_1, ..., X_n) arrow.r P_theta^(times.big n)$ //times.o
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
  #remarque-max-vraisemblance(width: 400pt),
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

= Lecture 3: Information de Fisher, efficacité

Soit $(P_theta)_(theta in Theta)$, $Theta subset RR^p$ (identifiable, donnée). On note $f_theta$ densité de $P_theta$
$ op("Supp") f_theta = { x in E, \, f_theta(x) > 0 } $

Étant donné $(X_1, ..., X_n)$, i.i.d. de loi $P_theta$ et $theta mapsto L(theta) = product_(i=1)^n f_theta(X_i)$ la vraisemblance de l'échantillon. Sur $op("Supp") f_theta$ on peut calculer
$ log L_n(theta) = sum_(i=1)^n log f_theta(X_i) $
$ hat(theta) = op("argmax")_(theta in Theta) log L_n(theta) $

// #prop(name: "propriété de l'EMV")[
//   Si $hat(theta)$ EMV#footnote[*EMV* = *E*stimateur de *M*aximum de *V* raisemblance] de $theta$, $g(hat(theta))$ est un EMV de $g(theta)$
// ]
#prop[
  Si $hat(theta)$ EMV#footnote[*EMV* = Estimateur de Maximum de Vraisemblance] de $theta$, $g(hat(theta))$ est un EMV de $g(theta)$
]

Objectif: que peut-on avoir de "mieux" comme estimateur?
$-->$ modèle régulier

== Modèle régulier

#defn[
  Le modèle $(P_(theta))_(theta in Theta)$ est dit régulier si
  1.  $Theta$ est un ouvert et  $theta |-> f_theta(x)$ est  $C^1$
  2. $op("Supp") f_theta$ ne dépend pas de  $theta$:  $S = { x, #h(0.4em)f_theta(x) >0}$
  3. Pour tout $theta$, l'application 
   $
  x |-> ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0)
  $ 
  est intégrable $(L, mu)$ et l'intégrale 
   $
  I(theta) = int_S ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0) d x
  $ 
  est continue sur $Theta$.
]

#notation[
  On note la dérivée de $f_theta(x)$ par rapport à  $theta$:  $(partial f_theta)/(partial theta)(x)$
  La quantité  $I(theta)$ est appelée *Information de Fisher du modèle*.
]

#ex[
  - $f_theta(x) = theta e^(-x theta)$ densité par rapport à  $mu(d x) = bb(1)_(x >= 0) d x$

   $theta |-> theta e^(-x theta)$ est $C^(infinity)$ sur  $Theta = ]0, +infinity[$,  $op("Supp") f_theta = RR_+$

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
   continue sur $]0, +infinity[$
] 

#ex[
  $op("Bernoulli")(theta)$, $x = 0.1$,  $f_theta(0) = 1 - theta$,  $f_theta(1) = theta$, densité par rapport à  $delta_0 + delta_1$


  Pour tout  $x in { 0, 1}$,  $theta |-> f_theta(x)$ est  $C^1$ 
  $
  (( (partial f_theta(0))/(partial theta) )^2)/(f_theta(0)) = 1/(1 - theta)
  $ 
  $
  (( (partial f_theta(1))/(partial theta) )^2)/(f_theta(1)) = 1/(theta) => I(theta) = 1/(1 - theta) + 1/(theta) = 1/(theta (1 - theta))
  $ 
  continue sur $]0, 1[$
  
]

#ex[
  $f_theta(x) = 1/theta bb(1)_[0, theta] (x) = 1/theta bb(1)_[x, +infinity[ (theta)$ modèle non régulier
]

== Score et Information de Fisher
$(X_1, ..., X_n)$ i.i.d de loi de  $P_theta, #h(0.3em) f_theta$

#defn[
  On appelle *score* ou *vecteur de score* la dérivée de la log vraisemblance $partial/(partial theta) log L_n(theta) = S_n(theta) = sum_(i=1)^n partial/(partial theta) log f_theta (X_i)$
] 

#ex[
  $X_i ~  cal(E)(theta)$, $L_n(theta) = theta^n e^(-theta sum_i X_i)$,  $log L_n (theta) = n log theta - theta sum_i X_i$, donc  $S-n(theta) = n/theta - sum_(i=1)^n X-i$
]

#rmk[
  $
  E(S_n (theta)) = E[ n(1/theta - (sum X_i)/n)]
  $ 
]

Hyp supplémentaire de régularité:
$(H)$ pour tout estimateur  $h(X)$ et tout $theta$, les intégrales suivantes existent et sont égales:
 $
partial/(partial theta) int_S h(x) f_theta (x) d x = int_S h(x) ( partial f_theta)/(partial theta) (x) d x
$ 
#rmk[
  condition d'application du thm de dérivation de Lebesgue.

  $
  h sup_(tilde(theta) in V_theta) |(partial f_theta)/(partial theta) (x)| in L_1 (mu)
  $ 
] 

#prop[
  Sous $(H)$, le score est centré  $(P_theta)$,  $n=1$

   $
  E_theta [partial/(partial theta) log L_1(theta)] = int_S partial/(partial
  theta) log f_theta (x) d x = int_S ( partial/(partial theta) f_theta(x)
)/cancel(f_theta (x)) cancel(f_theta (x)) d x = int_S (partial
f_theta)/(partial theta) (x) d x underbrace(=, (H)) partial/(partial theta)
overbracket(int f_theta (x) d x, = 1) = 0
  $ 
]

#defn[
  L'information de Fisher associé à $(X_1, dots, X_n)$ 
   $
  I_n (theta) underbrace(=, "def") E_theta [ (partial/(partial theta) log L_n(theta))^2] overbrace(=, "cor. de la prop 1") = op("Var")_theta [(partial log L_n (theta))/(partial theta)]
  $ 

  $
  (*) E_theta [ partial/(partial theta) log f_theta (X_1)]^2 = int_S ( (partial/(partial theta) f_theta (x))/(f_theta (x)) )^2 f_theta (x) d x = int_S ((partial/(partial theta) f_theta (x))^2)/(f_theta (x)) = "\"expression de la definition 1\""
  $ 
]

#ex[
  $(X_1, ..., X_n) ~  cal(E)(theta)$, $partial/(partial theta) log L_n (theta) = n/theta - sum_(i=1)^n X_i$
   $
  I_n (theta) = E( (n/theta - sum X_i)^2) = n^2 E[(1/theta - (sum X_i)/n)^2] = n^2 op("Var")(overline(X)) = n^2 1/n 1/(theta^2) = n/(theta^2)
  $ 
]

#prop[
  $
  I_n (theta) = n I(theta)
  $
  en effet,
  $
  I_n (theta) = op("Var")(partial/(partial theta) log L_n (theta)) = op("Var") (sum_(i=1)^n partial/(partial theta) log f_theta (X_i)) underbrace(=, "independance") = sum_(i=1)^n op("Var")(partial/(partial theta) log f_theta (X_i)) = \
  = n underbrace(op("Var")(partial/(partial theta) log f_theta (X_1))) = n I (theta)
  $ 
]

#ex[
  $(X_1, ..., X_n)$ i.i.d  $cal(P)(theta)$,  $f_theta (x) = e^(- theta)(theta^x)/(x!)$
   $
  log L_n (theta) = -n theta + (sum X_i) log theta - log product_(i=1)^n X_i !
  $ 
  $
  partial/(partial theta) log L_n (theta) = -n + (sum X_i)/theta => I_n (theta) = op("Var")((sum X_i)/theta) = 1/(theta^2) n theta = n/theta
  $ 
]

== Inp. de Fisher et derivé seconde
#prop[
  En ajoutant que $theta |-> f_theta (x)$ est  $C^2$ et que  $(H)$ vrai pour  $(theta^2)/(partial theta^2)$ alors l'info de Fisher s'écrit encore 
   $
  I_n (theta) = -E_theta [ (partial^2 log L_n (theta))/(partial theta^2) ]
  $ 
  si $hat(theta)$ EMV,  $I_n(hat(theta)) > 0$

  $n=1$
  
   $(partial^2)/(partial theta^2) log f_theta (x) = (( (partial^2 f_theta (x))/(partial theta^2) )^2)/(f_theta (x)) - (( (partial f_theta)/(partial theta)(x) )^2)/(f_theta^2 (x))$ 

    $
   E[ (partial^2)/(partial theta^2) log f_theta (X_1)] = int_S ((partial^2 f_theta(x))/(partial theta^2))/(cancel(f_theta (x))) cancel(f_theta (x)) d x - underbrace(int_S (( (partial f_theta (x))/partial theta )^2)/(f_theta^2 (x)) d x, I (theta))
   $ 
]

#import "figures/visual-example-for-info-fisher.typ":diagram as visual-example-for-info-fisher
#visual-example-for-info-fisher(width: 400pt)

Si courbe très "piqué" en l'EMV (i.e. info. Fisher est grande) alors l'EMV est localisé de façon précise

== Inégalité de Cramer - Rao
Soit $g(theta)$ le paramètre d'intérêt où  $g: Theta -> RR$

#prop[
  Sous les hypothèses d'un modèle régulier, si pour tout $theta$,  $I(theta) > 0$, alors pour tout estimateur  $T = T(X_1, ..., X_n)$ #underline("sans biais"),  $E_theta T^2 < +infinity$, on a
   $
  forall theta in Theta, underbracket( op("Var")_theta (T) >= ((g'(theta)^2))/(I_n (theta)) ) = ((g'(theta))^2)/(n I(theta))
  $ 
] 
#proof[
  $
  &forall theta #h(0.5em) E_theta(T) = g(theta) \
  =>& partial/(partial theta) E_theta (T) = g'(theta) \
  underbrace(<=>, T=T(X_1))& partial/(partial theta) int_S T(x) f_theta (x) d x = g'(theta) \
  underbrace(<=>, (H))& int_S T(x) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g' (theta) \
  <=>& int_S (T(x) - g(theta)) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g'(theta)
  $ 
]
Inégalité de Cauchy-Schwarz pour $angle.l h_1, h_2 angle.r = int h_1(x) h_2(x) f_theta (x) d x$ avec  $h_1(X)$ et  $h_2(X)$ centrées

 $
( angle.l T(X) - g(theta), (partial/(partial theta) f_theta (x))/(f_theta (x)) angle.r_theta )^2 = (g'(theta))^2 underbrace(=, "c.s") underbrace(int (T(x) - g(theta))^2 f_theta (x) d x, = op("Var")_theta (T)) times underbrace(int ((partial/(partial theta) f_theta (x))/(f_theta (x)))^2 f_theta (x) d x, = I(theta))
$ 

#defn(info: [huy])[
  Si $T$ réalise l'égalité, alors  $T$ est dit *efficace*.
]
#defn[
  fdsa
  fdas, pen, fdas
  Si $T$ réalise l'égalité, alors  $T$ est dit *efficace*.
]
#thm(info: "huy")[#lorem(60)]
#proof[ h fdsa, fdsa, fdasfdas]

fdsafdas
fdsa
