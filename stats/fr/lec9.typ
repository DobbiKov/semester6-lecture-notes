#import "preamble.typ": *

= Tests d'hypothèse (sur un paramètre)

== Formalisme d'un test
=== Introduction

#defn(info: "test statistique")[
  Un test d'hypothèse est une fonction (mesurable) de l'échantillon $(X_1, ..., X_n)$ à valeurs dans  ${0, 1}$.
  - $H_0$ est acceptée si  $phi(X_1, ..., X_n) = 0$
  - $H_0$ est rejetée si $phi(X_1, ..., X_n) = 1$

  Le domaine ${(X_1, ..., X_n), #h(6pt) phi(X_1, ..., X_n) = 1} =: cal(R)$ est
  la région de rejet du test, $cal(R)^c$ est la région d'acceptation. On peut
  écrire: $phi(X_1, ..., X_n) = bb(1)_(cal(R)) (X_1, ..., X_n)$
]<def:statistique-de-test>

Très souvent, $cal(R)$ est construite à partir de $T = T(X_1, ..., X_n)$
statistique de test @def:statistique-de-test, elle-même basée sur un estimateur
$hat(theta)_n$ de  $theta$, paramètre d'intérêt.

$arrow.curve$ La question est: comment construire $cal(R)$?

=== Risques d'erreur d'un test

Risque de $1^"ere"$ espèce.


De manière générale, on testera  
$
&H_0 ": "  theta = a_(a in Theta) "contre"  H_1 ":"  theta != a \
&H_0 ": "  theta <= a "contre" H_1: theta > a "(ex: contrôle de qualité)"
$ 
Si on considère une partition $Theta_0 union Theta_1 = Theta_("espace des paramètres")$,  $Theta_0 inter Theta_1 = emptyset$, alors hypothèses sont:
   $H_0$: $theta in Theta_0$ contre  $H_1$:  $theta in Theta_1$

#rmk(info: "Vocabulaire")[
- Test bilatère
  -  $Theta_0 = {a}$  $H_0$ est une hypothèse simple.
  -  $Theta_1 = Theta without {a}$,  $H_1$ est une hypothèse bilatère 
- Test unilatère
  -  si $Theta_0 = ]- infinity, a]$ et $Theta_1 = ]a, +infinity[$  $H_1$ et  $H_0$ sont unilatères

 $H_0 = theta = a$ contre $H_0$:  $theta > a$  $-->$ Test unilatère
 ]

#defn(info: [erreur de $1^"ere"$ espèce])[
-- celle que l'on veut contrôler
 $
alpha: Theta_0 &--> [0, 1] \
       theta &|-> &P_theta ((X_1, ..., X_n) in cal(R)) = E_theta [ phi(X) ] &\
       & &= P_(H_0 \ "vrai") ("rejet de " H_0) &
$ 

- niveau $alpha$ ssi 
 $
sup_(theta in Theta_0) P_theta ((X_1, ..., X_n) in cal(R)) "op" alpha
$ 
où pour  $
"op" = cases(
  <= "pour lois discrètes",
  = "pour lois continues exactes",
  --> "pour lois asymptotiques"
)
$ 
]

#defn(info: [erreur de $2^"nde"$ espèce])[
 $
beta: Theta_1 &--> [0, 1]\
       theta &|-> P_theta ((X_1, ..., X_n) in cal(R)^c) = P_(H_1 \ "vrai") ("conserver " H_0)
$ 
]

#defn(info: [Fonctions de puissance])[
$
Pi: Theta &--> [0, 1]\
    theta &|-> P_theta ( (X_1, ..., X_n) in cal(R) )
$ 
- si $theta in Theta_0$:  $Pi(theta) = alpha (theta)$
- si $theta in Theta_1$:  $Pi(theta) = P_theta ((X_1, ..., X_n) in cal(R)) = 1 - P_(H_1)( (X_1, ..., X_n) in cal(R)^c ) = 1 - beta (theta)$ 
]

== Exemple 
$(X_1, ..., X_n)$ i.i.d. de loi  $cal(N) (theta, 1)$. Hypothèses à tester:
 $
H_0 ": " theta <= 0 " contre " H_1 ": " theta > 0
$ 
Comme $E[X_i] =: theta$ est inconnue, on l'estime avec  $hat(theta) = overline(X)$.
1. Première idée: rejet de  $H_0$ si  $hat(theta) > 0$
$
  cal(R) = {(X_1, ..., X_n), hat(theta)(X_1, ..., X_n) > 0}
$ 

Soit $theta <= 0$, 
 $
