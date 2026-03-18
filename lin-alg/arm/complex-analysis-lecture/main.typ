// --- CHUNK_METADATA_START ---
// src_checksum: 536a93f7cddef976c8aae9ff1febe1d6b2f0a3bf73f4bb1ebd2bc53fd33f6c8d
// --- CHUNK_METADATA_END ---
// ─────────────────────────────────────────────────────────────────────────────
//  Կոմպլեքս անալիզ և կիրառություններ գծային հանրահաշվում — Դասընթացի նոթեր
// ─────────────────────────────────────────────────────────────────────────────

// ── Page setup ───────────────────────────────────────────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.8cm, y: 3cm),
  numbering: "1",
  number-align: center,
)

#set text(font: "New Computer Modern", size: 11pt, lang: "fr")
#set par(justify: true, leading: 0.7em)
#set heading(numbering: "1.1")

// ── Colour palette ────────────────────────────────────────────────────────────
#let accent   = rgb("#1a4f82")   // մուգ կապույտ
#let soft-bg  = rgb("#eef3fa")   // շատ բաց կապույտ
#let green-bg = rgb("#eaf6ea")
#let red-bg   = rgb("#fdf0f0")
#let gray-bg  = rgb("#f5f5f5")

// ── Theorem-like boxes ────────────────────────────────────────────────────────
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
    Բարդ անալիզ\
    և կիրառություններ գծային հանրահաշվում
  ]
  #v(0.6cm)
  #text(size: 13pt, fill: rgb("#555"))[Անտուան Լևիտի դասընթացներ։ Դասախոսության նշումները՝ Եղոր Կորոտենկոյի կողմից։]
  #v(2cm)
  #line(length: 60%, stroke: 1.5pt + accent)
  #v(2cm)
]

#outline(indent: 1em)

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: c1433885ed2311ec067a57fef10a2e1f2b0ad0940fa904eb0b6f9869350c8ce5
// --- CHUNK_METADATA_END ---
= Ռեզոլվենտա և սպեկտր
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: b16c577c98c7c95de3e465cc9ce12f54f083938119f1a1bcdd5c2bffcb3f7f9a
// --- CHUNK_METADATA_END ---
== Սահմանումներ

#definition(title: "Սպեկտր և ռեզոլվենտ")[
  Թող $A in M_n (CC)$։ *Սպեկտր* $A$-ի կոչվում է հետևյալ բազմությունը՝
  $
    "Sp"(A) = {mu in CC bar.v A - mu I "շրջելի չէ"}.
  $
  Ցանկացած $lambda in CC without "Sp"(A)$ համար, $A - lambda I$ մատրիցը շրջելի է։
  Նշանակենք
  $
    R_A (lambda) = (A - lambda I)^(-1)
  $
  և այն կոչվում է *ռեզոլվենտ* $A$-ի $lambda$-ում։
]

#remarque[
  Գոյություն ունի այլընտրանքային արտահայտություն։ Դնենք
  $
    B_A (z) = (I - z A)^(-1), quad
    z in CC without {1/mu bar.v mu in "Sp"(A)}.
  $
  Ուղղակի հաշվարկը տալիս է
  $
    R_A (lambda) = -1/lambda space B_A (1/lambda).
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 30a2bb384c6d397ea036b1e070e5bac64d25c452ad36954dbb055d3234d7f6ec
// --- CHUNK_METADATA_END ---

== Օպերատորի նորմ

$CC^n$-ը օժտված է $norm(dot)_2$ էվկլիդեսյան նորմով։
$A in M_n (CC)$-ի *օպերատորի նորմը* (ենթակա նորմ) հետևյալն է՝
$
  norm(A) = sup_(v in CC^n, v != 0) norm(A v)_2 / norm(v)_2.
$
Այն բավարարում է $norm(A B) <= norm(A) norm(B)$ անհավասարությանը։ Ավելին, եթե $norm(A) < 1$, ապա $I - A$-ը շրջելի է և
$
  (I - A)^(-1) = sum_(n=0)^(+infinity) A^n.
$

// --- CHUNK_METADATA_START ---
// src_checksum: 16f21f9c4c418c3f3f51f90da45744b9ff2a4c4b8935b19bca133ce5c314daac
// --- CHUNK_METADATA_END ---
== Ռեզոլվենտի ամբողջական շարքի զարգացում

