// --- CHUNK_METADATA_START ---
// src_checksum: 536a93f7cddef976c8aae9ff1febe1d6b2f0a3bf73f4bb1ebd2bc53fd33f6c8d
// needs_review: True
// --- CHUNK_METADATA_END ---
// ─────────────────────────────────────────────────────────────────────────────
//  Комплексний аналіз та застосування до лінійної алгебри — Конспекти лекцій
// ─────────────────────────────────────────────────────────────────────────────

// ── Налаштування сторінки ───────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.8cm, y: 3cm),
  numbering: "1",
  number-align: center,
)

#set text(font: "New Computer Modern", size: 11pt, lang: "fr")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// ── Палітра кольорів ────────────────────────────────────────────────────────────
#let accent   = rgb("#1a4f82")   // темно-синій
#let soft-bg  = rgb("#eef3fa")   // дуже світло-синій
#let green-bg = rgb("#eaf6ea")
#let red-bg   = rgb("#fdf0f0")
#let gray-bg  = rgb("#f5f5f5")

// ── Блоки теоремного типу ────────────────────────────────────────────────────────
#let theorem-counter  = counter("theorem")
#let def-counter      = counter("definition")
#let prop-counter     = counter("proposition")
#let rem-counter      = counter("remarque")
#let ex-counter       = counter("exemple")
#let obs-counter      = counter("observation")

#let tbox(title, body, bg: soft-bg, border: accent) = block(
  width: 100%,
  radius: 4pt,
  stroke: (left: 3pt + border, rest: 0.5pt + border.lighten(50%)),
  fill: bg,
  inset: (left: 12pt, right: 10pt, top: 8pt, bottom: 8pt),
)[
  #text(weight: "bold", fill: border)[#title] \ #v(2pt) #body
]

#let definition(title: none, body) = {
  def-counter.step()
  let head = if title != none [Définition (#title)] else [Définition]
  tbox(head, body, bg: soft-bg, border: accent)
  v(4pt)
}

#let theorem(title: none, body) = {
  theorem-counter.step()
  let head = if title != none [Théorème — #title] else [Théorème]
  tbox(head, body, bg: rgb("#e8f0fb"), border: rgb("#1a3a6e"))
  v(4pt)
}

// --- CHUNK_METADATA_START ---
// src_checksum: f7fb376b08e2fdc5b62f0d6de00a6958600e0e87333b02fd6ebd46cae4f19a40
// needs_review: True
// --- CHUNK_METADATA_END ---

#let proposition(title: none, body) = {
  prop-counter.step()
  let head = if title != none [Proposition — #title] else [Proposition]
  tbox(head, body, bg: soft-bg, border: rgb("#2e6da4"))
  v(4pt)
}

#let remarque(body) = {
  rem-counter.step()
  tbox([Remarque], body, bg: gray-bg, border: rgb("#888"))
  v(4pt)
}

#let observation(body) = {
  obs-counter.step()
  tbox([Observation], body, bg: green-bg, border: rgb("#2e7d32"))
  v(4pt)
}

#let exemple(title: none, body) = {
  ex-counter.step()
  let head = if title != none [Exemple — #title] else [Exemple]
  tbox(head, body, bg: rgb("#fef9e7"), border: rgb("#b8860b"))
  v(4pt)
}

#let proof(body) = {
  block(inset: (left: 8pt), stroke: (left: 1.5pt + rgb("#aaa")))[
    _Preuve._ #body #h(1fr) $square$
  ]
  v(4pt)
}

// ── Figure helper ─────────────────────────────────────────────────────────────
#let fig(path, cap, width: 60%) = {
  figure(
    image(path, width: width),
    caption: cap,
  )
  v(4pt)
}

// ═════════════════════════════════════════════════════════════════════════════
//  TITLE PAGE
// ═════════════════════════════════════════════════════════════════════════════
#align(center)[
  #v(1.5cm)
  #text(size: 22pt, weight: "bold", fill: accent)[
    Комплексний аналіз\
    та застосування до лінійної алгебри
  ]
  #v(0.6cm)
  #text(size: 13pt, fill: rgb("#555"))[Курс Антуана Левітта. Конспекти лекцій Єгора Коротенка]
  #v(2cm)
  #line(length: 60%, stroke: 1.5pt + accent)
  #v(2cm)
]

#outline(indent: 1em)

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: c1433885ed2311ec067a57fef10a2e1f2b0ad0940fa904eb0b6f9869350c8ce5
// needs_review: True
// --- CHUNK_METADATA_END ---
= Резольвента і спектр
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: b16c577c98c7c95de3e465cc9ce12f54f083938119f1a1bcdd5c2bffcb3f7f9a
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення

