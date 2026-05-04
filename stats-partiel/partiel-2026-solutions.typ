#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(size: 11pt, lang: "fr")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: none)
#show heading.where(level: 1): it => [
  #v(0.5em)
  #block(text(size: 14pt, weight: "bold", it.body))
  #v(0.3em)
]
#show heading.where(level: 2): it => [
  #v(0.4em)
  #block(text(size: 12pt, weight: "bold", it.body))
  #v(0.2em)
]

#align(center)[
  #text(size: 16pt, weight: "bold")[Inférence statistique --- Partiel du 23 février 2026]\
  #text(size: 11pt, style: "italic")[Solutions complètes] \
  #text(size: 11pt, style: "italic")[Yehor Korotenko]
]

#v(0.5em)
#line(length: 100%, stroke: 0.5pt)

= Exercice 1 (Variance empirique)

*Cadre.* Soit $X_1, dots, X_n$ un échantillon i.i.d. d'espérance $mu in RR$ et de variance $sigma^2 > 0$. On pose
$ overline(X) = 1/n sum_(i=1)^n X_i, quad V_n = 1/n sum_(i=1)^n (X_i - overline(X))^2. $

== Question 1 --- Calcul de $"Var"(overline(X))$ et $E(overline(X)^2)$

Par indépendance des $X_i$ et propriétés de la variance :
$ "Var"(overline(X)) = "Var"(1/n sum_(i=1)^n X_i) = 1/n^2 sum_(i=1)^n "Var"(X_i) = 1/n^2 dot n sigma^2 = sigma^2 / n. $

Comme $E(overline(X)) = mu$, la formule de König--Huygens donne :
$ E(overline(X)^2) = "Var"(overline(X)) + E(overline(X))^2 = sigma^2/n + mu^2. $

== Question 2 --- Identité, biais et consistance

*Identité.* Développons le carré :
$ V_n = 1/n sum_(i=1)^n (X_i^2 - 2 X_i overline(X) + overline(X)^2) = 1/n sum_(i=1)^n X_i^2 - 2 overline(X) dot underbrace(1/n sum_(i=1)^n X_i, =overline(X)) + overline(X)^2. $
Les deux derniers termes valent $-2 overline(X)^2 + overline(X)^2 = -overline(X)^2$, d'où
#align(center, box(stroke: 0.6pt, inset: 8pt, $ V_n = 1/n sum_(i=1)^n X_i^2 - overline(X)^2. $))

*Biais.* Par linéarité, $E(1/n sum X_i^2) = E(X_1^2) = sigma^2 + mu^2$. Avec la question 1,
$ E(V_n) = (sigma^2 + mu^2) - (sigma^2/n + mu^2) = sigma^2 - sigma^2/n = (n-1)/n sigma^2. $
Donc $V_n$ est *biaisé* avec
#align(center, box(stroke: 0.6pt, inset: 8pt, $ "biais"(V_n) = E(V_n) - sigma^2 = -sigma^2 / n. $))
(Biais négatif, qui tend vers $0$ quand $n -> infinity$ : asymptotiquement sans biais.)

*Consistance.* La loi forte des grands nombres (LFGN) appliquée aux $X_i^2$ (intégrables car $E(X_i^2) = mu^2 + sigma^2 < infinity$) donne
$ 1/n sum_(i=1)^n X_i^2 attach(-->, t: "p.s.") E(X_1^2) = mu^2 + sigma^2. $
La LFGN appliquée aux $X_i$ donne $overline(X) attach(-->, t: "p.s.") mu$, donc par continuité $overline(X)^2 attach(-->, t: "p.s.") mu^2$. Par opérations sur les limites presque sûres :
$ V_n = 1/n sum_(i=1)^n X_i^2 - overline(X)^2 attach(-->, t: "p.s.") (mu^2 + sigma^2) - mu^2 = sigma^2. $
La convergence p.s. implique la convergence en probabilité, donc $V_n$ est un *estimateur consistant* de $sigma^2$. #h(1fr) $square$