#proposition(title: "Poly, Prop. 4.8")[
  Հետևյալ շարքը զուգամիտում է (տեղայնորեն հավասարաչափ օպերատորի նորմի համար)
  $DD(0, 1/norm(A))$ սկավառակի վրա։
  $
    B_A (z) = sum_(n=0)^(+infinity) z^n A^n.
  $
]

#fig(
  "figures/fig_resolvent_disk.png",
  [$B_A(z)=sum_(n=0)^(+infinity) z^n A^n$-ի զուգամիտության տիրույթը։
   Խաչերը նշում են $1\/mu_i$ եզակիությունները $mu_i in "Sp"(A)$ համար։],
  width: 55%,
)

#remarque[
  Իր սահմանման տիրույթի ցանկացած կետի շրջակայքում $B_A$-ն
  վերլուծելի է աստիճանային շարքի՝
  $
    B_A (z) = sum_(n=0)^(+infinity) (z - z_0)^n B_A (z_0) [A B_A (z_0)]^n.
  $
  *Նպատակը՝* ուսումնասիրել մեկ կոմպլեքս փոփոխականի այս տիպի ֆունկցիաները։
]

Հանրահաշվական հաշվարկը ցույց է տալիս, որ, նշանակելով $C = I - z_0 A$ և $D = (z - z_0) A$՝
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
// --- CHUNK_METADATA_END ---
= Հոլոմորֆ ֆունկցիաներ
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: fbb87865e9bf26cb8905517e57f16dba39736b34d90e31608a56ce648d68a872
// --- CHUNK_METADATA_END ---
== Սահմանում

#definition(title: "Հոլոմորֆ ֆունկցիա")[
  Թող $Omega subset CC$ բաց բազմություն լինի, և $f : Omega -> CC$։
  Ասում ենք, որ $f$ *հոլոմորֆ* է, երբ
  $
    forall z_0 in Omega, quad
    exists epsilon > 0 "և" (a_n)_(n in NN) "այնպիսիք, որ" quad
    forall z in DD(z_0, epsilon), quad
    f(z) = sum_(n=0)^(+infinity) a_n (z - z_0)^n.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: 8a4f235a701e9bb3e60f7a17855b5f1aa4066ad8d51fa321bff04d0247575211
// --- CHUNK_METADATA_END ---
== Հիշեցում: Ամբողջ շարքերի զուգամիտություն

#proposition(title: "Կարճ հիշեցում")[
  Եթե $(|a_n|^(1\/n))_(n in NN)$ սահմանափակված է $M > 0$-ով, ապա $z |-> sum_(n in NN) a_n z^n$ ամբողջ շարքը տեղայնորեն հավասարաչափ զուգամիտում է $DD(0, 1\/M)$ վրա և սահմանում է $C^infinity$ ֆունկցիա՝ որպես երկու իրական փոփոխականների ֆունկցիա։

  Մասնավորապես, եթե $R < 1/M$ և $z in DD(0, R)$ :
  $
    sum_(n in NN) |a_n z^n| <= sum_(n in NN) (R M)^n < +infinity.
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: b7bebbfc7f56a9f2723ad2193c1fa4d59e5301e0360a6afa4ea9724a69404230
// --- CHUNK_METADATA_END ---
== Օպերատորը $overline(partial)$

#observation[
  Գրելով $z = x + i y$, հաշվարկում ենք.
  $
    diff/(diff x) (x + i y)^n = n (x + i y)^(n-1),
    quad quad
    diff/(diff y) (x + i y)^n = i n (x + i y)^(n-1).
  $
  Մասնավորապես, ցանկացած $n in NN$-ի համար.
  $
    (diff/(diff x) + i diff/(diff y))(x + i y)^n = 0.
  $
  Նշանակում ենք $overline(partial) = diff/(diff overline(z)) = 1/2 (diff/(diff x) + i diff/(diff y))$
  (նաև նշանակվում է որպես $diff/(diff overline(z))$).
]

#proposition[
  Եթե $f$-ը հոլոմորֆ է, ապա $overline(partial) f = 0$.
]

// --- CHUNK_METADATA_START ---
// src_checksum: 610dc4c4e8f1f83a40def0ec8e3d33b37cd6c6684d1b21c95256bdba051017a1
// --- CHUNK_METADATA_END ---
== Օրինակներ