#definition(title: "Спектр та резольвента")[
  Нехай $A in M_n (CC)$. *Спектром* $A$ називають множину
  $
    "Sp"(A) = {mu in CC bar.v A - mu I "не є оберненою"}.
  $
  Для будь-якого $lambda in CC without "Sp"(A)$ матриця $A - lambda I$ є оберненою.
  Позначаємо
  $
    R_A (lambda) = (A - lambda I)^(-1)
  $
  і називаємо її *резольвентою* $A$ в точці $lambda$.
]

#remarque[
  Маємо альтернативний вираз. Покладемо
  $
    B_A (z) = (I - z A)^(-1), quad
    z in CC without {1/mu bar.v mu in "Sp"(A)}.
  $
  Прямий розрахунок дає
  $
    R_A (lambda) = -1/lambda space B_A (1/lambda).
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 30a2bb384c6d397ea036b1e070e5bac64d25c452ad36954dbb055d3234d7f6ec
// needs_review: True
// --- CHUNK_METADATA_END ---
== Норма оператора

Оснащуємо $CC^n$ евклідовою нормою $norm(dot)_2$.
*Норма оператора* (підпорядкована норма) для $A in M_n (CC)$ є
$
  norm(A) = sup_(v in CC^n, v != 0) norm(A v)_2 / norm(v)_2.
$
Вона задовольняє $norm(A B) <= norm(A) norm(B)$. Крім того, якщо $norm(A) < 1$, тоді
$I - A$ є оборотною і
$
  (I - A)^(-1) = sum_(n=0)^(+infinity) A^n.
$

// --- CHUNK_METADATA_START ---
// src_checksum: 16f21f9c4c418c3f3f51f90da45744b9ff2a4c4b8935b19bca133ce5c314daac
// needs_review: True
// --- CHUNK_METADATA_END ---
== Розклад резольвенти в степеневий ряд

#proposition(title: "Poly, Prop. 4.8")[
  Наступний ряд збігається (локально рівномірно за операторною нормою)
  на диску $DD(0, 1/norm(A))$ :
  $
    B_A (z) = sum_(n=0)^(+infinity) z^n A^n.
  $
]

#fig(
  "figures/fig_resolvent_disk.png",
  [Область збіжності $B_A(z)=sum_(n=0)^(+infinity) z^n A^n$.
   Хрестики позначають сингулярності $1\/mu_i$ для $mu_i in "Sp"(A)$.],
  width: 55%,
)

#remarque[
  В околі кожної точки своєї області визначення, $B_A$ розкладається в степеневий ряд:
  $
    B_A (z) = sum_(n=0)^(+infinity) (z - z_0)^n B_A (z_0) [A B_A (z_0)]^n.
  $
  *Мета:* вивчити цей тип функції комплексної змінної.
]

Алгебраїчний розрахунок показує, що, поклавши $C = I - z_0 A$ та $D = (z - z_0) A$ :
$
  B_A (z)
  = (I - z A)^(-1)
  = (I - z_0 A - (z - z_0) A)^(-1)
  = (C - D)^(-1)
  = sum_(n=0)^(+infinity) C^(-1) (D C^(-1))^n.
$

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: da3c707b756c0b3b639f935298b21350891e0ac0f6e7d124047670897222ba8c
// needs_review: True
// --- CHUNK_METADATA_END ---
= Голоморфні функції
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: fbb87865e9bf26cb8905517e57f16dba39736b34d90e31608a56ce648d68a872
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення

#definition(title: "Голоморфна функція")[
  Нехай $Omega subset CC$ є відкритою множиною і $f : Omega -> CC$.
  Кажуть, що $f$ є *голоморфною*, коли
  $
    forall z_0 in Omega, quad
    exists epsilon > 0 "і" (a_n)_(n in NN) "такі, що" quad
    forall z in DD(z_0, epsilon), quad
    f(z) = sum_(n=0)^(+infinity) a_n (z - z_0)^n.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 8a4f235a701e9bb3e60f7a17855b5f1aa4066ad8d51fa321bff04d0247575211
// needs_review: True
// --- CHUNK_METADATA_END ---
== Нагадування: збіжність степеневих рядів