alpha(theta) = P_theta (hat(theta) > 0) = P_theta (overline(X) > 0)
$ 
Quelle est la loi de $overline(X)$?

 $overline(X) ~_("loi" \ "exacte") cal(N) ()$ car toute combinaison linéaire de variables aléatoires gaussiennes est une gaussienne.

  $E[overline(X)] = E[X_i] = theta$,  $Var(overline(X)) = 1/n Var(X_i) = 1/n$

  _reflexe_: _centrer et réduire la loi normale_:
   $
  alpha(theta) = P_theta ((overline(X) - theta)/(sqrt(1/n)) > - sqrt(n) theta) = P(cal(N) (0, 1) > - sqrt(n) theta) = 1 - Phi(- sqrt(n) theta) = Phi(sqrt(n) theta)
  $ 

Où $Phi$ est une fonction de répartition de la loi  $cal(N) (0, 1)$

#let custom_phi(x) = {
  let pi = 3.14159265358979
  let coeff = 1.0 / calc.sqrt(2.0 * pi)
  let x2 = x * x
  coeff * calc.exp(x2 / (-2.0))
}

#let cutoff = 1.2

#align(center)[
#canvas({
  plot.plot(
    size: (8, 4),
    x-min: -4, x-max: 4,
    y-min: 0, y-max: 0.45,
    x-label: $x$,
    y-label: $phi(x)$,
    axis-style: "school-book",
    {
      // Shaded CDF area
      plot.add(
        domain: (-4, cutoff),
        samples: 200,
        custom_phi,
        fill: true,
        fill-type: "axis",
        style: (fill: rgb(100, 149, 237, 120), stroke: none),
      )

      // Normal curve
      plot.add(
        domain: (-4, 4),
        samples: 200,
        custom_phi,
        style: (stroke: rgb(30, 80, 200) + 2pt),
      )

      // Vertical line at cutoff
      plot.add(
        ((cutoff, 0), (cutoff, custom_phi(cutoff))),
        style: (stroke: (paint: red, thickness: 1.5pt, dash: "dashed")),
      )

      // Annotation label
      plot.annotate({
        draw.content(
          (cutoff, -0.03),
          anchor: "north",
          text(size: 10pt, fill: red)[$sqrt(n) hat(theta)$]
        )
        draw.content(
          ((cutoff + -4) / 2, custom_phi((cutoff + -4) / 2) / 2.5),
          text(size: 9pt, fill: rgb(30, 60, 180))[$Phi(sqrt(n) hat(theta))$]
        )
      })
    }
  )
})
]

$
"niveau" = sup_(theta <= 0) Phi(sqrt(n) theta) = Phi(0) = 1/2 = 50%
$ 
Alors, on a une chance sur 2 de se tromper -- ce qui n'est pas acceptable !

$-->$ on souhaite  $alpha$ petit:  $alpha = 5%$:
- $cal(R) = {hat(theta) > 0}$  $-->$  $cal(R) = {hat(theta) > c}$ ($c > 0$) 
- valeur de $c = c(alpha)$ telle que  $sup_(theta <= 0) alpha(theta) <= alpha$

$
alpha(theta) &= P_(theta <= 0) (overline(X) > c) = P_(theta <= 0) ((overline(X) - theta)/sqrt(1/n) > (c - theta)/sqrt(1/n))\
             &= P(cal(N) (0, 1) > sqrt(n) (c - theta))
$ 

#underline[Condition de niveau]:

Trouver $c$ telle que  
$
    &sup_(theta <= 0) P( cal(N) (0, 1) > sqrt(n) (c - theta)) =_("loi" \ "continue") alpha \
<=> &P(cal(N) (0, 1) > sqrt(n) c) = alpha \
<=> &1 - Phi(sqrt(n) c) \
<=> &Phi(sqrt(n) c) = 1 - alpha \
<=> &sqrt(n) c = Phi^(-1) (1 - alpha) => c_alpha = 1/sqrt(n) #math.op("qnorm")_(1-alpha)
$ 

On a construit un test de niveau $alpha$ avec 
$
cal(R) = { (X_1, ..., X_n),  overline(X) > (#math.op("qnorm")_(1 - alpha))/sqrt(n)}
$ 

#underline[application numérique]:
$alpha = 5% => #math.op("qnorm")_(1 - alpha) = 1.645, n = 100 -> c_alpha = 0.1645$
 
expérience $->$  $overline(X)^"obs" = $ réalisation de $overline(X)$ sur mes données
- si  $overline(X)^"obs" = 0.1 < c_alpha$ on ne rejette pas  $H_0$
- si  $overline(X)^"obs" = 0.3 > c_alpha => $ rejet de  $H_0$

== Construction d'un test
1. 
  - Définire les hypothèse  $H_0$ et  $H_1$
  - Identifier le paramtètre d'intérêt 
2. 
  - définir la forme de $cal(R)$, forme de  $H_1$  $=>$ forme de  $cal(R) = {T > c}$ ou bien  ${T < c}$ 
  - trouver une statistique de test
  - $T = $ version normalisée de  
  $
  hat(theta) = (hat(theta) - theta)/sqrt(Var(hat(theta)))
  $
3. Trouver le seuil  $c$ pour voir un test de niveau  $alpha$

