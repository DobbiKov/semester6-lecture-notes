// --- CHUNK_METADATA_START ---
// src_checksum: bf4f053b3c601460c29af9ad86cf2929568bea904bfd20b2084876a0221ff75e
// --- CHUNK_METADATA_END ---
// ─────────────────────────────────────────────────────────────────────────────
// Розділ: Комплексний аналіз та застосування до лінійної алгебри
// На основі курсу Антуана Левітта — Університет Париж-Сакле
// ─────────────────────────────────────────────────────────────────────────────

#import "@local/dobbikov:1.0.0": *
#import "@preview/cetz:0.4.2": canvas, draw
#let math-font = "New Computer Modern Math"
#let text-font =  "New Computer Modern"

#show math.text: it => {
  let tostr(it) = if type(it) == str {it}
    else if type(it) != content {str(it)}
    else if it.has("text") {it.text}
    else if it.has("children") {it.children.map(tostr).join()}
    else if it.has("body") {tostr(it.body)}
    else if it == [ ] {" "}
  if tostr(it).match(regex("[0-9]")) != none {
    text(font: math-font, it)
  }
  else {
    text(font: text-font, it)
  }
}

#set math.equation(numbering: "(1)")

#show: dobbikov.with(
  title: [Комплексний аналіз та його застосування до лінійної алгебри],
  subtitle: [Самостійний вступ],
  author: "На основі курсу Антуана Левітта, Університет Париж-Сакле | Єгор Коротенко",date: none,
  report-style: true,
  language: "ua",
)

// ─────────────────────────────────────────────────────────────────────────────
// ВСТУП
// ─────────────────────────────────────────────────────────────────────────────
// --- CHUNK_METADATA_START ---
// src_checksum: bd4fc42129273d9f1334f0eecc78656b2c1a6044d736065e3cb6485abd002741
// --- CHUNK_METADATA_END ---
= Вступ

Цей розділ пропонує короткий, але самодостатній вступ до комплексного аналізу, маючи на увазі єдину мету: дійти до формули *спектрального проєктора*

$ Pi_mu = 1/(2 pi i) integral.cont_gamma R_A (z) dif z, $

яка видобуває проєктор на власний простір матриці $A$ з контурного інтеграла її резольвенти. Попутно ми розвиватимемо справжню геометричну та аналітичну інтуїцію — а не просто формули.

Центральною темою є дивовижне явище жорсткості. Функція $f : RR -> RR$ може бути диференційованою скрізь, не маючи представлення у вигляді степеневого ряду. Функція $f : CC -> CC$, яка є диференційованою скрізь у комплексному сенсі, *автоматично* є степеневим рядом. Цей єдиний факт — доведення якого проходить через теорему Стокса та формулу Коші — робить комплексний аналіз таким потужним.

*Дорожня карта.* Ми рухаємося п'ятьма кроками:
+ *Голоморфні функції* — що означає комплексна диференційовність геометрично (§2)
+ *Контурні інтеграли* — інтегрування вздовж кривих у $CC$ (§3)  
+ *Теорема Стокса* — чому голоморфні функції мають нульові інтеграли по замкненому контуру (§4)
+ *Формула Коші* — граничні дані визначають внутрішні значення (§5)
+ *Застосування до лінійної алгебри* — спектральний проєктор (§6)

// ─────────────────────────────────────────────────────────────────────────────
// §2  ГОЛОМОРФНІ ФУНКЦІЇ
// ─────────────────────────────────────────────────────────────────────────────
// --- CHUNK_METADATA_START ---
// src_checksum: 39429ca730c773e67d54fe69badf373c02bf648de0a15239d090d6bd662aead7
// --- CHUNK_METADATA_END ---
= Голоморфні функції
// --- CHUNK_METADATA_START ---
// src_checksum: b12522606a44c882e22cd61870dbe2dbe7b29c926e1baf0457ce5b5d9f4a76f0
// needs_review: True
// --- CHUNK_METADATA_END ---
== Геометричний зміст комплексної диференційовності

Функція $f : RR^2 -> RR^2$ є диференційовною в точці $p_0$, якщо існує матриця $J f(p_0)$ — якобіан — така, що
$ f(p_0 + h) = f(p_0) + J f(p_0) dot h + o(|h|). $
Якобіан може бути *будь-якою* матрицею $2 times 2$: він може представляти обертання, зсув, відображення, асиметричне розтягування або будь-яку їх комбінацію.

Комплексна площина $CC$ має додаткову структуру, якої немає у $RR^2$: *множення*. Множення на комплексне число $w = r e^(i theta)$ діє на $RR^2$ як одночасне обертання на $theta$ та масштабування на $r$. Як матриця:
$ z mapsto w z quad "відповідає" quad mat(a, -b; b, a), quad w = a + i b. $
Це *дуже* особлива матриця $2 times 2$ — вона має лише 2 вільні параметри
замість 4. Додаткове обмеження: $a_(11) = a_(22)$ і $a_(12) = -a_(21)$.

#defn[
  Нехай $Omega subset CC$ є відкритою множиною, а $f : Omega -> CC$. Ми говоримо, що $f$ є *голоморфною* на $Omega$, якщо для кожної точки $z_0 in Omega$ існує окіл, на якому $f$ може бути виражена у вигляді збіжного степеневого ряду:
  $ f(z) = sum_(n=0)^infinity a_n (z - z_0)^n. $
]

#insight[
  Голоморфна = локально виглядає як множення на комплексне число. Збільшуючи
  масштаб поблизу будь-якої точки $z_0$, функція $f$ поводиться як $f(z_0 + h)
  approx f(z_0) + f'(z_0) dot h$, де $f'(z_0) in CC$, а множення
  є *комплексним* множенням — обертанням і масштабуванням вхідного
  зміщення $h$. Без відображень, без зсувів, без асиметричних розтягувань.
]

// --- CHUNK_METADATA_START ---
// src_checksum: 818f5cb68710ed7e21fdf0209347d16ae0c69fd4abb5f6de545ba493aac5db53
// needs_review: True
// --- CHUNK_METADATA_END ---
== Оператор $overline(partial)$ та рівняння Коші-Рімана

