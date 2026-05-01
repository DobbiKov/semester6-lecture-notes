#import "@local/dobbikov:1.0.0": *

#show: dobbikov.with(
  title: [Statistique — Aide-Mémoire],
  author: none,
  date: none,
  language: "fr",
  maketitle: true,
  report-style: true,
)

#set page(paper: "a4", margin: (x: 1.2cm, y: 1.2cm))
#set text(size: 9pt)
#set par(justify: true, first-line-indent: 0pt)
#set columns(gutter: 0.8em)

#let Bern = math.op("Bernoulli")
#let Exp  = math.op("Exp")
#let Var  = math.op("Var")
#let Biais = math.op("Biais")
#let argmax = math.op("argmax", limits: true)
#let pval   = math.op("p-valeur")

// ──────────────────────────────────────────────────────────────
// PARTIE 1 — MODÈLE & ESTIMATEURS
// ──────────────────────────────────────────────────────────────
#columns(2)[
= Modèle statistique & estimateurs


#defn(info: "Modèle statistique")[
  $(Omega, cal(A), cal(P))$ avec $cal(P) = {P_theta ; theta in Theta}$.
  - *Paramétrique* : $Theta subset RR^p$.
  - *Identifiable* : $theta mapsto P_theta$ injective.
]

#defn(info: "Estimateur")[
  $hat(theta)_n = h(X_1,dots,X_n)$ mesurable, indépendant de $theta$.
]

#defn(info: "Biais")[
  $B(hat(theta),theta) = EE[hat(theta)] - theta$.
  Sans biais $<=>$ $B = 0$.
]

#defn(info: "Risque quadratique (MSE)")[
  $R(hat(theta),theta) = EE[(hat(theta)-theta)^2]$
]

#thm(info: "Décomposition biais-variance")[
  $ R(hat(theta),theta) = B(hat(theta),theta)^2 + Var(hat(theta)) $
]

#defn(info: "Consistance")[
  $hat(theta)_n -->^(PP) theta$ (convergence en probabilité).
  Fortement consistant si convergence p.s.
]

#rmk[
  Si $R(hat(theta)_n, theta) -> 0$ alors $hat(theta)_n$ est consistant
  (convergence $L^2 => $ convergence en probabilité, via Bienaymé-Tchebychev).
]

#lem(info: "Lemme des applications continues (LAC)")[
  Si $Z_n -->^(PP) Z$ et $h$ continue, alors $h(Z_n) -->^(PP) h(Z)$.
  Idem en loi. *Attention* : la réciproque pour la convergence en loi est fausse en général.
]


// ──────────────────────────────────────────────────────────────
// PARTIE 2 — MÉTHODES DE CONSTRUCTION
// ──────────────────────────────────────────────────────────────
= Méthodes de construction d'estimateurs


== Méthode des moments

#defn[
  - *Moment théorique* d'ordre $k$ : $mu_k = EE[X_i^k]$
  - *Moment empirique* d'ordre $k$ : $hat(mu)_k = 1/n sum_(i=1)^n X_i^k$

  Par LGN : $hat(mu)_k -->^(PP) mu_k$.

  Si $theta = cal(L)(mu_1,dots,mu_k)$, l'estimateur des moments est
  $hat(theta)_"MM" = cal(L)(hat(mu)_1,dots,hat(mu)_k)$
  (consistant par LAC).
]

*Exemples courants :*
- $X_i ~ Bern(theta)$ : $hat(theta) = overline(X)$
- $X_i ~ Exp(theta)$ ($f = theta e^{-theta x}$) : $hat(theta) = 1/overline(X)$
- $X_i$ de densité $theta x^{theta-1} bb(1)_{[0,1]}$ : $hat(theta) = overline(X)/(1-overline(X))$

*Variance empirique :*
$ hat(sigma)_n^2 = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum X_i^2 - overline(X)^2 $
Consistant pour $Var(X)$ (par LGN + LAC sur le couple).

== Maximum de vraisemblance (EMV)

#defn[
  *Vraisemblance* : $L_n(theta) = product_(i=1)^n f_theta(X_i)$

  *Log-vraisemblance* : $ell_n(theta) = sum_(i=1)^n log f_theta(X_i)$

  *EMV* : $hat(theta)_"MV" = argmax_(theta in Theta) L_n(theta) = argmax ell_n(theta)$
]

#prop[
  Si $hat(theta)$ est EMV de $theta$, alors $g(hat(theta))$ est EMV de $g(theta)$.
]