#proposition(title: "Коротке нагадування")[
  Якщо $(|a_n|^(1\/n))_(n in NN)$ обмежена $M > 0$, тоді степеневий ряд
  $z |-> sum_(n in NN) a_n z^n$
  збігається локально рівномірно на $DD(0, 1\/M)$, і визначає функцію
  $C^infinity$ як функцію двох дійсних змінних.

  Зокрема, якщо $R < 1/M$ і $z in DD(0, R)$ :
  $
    sum_(n in NN) |a_n z^n| <= sum_(n in NN) (R M)^n < +infinity.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: b7bebbfc7f56a9f2723ad2193c1fa4d59e5301e0360a6afa4ea9724a69404230
// needs_review: True
// --- CHUNK_METADATA_END ---
== Оператор $overline(partial)$

#observation[
  Записуючи $z = x + i y$, обчислюємо:
  $
    diff/(diff x) (x + i y)^n = n (x + i y)^(n-1),
    quad quad
    diff/(diff y) (x + i y)^n = i n (x + i y)^(n-1).
  $
  Зокрема, для будь-якого $n in NN$ :
  $
    (diff/(diff x) + i diff/(diff y))(x + i y)^n = 0.
  $
  Позначимо $overline(partial) = diff/(diff overline(z)) = 1/2 (diff/(diff x) + i diff/(diff y))$
  (також позначається $diff/(diff overline(z))$).
]

#proposition[
  Якщо $f$ є голоморфною, то $overline(partial) f = 0$.
]

// --- CHUNK_METADATA_START ---
// src_checksum: 610dc4c4e8f1f83a40def0ec8e3d33b37cd6c6684d1b21c95256bdba051017a1
// needs_review: True
// --- CHUNK_METADATA_END ---
== Приклади

Наступні функції є голоморфними:
- резольвента $lambda |-> R_A (lambda)$,
- поліноми,
- експонента $z |-> exp(z)$,
- матрична експонента $z |-> exp(z A)$.

#exemple(title: "Не-приклад")[
  Функція $z |-> overline(z)$ не є *голоморфною*, тому що
  $
    diff/(diff x)(x - i y) = 1 != 0 = overline(partial) overline(z).
  $
]

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: d99e47e1d65d6360340379dfa6b5fa08bdd44f07e9bcf5d5259a6889f8a39b12
// needs_review: True
// --- CHUNK_METADATA_END ---
= Контурні інтеграли
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 339d8a772f2ac0599da1ef84e8f391ca0c56a794863afee54fcb634b82027aed
// needs_review: True
// --- CHUNK_METADATA_END ---
== Формула Стокса / Теорема Ампера

// --- CHUNK_METADATA_START ---
// src_checksum: 0c8a41521a47fc449c030ff8aaccc9043b52e78ed216eea0933628381b52eb8b
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Версія 1D

Якщо $f in C^1([a,b], RR)$, то
$
  integral_a^b f'(x) dif x = f(b) - f(a).
$

// --- CHUNK_METADATA_START ---
// src_checksum: d702148d071a549797fe2f5c4c90e10421f63a01ca278cc8b8081ea3729b8611
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Версія 2D

Нехай $Omega subset RR^2$ — відкрита множина, границя якої є простою регулярною кривою $gamma$.
Ми обходимо $gamma$ зі швидкістю $1$; ми позначаємо $T = "Довжина"(gamma)$.

#fig(
  "figures/fig_contour_simple.png",
  [Простий контур $gamma = diff Omega$ орієнтований у додатному напрямку.],
  width: 42%,
)

#theorem(title: "Стокса / Гріна-Рімана")[
  Нехай $arrow(A) : Omega -> RR^2$ — векторне поле $C^1$, де
  $
    arrow(A)(x,y) = A_x (x,y) arrow(e)_x + A_y (x,y) arrow(e)_y.
  $
  Визначимо скалярний ротор
  $
    "rot"(arrow(A)) = (diff A_y)/(diff x) - (diff A_x)/(diff y).
  $
  Тоді
  $
    integral.double_Omega "rot"(arrow(A)) dif x dif y
    = integral_0^T arrow(A)(gamma(s)) dot arrow(T)(gamma(s)) dif s,
  $
  де $arrow(T)(s) = gamma'(s)$ є дотичним вектором.
]

// --- CHUNK_METADATA_START ---
// src_checksum: d84cbd93cd1f8437e08d435e8da82b81ec20f46f53f0dbc422d156acd6e1fd66
// needs_review: True
// --- CHUNK_METADATA_END ---

=== Доказ для квадрата

Візьмемо $Omega = [0,1]^2$ і $A$ афінне:
$
  A_x = c_x + a_(x x) x + a_(x y) y, quad
  A_y = c_y + a_(y x) x + a_(y y) y.
