// --- CHUNK_METADATA_START ---
// src_checksum: 90ed0567dfa60ed61541e0c120b7ad6faf72510209fefb5744dc876b21c83bd3
// needs_review: True
// --- CHUNK_METADATA_END ---
// ─────────────────────────────────────────────────────────────────────────────
//  Комплексний аналіз та застосування до лінійної алгебри — Конспекти лекцій
// ─────────────────────────────────────────────────────────────────────────────

#import "@local/dobbikov:1.0.0": *

// ── Page setup ───────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.8cm, y: 3cm),
  numbering: "1",
  number-align: center,
)

#set text(font: "New Computer Modern", size: 11pt, lang: "uk")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// ── Language & theorem rules ──────────────────────────────────────────────────
#_dobbikov-lang.update(_ => "ua")
#show: thm-rules.with(qed-symbol: $square$)

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
#let accent = rgb("#1a4f82")
#align(center)[
  #v(1.5cm)
  #text(size: 22pt, weight: "bold", fill: accent)[Комплексний аналіз\та застосування до лінійної алгебри
  ]
  #v(0.6cm)
  #text(size: 13pt, fill: rgb("#555"))[Курс Антуана Левітта. Конспекти лекцій, складені Єгором Коротенком]
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
= Резольвента та спектр
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: e6c659049a5843616e099bfe5f1b60e6874f64a5f92c8bf81b9979decde11190
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення

#defn("Спектр та резольвента")[
  Нехай $A in M_n (CC)$. Множина
  $
    "Sp"(A) = {mu in CC bar.v A - mu I "не є оборотною"}.
  $
  називається *спектром* $A$.
  Для кожного $lambda in CC without "Sp"(A)$ матриця $A - lambda I$ є оборотною.
  Позначимо
  $
    R_A (lambda) = (A - lambda I)^(-1)
  $
  і її називають *резольвентою* $A$ в точці $lambda$.
]

#rmk[
  Існує альтернативний вираз. Покладемо
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
*Норма оператора* (підпорядкована норма) для $A in M_n (CC)$ це
$
  norm(A) = sup_(v in CC^n, v != 0) norm(A v)_2 / norm(v)_2.
$
Вона задовольняє $norm(A B) <= norm(A) norm(B)$. Крім того, якщо $norm(A) < 1$, то
$I - A$ є оборотним і
$
  (I - A)^(-1) = sum_(n=0)^(+infinity) A^n.
$

// --- CHUNK_METADATA_START ---
// src_checksum: 8f371a2edeb2fd23e0df819a583e4e4fe96ebd36289efca1d56561cdb3cc5ed5
// needs_review: True
// --- CHUNK_METADATA_END ---
== Розклад в степеневий ряд резольвенти

#prop("Полі, Озн. 4.8")[
  Наступний ряд збігається (локально рівномірно за операторною нормою)
  на диску $DD(0, 1/norm(A))$ :
  $
    B_A (z) = sum_(n=0)^(+infinity) z^n A^n.
  $
]

#fig(
  "figures/fig_resolvent_disk.png",
  [Область збіжності $B_A(z)=sum_(n=0)^(+infinity) z^n A^n$.
   Хрестики позначають особливості $1\/mu_i$ для $mu_i in "Sp"(A)$.],
  width: 55%,
)

#rmk[
  В околі кожної точки своєї області визначення, $B_A$ може бути
  розкладена в степеневий ряд :
  $
    B_A (z) = sum_(n=0)^(+infinity) (z - z_0)^n B_A (z_0) [A B_A (z_0)]^n.
  $
  *Мета :* вивчити цей тип функції комплексної змінної.
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
// src_checksum: 3c1f06a43e7e75d54521314c2ecd21bfb1350fb2fc69b0be2fbed59148b6336a
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення

#defn("Голоморфні функції")[
  Нехай $Omega subset CC$ є відкритою множиною, а $f : Omega -> CC$.
  Кажуть, що $f$ є *голоморфною*, коли
  $
    forall z_0 in Omega, quad
    exists epsilon > 0 "та" (a_n)_(n in NN) "такі, що" quad
    forall z in DD(z_0, epsilon), quad
    f(z) = sum_(n=0)^(+infinity) a_n (z - z_0)^n.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: c04d54222b4b7e5c81a85ebe90e8fa402702619963c10d1aed217bc7234fdc99
// needs_review: True
// --- CHUNK_METADATA_END ---
== Нагадування: збіжність степеневих рядів

#prop("Повторне нагадування")[
  Якщо $(|a_n|^(1\/n))_(n in NN)$ обмежена $M > 0$, то степеневий ряд
  $z |-> sum_(n in NN) a_n z^n$
  збігається локально рівномірно на $DD(0, 1\/M)$, і визначає функцію
  $C^infinity$ як функцію двох дійсних змінних.

  Зокрема, якщо $R < 1/M$ і $z in DD(0, R)$ :
  $
    sum_(n in NN) |a_n z^n| <= sum_(n in NN) (R M)^n < +infinity.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 750f2d736ec19c44dcd44bdabd484d59f7a6aac117c097aa95e669d544236ac4
