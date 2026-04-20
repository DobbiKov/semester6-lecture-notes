#import "@local/dobbikov:1.0.0":*

#show: dobbikov.with(
  title: [CheatSheet Equa Diff],
  subtitle: none,
  author: "Yehor KORORTENKO",
  date: datetime.today(),
  language: "fr",
  report-style: true
)

= Chapitre 1

#prop[Les solutions de $y' = a y$ sur $RR$ sont
$ y(t) = C e^(a t), quad C in RR. $]

#prop[Soit $a : I -> RR$ continue, $A$ une primitive de $a$.
Les solutions de $y' = a(t) y$ sur $I$ sont
$ y(t) = C e^(A(t)), quad C in RR. $]

#prop[Soit $a, b in cal(C)^0(I)$, $A$ primitive de $a$, $t_0 in I$.
$y$ est solution de $y' = a(t)y + b(t)$ ssi $exists C in RR$ tel que
$ y(t) = C e^(A(t)) + integral_(t_0)^t e^(A(t)-A(s)) b(s) dif s. $]

#defn[Une *équation différentielle d'ordre 1* sur $I$ est une expression
$ y' = f(t, y), $
où $f : I times U -> RR$ est continue. Elle est dite *autonome* si $f$ ne dépend
pas de $t$, *linéaire* si $f(t,x) = a(t)x + b(t)$, *homogène* si de plus $b = 0$.]

#defn[$(J, y)$ est une *solution* de $y' = f(t,y)$ si $y in cal(C)^1(J)$,
$y(t) in U$ pour tout $t in J$, et $y'(t) = f(t, y(t))$. Elle est *globale* si $J = I$,
*locale* sinon.]

#defn[$(J_2, y_2)$ *prolonge* $(J_1, y_1)$ si $J_1 subset J_2$ et
$y_1 = y_2|_(J_1)$. $(J_1, y_1)$ est *maximale* si elle n'admet aucun autre prolongement.]

#prop("Cauchy-Lipschitz")[Si $f : I times U -> RR$ est $cal(C)^1$,
alors pour tout $(t_0, y_0) in I times U$, le problème de Cauchy
$ y' = f(t,y), quad y(t_0) = y_0 $
admet une *unique solution maximale*.]

#defn[Une *équation d'ordre $n$* s'écrit
$ y^((n)) = F(t, y, y', dots, y^((n-1))), $
et une solution $(J, y)$ vérifie $y in cal(C)^n(J)$ avec $y^((n))(t) = F(t, y(t), dots, y^((n-1))(t))$.]

#prop[L'équation d'ordre $n$ est équivalente au système d'ordre 1
$Y' = G(t, Y)$ via $Y(t) = (y, y', dots, y^((n-1)))^top$, où
$ G(t, x_1, dots, x_n) = (x_2, x_3, dots, x_n, F(t, x_1, dots, x_n))^top. $]

#prop("Régularité")[Si $F in cal(C)^k(I)$ et $(J,Y)$ est solution de
$Y' = F(t,Y)$, alors $Y in cal(C)^(k+1)(J)$.]

= Chapitre 2

#defn[Le système $Y' = F(t, Y)$ est *linéaire* si $F$ est affine en $Y$ :
$ Y' = A(t) Y + B(t), $
où $A : I -> cal(M)_n (RR)$ et $B : I -> RR^n$ sont continues. Il est *homogène* si $B = 0$.]

#prop[$Y$ est solution du problème de Cauchy
$Y' = A(t)Y + B(t),\ Y(t_0) = X_0$
ssi pour tout $t in J$ :
$ Y(t) = X_0 + integral_(t_0)^t [A(s)Y(s) + B(s)] dif s. $]

*Schéma de Picard :*
$ Y_0(t) = X_0, quad Y_(n+1)(t) = X_0 + integral_(t_0)^t [A(s)Y_n(s)+B(s)] dif s. $
La série $sum W_n$ avec $W_n = Y_n - Y_(n-1)$ converge normalement :
$ norm(W_n (t)) <= A^(n-1) M t^n / (n!) $
où $A = sup norm(A(s))$, $M = sup norm(A(s)X_0 + B(s))$.

#prop("Cauchy-Lipschitz linéaire")[Si $A : I -> cal(M)_n (CC)$ et
$B : I -> CC^n$ sont continues, alors pour tout $X_0 in CC^n$ et $t_0 in I$, le problème
de Cauchy admet une *unique solution maximale, qui est globale*.]

