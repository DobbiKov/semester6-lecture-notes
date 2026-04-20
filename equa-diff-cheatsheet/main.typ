#import "@local/dobbikov:1.0.0":*

// ── Compact theorem environments ─────────────────────────────────────────────
#let _red = thm-red-color
#let _tf   = x => text(fill: _red, size: 0.92em)[#strong(smallcaps(x))]
#let _nf   = x => text(fill: _red, size: 0.92em)[#strong(smallcaps([~(#x)]))]
#let _sep  = text(fill: _red)[*.*#h(0.15em)]

#let _mk(head, bf: true) = thm-with-info(thm-plain2(
  head,
  stroke: (left: _red + 0.8pt),
  fill: none,
  inset: (left: 0.35em, right: 0pt, y: 0.08em),
  title-fmt: _tf,
  name-fmt: _nf,
  separator: _sep,
  body-fmt: if bf { emph } else { x => x },
  counter: "thm",
  base-level: 1,
  padding: (y: 0.4em),
))

#let prop = _mk("Prop.")
#let defn = _mk("Def.", bf: false)

// ── Global rules ──────────────────────────────────────────────────────────────
#show: thm-rules.with(qed-symbol: $square$)

#set page(
  paper: "a4",
  margin: (x: 4mm, y: 5mm),
  numbering: none,
  header: none,
  footer: none,
)
#set text(font: "New Computer Modern", size: 10pt, lang: "fr", fallback: false)
#set par(spacing: 0.25em, first-line-indent: 0pt, justify: true)
#set block(spacing: 0.22em)
#set figure(gap: 0.05em)
#show math.equation.where(block: true): set block(above: 0.15em, below: 0.15em)
#set heading(numbering: "1.")
#set enum(indent: 0.3em, body-indent: 0.3em)
#set list(indent: 0.3em, body-indent: 0.3em)

#show heading.where(level: 1): it => {
  v(0.35em, weak: true)
  block(fill: _red, width: 100%, inset: (x: 3pt, y: 2pt),
    text(fill: white, size: 8pt, weight: "bold", smallcaps(it.body))
  )
  v(0.12em, weak: true)
}

// ── Title bar ─────────────────────────────────────────────────────────────────
#block(fill: luma(230), width: 100%, inset: (x: 5pt, y: 3pt),
  stack(dir: ltr,
    text(size: 9pt, weight: "bold")[Équations Différentielles — Cheatsheet],
    h(1fr),
    text(size: 7.5pt, style: "italic")[Yehor KORORTENKO],
  )
)
#v(0.25em)

// ── Content ──────────────────────────────────────────────────────────────────
#columns(2, gutter: 3.5mm)[

= Chapitre 1

#prop[Les solutions de $y' = a y$ sur $RR$ sont $y(t) = C e^(a t)$, $C in RR$.]

#prop[Soit $a : I -> RR$ continue, $A$ primitive de $a$.
Les solutions de $y' = a(t) y$ sur $I$ sont $y(t) = C e^(A(t))$, $C in RR$.]

#prop[Soit $a, b in cal(C)^0(I)$, $A$ primitive de $a$, $t_0 in I$.
$y$ est solution de $y' = a(t)y + b(t)$ ssi $exists C in RR$ tel que
$ y(t) = C e^(A(t)) + integral_(t_0)^t e^(A(t)-A(s)) b(s) dif s. $]

#defn[Une *EDO d'ordre 1* sur $I$ : $y' = f(t, y)$, $f : I times U -> RR$ continue.
*Autonome* si $f$ ne dépend pas de $t$, *linéaire* si $f = a(t)x+b(t)$, *homogène* si $b=0$.]

#defn[$(J, y)$ est *solution* de $y' = f(t,y)$ si $y in cal(C)^1(J)$, $y(t) in U$,
$y'(t) = f(t, y(t))$. *Globale* si $J=I$, *locale* sinon.]

