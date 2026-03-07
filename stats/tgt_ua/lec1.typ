// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
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
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 43ba1e95b0f2e64be6fac94c25d8fdb5b386caebf2cd3d4814c8bbd79975b312
// --- CHUNK_METADATA_END ---
= Вступ
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c87ca8d91c1d06fb49b63aa12ea9acceb250ba93a9cb8e835ba0b03bd85e09bb
// --- CHUNK_METADATA_END ---
== Оцінювання
- $0.4$ Поточний контроль $+ 0.6$ Іспит.
- Розподіл : $80\%$ проміжний іспит, $20\%$ Контрольна робота (запланована на 26/01).
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f304a7eac8fabbf4c839d8e355944d0fd595aa4b05ebf113a14157388d4c230a
// --- CHUNK_METADATA_END ---
== Статистична Модель

#defn(info: "Статистична Модель")[
  Статистична модель — це ймовірнісний простір $(Omega, cal(A), cal(P))$ де $cal(P)$ є сімейством розподілів ймовірностей ${P_theta; theta in Theta}$.
]

- Якщо $exists p in NN^*, Theta subset RR^p$ : параметрична модель.
- Інакше : непараметрична модель.

#ex(info: "Сімейства розподілів")[
  - Розподіли Пуассона : $cal(P) = {P(lambda); lambda > 0}$.
  - Регулярна щільність : $cal(P) = {PP; PP " щільність якої допускає обмежену другу похідну"}$.
]

#defn(info: "Спостереження")[
  Спостереження — це випадкова величина (в.в.), розподіл якої належить до ${P_theta, theta in Theta}$.
  Наше спостереження матиме структуру $n$-вибірок $X_1, ..., X_n$ н.о.р. (незалежних та однаково розподілених) із спільним розподілом $in {P_theta, theta in Theta}$.
]

#rmk[
  $(X_1, ..., X_n)$ має розподіл $P_theta^(times.o n)$. Вибірка містить всю інформацію про $P_theta$, отже, про $theta$. //times.o
]

#defn(info: "Ідентифіковність")[
  Модель є ідентифікованою тоді і тільки тоді (т.т.т.), якщо відображення $theta mapsto P_theta$ є ін'єктивним.
]
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6f02be46d3cd08ea80269742d031d50c1d27a4e2f1f43609cf4598883180fe65
// --- CHUNK_METADATA_END ---
== Оцінювачі

*Гіпотеза :* Спостерігаємо $X_1, ..., X_n$ i.i.d. зі спільним розподілом $in {P_theta, theta in Theta subset RR^p}$ (ідентифікована параметрична модель). Нехай $theta^*$ є справжнє невідоме значення таке, що $P_(X_i) = P_(theta^*)$.

#defn(info: "Оцінювач")[
  Оцінювач для $theta$ — це функція вибірки $(X_1, ..., X_n)$ , вимірна та незалежна від $theta$ (обчислювана на основі даних).
]

*Позначення :* $hat(theta) = hat(theta)_n = h(X_1, ..., X_n)$. Це випадкова величина. \
Приклади : $hat(theta) = overline(X)$, $hat(theta) = X_1 - X_3$, тощо.

Фундаментальні питання :
+ Як визначити хороший оцінювач ?
+ Як побудувати хороший оцінювач ?
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 14df5690760448fc7088aa24a6ce62dbfe4cff637754de078d71fea69fe6d508
// --- CHUNK_METADATA_END ---
== Квадратичний ризик

*Ідея :* В середньому, $hat(theta)$ має бути близьким до $theta$. Ми розглядаємо $EE[hat(theta) - theta]$.

#defn(info: "Зміщення")[
  Зміщення $hat(theta)$ визначається як :
  $ B(hat(theta), theta) = EE[hat(theta)] - theta $
  Кажуть, що $hat(theta)$ є *незміщеним* тоді і тільки тоді, якщо $B(hat(theta), theta) = 0$.
]

#defn(info: "Квадратичний ризик / MSE")[
  $ R(hat(theta), theta) = EE[(hat(theta) - theta)^2] $
  Це *середньоквадратична помилка (MSE)* англійською.
]