// needs_review: True
// --- CHUNK_METADATA_END ---
== Оператор $overline(partial)$

#rmk[
  Записуючи $z = x + i y$, ми обчислюємо:
  $
    diff/(diff x) (x + i y)^n = n (x + i y)^(n-1),
    quad quad
    diff/(diff y) (x + i y)^n = i n (x + i y)^(n-1).
  $
  Зокрема, для всіх $n in NN$ :
  $
    (diff/(diff x) + i diff/(diff y))(x + i y)^n = 0.
  $
  Позначимо $overline(partial) = diff/(diff overline(z)) = 1/2 (diff/(diff x) + i diff/(diff y))$
  (також позначається $diff/(diff overline(z))$).
]

#prop[
  Якщо $f$ є голоморфною, то $overline(partial) f = 0$.
]

// --- CHUNK_METADATA_START ---
// src_checksum: 0232f18b14e987ba21516e49e7c759ef2b9e9f4b0d3ad666a1acad589691c735
// needs_review: True
// --- CHUNK_METADATA_END ---
== Приклади

Наступні функції є голоморфними:
- резольвента $lambda |-> R_A (lambda)$,
- поліноми,
- експонента $z |-> exp(z)$,
- матрична експонента $z |-> exp(z A)$.

#ex("Не-приклад")[
  Функція $z |-> overline(z)$ не є *голоморфною*, оскільки
  $
    diff/(diff x)(x - i y) = 1 != 0 = overline(partial) overline(z).
  $
]

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: d99e47e1d65d6360340379dfa6b5fa08bdd44f07e9bcf5d5259a6889f8a39b12
// needs_review: True
// --- CHUNK_METADATA_END ---
= Контурні інтеграли// ═════════════════════════════════════════════════════════════════════════════

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

Якщо $f in C^1([a,b], RR)$, тоді
$
  integral_a^b f'(x) dif x = f(b) - f(a).
$

// --- CHUNK_METADATA_START ---
// src_checksum: 0d01d154461a3f347d63c8f2f39ff11df022f41a77f2af3e4a5a6a839a3ebac5
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Версія 2D

Нехай $Omega subset RR^2$ — відкрита множина, межа якої є простою гладкою кривою $gamma$.
Обходимо $gamma$ зі швидкістю $1$; позначаємо $T = "Довжина"(gamma)$.

#fig(
  "figures/fig_contour_simple.png",
  [Простий контур $gamma = diff Omega$ орієнтований у додатному напрямку.],
  width: 42%,
)

#thm("Стоксa / Грін-Рімана")[
  Нехай $arrow(A) : Omega -> RR^2$ — векторне поле $C^1$, де
  $
    arrow(A)(x,y) = A_x (x,y) arrow(e)_x + A_y (x,y) arrow(e)_y.
  $
  Визначаємо скалярний ротор
  $
    "rot"(arrow(A)) = (diff A_y)/(diff x) - (diff A_x)/(diff y).
  $
  Тоді
  $
    integral.double_Omega "rot"(arrow(A)) dif x dif y
    = integral_0^T arrow(A)(gamma(s)) dot arrow(T)(gamma(s)) dif s,
  $
  де $arrow(T)(s) = gamma'(s)$ — дотичний вектор.
]

// --- CHUNK_METADATA_START ---
// src_checksum: 58435ff69414e338fb7b01a4ccd0184987845153f9ce12ff0f0d446a3d671eaa
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Доказ на квадраті

Візьмемо $Omega = [0,1]^2$ та $A$ афінне :
$
  A_x = c_x + a_(x x) x + a_(x y) y, quad
  A_y = c_y + a_(y x) x + a_(y y) y.
$
Отже $"rot"(arrow(A)) = a_(y x) - a_(x y)$ і
$integral.double_Omega "rot"(arrow(A)) = a_(y x) - a_(x y)$.

#fig(
  "figures/fig_square_stokes.png",
  [Квадрат $Omega = [0,1]^2$ з його чотирма пронумерованими сторонами.],
  width: 42%,
)

Параметризуємо чотири сторони і сумуємо внески:

#block(
  width: 100%,
  fill: rgb("#f5f5f5"),
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

Додавши: $integral.cont_(diff Omega) arrow(A) dot dif arrow(T) = a_(y x) - a_(x y) = integral.double_Omega "rot"(arrow(A))$. $square$

*Шлях до справжнього доведення:*
+ Спершу перевірити для афінних функцій на довільних трикутниках.
+ Апроксимувати $gamma$ багатокутною кривою, тріангулювати $Omega$ і апроксимувати $A$ афінною функцією на кожному трикутнику.

// --- CHUNK_METADATA_START ---
// src_checksum: 308e2aefe4528b612baeb3962a080235ba98415c6b01cad34c3918f57163f019
// needs_review: True
// --- CHUNK_METADATA_END ---

== Комплексний інтеграл та формула Гріна