#defn[$(J_2,y_2)$ *prolonge* $(J_1,y_1)$ si $J_1 subset J_2$ et $y_2|_(J_1)=y_1$.
$(J_1,y_1)$ est *maximale* si non prolongeable.]

#prop("Cauchy-Lipschitz")[Si $f in cal(C)^1(I times U)$, le problème $y' = f(t,y)$, $y(t_0)=y_0$ admet une *unique solution maximale*.]

#defn[*EDO d'ordre $n$* : $y^((n)) = F(t,y,y',dots,y^((n-1)))$;
solution $(J,y)$ avec $y in cal(C)^n(J)$.]

#prop[L'EDO d'ordre $n$ est équivalente à $Y' = G(t,Y)$ via
$Y = (y,dots,y^((n-1)))^top$, où $G = (x_2,dots,x_n,F)^top$.]

#prop("Régularité")[Si $F in cal(C)^k$ et $(J,Y)$ est solution, alors $Y in cal(C)^(k+1)(J)$.]

= Chapitre 2

#defn[Système *linéaire* : $Y' = A(t)Y + B(t)$, $A : I -> cal(M)_n$, $B : I -> RR^n$ continues. *Homogène* si $B=0$.]

#prop[$Y$ est solution du problème de Cauchy $Y'=A(t)Y+B(t)$, $Y(t_0)=X_0$ ssi
$ Y(t) = X_0 + integral_(t_0)^t [A(s)Y(s)+B(s)] dif s. $]

*Picard :* $Y_0 = X_0$, $Y_(n+1)(t) = X_0 + integral_(t_0)^t [A Y_n+B] dif s$; converge, $norm(W_n) <= A^(n-1) M t^n slash n!$

#prop("CL linéaire")[Si $A,B$ continues, le problème de Cauchy a une *unique solution maximale globale*.]

#prop[Les solutions de $Y'=A(t)Y$ forment un *s.e.v.* de $cal(C)^1(I,RR^n)$.]

#prop[Si $Y_1,Y_2$ sont solutions de $Y'=A Y+B$, alors $Y_1-Y_2$ est solution de l'homogène.]

#prop("Superposition")[Toute solution de $Y'=A Y+B$ s'écrit $Y=Y_0+Z$, $Y_0$ particulière, $Z$ homogène.]

#prop[L'espace $cal(S)_H$ a *dimension $n$*. Isomorphisme : $X_0 |-> Y_(X_0)$.]

#defn[$exp(A) = sum_(k>=0) A^k slash k!$ converge normalement.]

*Cas :* $e^0=I$; $A$ diag. $=> e^A=$ diag$(e^(lambda_i))$; $A^p=0 => e^A = sum_0^(p-1) A^k slash k!$; $A=P B P^(-1) => e^A=P e^B P^(-1)$.

#prop[Si $A B=B A$, alors $e^(A+B)=e^A e^B$.]

#prop("Jordan-Chevalley")[$forall f$ linéaire sur $CC^n$, $exists!$ décomposition $f=d+n$, $d$ diag., $n$ nilp., $d n = n d$.]

*Algo :* (1) $chi_f = product(X-lambda_j)^(m_j)$ ; (2) base $cal(B)_j$ de $ker(A-lambda_j)^(m_j)$ ; (3) $d(u)=lambda_j u$ ; (4) $n=f-d$.

#prop[Pour le bloc Jordan $T_j = lambda_j I + N_j$ :
$ e^(T_j) = e^(lambda_j)(I + N_j + dots + N_j^(m_j-1) slash (m_j-1)!). $]

#prop[$phi(t)=e^(t A)$ est $cal(C)^oo$; $phi(t_1+t_2)=phi(t_1)phi(t_2)$; $phi(t)^(-1)=phi(-t)$; $(dif slash dif t)e^(t A)=A e^(t A)$.]

#prop[Solution unique de $Y'=A Y$, $Y(0)=X_0$ : $Y(t)=e^(t A)X_0$.]

#prop[Solutions complexes de $Y'=A Y$ : combinaisons de $t |-> e^(t lambda_j) t^k u_(j,k)$, $k <= m_j-1$.]