Кажуть, що $hat(theta)_1$ кращий за $hat(theta)_2$ тоді і тільки тоді, якщо $R(hat(theta)_1, theta) <= R(hat(theta)_2, theta)$.
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0416d9d933540514f2cf5759107bc489ebdd5d6204b9f631671f44b862285c11
// --- CHUNK_METADATA_END ---
=== Приклад : Модель Пуассона
Нехай $X_1, ..., X_n$ мають Пуассонівський розподіл $P_theta$ , $theta > 0$. Шукаємо оцінку для $theta = EE[X_i]$.

Запропонуємо : $hat(theta) = overline(X) = 1/n sum_(i=1)^n X_i$.

*Обчислення зміщення :*
$
  B(hat(theta), theta) &= EE[1/n sum_(i=1)^n X_i] - theta \
  &= 1/n sum_(i=1)^n EE[X_i] - theta quad ("за лінійністю") \
  &= 1/n dot n dot EE[X_1] - theta \
  &= theta - theta = 0
$
Отже $EE[overline(X)] = theta$ є незміщеною оцінкою.

*Обчислення ризику :*
$
  R(hat(theta), theta) &= EE[(overline(X) - theta)^2] = EE[(overline(X) - EE[overline(X)])^2] \
  &= Var(overline(X)) = Var(1/n sum X_i) \
  &= 1/n^2 sum Var(X_i) quad ("оскільки i.i.d") \
  &= 1/n^2 dot n dot Var(X_1) = (Var(X_1))/n = theta/n
$

#thm(info: "Розклад ризику на зміщення-дисперсію")[
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
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 074abcf51803765b7713b0d3dcdb57d764201e2c289dc001247b518f59c18c01
// --- CHUNK_METADATA_END ---
== Послідовність
Асимптотична властивість. Розглядаються лише послідовні оцінки.

#defn(info: "Послідовність")[
  Нехай $(X_1, ..., X_n)$ н.о.р. з розподілом $P_theta$. Нехай $hat(theta)_n = h(X_1, ..., X_n)$.
  $hat(theta)_n$ є послідовною оцінкою (або збіжною) для $theta$ тоді і тільки тоді, коли :
  $ hat(theta)_n -->_(n -> +infinity)^(PP) theta $
]

#rmk[
  $hat(theta)_n$ є сильно послідовною тоді і тільки тоді, коли $hat(theta)_n -->_(n -> +infinity)^("p.s.") theta$.
]
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 082b3f3fd50fd6c42a745339d17d61c24015c6234ff322eef272ea1c43944332
// --- CHUNK_METADATA_END ---
=== Приклад : Повернення до моделі Пуассона
$Theta = RR_+^*$, $hat(theta)_n = overline(X)$.

- Можна покликатися на Закон великих чисел (ЗВЧ) : $overline(X) -->^(PP) EE[X_i] = theta$.
- Через квадратичний ризик :
  $ R(hat(theta)_n, theta) = Var(overline(X)) = theta/n -->_(n -> +infinity) 0 $
  Згідно з нерівністю Чебишова-Бінаме :
  $ P(|hat(theta)_n - theta| > epsilon) <= (EE[(hat(theta)_n - theta)^2])/epsilon^2 = (R(hat(theta)_n, theta))/epsilon^2 -> 0 $
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8d18128e5d8de85fee63298356854cece7012ba4d0ab496f74e26ab97b7b68c0
// --- CHUNK_METADATA_END ---
=== Метод "Plug-in"
Нехай $(X_1, ..., X_n)$ — н.о.р. Пуассона$(theta)$. Ми хочемо оцінити $beta = P(X_i = 0) = e^(-theta)$.
$ hat(beta) = e^(-hat(theta)) = e^(-overline(X)) $

$hat(beta)$ є слушним для оцінки $beta$.

#lem(info: "Лема про неперервне відображення")[
  Якщо $Z_n -->^(PP) Z$, тоді $h(Z_n) -->^(PP) h(Z)$ для будь-якої неперервної функції $h$.
]