Հետևյալ ֆունկցիաները հոլոմորֆ են.
- ռեզոլվենտը $lambda |-> R_A (lambda)$,
- բազմանդամները,
- էքսպոնենտը $z |-> exp(z)$,
- մատրիցա-էքսպոնենտը $z |-> exp(z A)$.

#exemple(title: "Ոչ-օրինակ")[
  Ֆունկցիան $z |-> overline(z)$ *հոլոմորֆ* չէ, քանի որ
  $
    diff/(diff x)(x - i y) = 1 != 0 = overline(partial) overline(z).
  $
]

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: d99e47e1d65d6360340379dfa6b5fa08bdd44f07e9bcf5d5259a6889f8a39b12
// --- CHUNK_METADATA_END ---
= Կոնտուրային ինտեգրալներ
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 339d8a772f2ac0599da1ef84e8f391ca0c56a794863afee54fcb634b82027aed
// --- CHUNK_METADATA_END ---
== Ստոքսի բանաձև / Ամպերի թեորեմ

// --- CHUNK_METADATA_START ---
// src_checksum: 0c8a41521a47fc449c030ff8aaccc9043b52e78ed216eea0933628381b52eb8b
// --- CHUNK_METADATA_END ---
=== Տարբերակ 1D

Եթե $f in C^1([a,b], RR)$, ապա
$
  integral_a^b f'(x) dif x = f(b) - f(a).
$

// --- CHUNK_METADATA_START ---
// src_checksum: d702148d071a549797fe2f5c4c90e10421f63a01ca278cc8b8081ea3729b8611
// --- CHUNK_METADATA_END ---
=== 2D Տարբերակ

Թող $Omega subset RR^2$ լինի բաց տիրույթ, որի եզրը պարզ կանոնավոր $gamma$ կոր է։
Մենք անցնում ենք $gamma$-ով $1$ արագությամբ; նշանակենք $T = "Երկարություն"(gamma)$։

#fig(
  "figures/fig_contour_simple.png",
  [Պարզ եզրագիծ $gamma = diff Omega$ ուղղորդված դրական ուղղությամբ։],
  width: 42%,
)

#theorem(title: "Ստոքսի / Գրին-Ռիմանի")[
  Թող $arrow(A) : Omega -> RR^2$ լինի $C^1$ վեկտորական դաշտ, որտեղ
  $
    arrow(A)(x,y) = A_x (x,y) arrow(e)_x + A_y (x,y) arrow(e)_y.
  $
  Սահմանենք սկալյար ռոտորը՝
  $
    "rot"(arrow(A)) = (diff A_y)/(diff x) - (diff A_x)/(diff y).
  $
  Ապա
  $
    integral.double_Omega "rot"(arrow(A)) dif x dif y
    = integral_0^T arrow(A)(gamma(s)) dot arrow(T)(gamma(s)) dif s,
  $
  որտեղ $arrow(T)(s) = gamma'(s)$ տանգենցիալ վեկտորն է։
]

// --- CHUNK_METADATA_START ---
// src_checksum: d84cbd93cd1f8437e08d435e8da82b81ec20f46f53f0dbc422d156acd6e1fd66
// --- CHUNK_METADATA_END ---
=== Քառակուսու վրա ապացույց

Վերցնում ենք $Omega = [0,1]^2$ և $A$-ն աֆին է.
$
  A_x = c_x + a_(x x) x + a_(x y) y, quad
  A_y = c_y + a_(y x) x + a_(y y) y.
$
Այսպիսով $"rot"(arrow(A)) = a_(y x) - a_(x y)$ և
$integral.double_Omega "rot"(arrow(A)) = a_(y x) - a_(x y)$։

#fig(
  "figures/fig_square_stokes.png",
  [Քառակուսին $Omega = [0,1]^2$ իր չորս համարակալված կողմերով։],
  width: 42%,
)

Պարամետրավորում ենք չորս կողմերը և գումարում ենք ներդրումները. 

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

Գումարելով ստացվում է. $integral.cont_(diff Omega) arrow(A) dot dif arrow(T) = a_(y x) - a_(x y) = integral.double_Omega "rot"(arrow(A))$։ $square$