#prop[L'ensemble des solutions de $Y' = A(t)Y$ est un *sous-espace
vectoriel* de $cal(C)^1(I, RR^n)$.]

#prop[Si $Y_1, Y_2$ sont solutions de $Y' = A(t)Y + B(t)$, alors
$Y_1 - Y_2$ est solution de $Y' = A(t)Y$.]

#prop("Superposition")[Toute solution de $Y' = A(t)Y + B(t)$ s'écrit
$Y = Y_0 + Z$ avec $Y_0$ une solution particulière et $Z$ solution de l'homogène.]

#prop[L'espace $cal(S)_H$ des solutions de $Y' = A(t)Y$ est de
*dimension $n$*. L'isomorphisme est $phi : X_0 |-> Y_(X_0)$ (évaluation en $t_0$).]

#defn[Pour $A in cal(M)_n (CC)$,
$ exp(A) = sum_(k >= 0) 1/(k!) A^k. $
Cette série converge normalement (majorée par $e^(|||A|||)$).]

*Cas particuliers :*
- $exp(0) = I$
- $A = "diag"(lambda_1, dots, lambda_n) => e^A = "diag"(e^(lambda_1), dots, e^(lambda_n))$
- $A$ nilpotente ($A^p = 0$) $=> e^A = I + A + dots + A^(p-1)$
- $A = P B P^(-1) => e^A = P e^B P^(-1)$

#prop[Si $A B = B A$, alors $e^(A+B) = e^A e^B$.]

#prop("Décomposition de Jordan-Chevalley")[Pour tout $f$ linéaire
sur $CC^n$, il existe un unique couple $(d, n)$ avec $d$ diagonalisable, $n$ nilpotente,
$d compose n = n compose d$, et $f = d + n$.]

*Algorithme :*
+ Calculer $chi_f(X) = product_j (X - lambda_j)^(m_j)$
+ Trouver une base $cal(B)_j$ de $ker(A - lambda_j I)^(m_j)$
+ Définir $d(u) = lambda_j u$ pour $u in cal(B)_j$
+ Poser $n = f - d$

#prop[Avec la décomposition de Jordan $T_j = lambda_j I_(m_j) + N_j$,
$ e^(T_j) = e^(lambda_j) (I + N_j + 1/(2!) N_j^2 + dots + 1/((m_j-1)!) N_j^(m_j - 1)). $]

#prop[La fonction $phi : t |-> e^(t A)$ est $cal(C)^oo$ et vérifie :
+ $phi(t_1 + t_2) = phi(t_1) phi(t_2)$
+ $phi(t)^(-1) = phi(-t)$
+ $phi^((n))(t) = A^n e^(t A)$

En particulier $dif/(dif t) e^(t A) = A e^(t A) = e^(t A) A$.]

#prop[L'unique solution de
$ Y' = A Y, quad Y(0) = X_0 $
est $Y(t) = e^(t A) X_0$.]

#prop[Les solutions complexes de $Y' = A Y$ sont des combinaisons
linéaires de fonctions
$ t |-> e^(t lambda_j) t^k u_(j,k), $
où $lambda_j$ est valeur propre de $A$, $k <= m_j - 1$, $u_(j,k) in CC^n$.]

*Variation de la constante.* Une solution particulière de $Y' = A Y + B(t)$ est
$ Y_p(t) = e^(t A) integral_(t_0)^t e^(-s A) B(s) dif s. $

#prop[Pour $A in cal(M)_n (RR)$, les solutions réelles de $Y' = A Y$
sont des combinaisons linéaires de
$ t |-> e^(t a_j) cos(b_j t) t^k u_(j,k), quad t |-> e^(t a_j) sin(b_j t) t^k v_(j,k), $
avec $lambda_j = a_j + i b_j$ valeur propre, $k <= m_j - 1$, $u_(j,k), v_(j,k) in RR^n$.]

#defn[La *résolvante* de $Y' = A(t)Y$ est
$ R(t, t_0) = Phi_t compose (Phi_(t_0))^(-1) in cal(M)_n (RR), $
i.e. $R(t,t_0) X_0$ est la valeur en $t$ de la solution valant $X_0$ en $t_0$.
Pour $A$ constante : $R(t, t_0) = e^((t-t_0)A)$.]

