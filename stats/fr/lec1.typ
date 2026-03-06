
#import "preamble.typ": *

= Introduction
== Evaluation
- $0.4$ CC $+ 0.6$ Examen.
- Répartition : $80\%$ partiel, $20\%$ Interro (prévue le 26/01).

== Modèle Statistique

#defn(info: "Modèle Statistique")[
  Un modèle statistique est un espace de probabilité $(Omega, cal(A), cal(P))$ où $cal(P)$ est une famille de lois de probabilité ${P_theta; theta in Theta}$.
]

- Si $exists p in NN^*, Theta subset RR^p$ : modèle paramétrique.
- Sinon : modèle non paramétrique.

#ex(info: "Familles de lois")[
  - Lois de Poisson : $cal(P) = {P(lambda); lambda > 0}$.
  - Densité régulière : $cal(P) = {PP; PP " dont la densité admet une dérivée seconde bornée"}$.
]

#defn(info: "Observation")[
  Une observation est une variable aléatoire (v.a.) dont la loi appartient à ${P_theta, theta in Theta}$.
  Notre observation aura une structure de $n$-échantillons $X_1, ..., X_n$ i.i.d. (indépendants et identiquement distribués) de loi commune $in {P_theta, theta in Theta}$.
]

#rmk[
  $(X_1, ..., X_n)$ est de loi $P_theta^(times.o n)$. L'échantillon contient toute l'information sur $P_theta$, donc sur $theta$. //times.o
]

#defn(info: "Identifiabilité")[
  Un modèle est identifiable si et seulement si (ssi) l'application $theta mapsto P_theta$ est injective.
]

== Estimateurs

*Hypothèse :* On observe $X_1, ..., X_n$ i.i.d. de loi commune $in {P_theta, theta in Theta subset RR^p}$ (modèle paramétrique identifiable). Soit $theta^*$ la vraie valeur inconnue telle que $P_(X_i) = P_(theta^*)$.

#defn(info: "Estimateur")[
  Un estimateur de $theta$ est une fonction de l'échantillon $(X_1, ..., X_n)$ mesurable et indépendante de $theta$ (calculable à partir des données).
]

*Notation :* $hat(theta) = hat(theta)_n = h(X_1, ..., X_n)$. C'est une variable aléatoire. \
Exemples : $hat(theta) = overline(X)$, $hat(theta) = X_1 - X_3$, etc.

Questions fondamentales :
+ Comment définir un bon estimateur ?
+ Comment construire un bon estimateur ?

== Risque quadratique

*Idée :* En moyenne, $hat(theta)$ doit être proche de $theta$. On regarde $EE[hat(theta) - theta]$.

#defn(info: "Biais")[
  Le biais de $hat(theta)$ est défini par :
  $ B(hat(theta), theta) = EE[hat(theta)] - theta $
  On dit que $hat(theta)$ est *sans biais* si $B(hat(theta), theta) = 0$.
]

#defn(info: "Risque quadratique / MSE")[
  $ R(hat(theta), theta) = EE[(hat(theta) - theta)^2] $
  C'est la *Mean Squared Error (MSE)* en anglais.
]

On dit que $hat(theta)_1$ est meilleur que $hat(theta)_2$ ssi $R(hat(theta)_1, theta) <= R(hat(theta)_2, theta)$.

=== Exemple : Modèle de Poisson
Soit $X_1, ..., X_n$ de loi $P_theta$ de Poisson, $theta > 0$. On cherche un estimateur de $theta = EE[X_i]$.

Proposons : $hat(theta) = overline(X) = 1/n sum_(i=1)^n X_i$.

*Calcul du Biais :*
$
  B(hat(theta), theta) &= EE[1/n sum_(i=1)^n X_i] - theta \
  &= 1/n sum_(i=1)^n EE[X_i] - theta quad ("par linéarité") \
  &= 1/n dot n dot EE[X_1] - theta \
  &= theta - theta = 0
$
Donc $EE[overline(X)] = theta$, est l'estimateur sans biais.

*Calcul du Risque :*
$
  R(hat(theta), theta) &= EE[(overline(X) - theta)^2] = EE[(overline(X) - EE[overline(X)])^2] \
  &= Var(overline(X)) = Var(1/n sum X_i) \
  &= 1/n^2 sum Var(X_i) quad ("car i.i.d") \
  &= 1/n^2 dot n dot Var(X_1) = (Var(X_1))/n = theta/n
$

#thm(info: "Décomposition Biais-Variance du risque")[
  $ R(hat(theta), theta) = (B(hat(theta), theta))^2 + Var(hat(theta)) $
]

#proof[
  $
    R(hat(theta), theta) &= EE[(hat(theta) - theta)^2] \
    &= EE[(hat(theta) - EE[hat(theta)] + EE[hat(theta)] - theta)^2] \
    &= EE[(hat(theta) - EE[hat(theta)])^2] + EE[(EE[hat(theta)] - theta)^2] + 2 EE[(hat(theta) - EE[hat(theta)])(EE[hat(theta)] - theta)] \
    &= Var(hat(theta)) + (B(hat(theta), theta))^2 + 2(EE[hat(theta)] - theta) underbrace(EE[hat(theta) - EE[hat(theta)]], 0) \
    &= Var(hat(theta)) + B(hat(theta), theta)^2
  $
]

== Consistance
Propriété asymptotique. On ne considère que des estimateurs consistants.

#defn(info: "Consistance")[
  Soit $(X_1, ..., X_n)$ i.i.d. de loi $P_theta$. Soit $hat(theta)_n = h(X_1, ..., X_n)$.
  $hat(theta)_n$ est un estimateur consistant (ou convergent) de $theta$ ssi :
  $ hat(theta)_n -->_(n -> +infinity)^(PP) theta $
]

#rmk[
  $hat(theta)_n$ est fortement consistant ssi $hat(theta)_n -->_(n -> +infinity)^("p.s.") theta$.
]

=== Exemple : Retour au modèle de Poisson
$Theta = RR_+^*$, $hat(theta)_n = overline(X)$.

- On peut invoquer la Loi des Grands Nombres (LGN) : $overline(X) -->^(PP) EE[X_i] = theta$.
- Via le risque quadratique :
  $ R(hat(theta)_n, theta) = Var(overline(X)) = theta/n -->_(n -> +infinity) 0 $
  D'après l'inégalité de Bienaymé-Tchebychev :
  $ P(|hat(theta)_n - theta| > epsilon) <= (EE[(hat(theta)_n - theta)^2])/epsilon^2 = (R(hat(theta)_n, theta))/epsilon^2 -> 0 $

=== Méthode "Plug-in"
Soit $(X_1, ..., X_n)$ i.i.d. Poisson$(theta)$. On veut estimer $beta = P(X_i = 0) = e^(-theta)$.
$ hat(beta) = e^(-hat(theta)) = e^(-overline(X)) $

$hat(beta)$ est consistant pour estimer $beta$.

#lem(info: "Lemme de l'application continue")[
  Si $Z_n -->^(PP) Z$, alors $h(Z_n) -->^(PP) h(Z)$ pour toute fonction continue $h$.
]
