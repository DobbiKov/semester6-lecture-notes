#import "preamble.typ": *

= Fonction de répartition empirique
$(X_1, ..., X_n)$ échantillon i.i.d. à valeurs réelles de loi  $F$ inconnue.
 $
forall x in RR, F(x) = P(X_1 <= x) = E[bb(1)_(X_1 <= x)]
$ 

#defn[
  La fonction de répartition #underline[empirique] associée à $(X_1, ..., X_n)$ est définie par:
   $
  hat(F)_n: RR &--> [0, 1] \
            x &|-> 1/n sum_(i=1)^n bb(1)_(X_i <= x)
  $ 
  $forall x in RR, hat(F)_n (x)$ est une variable aléatoire, estimateur de $F(x)$. 
]

#defn[
  Loi empirique $P_n = 1/n sum_(i=1)^n delta_X_i$ est une loi discrète uniforme sur ${X_1, ..., X_n}$.
]

Représentation graphique

Conditionnelement $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$

 $
x_((1)) <= x_((2)) <= ... <= x_((n)) " valeurs ordonnées"
$ 

#import "figures/repr-graphique-repartition-empirique.typ":diagram as repr-graphique-repartition-empirique
#repr-graphique-repartition-empirique(width: 400pt)
fdsa

#prop(info: "Propriétés immédiats")[
  - $n hat(F)_n (x) = sum_(i=1)^n bb(1)_(X_i <= x)$ suit la loi binomiale$(n, F(x))$ 
  - $R(hat(F)_n (x), F(x)) = 0 + 1/(n^2) Var(sum_(i=1)^n bb(1)_(X_i <= x)) underbrace(=, "indep") 1/n F(x) (1 - F(x)) -->_(n -> +infinity) 0$
    donc  $forall x in RR, hat(F)_n (x) -->^P F(x)$
  - ou bien #underline[LGN]:  $hat(F)_n (x)$ estimateur #underline[consistant] de  $F(x)$.
  - On a un résultat de convergence uniforme :
     $
    sup_(x in RR) |hat(F)_n (x) - F(x)| -->_(n -> +infinity)^P 0 " (Théorème de Glivenko-Cantelli)"
    $ 
    .#footnote[Thm de Glivenko-Cantelli: #link("https://fr.wikipedia.org/wiki/Th%C3%A9or%C3%A8me_de_Glivenko-Cantelli")]
  - $hat(F)_n (x)$ est-il asymptotiqument normal?
    
     $
    hat(F)_n (x) = 1/n sum_(i=1)^n bb(1)_(X_i <= x)
    $ 
    TLC: les $X_i$ sont i.i.d., donc les  ${bb(1)_(X_i <= x) = Y_i}$ sont i.i.d.
     $
    forall x, F(x) in ]0, 1[, #h(1em) sqrt(n)(hat(F)_n (x) - F(x)) -->^(cal(L))_(n -> +infinity) cal(N)(0, F(x)(1 - F(x)))
    $ 
    $
    <==> (hat(F)_n (x) - F(x))/(sqrt((F(x)(1 - F(x)))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
    $ 
]

== Estimation empirique
"plug-in" ou méthode de substitution, paramètre d'intérêt  $theta = c(F)$, la
méthode empirique définit  $hat(theta)$, estimateur impirique en remplaçant
$F$ par  $hat(F)_n -> hat(theta)_n = c(hat(F)_n)$.

#ex[
  $theta = E_F (X) -> hat(theta)_n = E_(hat(F)_n)(X) = sum_(i=1)^n X_i times 1/n = overline(X)$ si $X_i$ distinctes

   $
  theta = Var_F (X) -> hat(theta)_n = Var_(hat(F)_n)(X) = 1/n sum (X_i - overline(X))^2
  $ 
]

== Inverse généralisé
#defn[
  On définit l'inverse généralisé de $F$ par:
   $
  F^(-1): [0, 1] --> RR
  $ 
  $
  forall alpha in [0, 1], F^(-1)(alpha) = inf{x in RR, F(x) >= alpha}
  $ 
  Si $F$ est strictement croissante,  $inf x$ tel que  $F(x) >= a <=> x >= F^(-1) (alpha)$, si  $F$ est la fonction d'une loi discrète.

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

Vocab: 
- $F^(-1)$ s'appelle aussi la #underline[fonction quantile]
-  $F^(-1) (alpha) = $ quantile d'ordre  $alpha$, de la loi  $F$
-  $F^(-1) (1/4) = $ 1er quantile
-  $F^(-1)(1/2) = $ médiane
-  $F^(-1) (3/4) = $ 3eme quantile

#lem[
  $U$ variable aléatoire sur $[0, 1]$,  $F$ f.r., alors  $F^(-1)(U)$ est une variable aléatoire de loi  $F$
] 
- Si $F$ bijective: 
 $