$
Отже $"rot"(arrow(A)) = a_(y x) - a_(x y)$ і
$integral.double_Omega "rot"(arrow(A)) = a_(y x) - a_(x y)$.

#fig(
  "figures/fig_square_stokes.png",
  [Квадрат $Omega = [0,1]^2$ з чотирма пронумерованими сторонами.],
  width: 42%,
)

Параметризуємо чотири сторони і сумуємо внески:

#block(
  width: 100%,
  fill: gray-bg,
  radius: 4pt,
  inset: 10pt,
)[
$
  &(1): quad s |-> (s, 0), s in [0,1],
    &&integral_0^1 A_x (s,0) dif s = c_x + a_(x x)/2 \

  &(2): quad s |-> (1, s), s in [0,1],
    &&integral_0^1 A_y (1,s) dif s = c_y + a_(y x) + a_(y y)/2 \

  &(3): quad s |-> (1-s, 1), s in [0,1],
    &&-integral_0^1 A_x (1-s,1) dif s = -(c_x + a_(x y) + a_(x x)/2) \

  &(4): quad s |-> (0, 1-s), s in [0,1],
    &&-integral_0^1 A_y (0,1-s) dif s = -(c_y + a_(y y)/2)
$
]

Додавши : $integral.cont_(diff Omega) arrow(A) dot dif arrow(T) = a_(y x) - a_(x y) = integral.double_Omega "rot"(arrow(A))$. $square$

*Шлях до справжнього доказу:*
+ Спочатку перевірити для афінних функцій на довільних трикутниках.
+ Апроксимувати $gamma$ багатокутною кривою, тріангулювати $Omega$, і апроксимувати $A$ афінною функцією на кожному трикутнику.

// --- CHUNK_METADATA_START ---
// src_checksum: 088a09dc6583c1002ad32004d63b9f31de997da87f6265d5adeb4d914ec9f5c2
// needs_review: True
// --- CHUNK_METADATA_END ---
== Комплексний інтеграл і Формула Гріна

Нехай $f : Omega -> CC$ є класу $C^1$ і $gamma : [0,T] -> CC$ — гладка крива. Визначимо:
$
  integral_gamma f = integral_0^T f(gamma(s)) gamma'(s) dif s.
$

Поклавши $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, обчислимо:
$
  "ротор"(arrow(A))
  = i diff_x f - diff_y f
  = i (diff_x f + i diff_y f)
  = 2 i space overline(partial) f.
$

#proposition[
  Якщо $f : Omega -> CC$ є класу $C^1$ з $overline(partial) f = 0$, то для
  будь-якої кривої $gamma$ замкненої в $Omega$,
  $
    integral.cont_gamma f = 0.
  $
]

#remarque[
  Вірно, якщо маємо просту криву і $f$ визначена всюди всередині.
  Загалом для гомологічних контурів:
  $
    integral.cont_(gamma_1) f = 0,
    quad
    integral.cont_(gamma_2) f = integral.cont_(gamma_3) f,
    quad
    integral.cont_(gamma_5) f = integral.cont_(gamma_2) f + integral.cont_(gamma_4) f.
  $
]

#fig(
  "figures/fig_nested_contours.png",
  [Гомологічні контури: $gamma_1$ (малий ізольований контур), $gamma_2, gamma_3$ (вкладені контури), $gamma_4$ (контур з отвором), $gamma_5$ (великий зовнішній контур).],
  width: 80%,
)

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: 1b2f077bceae01f507742d2732a05b511f43acc81e4a6d5adb923c46be1f9083
// needs_review: True
// --- CHUNK_METADATA_END ---
= Формула Коші
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 545be3864fdac137a19a17da09422d5a29f6e4a800de40e197f14a7b666614a8
// needs_review: True
// --- CHUNK_METADATA_END ---
== Твердження

#theorem(title: "Формула Коші")[
  Нехай $f in C^1(Omega, CC)$ з $overline(partial) f = 0$.
  Нехай $z_0 in Omega$.  Тоді, для будь-якої кривої $gamma$, яка робить один оберт
  (у прямому напрямку) навколо $z_0$,
  $
    integral.cont_gamma f(z)/(z - z_0) dif z = 2 pi i f(z_0).
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: cf13be78ab52a9ec06eff0ddeccbf87099146e5477b2b8d0fa8613b7e76370fd
// needs_review: True
// --- CHUNK_METADATA_END ---
== Доказ