Записуючи $z = x + i y$, будь-яку гладку $f : CC -> CC$ можна розглядати як таку, що залежить від двох незалежних "координат" $z$ та $overline(z)$, оскільки
$ x = (z + overline(z))/2, quad y = (z - overline(z))/(2i). $
Ланцюгове правило дає природні диференціальні оператори у цьому новому базисі:
$ partial_z = 1/2 (partial_x - i partial_y), quad overline(partial) equiv partial_(overline(z)) = 1/2 (partial_x + i partial_y). $
Вони не визначаються таким чином — вони *виводяться* зі зміни змінних. Одразу перевіряємо, що $partial_z (z^n) = n z^(n-1)$, $overline(partial)(z^n) = 0$, і $overline(partial)(overline(z)) = 1$. Отже, $overline(partial)$ — це "антиголоморфна похідна" — вона виявляє залежність від $overline(z)$.

#thm("Cauchy-Riemann")[
  Нехай $f = u + i v$ (де $u, v$ — дійснозначні функції) буде класу $C^1$. Наступні твердження є еквівалентними:
  + $overline(partial) f = 0$,
  + $partial_x u = partial_y v$ і $partial_y u = -partial_x v$ (рівняння Коші-Рімана),
  + Якобіан $J f$ має вигляд $mat(a, -b; b, a)$ для деяких $a, b in RR$,
  + $f$ є комплексно-диференційовною в кожній точці, причому $f'(z_0) = a + i b$.
]

#proof[
  Еквівалентність (1) і (2) є прямим обчисленням: $overline(partial) f = frac(1,2)(partial_x + i partial_y)(u + i v) = frac(1,2)[(partial_x u - partial_y v) + i(partial_x v + partial_y u)]$, що дорівнює нулю тоді й лише тоді, коли $partial_x u = partial_y v$ і $partial_y u = -partial_x v$.

  Для (2) $<=>$ (3): якобіан дорівнює $J f = mat(partial_x u, partial_y u; partial_x v, partial_y v)$. Рівняння Коші-Рімана є точною умовою $partial_x u = partial_y v$ і $partial_y u = -partial_x v$, що дає $J f = mat(a, -b; b, a)$, де $a = partial_x u$, $b = partial_x v$.

  Для (3) $<=>$ (4): Якобіан $J f$ у формі $mat(a,-b;b,a)$ діє на $h = h_1 + i h_2$ як $(a + i b)(h_1 + i h_2)$ — тобто комплексне множення на $a + i b = f'(z_0)$. $square$
]