#prop[La résolvante vérifie :
+ $R(t,t) = "Id"$
+ $R(t_2, t_1) R(t_1, t_0) = R(t_2, t_0)$
+ $partial_t R(t, t_0) = A(t) R(t, t_0)$
+ $R(t, t_0)^(-1) = R(t_0, t)$]

#defn[${Y_1, dots, Y_n}$ est un *système fondamental de solutions*
si les $Y_j$ sont libres dans $cal(C)^1(I, RR^n)$.]

#defn[Le *wronskien* est
$ cal(W)(t) = det mat(Y_1(t), dots, Y_n(t)). $]

#prop("Liouville")[Pour $cal(W)(t) = det R(t, t_0)$ :
$ cal(W)(t) = exp(integral_(t_0)^t "Tr" A(s) dif s). $
En particulier $cal(W)(t) != 0$ : les colonnes de $R(t,t_0)$ forment un SFS.]

*Variation de la constante (cas variable).* Solution particulière de
$Y' = A(t)Y + B(t)$ :
$ Y_p(t) = R(t, t_0) integral_(t_0)^t R(t_0, s) B(s) dif s. $

*Ordre 2 scalaire.* Pour $y'' + p(t)y' + q(t)y = f(t)$, avec $(y_1, y_2)$ SFS
de l'homogène, on cherche $y_p = alpha_1(t) y_1 + alpha_2(t) y_2$ avec :
$ cases(alpha'_1 y_1 + alpha'_2 y_2 = 0, alpha'_1 y'_1 + alpha'_2 y'_2 = f(t).) $

= Chapitre 3

*Schéma d'Euler explicite :*
$ y_0 = x_0, quad y_(n+1) = y_n + h f(t_n, y_n). $

#defn[L'*erreur globale* est $e(h) = max_n |y(t_n) - y_n^h|$.]

#defn[Le schéma est *convergent* si $e(h) -> 0$ quand $h -> 0$.]

#defn[L'*erreur de consistance locale* est
$ epsilon_n(h) = y(t_(n+1)) - y(t_n) - h f(t_n, y(t_n)). $
L'*erreur globale de consistance* est $epsilon(h) = sum_(n=0)^(N-1) |epsilon_n(h)|$.]

*Pour Euler explicite, $f in cal(C)^1$ :*
$ |epsilon_n(h)| <= M h^2, quad epsilon(h) <= M' h quad => "ordre 1". $

#prop[La méthode d'Euler explicite est exactement d'ordre 1.]

#defn[Le schéma est *stable* s'il existe $C > 0$ tel que pour tout
$h$ assez petit, tout $y_0, z_0$ et toute perturbation $delta_n$ :
$ |z_n^h - y_n^h| <= C (|z_0 - y_0| + sum_(m=0)^(n-1) |delta_m|). $]

#prop[Si $f$ est $L$-lipschitzienne en sa 2e variable (uniformément en $t$),
alors Euler est stable avec constante $C = e^(L(t - t_0))$.]

#prop("Lax")[Consistance + Stabilité $=>$ Convergence.

Pour Euler : $e(h) = O(h)$.]

*Euler implicite :*
$ y_(n+1)^h = y_n^h + h f(t_(n+1), y_(n+1)^h). $
Stable pour tout $h > 0$ sur $y' = -a y$ ($a > 0$) ; même ordre que l'explicite.

*Méthode de Heun (RK2, ordre 2) :*
$ p_1 = f(t_n, y_n), quad p_2 = f(t_n + h, y_n + h p_1), $
$ y_(n+1) = y_n + h/2 (p_1 + p_2). $

*Conditions d'ordre 2 pour RK à 2 étages :*
$ b_1 + b_2 = 1, quad b_2 c_2 = 1/2, quad b_2 a_(2,1) = 1/2. $
Famille : $b_2 = 1/(2 alpha), c_2 = a_(2,1) = alpha$. Heun : $alpha=1$ ; point milieu : $alpha = 1/2$.

#prop[Le schéma $y_(n+1) = y_n + h Phi(t, y_n, h)$ est consistant
ssi $Phi(t, x, 0) = f(t, x)$.

Pour RK : consistance $<=>$ $sum_(i=1)^q b_i = 1$.]

*Méthode RK4 (ordre 4, 4 étages) — tableau de Butcher :*
$ mat(0, , , , ; 1/2, 1/2, , , ; 1/2, 0, 1/2, , ; 1, 0, 0, 1, ; , 1/6, 1/3, 1/3, 1/6) $