Значення інтеграла не залежить від $gamma$, тому ми беремо $gamma_epsilon$ — коло радіусом $epsilon$ навколо $z_0$ :
$
  integral.cont_(gamma_epsilon) f(z)/(z - z_0) dif z
  = integral.cont_(gamma_epsilon) f(z_0)/(z - z_0) dif z
  + O(epsilon dot 1/epsilon dot epsilon)
  = O(epsilon).
$

#fig(
  "figures/fig_cauchy_circle.png",
  [Коло $gamma_epsilon$ радіусом $epsilon$ з центром у $z_0$,
   використане в доказі формули Коші.],
  width: 48%,
)

Параметризуємо $gamma_epsilon : theta |-> z_0 + epsilon e^(i theta)$,
$theta in [0, 2pi]$, отже $gamma_epsilon'(theta) = i epsilon e^(i theta)$ і
$
  integral.cont_(gamma_epsilon) 1/(z - z_0) dif z
  = integral_(theta=0)^(2pi)
      1/(epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta
  = integral_0^(2pi) i dif theta
  = 2 pi i.
$

// --- CHUNK_METADATA_START ---
// src_checksum: 87f542353ea9184316759eb7602103d45c0cc621206445c3b0ec2a42558e2b41
// needs_review: True
// --- CHUNK_METADATA_END ---
== Характеристика голоморфних функцій

#theorem[
  Нехай $Omega$ — відкрита множина в $CC$, $f : Omega -> CC$ класу $C^1$, така що
  $overline(partial) f = 0$.  Тоді $f$ є голоморфною функцією.
]

#proof[
  Нехай $gamma$ — проста крива в $Omega$.  Для будь-якого $z_0$ всередині
  $gamma$, формула Коші дає
  $
    f(z_0) = 1/(2 pi i) integral.cont_gamma f(z)/(z - z_0) dif z.
  $
  Для будь-якого $z in gamma$, функція $z_0 |-> 1/(z - z_0)$ є голоморфною на
  $CC without {z}$.  Після інтегрування, $z_0 |-> 1/(2pi i) integral.cont_gamma f(z)/(z - z_0) dif z$
  є голоморфною на $omega = "Int"(gamma)$.
]

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: 7e05636f40fbf4f25ec422c348b97f18aefc0b0482f990c0f91b5a55a1cd8bce
// needs_review: True
// --- CHUNK_METADATA_END ---
= Застосування до лінійної алгебри
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 99aa02c594469d39505057f3791686b5f001b28c217321628f51d263a3c88cab
// needs_review: True
// --- CHUNK_METADATA_END ---
== Спектральний проектор

#proposition(title: "Проектор на власний простір")[
  Нехай $A in M_n (CC)$ діагоналізовна, і нехай $gamma$ — крива, що робить один обхід
  навколо власного значення $mu$, не оточуючи інші. Тоді
  $
    1/(2 pi i) integral.cont_gamma R_A (z) dif z = Pi_mu,
  $
  де $Pi_mu$ є *проектором* на власний простір $E_mu$, паралельно до
  інших власних просторів.
]

#fig(
  "figures/fig_eigenvalue_contour.png",
  [Контур $gamma$, що оточує власне значення $mu$, не оточуючи інші
   власні значення (червоні хрестики).],
  width: 52%,
)

// --- CHUNK_METADATA_START ---
// src_checksum: 6c8f64a5ce641316f7d834cb193c5d198d73b5eb7c34ee83011f39d8b5036c2c
// needs_review: True
// --- CHUNK_METADATA_END ---
== Доказ

Оскільки $A$ є діагоналізованою, існує оборотна $P$ така, що
$
  A = P^(-1) mat(mu, 0; 0, D') P,
  quad mu in.not "Sp"(D').
$
Тоді
$
  (A - lambda I)^(-1)
  = P^(-1)
    mat((mu - lambda)^(-1), 0; 0, (D' - lambda I)^(-1))
    P.
$
Інтегруємо по $gamma$ :
$
  1/(2 pi i) integral.cont_gamma (A - lambda I)^(-1) dif lambda
  &= P^(-1)
     mat(display(1/(2 pi i) integral.cont_gamma dif lambda/(mu - lambda)), 0;
         0, 0)
     P \
  &= P^(-1)
     mat(1, 0; 0, 0)
     P
  = Pi_mu.
$

Нижній блок дорівнює нулю, оскільки $(D' - lambda I)^(-1)$ є голоморфним всередині
$gamma$ (оскільки $mu in.not "Sp"(D')$). Верхній блок дорівнює $1$ за обчисленням лишків:
$
  1/(2 pi i) integral.cont_gamma 1/(mu - lambda) dif lambda = 1.
  quad square
$