// --- CHUNK_METADATA_START ---
// src_checksum: 777ec6f9f7be4ea373c3adc7b12790342459de44ee2e468d99ea5a891b668707
// --- CHUNK_METADATA_END ---
#figure(
  canvas({
    import draw: *
    // Ліворуч: неголоморфний (z-комплексно-спряжений, відбиття)
    set-style(stroke: (thickness: 0.8pt))
    
    // Вхідна сітка ліворуч
    for i in range(4) {
      line((0.5 + i * 0.6, 0.3), (0.5 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((0.3, 0.5 + i * 0.5), (2.1, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    rect((0.9, 0.9), (1.5, 1.5), stroke: (paint: blue.darken(20%), thickness: 1.2pt), fill: blue.lighten(85%))
    content((1.2, 1.2), text(size: 8pt, fill: blue.darken(30%))[$square$])
    content((1.1, 0.1), text(size: 8pt)[вхід $z$])
    
    // Стрілка
    line((2.5, 1.2), (3.1, 1.2), mark: (end: ">", size: 0.2), stroke: (paint: blue.darken(20%)))
    content((2.8, 1.45), text(size: 7.5pt, fill: blue.darken(20%))[$f(z) = overline(z)$])

    // Вихідна сітка ліворуч (відбита)
    for i in range(4) {
      line((3.5 + i * 0.6, 0.3), (3.5 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((3.3, 0.5 + i * 0.5), (5.1, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    // Відбитий квадрат (той самий x, перевернутий y відносно центру 1.2)
    rect((3.9, 0.9), (4.5, 1.5), stroke: (paint: red.darken(20%), thickness: 1.2pt), fill: red.lighten(85%))
    content((4.2, 1.2), text(size: 8pt, fill: red.darken(30%))[$square$])
    content((4.1, 0.1), text(size: 8pt)[відбитий — не голоморфний.])

    // Праворуч: голоморфний (z^2, обертання+масштабування)
    for i in range(4) {
      line((6.2 + i * 0.6, 0.3), (6.2 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((6.0, 0.5 + i * 0.5), (8.0, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    rect((6.6, 0.9), (7.2, 1.5), stroke: (paint: blue.darken(20%), thickness: 1.2pt), fill: blue.lighten(85%))
    content((6.9, 1.2), text(size: 8pt, fill: blue.darken(30%))[$square$])
    content((6.8, 0.1), text(size: 8pt)[вхід $z$])

    line((8.3, 1.2), (8.9, 1.2), mark: (end: ">", size: 0.2), stroke: (paint: teal.darken(20%)))
    content((8.6, 1.45), text(size: 7.5pt, fill: teal.darken(20%))[$f(z) = z^2$])

    for i in range(4) {
      line((9.2 + i * 0.6, 0.3), (9.2 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((9.0, 0.5 + i * 0.5), (11.0, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    // Повернутий квадрат (паралелограм для імітації обертання+масштабування)
    line((9.6, 1.5), (10.15, 1.3), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((10.15, 1.3), (9.95, 0.75), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((9.95, 0.75), (9.4, 0.95), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((9.4, 0.95), (9.6, 1.5), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    rect((9.35, 0.7), (10.2, 1.55), stroke: none, fill: teal.lighten(85%))
    line((9.6, 1.5), (10.15, 1.3), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((10.15, 1.3), (9.95, 0.75), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((9.95, 0.75), (9.4, 0.95), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    line((9.4, 0.95), (9.6, 1.5), stroke: (paint: teal.darken(20%), thickness: 1.2pt))
    content((9.8, 1.15), text(size: 8pt, fill: teal.darken(30%))[$square$])
    content((9.9, 0.1), text(size: 8pt)[обернений+масштабований — голо.])
  }),
  caption: [Зліва: $f(z) = overline(z)$ відображає площину — Якобіан має вигляд $mat(1,0;0,-1)$, який *не* має вигляду $mat(a,-b;b,a)$, тому він не є голоморфним. Справа: $f(z) = z^2$ локально обертає та масштабує — Якобіан має особливий вигляд, тому він є голоморфним.]
)
// --- CHUNK_METADATA_START ---
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// src_checksum: ca01e0ee72f7542d01f53b68be2137488fea1445463c16214eafc26fa1e833b4
// needs_review: True
// --- CHUNK_METADATA_END ---
== Приклади та контрприклади

Наступні функції є голоморфними:
- Поліноми $p(z) = a_0 + a_1 z + dots + a_n z^n$ (степеневі ряди, що закінчуються після скінченної кількості членів)
- Комплексна експонента $z mapsto exp(z) = sum_(n=0)^infinity z^n / n!$  
- Матрична експонента $z mapsto exp(z A)$ для фіксованої $A in M_n (CC)$
- Резольвента $lambda mapsto R_A (lambda) = (A - lambda I)^(-1)$, на $CC without "Sp"(A)$

Наступні *не* є голоморфними:
- $f(z) = overline(z)$: дає $overline(partial) f = 1 != 0$
- $f(z) = |z|^2 = z overline(z)$: дає $overline(partial) f = z != 0$ (крім $z = 0$)
- $f(z) = "Re"(z) = x$: дає $overline(partial) f = 1/2 != 0$

#rmk[
  $f(z) = |z|^2$ є комплексно-диференційовною в $z = 0$ (границя $|h|^2 / h = overline(h) -> 0$ при $h -> 0$), але більше ніде. Бути диференційовною в одній ізольованій точці *не* означає бути голоморфною — голоморфність вимагає диференційовності у відкритому околі.
]

// ─────────────────────────────────────────────────────────────────────────────
// §3  КОНТУРНІ ІНТЕГРАЛИ
// ─────────────────────────────────────────────────────────────────────────────

// --- CHUNK_METADATA_START ---
// src_checksum: 38b2150ec3f70ca0b11e71f1d5b85583a4356c7e4629db3851ef5db35aa5b76a
// --- CHUNK_METADATA_END ---
= Контурні інтеграли
// --- CHUNK_METADATA_START ---
// src_checksum: 1a8900523bc96d3df414260679505fd64f0d5bf1106ac17efbb4399150bf52dc
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення
#defn(info: "Контурний інтеграл")[
*Контур* (або *крива*) у $CC$ — це $C^1$-відображення $gamma : [0, T] -> CC$.
*Контурний інтеграл* від $f$ уздовж $gamma$ визначається як

$ integral_gamma f dif z := integral_0^T f(gamma(t)) dot gamma'(t) dif t. $
]

Це точно такий же, як дійсний інтеграл $integral_a^b f(x) dif x$, за винятком того, що:
- Ми інтегруємо вздовж *кривої* у $CC$, а не відрізка в $RR$
- У кожній точці ми множимо $f(gamma(t))$ на $gamma'(t)$ — *швидкість* кривої, комплексне число, що кодує як швидкість, так і напрямок
- Результатом є комплексне число

Множник $gamma'(t) dif t$ є нескінченно малим переміщенням $dif z$ уздовж кривої. На дійсному відрізку $gamma(t) = t$ ми маємо $gamma'(t) = 1$, і визначення зводиться до звичайного інтеграла.
// --- CHUNK_METADATA_START ---
// src_checksum: 609232ca62f14a6e0e8e567f6656ab1c774e0d0492c7b593f40180c575291932
// needs_review: True
// --- CHUNK_METADATA_END ---
#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))

    // Axes
    line((-0.2, 0), (4.5, 0), mark: (end: ">", size: 0.15), stroke: (paint: gray.darken(20%), thickness: 0.6pt))
    line((0, -0.3), (0, 3.2), mark: (end: ">", size: 0.15), stroke: (paint: gray.darken(20%), thickness: 0.6pt))
    content((4.6, 0), text(size: 9pt)[$"Re"$])
    content((0.05, 3.35), text(size: 9pt)[$"Im"$])

    // Ellipse-ish contour
    let pts = ((0.8,0.5),(1.2,0.2),(2.0,0.15),(2.8,0.3),(3.4,0.8),(3.6,1.5),(3.3,2.3),(2.4,2.8),(1.4,2.7),(0.7,2.1),(0.5,1.4),(0.6,0.9),(0.8,0.5))
    for i in range(pts.len() - 1) {
      line(pts.at(i), pts.at(i+1), stroke: (paint: teal.darken(20%), thickness: 1.5pt))
    }
    // Arrow on contour
    let mid = pts.at(9)
    let nxt = pts.at(10)
    line(mid, nxt, mark: (end: ">", size: 0.22), stroke: (paint: teal.darken(20%), thickness: 1.5pt))
    content((0.1, 2.2), text(size: 9pt, fill: teal.darken(30%))[$gamma$])

    // A point on the curve
    let pt = (2.2, 2.75)
    circle(pt, radius: 0.07, fill: blue.darken(20%), stroke: none)
    content((2.4, 2.95), text(size: 9pt, fill: blue.darken(30%))[$gamma(t)$])

    // Velocity arrow at that point
    line((2.2, 2.75), (1.5, 2.52), mark: (end: ">", size: 0.2), stroke: (paint: orange.darken(20%), thickness: 1.5pt))
    content((1.6, 2.2), text(size: 9pt, fill: orange.darken(30%))[$gamma'(t)$])

    // Tiny dz annotation
    content((3.0, 2.0), text(size: 8.5pt, fill: gray.darken(40%))[tiny step $dif z = gamma'(t) dif t$])
    
    // Pintegral.cont z0 inside
    circle((2.0, 1.4), radius: 0.07, fill: red.darken(20%), stroke: none)
    content((2.2, 1.3), text(size: 9pt, fill: red.darken(30%))[$z_0$])
  }),
  caption: [Контур $gamma$ у $CC$. У кожній точці $gamma(t)$, швидкість $gamma'(t)$ задає напрямок і швидкість руху. Контурний інтеграл накопичує добутки $f(gamma(t)) dot gamma'(t) dif t$ — крихітні комплексні внески — по всій кривій.]
)

// --- CHUNK_METADATA_START ---
// src_checksum: ef74ff599195350c3d6926b72251d12b9b791f01bc1d3f787e1580d45c35dd5c
// --- CHUNK_METADATA_END ---
== Незалежність від шляху та замкнені контури

Два шляхи $gamma_1, gamma_2$ від $z_0$ до $z_1$ дають однаковий інтеграл, коли
$ integral_(gamma_1) f dif z = integral_(gamma_2) f dif z <==> integral_(gamma_1) f dif z - integral_(gamma_2) f dif z = 0. $
Але "$gamma_1$ з наступним $gamma_2$ у зворотному напрямку" це *замкнений контур*. Отже, незалежність від шляху еквівалентна наступному: *кожен інтеграл по замкненому контуру дорівнює нулю*:
$ integral.cont_gamma f dif z = 0 quad "для будь-якого замкненого" gamma. $
// --- CHUNK_METADATA_START ---
// src_checksum: a5464747470a73bd55e9cf5ee19da29edd6b9b64f2e92e0b3f011b9de4ebfdd7
// --- CHUNK_METADATA_END ---
== Фундаментальний приклад: інтеграл обходу

Нехай $z_0 in CC$ і $gamma_epsilon : theta mapsto z_0 + epsilon e^(i theta)$, $theta in [0, 2 pi]$ буде колом радіуса $epsilon$ навколо $z_0$. Тоді $gamma_epsilon' (theta) = i epsilon e^(i theta)$ і:

$ integral.cont_(gamma_epsilon) frac(1, z - z_0) dif z = integral_0^(2pi) frac(1, epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta = integral_0^(2pi) i dif theta = 2 pi i. $

$epsilon$ повністю скорочується — відповідь $2 pi i$ є *незалежною від радіуса*. Це найважливіший інтеграл у комплексному аналізі.

#rmk[
  Функція $1/(z - z_0)$ діє як "вихор", зосереджений у $z_0$: вона є голоморфною скрізь, окрім самої точки $z_0$, а інтегрування навколо $z_0$ завжди дає $2 pi i$ незалежно від форми петлі, якщо вона обходить $z_0$ один раз.
]

// ─────────────────────────────────────────────────────────────────────────────
// §4  ТЕОРЕМА СТОКСА ТА НУЛЬОВІ КОНТУРНІ ІНТЕГРАЛИ
// ─────────────────────────────────────────────────────────────────────────────
// --- CHUNK_METADATA_START ---
// src_checksum: 5c0ea600b0ac1386f177ef9f0611aff88e7a5db55418817e6d421b155610a590
// --- CHUNK_METADATA_END ---
= Теорема Стокса та нульові інтеграли по замкненому контуру
// --- CHUNK_METADATA_START ---
// src_checksum: 765e782d8df74bebf69a4c3fab03efe5c3064904cc19d0ae10639ee8ed4f77f2
// needs_review: True
// --- CHUNK_METADATA_END ---
== Ротор і теорема Стокса

Для векторного поля $arrow(A) = A_x arrow(e)_x + A_y arrow(e)_y$ на $RR^2$, *скалярний ротор* (ротаціал) вимірює локальне обертання:
$ "rot"(arrow(A)) = partial_x A_y - partial_y A_x. $
Геометрично: розмістіть крихітне лопатеве колесо в точці рідини. Якщо потік змушує його обертатися, ротор там відмінний від нуля. Якщо потік локально "збалансований" — стільки ж приходить з одного боку, скільки й з іншого — ротор дорівнює нулю, і колесо залишається нерухомим.

// --- CHUNK_METADATA_START ---
// src_checksum: 384955fe8e45ebe0e37cefc2aedc6441578616037b0582d167a7b9492c567c2f
// --- CHUNK_METADATA_END ---
#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))

    // Ліворуч: нульова вихровість (рівномірний потік)
    content((1.5, 3.3), text(size: 9pt, weight: "bold")[нульова вихровість])
    for row in range(4) {
      for col in range(4) {
        let x = 0.4 + col * 0.8
        let y = 0.4 + row * 0.7
        line((x - 0.28, y), (x + 0.28, y), mark: (end: ">", size: 0.15), stroke: (paint: teal.darken(20%), thickness: 1pt))
      }
    }
    // Лопатеве колесо (нерухоме)
    circle((1.5, 1.55), radius: 0.22, stroke: (paint: orange.darken(20%), thickness: 1pt), fill: none)
    line((1.5, 1.33), (1.5, 1.77), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((1.28, 1.55), (1.72, 1.55), stroke: (paint: orange.darken(20%), thickness: 1pt))
    content((1.5, 0.1), text(size: 8pt, fill: orange.darken(30%))[колесо залишається нерухомим])

    // Праворуч: ненульова вихровість (вихор)
    content((6.2, 3.3), text(size: 9pt, weight: "bold")[ненульова вихровість])
    let cx = 6.2
    let cy = 1.6
    for row in range(4) {
      for col in range(4) {
        let x = 4.8 + col * 0.9
        let y = 0.4 + row * 0.7
        let dx = x - cx
        let dy = y - cy
        let r2 = dx * dx + dy * dy + 0.01
        let vx = -dy / r2
        let vy = dx / r2
        let mag = calc.sqrt(vx*vx + vy*vy)
        let scale = 0.25 / calc.max(mag, 0.01)
        let nx = vx * scale
        let ny = vy * scale
        line((x - nx, y - ny), (x + nx, y + ny), mark: (end: ">", size: 0.15), stroke: (paint: teal.darken(20%), thickness: 1pt))
      }
    }
    circle((cx, cy), radius: 0.06, fill: red.darken(20%), stroke: none)
    // Обертове лопатеве колесо
    circle((cx, cy), radius: 0.22, stroke: (paint: orange.darken(20%), thickness: 1pt), fill: none)
    line((cx, cy - 0.22), (cx + 0.18, cy + 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((cx + 0.22, cy), (cx - 0.18, cy + 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((cx, cy + 0.22), (cx - 0.18, cy - 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    content((cx, 0.25), text(size: 8pt, fill: orange.darken(30%))[колесо обертається])
    content((cx, 0.05), text(size: 8pt, fill: red.darken(30%))[сингулярність у центрі])

  }),
  caption: [Ліворуч: однорідний потік має нульовий ротор — лопатеве колесо, розміщене будь-де, залишається нерухомим. Праворуч: вихор має ненульовий ротор — лопатеве колесо обертається. Ротор вимірює локальне обертання рідини.]
)
// --- CHUNK_METADATA_START ---
// src_checksum: c3d96d22d309896c6c8139a3910c89d078ff388f073572de242c333d9a8e9331
// --- CHUNK_METADATA_END ---
#thm("Стоукс / Ґрін")[Нехай $Omega subset RR^2$ буде обмеженою відкритою множиною з гладкою межею $gamma = partial Omega$ (орієнтованою проти годинникової стрілки), а $arrow(A) : overline(Omega) -> RR^2$ — векторним полем класу $C^1$. Тоді
  $ integral.cont_(partial Omega) arrow(A) dot dif arrow(T) = integral.double_Omega "rot"(arrow(A)) dif x dif y. $
]

Ідея доведення: розбити $Omega$ на крихітні квадрати зі стороною $epsilon$. На кожному квадраті внески від спільних внутрішніх ребер взаємно знищуються (протилежні орієнтації). Залишається зовнішня межа. На кожному крихітному квадраті підінтегральна функція приблизно постійна, що дає внесок $approx "rot"(arrow(A)) dot epsilon^2$.
// --- CHUNK_METADATA_START ---
// src_checksum: bb5961d4a0f8113fbd4fbcde8fdfc1650695502999e38af0f1d3137a4e623df9
// --- CHUNK_METADATA_END ---
== Зв'язок з комплексними інтегралами

Записуючи комплексний інтеграл $integral_gamma f dif z$ у дійсних координатах з $f(x,y)$ та $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, отримуємо:
$ "rot"(arrow(A)) = i partial_x f - partial_y f = i(partial_x f + i partial_y f) = 2i overline(partial) f. $

#prop[
  Нехай $f : Omega -> CC$ буде $C^1$ з $overline(partial) f = 0$. Тоді для будь-якої замкненої кривої $gamma$ в $Omega$,
  $ integral.cont_gamma f dif z = 0. $
]

#proof[
  За теоремою Стокса, $integral.cont_gamma f dif z = integral.double_"interior" "rot"(arrow(A)) dif x dif y = integral.double 2i overline(partial) f dif x dif y = 0$.
]

#insight[
  Чому $overline(partial) f = 0$ дає нульові інтеграли по замкненому контуру? Тому що голоморфні функції *локально виглядають як обертання та масштабування*. Обходячи будь-який контур та множачи кожен крок на локальне обертання+масштабування, внески від протилежних сторін контуру ідеально компенсуються. Неголоморфні функції порушують цю симетрію — вони можуть розтягуватися по-різному в різних напрямках, і компенсація не відбувається. Ротор $"rot"(arrow(A)) = 2i overline(partial) f$ точно вимірює цю асиметрію.
]
// --- CHUNK_METADATA_START ---
// src_checksum: c22edfb7bd969a510173e858ee14a094343e282eac6437d9d5c86360c1258b0e
// --- CHUNK_METADATA_END ---
== Обчислення по малому квадрату

Перевіримо ключову оцінку явно. Розглянемо квадрат з вершиною в $z_0 = x_0 + i y_0$ і стороною $epsilon$. Рухаючись проти годинникової стрілки, чотири сторони вносять внесок:
// --- CHUNK_METADATA_START ---
// src_checksum: 0d1df5326d873d9f081a6e3c14db52a0bca763d768f85aa044d47cac72de0423
// --- CHUNK_METADATA_END ---
#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))
    
    let x0 = 1.0
    let y0 = 0.8
    let e = 2.4

    rect((x0, y0), (x0 + e, y0 + e), stroke: (paint: gray.darken(20%), thickness: 0.6pt), fill: blue.lighten(93%))

    // Side 1: bottom, left->right
    line((x0 + 0.3, y0), (x0 + e - 0.3, y0), mark: (end: ">", size: 0.18), stroke: (paint: blue.darken(30%), thickness: 1.8pt))
    content((x0 + e/2, y0 - 0.35), text(size: 8pt, fill: blue.darken(30%))[(1) $dif z = epsilon$, start $z_0$])

    // Side 2: right, bottom->top
    line((x0 + e, y0 + 0.3), (x0 + e, y0 + e - 0.3), mark: (end: ">", size: 0.18), stroke: (paint: teal.darken(30%), thickness: 1.8pt))
    content((x0 + e + 0.05, y0 + e/2), anchor: "west", text(size: 8pt, fill: teal.darken(30%))[(2) $dif z = i epsilon$, start $z_0 + epsilon$])

    // Side 3: top, right->left
    line((x0 + e - 0.3, y0 + e), (x0 + 0.3, y0 + e), mark: (end: ">", size: 0.18), stroke: (paint: orange.darken(30%), thickness: 1.8pt))
    content((x0 + e/2, y0 + e + 0.35), text(size: 8pt, fill: orange.darken(30%))[(3) $dif z = -epsilon$, start $z_0 + i epsilon$])

    // Side 4: left, top->bottom
    line((x0, y0 + e - 0.3), (x0, y0 + 0.3), mark: (end: ">", size: 0.18), stroke: (paint: red.darken(30%), thickness: 1.8pt))
    content((x0 - 0.05, y0 + e/2), anchor: "east", text(size: 8pt, fill: red.darken(30%))[(4) $dif z = -i epsilon$])

    // Corner labels
    content((x0 - 0.05, y0 - 0.2), text(size: 8.5pt)[$z_0$])
    content((x0 + e + 0.02, y0 - 0.2), text(size: 8.5pt)[$z_0 + epsilon$])
    content((x0 + e + 0.02, y0 + e + 0.12), text(size: 8.5pt)[$z_0 + epsilon + i epsilon$])
    content((x0 - 0.05, y0 + e + 0.12), text(size: 8.5pt)[$z_0 + i epsilon$])

    // epsilon label
    line((x0, y0 - 0.6), (x0 + e, y0 - 0.6), stroke: (paint: gray.darken(30%), thickness: 0.5pt))
    content((x0 + e/2, y0 - 0.78), text(size: 8.5pt)[$epsilon$])
  }),
  caption: [Чотири сторони крихітного квадрата зі стороною $epsilon$ з кутом у $z_0$, обходиться проти годинникової стрілки. Кожна сторона вносить $f("куток") times dif z$ до контурного інтеграла.]
)
// --- CHUNK_METADATA_START ---
// src_checksum: 1ec58b4d494887e8587d5ae44c9b6be933d3ab5ed162f98aca35952e52d2ce75
// --- CHUNK_METADATA_END ---
Сума всіх чотирьох внесків становить:
$ f(z_0) dot epsilon + f(z_0 + epsilon) dot i epsilon + f(z_0 + i epsilon) dot (-epsilon) + f(z_0) dot (-i epsilon). $

Групуючи та використовуючи $f(z_0 + epsilon) approx f(z_0) + epsilon partial_x f$ і $f(z_0 + i epsilon) approx f(z_0) + i epsilon partial_y f$:

$ = epsilon^2 [i partial_x f - partial_y f] = epsilon^2 dot i (partial_x f + i partial_y f) = 2i epsilon^2 overline(partial) f(z_0). $

Отже, $integral.cont_(partial square) f dif z approx 2i epsilon^2 overline(partial) f(z_0)$. Якщо $overline(partial) f = 0$, кожен квадрат дає нульовий внесок, і інтеграл по всьому контуру зникає.

// ─────────────────────────────────────────────────────────────────────────────
// §5 ФОРМУЛА КОШІ
// ─────────────────────────────────────────────────────────────────────────────
// --- CHUNK_METADATA_START ---
// src_checksum: 5ad06db9469d9f856307de1d4457288e51f9a6c6523b3a7db242770ee20a501a
// --- CHUNK_METADATA_END ---
= Формула Коші
// --- CHUNK_METADATA_START ---
// src_checksum: a2bf4bd5c610826ab663d542068ea36c596f80cc103fbe352e528b387db4ee02
// needs_review: True
// --- CHUNK_METADATA_END ---
== Твердження

#thm("Cauchy's Integral Formula")[
  Нехай $f : Omega -> CC$ буде $C^1$ з $overline(partial) f = 0$, і нехай $z_0 in Omega$. Для будь-якої замкнутої кривої $gamma$, яка один раз обходить проти годинникової стрілки навколо $z_0$ і повністю лежить у $Omega$:
  $ integral.cont_gamma frac(f(z), z - z_0) dif z = 2 pi i f(z_0). $
  Еквівалентно:
  $ f(z_0) = 1/(2 pi i) integral.cont_gamma frac(f(z), z - z_0) dif z. $
]

#insight[
  Ця формула говорить щось дивовижне: значення голоморфної функції в одній внутрішній точці $z_0$ є *повністю визначеним* її значеннями на граничному контурі $gamma$. У дійсному аналізі значення функції у внутрішніх точках не залежать від граничних значень. Для голоморфних функцій граничні значення жорстко контролюють усе всередині — як мильна плівка, натягнута на дротяний контур, де дріт (межа) повністю визначає форму плівки (внутрішню частину).
]

// --- CHUNK_METADATA_START ---
// src_checksum: 0e54684a76783b60811289167e19700ecbc216feaa1e1c99b98b535829b47d88
// needs_review: True
// --- CHUNK_METADATA_END ---
#proof[
Функція $g(z) = f(z)/(z - z_0)$ є голоморфною на $Omega without {z_0}$, але має особливість у $z_0$.

*Крок 1: деформація.* Оскільки $g$ є голоморфною в кільцевій області між $gamma$ та будь-яким малим колом $gamma_epsilon$ радіуса $epsilon$ навколо $z_0$, за теоремою Стокса маємо:
$ integral.cont_gamma g dif z = integral.cont_(gamma_epsilon) g dif z. $
Великий контур можна зменшити до крихітного контуру, не змінюючи значення інтеграла.

#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))

    // Outer contour
    hobby((0.5, 1.5), (1.2, 0.3), (3.0, 0.2), (4.2, 1.0), (4.0, 2.5), (2.5, 3.2), (1.0, 2.8), (0.5, 1.5),
      stroke: (paint: blue.darken(20%), thickness: 1.8pt), fill: blue.lighten(95%))
    
    // Shaded annular region fill
    circle((2.3, 1.7), radius: 0.65, fill: white, stroke: none)
    
    // Inner circle
    circle((2.3, 1.7), radius: 0.65, stroke: (paint: red.darken(20%), thickness: 1.5pt, dash: "dashed"), fill: none)
    
    // z0 point
    circle((2.3, 1.7), radius: 0.07, fill: red.darken(30%), stroke: none)
    content((2.55, 1.6), text(size: 9pt, fill: red.darken(30%))[$z_0$])

    // Arrows on contours
    content((4.2, 2.1), text(size: 9.5pt, fill: blue.darken(30%))[$gamma$])
    content((3.05, 1.7), text(size: 9.5pt, fill: red.darken(30%))[$gamma_epsilon$])

    // Region label
    content((3.5, 0.85), text(size: 8.5pt, fill: gray.darken(40%))[g holomorphic here])

    // epsilon label
    line((2.3, 1.7), (2.95, 1.7), stroke: (paint: gray.darken(20%), thickness: 0.5pt))
    content((2.63, 1.88), text(size: 8pt)[$epsilon$])

    // Equals sign
    content((5.3, 1.7), text(size: 14pt)[$=>$])
    content((6.0, 1.7), text(size: 10pt)[$integral.cont_gamma = integral.cont_(gamma_epsilon)$])
  }),
  caption: [Деформація контуру. Оскільки $g = f slash (z - z_0)$ є голоморфною в затіненій кільцевій області між $gamma$ та малим колом $gamma_epsilon$, обидва інтеграли рівні. Ми можемо стягнути $gamma$ до крихітного кола без зміни інтеграла.])

*Крок 2: наближення.* На $gamma_epsilon$, коли $epsilon -> 0$ ми маємо $f(z) -> f(z_0)$, тому:
$ integral.cont_(gamma_epsilon) frac(f(z), z - z_0) dif z approx f(z_0) integral.cont_(gamma_epsilon) frac(1, z - z_0) dif z = f(z_0) dot 2 pi i, $
де останній інтеграл було обчислено явно в §3. Помилка наближення становить $O(epsilon)$ і зникає, коли $epsilon -> 0$, що завершує доведення. 
]
// --- CHUNK_METADATA_START ---
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// src_checksum: 92a3986825c9e4d73a2dbff475b1ad60cbd915a4a5f4624553295f86af5e6796
// needs_review: True
// --- CHUNK_METADATA_END ---
== Від формули Коші до степеневих рядів

Формула Коші є *генератором степеневих рядів*. Зафіксуємо $z_0$ і запишемо $w$ як близьку точку. Розкладемо ядро Коші в геометричний ряд:
$ frac(1, z - w) = frac(1, (z - z_0) - (w - z_0)) = frac(1, z - z_0) sum_(n=0)^infinity frac((w - z_0)^n, (z - z_0)^n). $

Підставляючи у формулу Коші та міняючи місцями суму й інтеграл (що обґрунтовано рівномірною збіжністю):
$ f(w) = sum_(n=0)^infinity underbrace(lr([frac(1, 2 pi i) integral.cont_gamma frac(f(z), (z - z_0)^(n+1)) dif z], size: #100%))_(=: a_n) (w - z_0)^n. $

Це є справжній степеневий ряд для $f$ в околі $z_0$ — що доводить, що комплексна диференційовність всюди *змушує* $f$ бути степеневим рядом. Це диво не має аналогів у дійсному аналізі.

// ─────────────────────────────────────────────────────────────────────────────
// §6 ЗАСТОСУВАННЯ: СПЕКТРАЛЬНИЙ ПРОЕКТОР
// ─────────────────────────────────────────────────────────────────────────────

// --- CHUNK_METADATA_START ---
// src_checksum: f59aa9bfe6a678d5adc2089513362ca09968ca228313d53331e256ca88e912c5
// --- CHUNK_METADATA_END ---
= Застосування: Спектральний Проектор

Тепер ми переходимо до результату лінійної алгебри. Протягом цього розділу $A in M_n (CC)$.
// --- CHUNK_METADATA_START ---
// src_checksum: 9cd3f34be80e1b91b146eaf49e24036f941f0796216b2422997eab11ae67c325
// --- CHUNK_METADATA_END ---
== Резольвента

#defn[
  *Спектр* $A$ — це $"Sp"(A) = {mu in CC | A - mu I "not invertible"}$. Для $lambda in.not "Sp"(A)$ *резольвента* має вигляд
  $ R_A (lambda) = (A - lambda I)^(-1). $
]

Резольвента є матричнозначною функцією від $lambda$. Вона голоморфна на $CC without "Sp"(A)$: за рядом Неймана, для $|lambda - lambda_0| < 1 slash ||R_A (lambda_0)||$,
$ R_A (lambda) = sum_(n=0)^infinity (lambda - lambda_0)^n R_A (lambda_0)^(n+1). $
Сингулярності $R_A (lambda)$ є саме власними значеннями $A$.
// --- CHUNK_METADATA_START ---
// src_checksum: 108a4471284842db69f7d43c318210a9ee6d439704061129eb62a5662115e1a7
// --- CHUNK_METADATA_END ---
== Спектральний проектор
// --- CHUNK_METADATA_START ---
// src_checksum: 9b04dc2386f63dbbad9d22f908b96d81652be0256ec168753a94536e00284d93
// --- CHUNK_METADATA_END ---
#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))

    // Complex plane
    line((-0.3, 0), (5.5, 0), mark: (end: ">", size: 0.12), stroke: (paint: gray.darken(20%), thickness: 0.5pt))
    line((0, -0.4), (0, 3.5), mark: (end: ">", size: 0.12), stroke: (paint: gray.darken(20%), thickness: 0.5pt))
    content((5.6, 0.05), text(size: 8pt)[$"Re"$])
    content((0.1, 3.6), text(size: 8pt)[$"Im"$])

    // Other eigenvalues (crosses)
    let others = ((1.0, 2.2), (0.8, 0.6), (1.5, 1.3), (2.5, 2.8))
    for pt in others {
      let x = pt.at(0)
      let y = pt.at(1)
      line((x - 0.12, y - 0.12), (x + 0.12, y + 0.12), stroke: (paint: red.darken(20%), thickness: 1.5pt))
      line((x - 0.12, y + 0.12), (x + 0.12, y - 0.12), stroke: (paint: red.darken(20%), thickness: 1.5pt))
    }

    // Target eigenvalue mu
    let mx = 3.8
    let my = 1.2
    line((mx - 0.12, my - 0.12), (mx + 0.12, my + 0.12), stroke: (paint: blue.darken(30%), thickness: 2pt))
    line((mx - 0.12, my + 0.12), (mx + 0.12, my - 0.12), stroke: (paint: blue.darken(30%), thickness: 2pt))
    content((mx + 0.25, my + 0.22), text(size: 9pt, fill: blue.darken(30%))[$mu$])

    // Contour around mu only
    circle((mx, my), radius: 0.75, stroke: (paint: blue.darken(20%), thickness: 2pt, dash: none), fill: blue.lighten(93%))
    
    // Arrow on circle (tangent segment indicating CCW direction)
    line((mx + 0.74, my - 0.1), (mx + 0.74, my + 0.18), mark: (end: ">", size: 0.18), stroke: (paint: blue.darken(20%), thickness: 2pt))
    content((mx + 1.05, my + 0.85), text(size: 9pt, fill: blue.darken(30%))[$gamma$])

    // Annotation
    content((2.0, 0.2), text(size: 8pt, fill: red.darken(30%))[other eigenvalues])
    content((2.0, 0.0), text(size: 8pt, fill: red.darken(30%))[stay outside $gamma$])

    // Formula
    content((2.8, 3.1), text(size: 9pt)[$Pi_mu = frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z$])
  }),
  caption: [Контур $gamma$ обходить один раз цільове власне значення $mu$ (синій хрестик), тоді як усі інші власні значення (червоні хрестики) залишаються поза $gamma$. Контурний інтеграл резольвенти виділяє спектральний проектор на власний простір $E_mu$.]
)
// --- CHUNK_METADATA_START ---
// src_checksum: bd86f815ffc4a3bd56771369da29337e6b386c6b6799b17daeff95b235d7570c
// --- CHUNK_METADATA_END ---
#prop("Спектральний Проєктор")[
  Нехай $A in M_n (CC)$ діагоналізовна, $mu$ — власне значення $A$, а $gamma$ — замкнена крива, яка обходить $mu$ один раз проти годинникової стрілки, але не обходить жодного іншого власного значення. Тоді
  $ Pi_mu := 1/(2 pi i) integral.cont_gamma R_A (z) dif z $
  є проектором на власний підпростір $E_mu = ker(A - mu I)$, паралельний до суми всіх інших власних підпросторів.
]

#proof[
  Оскільки $A$ є діагоналізовною, запишемо $A = P^(-1) mat(mu, 0; 0, D') P$, де $mu in.not "Sp"(D')$.
  
  Резольвента блок-діагоналізується так:
  $ R_A (z) = (A - z I)^(-1) = P^(-1) mat((mu - z)^(-1), 0; 0, (D' - z I)^(-1)) P. $

  Інтегруючи по $gamma$:
  $ frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z = P^(-1) mat(frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z), 0; 0, frac(1, 2 pi i) integral.cont_gamma (D' - z I)^(-1) dif z) P. $

  *Верхній лівий блок:* За інтегралом звивистості з §3,
  $ frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z) = frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z) = 1. $

  *Нижній правий блок:* $(D' - z I)^(-1)$ є голоморфною *всередині* $gamma$ (оскільки жодне власне значення $D'$ не лежить всередині $gamma$). За Пропозицією 3.1, її інтеграл по $gamma$ дорівнює нулю.

  Отже:
  $ frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z = P^(-1) mat(1, 0; 0, 0) P = Pi_mu. qed $
]
// --- CHUNK_METADATA_START ---
// src_checksum: aaf33b2c7400b410a9de1e3725d3c25de7c1f8b5c7ac019bcc920ed0e07b718c
// --- CHUNK_METADATA_END ---
== Функціональне числення

Спектральний проектор є окремим випадком набагато загальнішої конструкції. Для будь-якої функції $f$, голоморфної в околі $"Sp"(A)$, визначимо:
$ f(A) = frac(1, 2 pi i) integral.cont_C frac(f(z), z - A) dif z, $
де $C$ — будь-який контур, що охоплює весь $"Sp"(A)$. Це *голоморфне функціональне числення*.

#insight[
  Це розширює природне визначення $f(A) = sum a_n A^n$ (для $f$ як степеневого ряду) до *всіх* голоморфних $f$, незалежно від проблем збіжності. Потрібно $(I + A)^(-1)$, коли $||A|| > 1$? Запишіть це як контурний інтеграл. Потрібно $log(A)$ для матриці без нульового власного значення? Використовуйте функціональне числення. Контурний інтеграл уникає всіх обмежень радіуса збіжності.
]

Основні властивості:
- $"Id"(A) = A$ (тотожна функція повертає $A$)
- $(f g)(A) = f(A) g(A)$ (мультиплікативність)
- Якщо $f(z) = sum a_n z^n$ збігається і $||A|| < "radius"$, то $f(A) = sum a_n A^n$ (узгодженість зі степеневими рядами)

// ─────────────────────────────────────────────────────────────────────────────
// §7  РЕЗЮМЕ: ЛОГІЧНИЙ ЛАНЦЮГ
// ─────────────────────────────────────────────────────────────────────────────
// --- CHUNK_METADATA_START ---
// src_checksum: 2c7cee81e534cf04847b975f327a7e30adf8e8442c4b056cecf2ceff18cac3ea
// --- CHUNK_METADATA_END ---
= Підсумок: Логічний ланцюжок

Весь розділ слідує одній нитці:

#align(center)[
  #block(
    inset: 16pt, radius: 6pt,
    stroke: (paint: blue.lighten(40%), thickness: 0.8pt),
    fill: blue.lighten(96%),
    [
      $overline(partial) f = 0$ #h(0.5em) $=>$ #h(0.5em) *Стокса* #h(0.5em) $=>$ #h(0.5em) $integral.cont_gamma f dif z = 0$ #h(0.5em) $=>$ #h(0.5em) *незалежність від шляху* \
      #v(0.5em)
      $=>$ #h(0.5em) *Коші* #h(0.5em) $=>$ #h(0.5em) $f(z_0) = frac(1, 2 pi i) integral.cont_gamma frac(f(z), z - z_0) dif z$ \
      #v(0.5em)
      $=>$ #h(0.5em) *степеневі ряди* #h(0.5em) $=>$ #h(0.5em) *спектральний проектор* $Pi_mu = frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z$
    ]
  )
]

Кожна стрілка відповідає одній секції цього розділу. Геометрична інтуїція кожного кроку:

#table(
  columns: (auto, 1fr, 1fr),
  stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { (bottom: 0.3pt + gray.lighten(40%)) },
  inset: 8pt,
  table.header(
    text(weight: "bold")[Крок],
    text(weight: "bold")[Формула],
    text(weight: "bold")[Геометричний зміст]
  ),
  [§2], [$overline(partial) f = 0$], [Якобіан = обертання + масштабування; без зсуву, без відбиття],
  [§3], [$integral_gamma f dif z$], [Накопичувати добуток $f times$ на швидкість вздовж кривої в $CC$],
  [§4], [$integral.cont f dif z = 0$], [Рівномірне обертання+масштабування компенсується навколо будь-якого замкнутого контуру],
  [§5], [Формула Коші], [Граничні значення жорстко визначають внутрішні значення],
  [§5], [Степеневі ряди], [Ядро Коші розкладається в геометричний ряд],
  [§6], [Спектральний проектор], [Контур навколо $mu$ виділяє лише $mu$-власний простір],
)

Найглибше розуміння полягає в тому, що $overline(partial) f = 0$ — "немає антиголоморфної частини" — одночасно є чотирма речами: умовою для матриці Якобі, відсутністю ротора, незалежністю інтегралів від шляху та жорстким зв'язком між граничними та внутрішніми значеннями, що робить спектральний проектор можливим.