== Question 3 --- TCL appliqué à $U_n$

Posons $Z_i = (X_i - mu)^2$. Les $Z_i$ sont i.i.d. avec
$ E(Z_i) = E[(X_i-mu)^2] = sigma^2, quad "Var"(Z_i) = E[(X_i - mu)^4] - (E[(X_i-mu)^2])^2 = mu_4 - sigma^4. $
La condition $mu_4 < infinity$ assure $"Var"(Z_i) < infinity$. Comme $U_n = 1/n sum_(i=1)^n Z_i$, le *Théorème de la Limite Centrale* donne :
#align(center, box(stroke: 0.6pt, inset: 8pt, $ sqrt(n) (U_n - sigma^2) attach(-->, t: cal(L)) cal(N)(0, mu_4 - sigma^4). $))

== Question 4 --- Normalité asymptotique de $V_n$

On part de l'identité (donnée) :
$ V_n = U_n - (overline(X) - mu)^2, $
qu'on multiplie par $sqrt(n)$ et qu'on recentre par $sigma^2$ :
$ sqrt(n)(V_n - sigma^2) = underbrace(sqrt(n)(U_n - sigma^2), (A_n)) - underbrace(sqrt(n)(overline(X)-mu)^2, (B_n)). $

*Terme $(A_n)$.* Par la question 3 : $A_n attach(-->, t: cal(L)) cal(N)(0, mu_4 - sigma^4)$.