Нехай $f : Omega -> CC$ є функцією класу $C^1$ і $gamma : [0,T] -> CC$ — гладка крива. Визначимо
$
  integral_gamma f = integral_0^T f(gamma(s)) gamma'(s) dif s.
$

Позначивши $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, обчислимо:
$
  "rot"(arrow(A))
  = i diff_x f - diff_y f
  = i (diff_x f + i diff_y f)
  = 2 i space overline(partial) f.
$

#prop[
  Якщо $f : Omega -> CC$ є функцією класу $C^1$ з $overline(partial) f = 0$, то для
  будь-якої замкненої кривої $gamma$ в $Omega$
  $
    integral.cont_gamma f = 0.
  $
]

#rmk[
  Вірно, якщо ми маємо просту криву і $f$ визначена скрізь всередині.
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
// src_checksum: b0e4bd6b2225f2c859167d2b0891aba64bedc970da5cd8d6b4717e44ebd74d9b
// needs_review: True
// --- CHUNK_METADATA_END ---
= Формула Коші
// ═════════════════════════════════════════════════════════════════════════════


#thm("Формула Коші")[
  Нехай $f in C^1(Omega, CC)$ з $overline(partial) f = 0$.
  Нехай $z_0 in Omega$. Тоді, для будь-якої кривої $gamma$, яка робить один оберт
  (у прямому напрямку) навколо $z_0$,
  $
    integral.cont_gamma f(z)/(z - z_0) dif z = 2 pi i f(z_0).
  $
]

#proof[
  Значення інтеграла не залежить від $gamma$, тому ми візьмемо $gamma_epsilon$
  — коло радіусом $epsilon$ навколо $z_0$ :
  $
    integral.cont_(gamma_epsilon) f(z)/(z - z_0) dif z
    = integral.cont_(gamma_epsilon) f(z_0)/(z - z_0) dif z
    + O(epsilon dot 1/epsilon dot epsilon)
    = O(epsilon).
  $

#fig(
    "figures/fig_cauchy_circle.png",
    [Коло $gamma_epsilon$ радіусом $epsilon$ з центром у $z_0$,
     що використовується у доведенні формули Коші.],
    width: 48%,
  )

  Параметризуємо $gamma_epsilon : theta |-> z_0 + epsilon e^(i theta)$,
  де $theta in [0, 2pi]$, тому $gamma_epsilon'(theta) = i epsilon e^(i theta)$, і
  $
    integral.cont_(gamma_epsilon) 1/(z - z_0) dif z
    = integral_(theta=0)^(2pi)
        1/(epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta
    = integral_0^(2pi) i dif theta
    = 2 pi i.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 23086b183677a5165ab0866f521076029d86bac6e421d35da2244b0e4e77face
// needs_review: True
// --- CHUNK_METADATA_END ---
== Характеристика голоморфних функцій

#thm[
  Нехай $Omega$ буде відкритою множиною в $CC$, функція $f : Omega -> CC$ класу $C^1$ така, що
  $overline(partial) f = 0$. Тоді $f$ є голоморфною.
]

#proof[
  Нехай $gamma$ — проста крива в $Omega$. Для будь-якої $z_0$ всередині
  $gamma$ формула Коші дає:
  $
    f(z_0) = 1/(2 pi i) integral.cont_gamma f(z)/(z - z_0) dif z.
  $
  Для будь-якого $z in gamma$ функція $z_0 |-> 1/(z - z_0)$ є голоморфною на
  $CC without {z}$. Після інтегрування $z_0 |-> 1/(2pi i) integral.cont_gamma f(z)/(z - z_0) dif z$
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
// src_checksum: c31eba2df3f12915ef1cee43cef6fa0153a7308d71985b1e004a7cd39f031ee0
// needs_review: True
// --- CHUNK_METADATA_END ---
== Спектральний проектор

#prop("Проєктор на власний прострі")[
  Нехай $A in M_n (CC)$ є діагоналізованою, і нехай $gamma$ — крива, що робить обхід
  навколо власного значення $mu$, не оточуючи інші. Тоді
  $
    1/(2 pi i) integral.cont_gamma R_A (z) dif z = Pi_mu,
  $
  де $Pi_mu$ є *проектором* на власний підпростір $E_mu$, паралельно до
  інших власних підпросторів.
]

#fig(
  "figures/fig_eigenvalue_contour.png",
  [Контур $gamma$, що оточує власне значення $mu$, не оточуючи інші
   власні значення (червоні хрестики).],
  width: 52%,
)

#proof[
  Оскільки $A$ є діагоналізованою, існує оборотна матриця $P$ така, що
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

  Нижній блок дорівнює нулю, оскільки $(D' - lambda I)^(-1)$ є голоморфною всередині
  $gamma$ (оскільки $mu in.not "Sp"(D')$). Верхній блок дорівнює $1$ за розрахунком
  лишків :
  $
    1/(2 pi i) integral.cont_gamma 1/(mu - lambda) dif lambda = 1.
    quad square
  $
]