*Var. cte. (cst.) :* $Y_p(t) = e^(t A) integral_(t_0)^t e^(-s A) B(s) dif s$.

#prop[Solutions réelles ($A in cal(M)_n(RR)$) : combinaisons de $e^(t a_j) cos(b_j t) t^k u$ et $e^(t a_j) sin(b_j t) t^k v$.]

#defn[*Résolvante :* $R(t,t_0) = Phi_t compose Phi_(t_0)^(-1)$; pour $A$ cst. : $R(t,t_0)=e^((t-t_0)A)$.]

#prop[$R(t,t)=I$; $R(t_2,t_1)R(t_1,t_0)=R(t_2,t_0)$; $partial_t R=A(t)R$; $R^(-1)(t,t_0)=R(t_0,t)$.]

#defn[*SFS* : ${Y_1,dots,Y_n}$ libres dans $cal(C)^1(I,RR^n)$. *Wronskien :* $cal(W)(t)=det(Y_1(t)|dots|Y_n(t))$.]

#prop("Liouville")[$cal(W)(t)=exp(integral_(t_0)^t "Tr" A(s) dif s) != 0$; les colonnes de $R(t,t_0)$ forment un SFS.]

*Var. cte. (var.) :* $Y_p(t) = R(t,t_0) integral_(t_0)^t R(t_0,s) B(s) dif s$.

*Ordre 2 :* Pour $y''+p y'+q y=f$, SFS $(y_1,y_2)$; chercher $y_p=alpha_1 y_1+alpha_2 y_2$ avec
$alpha'_1 y_1 + alpha'_2 y_2 = 0$, $alpha'_1 y'_1 + alpha'_2 y'_2 = f$.

= Chapitre 3

*Euler explicite :* $y_0=x_0$, $y_(n+1)=y_n+h f(t_n,y_n)$.

#defn[*Erreur globale :* $e(h)=max_n |y(t_n)-y_n^h|$.]

#defn[Schéma *convergent* si $e(h)->0$ quand $h->0$.]

#defn[*Erreur de consistance locale :* $epsilon_n(h)=y(t_{n+1})-y(t_n)-h f(t_n,y(t_n))$.
Erreur *globale :* $epsilon(h)=sum|epsilon_n(h)|$. Euler ($f in cal(C)^1$) : $|epsilon_n|<=M h^2$, $epsilon(h)<=M' h$ ⟹ ordre 1.]

#prop[Euler explicite est d'ordre *exactement 1*.]

#defn[Schéma *stable* si $exists C>0$ : $|z_n^h - y_n^h| <= C(|z_0-y_0|+sum_(m<n)|delta_m|)$.]

#prop[Si $f$ est $L$-Lipschitz en $y$, Euler est stable avec $C=e^(L(t-t_0))$.]

#prop("Lax")[Consistance $+$ Stabilité $=>$ Convergence. Pour Euler : $e(h)=O(h)$.]

*Euler implicite :* $y_(n+1)=y_n+h f(t_(n+1),y_(n+1))$. Stable $forall h>0$ sur $y'=-a y$.

*Heun (RK2) :* $p_1=f(t_n,y_n)$, $p_2=f(t_n+h,y_n+h p_1)$, $y_(n+1)=y_n+h(p_1+p_2)slash 2$.

*Ordre 2 RK (2 étages) :* $b_1+b_2=1$, $b_2 c_2=1/2$, $b_2 a_(2,1)=1/2$. Famille $b_2=1/(2alpha)$, $c_2=a_(2,1)=alpha$.

#prop[Schéma $y_(n+1)=y_n+h Phi(t,y_n,h)$ consistant $<=>$ $Phi(t,x,0)=f(t,x)$. RK : $<=>$ $sum b_i=1$.]

*RK4 :* tableau de Butcher $c=(0,1/2,1/2,1)^top$, $b=(1/6,1/3,1/3,1/6)^top$.

]
