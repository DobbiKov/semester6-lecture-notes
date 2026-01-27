
#import "preamble.typ": *

= Information de Fisher, efficacité

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
  script(T=T(X_1)) <=>& partial/(partial theta) int_S T(x) f_theta (x) d x = g'(theta) \
  script((H)) <=>& int_S T(x) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g' (theta) \
  <=>& int_S (T(x) - g(theta)) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g'(theta)
  $ 
]
Inégalité de Cauchy-Schwarz pour $angle.l h_1, h_2 angle.r = int h_1(x) h_2(x) f_theta (x) d x$ avec  $h_1(X)$ et  $h_2(X)$ centrées

 $
( angle.l T(X) - g(theta), (partial/(partial theta) f_theta (x))/(f_theta (x)) angle.r_theta )^2 = (g'(theta))^2 underbrace(=, "c.s") underbrace(int (T(x) - g(theta))^2 f_theta (x) d x, = op("Var")_theta (T)) times underbrace(int ((partial/(partial theta) f_theta (x))/(f_theta (x)))^2 f_theta (x) d x, = I(theta))
$ 

#defn[
  Si $T$ réalise l'égalité, alors  $T$ est dit *efficace*.
]