*Équation de vraisemblance* : résoudre $ell_n'(theta) = 0$, vérifier que c'est un maximum (e.g. $ell_n'' < 0$).

*Exemple :* $X_i ~ Bern(theta)$, $hat(theta)_"MV" = overline(X)$.

// ──────────────────────────────────────────────────────────────
// PARTIE 3 — INFORMATION DE FISHER & BORNE DE CRAMÉR-RAO
// ──────────────────────────────────────────────────────────────
= Information de Fisher & borne de Cramér-Rao


#defn(info: "Modèle régulier")[
  $(P_theta)$ est *régulier* si :
  1. $Theta$ ouvert, $theta mapsto f_theta(x)$ est $C^1$
  2. $op("Supp") f_theta$ ne dépend pas de $theta$
  3. L'intégrale $I(theta) = integral_S ((partial_theta f_theta(x))^2)/(f_theta(x)) dif x$ existe et est continue sur $Theta$
]

#defn(info: "Score")[
  $ S_n(theta) = partial/(partial theta) log L_n(theta) = sum_(i=1)^n partial/(partial theta) log f_theta(X_i) $
  Sous les hypothèses de régularité : $EE_theta[S_n(theta)] = 0$ (score centré).
]

#defn(info: "Information de Fisher")[
  $ I(theta) = EE_theta [(partial/(partial theta) log f_theta(X_1))^2] = Var_theta (partial/(partial theta) log f_theta(X_1)) $

  Pour $n$ observations : $I_n(theta) = n I(theta)$.

  Formule alternative (si $C^2$) :
  $ I_n(theta) = -EE_theta [partial^2/(partial theta^2) log L_n(theta)] $
]

*Exemples :*
- $X_i ~ cal(E)(theta)$ : $I(theta) = 1/theta^2$
- $X_i ~ Bern(theta)$ : $I(theta) = 1/(theta(1-theta))$
- $X_i ~ cal(P)(theta)$ : $I(theta) = 1/theta$

#prop(info: "Inégalité de Cramér-Rao")[
  Modèle régulier, $I(theta) > 0$. Pour tout estimateur $T$ *sans biais* de $g(theta)$ avec $EE_theta [T^2] < +oo$ :
  $ Var_theta(T) >= (g'(theta))^2/(n I(theta)) $
]

#defn(info: "Estimateur efficace")[
  $T$ est *efficace* s'il réalise l'égalité dans la borne de Cramér-Rao.
]


// ──────────────────────────────────────────────────────────────
// PARTIE 4 — ASYMPTOTIQUE
// ──────────────────────────────────────────────────────────────
= Propriétés asymptotiques


#lem(info: "Lemme de Slutsky")[
  Si $X_n -->^(cal(L)) X$ et $Y_n -->^(cal(L)) c$ (constante), alors :
  - $X_n + Y_n -->^(cal(L)) X + c$
  - $X_n Y_n -->^(cal(L)) c X$
  - $X_n/Y_n -->^(cal(L)) X/c$ (si $c != 0$)
]

#rmk[
  $X_n -->^(cal(L)) X$ et $Y_n -->^(cal(L)) Y$ *n'implique pas* $mat(X_n;Y_n) -->^(cal(L)) mat(X;Y)$ en général (sauf si indépendants ou si l'un converge en proba vers une constante).
]

#defn(info: "Normalité asymptotique")[
  $hat(theta)_n$ est *asymptotiquement normal* si
  $ sqrt(n)(hat(theta)_n - theta) -->^(cal(L)) cal(N)(0, tau^2(theta)) $
  *Note* : normalité asymptotique $=>$ consistance.
]