*Իսկական ապացույցի ճանապարհը.*
+ Նախ ստուգել ցանկացած եռանկյունների վրա աֆին ֆունկցիաների համար։
+ Մոտարկել $gamma$-ն բազմանկյուն կորով, եռանկյունացնել $Omega$-ն և մոտարկել $A$-ն յուրաքանչյուր եռանկյան վրա աֆին ֆունկցիայով։

// --- CHUNK_METADATA_START ---
// src_checksum: 088a09dc6583c1002ad32004d63b9f31de997da87f6265d5adeb4d914ec9f5c2
// --- CHUNK_METADATA_END ---
== Կոմպլեքս ինտեգրալ և Գրինի բանաձև

Ենթադրենք $f : Omega -> CC$-ը $C^1$ կարգի է և $gamma : [0,T] -> CC$-ը կանոնավոր կոր է։ Սահմանենք
$
  integral_gamma f = integral_0^T f(gamma(s)) gamma'(s) dif s.
$

Դնելով $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, հաշվարկում ենք՝
$
  "rot"(arrow(A))
  = i diff_x f - diff_y f
  = i (diff_x f + i diff_y f)
  = 2 i space overline(partial) f.
$

#proposition[
  Եթե $f : Omega -> CC$-ը $C^1$ կարգի է և $overline(partial) f = 0$, ապա $Omega$-ում գտնվող ցանկացած փակ $gamma$ կորի համար
  $
    integral.cont_gamma f = 0.
  $
]

#remarque[
  Ճիշտ է, եթե ունենք պարզ կոր և $f$-ը սահմանված է ամենուր ներսում:
  Ընդհանուր դեպքում համանման եզրագծերի համար՝
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
  [Համանման եզրագծեր՝ $gamma_1$ (փոքր մեկուսացված եզրագիծ), $gamma_2, gamma_3$ (ներդրված եզրագծեր), $gamma_4$ (անցքով եզրագիծ), $gamma_5$ (մեծ արտաքին եզրագիծ):],
  width: 80%,
)

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: 1b2f077bceae01f507742d2732a05b511f43acc81e4a6d5adb923c46be1f9083
// --- CHUNK_METADATA_END ---
= Կոշիի բանաձև
// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 545be3864fdac137a19a17da09422d5a29f6e4a800de40e197f14a7b666614a8
// --- CHUNK_METADATA_END ---
== Հայտարարություն

#theorem(title: "Կոշիի բանաձևը")[
  Ենթադրենք $f in C^1(Omega, CC)$, որտեղ $overline(partial) f = 0$։
  Ենթադրենք $z_0 in Omega$։ Ապա, ցանկացած $gamma$ կորի համար, որը մեկ պտույտ է կատարում
  (դրական ուղղությամբ) $z_0$-ի շուրջը,
  $
    integral.cont_gamma f(z)/(z - z_0) dif z = 2 pi i f(z_0).
  $
]

// --- CHUNK_METADATA_START ---
// src_checksum: cf13be78ab52a9ec06eff0ddeccbf87099146e5477b2b8d0fa8613b7e76370fd
// --- CHUNK_METADATA_END ---
== Ապացույց

Ինտեգրալի արժեքը կախված չէ $gamma$-ից, ուստի վերցնում ենք $gamma_epsilon$-ը՝ $z_0$-ի շուրջ $epsilon$ շառավղով շրջանը։
$
  integral.cont_(gamma_epsilon) f(z)/(z - z_0) dif z
  = integral.cont_(gamma_epsilon) f(z_0)/(z - z_0) dif z
  + O(epsilon dot 1/epsilon dot epsilon)
  = O(epsilon).
$

#fig(
  "figures/fig_cauchy_circle.png",
  [$z_0$-ում կենտրոնացած $epsilon$ շառավղով $gamma_epsilon$ շրջանը, որն օգտագործվում է Կոշիի բանաձևի ապացույցում։],
  width: 48%,
)