*Terme $(B_n)$.* Le TCL classique donne $sqrt(n)(overline(X) - mu) attach(-->, t: cal(L)) cal(N)(0, sigma^2)$, donc $sqrt(n)(overline(X)-mu) = O_P (1)$. Par ailleurs $overline(X) - mu attach(-->, t: P) 0$. Le lemme de Slutsky (produit d'une suite bornée en probabilité par une suite tendant en probabilité vers $0$) donne :
$ B_n = underbrace(sqrt(n)(overline(X)-mu), O_P (1)) dot underbrace((overline(X) - mu), o_P (1)) attach(-->, t: P) 0. $

*Conclusion (Slutsky).* La somme d'une suite convergente en loi et d'une suite tendant en probabilité vers $0$ converge en loi vers la même limite :
#align(center, box(stroke: 0.6pt, inset: 8pt, $ sqrt(n)(V_n - sigma^2) attach(-->, t: cal(L)) cal(N)(0, mu_4 - sigma^4). $))
$V_n$ est donc *asymptotiquement normal*, de variance asymptotique $mu_4 - sigma^4$. #h(1fr) $square$

#pagebreak()

= Exercice 2 (Modèle Bêta à un paramètre)

*Cadre.* $X_1, dots, X_n$ i.i.d. de densité $f(x; theta) = theta(1-x)^(theta-1) bb(1)_(0 < x < 1)$, avec $theta > 0$.

#text(style: "italic")[Remarque : c'est la loi $cal(B)(1, theta)$, transformée de l'exponentielle. Si $X tilde f(dot; theta)$ alors $-ln(1-X) tilde cal(E)(theta)$.]

== Question 1 --- Log-vraisemblance

Pour un échantillon avec tous les $x_i in (0,1)$ :
$ L_n (theta) = product_(i=1)^n theta (1-x_i)^(theta - 1) = theta^n product_(i=1)^n (1-x_i)^(theta-1). $
#align(center, box(stroke: 0.6pt, inset: 8pt, $ ell_n (theta) = log L_n (theta) = n log theta + (theta - 1) sum_(i=1)^n log(1 - x_i). $))

== Question 2 --- EMV

Posons $T_n = -sum_(i=1)^n log(1 - X_i) > 0$ (car $log(1-X_i) < 0$). On a $ell_n (theta) = n log theta - (theta - 1) T_n$. Dérivons :
$ (ell_n)' (theta) = n/theta - T_n. $
L'équation de vraisemblance $(ell_n)' (theta) = 0$ donne $theta = n / T_n$. La dérivée seconde
$ (ell_n)'' (theta) = -n/theta^2 < 0 $
est strictement négative, donc $ell_n$ est strictement concave et le point critique est l'unique maximum global. D'où
#align(center, box(stroke: 0.6pt, inset: 8pt, $ hat(theta)_n = n / (-sum_(i=1)^n log(1 - X_i)) = 1 / overline(W)_n, "où" W_i = -log(1 - X_i). $))

== Question 3 --- Consistance

Posons $W_i = -log(1 - X_i)$. Par changement de variable $w = -log(1-x)$, soit $x = 1 - e^(-w)$, $d x = e^(-w) d w$, et la densité de $W_i$ est
$ f_W (w) = theta (1 - (1 - e^(-w)))^(theta-1) dot e^(-w) = theta e^(-(theta-1)w) e^(-w) = theta e^(-theta w), quad w > 0. $
Donc $W_i tilde cal(E)(theta)$, exponentielle de paramètre $theta$. En particulier
$ E(W_i) = 1/theta, quad "Var"(W_i) = 1/theta^2 < infinity. $

La LFGN donne $overline(W)_n attach(-->, t: "p.s.") 1/theta$. Comme $theta > 0$, la limite est non nulle, donc par continuité de $w mapsto 1/w$ en $1/theta$ :
$ hat(theta)_n = 1 / overline(W)_n attach(-->, t: "p.s.") theta. $
La convergence p.s. implique la convergence en probabilité : $hat(theta)_n$ est *consistant*. #h(1fr) $square$

== Question 4 --- Normalité asymptotique et efficacité

*Normalité asymptotique.* On a montré que $W_i tilde cal(E)(theta)$ avec $E(W_i) = 1/theta$ et $"Var"(W_i) = 1/theta^2$. Par le TCL,
$ sqrt(n)(overline(W)_n - 1/theta) attach(-->, t: cal(L)) cal(N)(0, 1/theta^2). $
La fonction $g(w) = 1/w$ est dérivable en $1/theta > 0$ avec $g'(1/theta) = -theta^2$. La *méthode delta* donne
$ sqrt(n)(hat(theta)_n - theta) = sqrt(n)(g(overline(W)_n) - g(1/theta)) attach(-->, t: cal(L)) cal(N)(0, (g'(1/theta))^2 dot 1/theta^2). $
On calcule $(g'(1/theta))^2 dot 1/theta^2 = theta^4 dot 1/theta^2 = theta^2$. Ainsi
#align(center, box(stroke: 0.6pt, inset: 8pt, $ sqrt(n)(hat(theta)_n - theta) attach(-->, t: cal(L)) cal(N)(0, theta^2). $))
$hat(theta)_n$ est donc *asymptotiquement normal*, de variance asymptotique $theta^2$.

*Efficacité asymptotique.* Calculons l'information de Fisher. Pour une observation,
$ log f(x; theta) = log theta + (theta - 1) log(1-x), quad partial_theta log f = 1/theta + log(1 - x). $
$ partial_theta^2 log f = -1/theta^2. $
D'où, le modèle étant régulier (même justification qu'en cours : famille exponentielle, support indépendant de $theta$, dérivations sous l'intégrale licites) :
$ I_1 (theta) = -E[partial_theta^2 log f(X_1; theta)] = 1/theta^2. $
La *borne de Cramér--Rao asymptotique* est $1/I_1 (theta) = theta^2$, qui coïncide avec la variance asymptotique de $hat(theta)_n$. Donc
#align(center, box(stroke: 0.6pt, inset: 8pt)[$hat(theta)_n$ est asymptotiquement efficace.])
#h(1fr) $square$

#pagebreak()

= Exercice 3 (Bernoulli reparamétrée $Y = 2X-1$)

*Cadre.* $X tilde cal(B)(theta)$, $Y = 2X - 1$, donc $Y in {-1, 1}$.

== Question 1 --- Loi, espérance et variance de $Y$

$X = 1 <==> Y = 1$ et $X = 0 <==> Y = -1$. Donc
$ P(Y = 1) = theta, quad P(Y = -1) = 1 - theta. $

Par linéarité et propriétés classiques :
$ E(Y) = 2 E(X) - 1 = 2 theta - 1, $
$ "Var"(Y) = "Var"(2X - 1) = 4 "Var"(X) = 4 theta(1 - theta). $

== Question 2 --- Information de Fisher pour $Y$

Avec la paramétrisation donnée
$ log f(y; theta) = (1+y)/2 log theta + (1-y)/2 log(1 - theta), $
on dérive :
$ partial_theta log f = (1+y)/(2 theta) - (1-y)/(2(1-theta)). $
$ partial_theta^2 log f = -(1+y)/(2 theta^2) - (1-y)/(2(1-theta)^2). $

L'information de Fisher est
$ I_1 (theta) = -E[partial_theta^2 log f(Y; theta)] = E[(1+Y)/(2 theta^2)] + E[(1-Y)/(2(1-theta)^2)]. $
Or $E(1 + Y) = 1 + (2 theta - 1) = 2 theta$ et $E(1 - Y) = 2(1 - theta)$, donc
$ I_1 (theta) = (2 theta)/(2 theta^2) + (2(1 - theta))/(2(1-theta)^2) = 1/theta + 1/(1-theta) = 1/(theta(1-theta)). $
#align(center, box(stroke: 0.6pt, inset: 8pt, $ I_1 (theta) = 1 / (theta(1-theta)). $))

== Question 3 --- Estimateur des moments

L'égalité $E(Y) = 2 theta - 1$ s'inverse en $theta = (E(Y) + 1)/2$. La méthode des moments substitue la moyenne empirique :
#align(center, box(stroke: 0.6pt, inset: 8pt, $ hat(theta)_n = (overline(Y)_n + 1) / 2, "où" overline(Y)_n = 1/n sum_(i=1)^n Y_i. $))

#text(style: "italic")[Remarque : on peut écrire $hat(theta)_n = 1/n sum_i (Y_i + 1)/2 = 1/n sum_i X_i = overline(X)_n$, c'est-à-dire la fréquence empirique des $1$ — cohérent avec l'EMV bernoullien.]

== Question 4 --- Risque quadratique

*Biais.* Par linéarité,
$ E(hat(theta)_n) = (E(overline(Y)_n) + 1)/2 = ((2 theta - 1) + 1)/2 = theta. $
Donc $hat(theta)_n$ est *sans biais*.

*Variance.* Par indépendance des $Y_i$ et $"Var"(Y_i) = 4 theta (1 - theta)$ :
$ "Var"(hat(theta)_n) = "Var"(overline(Y)_n / 2 + 1/2) = 1/4 dot "Var"(overline(Y)_n) = 1/4 dot (4 theta(1-theta))/n = (theta(1-theta))/n. $

Le risque quadratique étant la somme du carré du biais et de la variance :
#align(center, box(stroke: 0.6pt, inset: 8pt, $ R(hat(theta)_n, theta) = E[(hat(theta)_n - theta)^2] = "biais"^2 + "Var" = (theta(1-theta))/n. $))

== Question 5 --- Efficacité

L'estimateur $hat(theta)_n$ est *sans biais*. Pour un estimateur sans biais dans un modèle régulier, la *borne de Cramér--Rao* est
$ "BCR"_n = 1 / (n I_1 (theta)) = (theta(1-theta))/n. $

Or
$ "Var"(hat(theta)_n) = (theta(1-theta))/n = "BCR"_n. $

L'estimateur sans biais $hat(theta)_n$ atteint la borne de Cramér--Rao, donc :
#align(center, box(stroke: 0.6pt, inset: 8pt)[$hat(theta)_n$ est efficace (à $n$ fixé, pas seulement asymptotiquement).])
#h(1fr) $square$

#v(1em)
#line(length: 100%, stroke: 0.5pt)
#align(center)[#text(style: "italic", size: 9pt)[Fin du sujet.]]