#lem(info: "$delta$-méthode")[
  Si $sqrt(n)(Z_n - mu) -->^(cal(L)) cal(N)(0, tau^2)$ et $g$ dérivable en $mu$ avec $g'(mu) != 0$, alors
  $ sqrt(n)[g(Z_n) - g(mu)] -->^(cal(L)) cal(N)(0, (g'(mu))^2 tau^2) $
]

*Application :* si $hat(theta)_n$ est asymptotiquement normal de variance $tau^2/n$, et si $hat(tau)^2$ est un estimateur consistant de $tau^2$, alors (par Slutsky) :
$ (sqrt(n)(hat(theta)_n - theta))/(hat(tau)) -->^(cal(L)) cal(N)(0, 1) $

*Efficacité asymptotique :* $hat(theta)_n$ est *asymptotiquement efficace* si $n Var(hat(theta)_n) -> 1/I(theta)$.


// ──────────────────────────────────────────────────────────────
// PARTIE 5 — FONC. DE RÉPARTITION EMPIRIQUE & QUANTILES
// ──────────────────────────────────────────────────────────────
= F.r. empirique & quantiles


#defn(info: "F.r. empirique")[
  $ hat(F)_n(x) = 1/n sum_(i=1)^n bb(1)_(X_i <= x) $
  - $n hat(F)_n(x) ~ "Binomiale"(n, F(x))$
  - $hat(F)_n(x)$ est sans biais et consistant pour $F(x)$
  - TLC : $sqrt(n)(hat(F)_n(x) - F(x)) -->^(cal(L)) cal(N)(0, F(x)(1-F(x)))$
]

#thm(info: "Glivenko-Cantelli")[
  $ sup_(x in RR) |hat(F)_n(x) - F(x)| -->^(PP) 0 $
]

#defn(info: "Inverse généralisé / Quantile")[
  $ F^{-1}(alpha) = inf{x in RR, F(x) >= alpha} $
  - $F^{-1}(1/4)$ = 1er quartile, $F^{-1}(1/2)$ = médiane, $F^{-1}(3/4)$ = 3e quartile
]

#defn(info: "Quantile empirique")[
  $ hat(q)_{n,alpha} = hat(F)_n^{-1}(alpha) = X_{([n alpha])} $
  où $X_{(1)} <= dots <= X_{(n)}$ est l'échantillon ordonné et $[u]$ est le plus petit entier $>= u$.
]


// ──────────────────────────────────────────────────────────────
// PARTIE 6 — INTERVALLES DE CONFIANCE
// ──────────────────────────────────────────────────────────────
= Intervalles de confiance


#defn[
  Un *IC de niveau $1-alpha$* pour $theta$ est un intervalle $[B_inf, B_sup]$ dont les bornes sont des fonctions de $(X_1,dots,X_n)$, ne dépendent pas des paramètres inconnus, et tel que
  $ P(theta in [B_inf, B_sup]) >= 1-alpha $
  (ou $-> 1-alpha$ pour un IC asymptotique).
]

== Méthode pivotale
Si $hat(theta)_n$ est asymptotiquement normal avec écart-type $sigma(theta)/sqrt(n)$ estimé par $hat(sigma)/sqrt(n)$ :
$ (sqrt(n)(hat(theta)-theta))/(hat(sigma)) -->^(cal(L)) cal(N)(0,1) $
$=> $ IC asymptotique de niveau $1-alpha$ :
$ hat(theta) pm q_{1-alpha/2} hat(sigma)/sqrt(n) $
où $q_{1-alpha/2} = Phi^{-1}(1-alpha/2)$ ($approx 1.96$ à $5%$).

#rmk[
  $q_{alpha/2} = -q_{1-alpha/2}$ par symétrie de $cal(N)(0,1)$.
  $P(q_{alpha/2} <= Z <= q_{1-alpha/2}) = 1-alpha$.
]

== IC dans le modèle gaussien
$(X_1,dots,X_n)$ i.i.d. $cal(N)(mu, sigma^2)$, $hat(mu) = overline(X)$, $hat(sigma)^2 = 1/n sum(X_i - overline(X))^2$, $S_n^2 = (n/(n-1)) hat(sigma)^2$.

- *IC pour $mu$* ($sigma^2$ inconnu, niveau exact) :
$ overline(X) pm t_{1-alpha/2}(n-1) S_n/sqrt(n) $
où $T = (overline(X)-mu)/(S_n/sqrt(n)) ~ "Student"(n-1)$.

- *IC pour $sigma^2$* (niveau exact) :
$ [(n hat(sigma)^2)/q_{1-alpha/2}^{chi^2(n-1)}, (n hat(sigma)^2)/q_{alpha/2}^{chi^2(n-1)}] $
car $(n hat(sigma)^2)/sigma^2 ~ chi^2(n-1)$.


// ──────────────────────────────────────────────────────────────
// PARTIE 7 — LOIS DÉRIVÉES (chi², Student)
// ──────────────────────────────────────────────────────────────
= Lois dérivées de la loi normale