Պարամետրացնում ենք $gamma_epsilon : theta |-> z_0 + epsilon e^(i theta)$-ը, $theta in [0, 2pi]$, ուստի $gamma_epsilon'(theta) = i epsilon e^(i theta)$ և
$
  integral.cont_(gamma_epsilon) 1/(z - z_0) dif z
  = integral_(theta=0)^(2pi)
      1/(epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta
  = integral_0^(2pi) i dif theta
  = 2 pi i.
$

// --- CHUNK_METADATA_START ---
// src_checksum: 87f542353ea9184316759eb7602103d45c0cc621206445c3b0ec2a42558e2b41
// --- CHUNK_METADATA_END ---
== Հոլոմորֆ ֆունկցիաների բնութագրում

#theorem[
  Թող $Omega$-ն լինի $CC$-ի բաց ենթաբազմություն, $f : Omega -> CC$-ը՝ $C^1$ դասի ֆունկցիա այնպես, որ
  $overline(partial) f = 0$։ Այդ դեպքում $f$-ը հոլոմորֆ է։
]

#proof[
  Թող $gamma$-ն լինի $Omega$-ի պարզ կոր։ Ցանկացած $z_0$-ի համար՝ $gamma$-ի ներսում, Կոշիի բանաձևը տալիս է՝
  $
    f(z_0) = 1/(2 pi i) integral.cont_gamma f(z)/(z - z_0) dif z.
  $
  Ցանկացած $z in gamma$-ի համար, $z_0 |-> 1/(z - z_0)$ ֆունկցիան հոլոմորֆ է
  $CC without {z}$-ի վրա։ Ինտեգրումից հետո $z_0 |-> 1/(2pi i) integral.cont_gamma f(z)/(z - z_0) dif z$-ը
  հոլոմորֆ է $omega = "Int"(gamma)$-ի վրա։
]

// ═════════════════════════════════════════════════════════════════════════════
// --- CHUNK_METADATA_START ---
// src_checksum: 7e05636f40fbf4f25ec422c348b97f18aefc0b0482f990c0f91b5a55a1cd8bce
// --- CHUNK_METADATA_END ---
= Կիրառություն գծային հանրահաշվին// ═════════════════════════════════════════════════════════════════════════════

// --- CHUNK_METADATA_START ---
// src_checksum: 99aa02c594469d39505057f3791686b5f001b28c217321628f51d263a3c88cab
// --- CHUNK_METADATA_END ---
== Սպեկտրային պրոյեկտոր

#proposition(title: "Պրոյեկտոր սեփական տարածության վրա")[
  Ենթադրենք $A in M_n (CC)$ անկյունագծելի է, և $gamma$-ն մի կոր է, որը մեկ պտույտ է կատարում $mu$ սեփական արժեքի շուրջ, առանց մյուսները շրջափակելու։ Ապա
  $
    1/(2 pi i) integral.cont_gamma R_A (z) dif z = Pi_mu,
  $
  որտեղ $Pi_mu$-ն *պրոյեկտորն* է $E_mu$ սեփական տարածության վրա՝ մյուս սեփական տարածություններին զուգահեռ։
]

#fig(
  "figures/fig_eigenvalue_contour.png",
  [$gamma$ կոնտուրը, որը շրջապատում է $mu$ սեփական արժեքը, առանց շրջափակելու մյուս սեփական արժեքները (կարմիր խաչեր)։],
  width: 52%,
)

// --- CHUNK_METADATA_START ---
// src_checksum: 6c8f64a5ce641316f7d834cb193c5d198d73b5eb7c34ee83011f39d8b5036c2c
// --- CHUNK_METADATA_END ---
== Ապացույց

Քանի որ $A$-ն տրամագծայնացվող է, ապա գոյություն ունի շրջելի $P$ այնպես, որ
$
  A = P^(-1) mat(mu, 0; 0, D') P,
  quad mu in.not "Sp"(D').
$
Այդ դեպքում
$
  (A - lambda I)^(-1)
  = P^(-1)
    mat((mu - lambda)^(-1), 0; 0, (D' - lambda I)^(-1))
    P.
$
Ինտեգրում ենք $gamma$-ի վրա։
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

Ստորին բլոկը զրո է, քանի որ $(D' - lambda I)^(-1)$-ը հոլոմորֆ է $gamma$-ի ներսում (քանի որ $mu in.not "Sp"(D')$)։ Վերին բլոկը $1$ է՝ ըստ մնացորդի հաշվարկի.
$
  1/(2 pi i) integral.cont_gamma 1/(mu - lambda) dif lambda = 1.
  quad square
$