P(F^(-1)(U) <= x) underbrace(=, F "bijective") P(U <= F(x)) underbrace(=, "car" P(U <= x) = x "sur" [0, 1]) F(x)
$ 
- Si $F$ discrète: $F^(-1)$ inverse généralisé:  $F^(-1)(y) <= x <=> y <= F(x)$

== Quantile empirique

#defn[
  On définit le #underline[quantile empirique] (sampe quantile) d'ordre
  $alpha$, comme étant le quantile de  $hat(F)_n$: 
  $
  hat(q)_(n, alpha) = hat(F)_n^(-1)(alpha) = inf{x, hat(F)_n (x) >= alpha}
  $ 
] 

#prop[
  - On peut montrer que $hat(q)_(n, alpha) = X_(([n alpha]))$ où  $X_((1)) <=
    X_((2)) <= ... <= X_((n))$ est l'echantillon ordoné des  $(X_i)_(1 <= i <
    n)$
    $
    [u] = "le plus petit entier" >= u
    $ 
]
#ex[
  $alpha = 1/2$,  $[n/2]$,
   $
  cases(
    "si" n=2k #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k)),
    "si" n=2k+1 #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k+1)))
  $ 
  - Consistance
    
    si $alpha in ]0,1[$, si  $F$ est strictement croissante au voisinage de  $alpha$
]

= Intervalles de confiance
== Définitions
$(X_1, ..., X_n)$ i.i.d. de loi  $P in {P_theta, theta in Theta subset RR^p}$,
on s'interesse à  $theta in RR$ ou  $g(theta): RR^p --> RR$. 

Un intervalle de confiance pour $theta$, de niveau de confiance  $1 - alpha,
alpha in ]0, 1[$ est un intervalle dont les bornes sont #underline[aléatoires],
fonctions de l'échantillon et ne dépend PAS des paramètres inconnus du modèle et tel que
 $
 P([B inf (X_1, ..., X_n); B sup (X_1, ..., X_n)] in.rev theta) >= 1 - alpha
$ 
#footnote[$B inf$ pour borne inférieure et $B sup$ pour borne supérieure]
- Un IC est calculable à partir des données 
- si l'inégalité est une égalité $=$ niveau de confiance est  #underline[exact].
- si on a $P(theta in [B inf, B sup]) -->_(n -> +infinity) 1 - alpha$, niveau est #underline[asymptotique].
- en général  $alpha = 1%, 5%$

== Interprétation
// fig 1 here
 $I C = [B inf(X_1, ..., X_n), B sup(X_1, ..., X_n)]$ formule mathématique qui g´arantit le niveau  $1 - alpha$.
 On observe  $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$, une réalisation de l'échantillon aléatoire. On calcule 
 $I C = [2.3; 5.1]$ de niveau de confiance $95%$ ($alpha = 5%$).

 En moyenne, sur 100 intervalles calculés (avec la même formule), il y a 5
 intervalles qui ne contiennent pas $theta$. 

 $
 P(theta in [B inf, B sup]) = 1 - alpha
 $ 
 $
 cancel(P(theta in [2.3, 5.1]) = 95%) "car " theta "un nombre"
 $ 