#defn(info: "Loi $chi^2(d)$")[
  Si $X_1,dots,X_d ~ cal(N)(0,1)$ i.i.d., alors
  $ Y = X_1^2 + dots + X_d^2 ~ chi^2(d) $
  - $EE[Y] = d$, $Var(Y) = 2d$
  - Fct génératrice : $M(t) = (1-2t)^{-d/2}$ ($t < 1/2$)
]

#defn(info: "Loi de Student $t(d)$")[
  Si $X ~ cal(N)(0,1)$ et $Y ~ chi^2(d)$ indépendantes :
  $ Z = X/sqrt(Y/d) ~ "Student"(d) $
  Quand $d -> +oo$, $"Student"(d) -> cal(N)(0,1)$.
]

#thm(info: "Loi des estimateurs gaussiens")[
  $(X_1,dots,X_n)$ i.i.d. $cal(N)(mu, sigma^2)$ :
  - $overline(X)$ et $sum(X_i - overline(X))^2$ sont *indépendantes*
  - $overline(X) ~ cal(N)(mu, sigma^2/n)$
  - $(n hat(sigma)^2)/sigma^2 = ((n-1)S_n^2)/sigma^2 ~ chi^2(n-1)$
  - $(overline(X) - mu)/(S_n/sqrt(n)) ~ "Student"(n-1)$
]


// ──────────────────────────────────────────────────────────────
// PARTIE 8 — TESTS D'HYPOTHÈSE
// ──────────────────────────────────────────────────────────────
= Tests d'hypothèse


#defn(info: "Test statistique")[
  Fonction $phi: (X_1,dots,X_n) -> {0,1}$.
  - $phi = 0$ : on conserve $H_0$
  - $phi = 1$ : on rejette $H_0$

  *Région de rejet* : $cal(R) = {phi = 1}$, souvent $cal(R) = {T > c}$ (ou $< c$, ou $|T| > c$).
]

#defn(info: "Types d'erreurs")[
  #table(columns: 3, align: center,
    [réalité/décision], [$H_0$ vraie], [$H_1$ vraie],
    [$H_0$ acceptée], [✓], [erreur 2e espèce],
    [$H_0$ rejetée], [erreur 1re espèce], [✓],
  )
  - *Erreur 1re espèce* : $alpha(theta) = P_theta((X_1,dots,X_n) in cal(R))$ pour $theta in Theta_0$
  - *Niveau $alpha$* : $sup_{theta in Theta_0} P_theta(cal(R)) <= alpha$
  - *Erreur 2e espèce* : $beta(theta) = P_theta(cal(R)^c)$ pour $theta in Theta_1$
  - *Puissance* : $Pi(theta) = P_theta(cal(R)) = 1-beta(theta)$ pour $theta in Theta_1$
]

== Construction d'un test (étapes)

1. Formuler $H_0$ et $H_1$ ; identifier $theta$.
2. Choisir la forme de $cal(R)$ selon $H_1$ :
   - $H_1: theta > theta_0$ $->$ $cal(R) = {T > c}$
   - $H_1: theta < theta_0$ $->$ $cal(R) = {T < c}$
   - $H_1: theta != theta_0$ (bilatère) $->$ $cal(R) = {|T| > c}$
3. Statistique de test $T = (hat(theta) - theta_0)/sqrt(Var(hat(theta)))$ normalisée sous $H_0$.
4. Trouver $c_alpha$ tel que $sup_{H_0} P(T in cal(R)) = alpha$ (ou $->alpha$).

#defn(info: "$p$-valeur")[
  Pour une réalisation $T^"obs"$ :
  - Si $cal(R) = {T > c}$ : $pval = P_{H_0}(T > T^"obs")$
  - Si $cal(R) = {T < c}$ : $pval = P_{H_0}(T < T^"obs")$
  - Si $cal(R) = {|T| > c}$ : $pval = P_{H_0}(|T| > |T^"obs"|)$

  *Règle* : on rejette $H_0$ ssi $pval < alpha$.
]

#rmk[
  Pour un test bilatère avec $T ~ cal(N)(0,1)$ ou Student (loi symétrique) :
  $pval = 2(1-F(|T^"obs"|))$ — double de la p-valeur unilatère.
]


// ──────────────────────────────────────────────────────────────
// PARTIE 9 — TESTS USUELS
// ──────────────────────────────────────────────────────────────
= Tests usuels


== Test sur $mu$ (modèle gaussien)

*$H_0: mu = mu_0$ contre $H_1: mu != mu_0$*, $sigma^2$ inconnu :
$ T = (overline(X) - mu_0)/(S_n/sqrt(n)) ~_{H_0} "Student"(n-1) $
$cal(R) = {|T| > t_{1-alpha/2}(n-1)}$

*$H_0: mu <= mu_0$ contre $H_1: mu > mu_0$* :
$ cal(R) = {T > t_{1-alpha}(n-1)} $

== Test sur $sigma^2$ (modèle gaussien)

*$H_0: sigma^2 = sigma_0^2$ contre $H_1: sigma^2 != sigma_0^2$* :
$ T = (n hat(sigma)^2)/sigma_0^2 ~_{H_0} chi^2(n-1) $
$cal(R) = {T > q_{1-alpha/2}^{chi^2(n-1)} " ou " T < q_{alpha/2}^{chi^2(n-1)}}$

== Test de Student à deux échantillons

$(X_i)$ i.i.d. $cal(N)(mu_1,sigma^2)$ et $(Y_j)$ i.i.d. $cal(N)(mu_2,sigma^2)$, indépendants, *variances égales*.

*$H_0: mu_1 = mu_2$ contre $H_1: mu_1 != mu_2$* :

Estimateur poolé de $sigma^2$ :
$ S_n^2 = 1/(n_1+n_2-2)\(sum(X_i-overline(X))^2 + sum(Y_j-overline(Y))^2\) $

Statistique :
$ T = (overline(X) - overline(Y))/(S_n sqrt(1/n_1+1/n_2)) ~_{H_0} "Student"(n_1+n_2-2) $

$cal(R) = {|T| > t_{1-alpha/2}(n_1+n_2-2)}$

$pval = 2(1 - F_{"Student"(n_1+n_2-2)}(|T^"obs"|))$

== Test asymptotique (proportion)

$(X_i)$ i.i.d. $Bern(p)$, *$H_0: p <= p_0$ contre $H_1: p > p_0$* :
$ T = (hat(p) - p_0)/sqrt((p_0(1-p_0))/n) -->^(cal(L))_(H_0) cal(N)(0,1) $
$cal(R) = {T > q_{1-alpha}}$, seuil $c_alpha = q_{1-alpha}/sqrt(n)$.

$pval = 1 - Phi(T^"obs")$


// ──────────────────────────────────────────────────────────────
// PARTIE 10 — FORMULAIRE RAPIDE
// ──────────────────────────────────────────────────────────────
= Formulaire rapide


*Quantiles usuels de $cal(N)(0,1)$* :
- $q_{0.90} approx 1.282$
- $q_{0.95} approx 1.645$
- $q_{0.975} approx 1.960$
- $q_{0.99} approx 2.326$

*Lois utiles* :
- $overline(X)$ de loi $cal(N)(mu, sigma^2/n)$ si $X_i ~ cal(N)(mu, sigma^2)$
- $overline(X) ~ cal(N)(mu, sigma^2/n)$ exacte (pas seulement asymptotique)
- TLC général : $sqrt(n)(overline(X)-mu)/sigma -->^(cal(L)) cal(N)(0,1)$

*Propriétés de $cal(N)(mu, sigma^2)$* :
- $f(x) = 1/sqrt(2pi sigma^2) e^{-(x-mu)^2/(2sigma^2)}$
- $M(t) = e^{t mu + sigma^2 t^2/2}$
- Moments centrés impairs nuls ; $EE[(X-mu)^4] = 3sigma^4$
- CL de gaussiennes indépendantes = gaussienne

*IC Bernoulli asymptotique* ($alpha = 5%$) :
$ hat(p) pm 1.96 sqrt((hat(p)(1-hat(p)))/n) $

*Biais de $hat(sigma)^2$* :
$ EE[hat(sigma)_n^2] = ((n-1)/n) sigma^2 => B = -sigma^2/n $
$=> S_n^2 = n/(n-1) hat(sigma)_n^2$ est sans biais.

*EMV dans $cal(N)(mu, sigma^2)$* :
$hat(mu) = overline(X)$, $hat(sigma)^2 = 1/n sum(X_i - overline(X))^2$ (biaisé).

*$delta$-méthode — rappel* : si $sqrt(n)(hat(theta) - theta) -->^(cal(L)) cal(N)(0, sigma^2)$ et $g$ dérivable,
$ sqrt(n)(g(hat(theta)) - g(theta)) -->^(cal(L)) cal(N)(0, (g'(theta))^2 sigma^2) $

]
