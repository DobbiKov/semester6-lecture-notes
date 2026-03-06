// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ec85412555d56610a6a7397199daf2830615de3739c98fad873b494b73e5b449
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: e1d9795071678fb78def96f4da3e955dd2ecf5fe5a4ab2a6ea6692c31b8eb29d
// --- CHUNK_METADATA_END ---
= Оцінювачі// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b838aca9b4848f5f872a033dd4a85c1b5c3ed4e287f16446e96d2eb811c7a1da
// --- CHUNK_METADATA_END ---
== Параметрична структура// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 922ea1229aa0474374dc6db33fd5a604f0e9786d15dc3219d04516f7ca8886e1
// --- CHUNK_METADATA_END ---
=== Параметрична статистична модель
Маємо спостереження ($X_1, ..., X_n$), вибірку i.i.d випадкових величин (незалежних, однаково розподілених) із спільним законом $P$ , що належить до параметризованої родини законів розподілу ймовірностей ${ P_(theta, theta in Theta subset RR^p) }$.

#rmk[
  Якщо $Theta subset$ простір нескінченної розмірності $arrow.r$ непараметрична модель.
]

Оцінити $P$ означає оцінити $theta in RR^p$.

#ex[
  #Bern ($theta$), #Exp ($theta$), $cal(N)(mu, sigma^2)$, закон із щільністю $f_theta (x) = theta x^(theta - 1) 1_(x in [0, 1])$
]

#notation[
  $E_(theta_n)[h(X_1, ..., X_n)]$, $Theta [h(X_1, ..., X_n)]$ \
  Закон розподілу для $(X_1, ..., X_n) arrow.r P_theta^(times.o n)$ //times.o
]

#defn(info: "Оцінювач")[
  $ hat(theta) = hat(theta)_n = h(X_1, ..., X_n) $
]

#defn(info: "Якість")[
  - Ризик
    $ R(hat(theta), theta) = E_theta [(hat(theta) - theta)^2] $
  - Зговірність
    $ hat(theta)_n ->_(n -> +infinity)^P theta $
]

#defn(info: "Ідентифіковна модель")[
  $ theta -> P_theta quad "ін'єктивний" $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0d82d4623dfcdaad4c36c9fc1ad08dd709818a9688ff33441cba418de4be4015
// --- CHUNK_METADATA_END ---
== Метод моментів
#defn[
  Називається *теоретичний момент* розподілу $X_i$ порядку $k$:
  $ mu_k = E[X_i^k], quad k >= 1 $
]

#defn[
  Називається *емпіричний момент* розподілу $X_i$ порядку $k$:
  $ hat(mu)_k = 1/n sum_(i=1)^n X_i^k $
]

За законом великих чисел $hat(mu)_k -->_(n -> +infinity)^P mu_k$.

Метод моментів: якщо можна записати $theta$ або $g(theta)$ цільовий параметр як функцію від $k$ перших теоретичних моментів.
$ theta = cal(L)(mu_1, ..., mu_k) $
тоді оцінка
$ hat(theta) = cal(L)(hat(mu)_1, ..., mu_k) $
отримується за допомогою методу.

#ex(info: "Обчислення оцінок за допомогою методу моментів")[
  - $X_i tilde Bern(theta)$ зі значеннями 0-1,
    $ theta = P(X_i = 1) = E[X_i] arrow.r 1/n sum_(i=1)^n X_i = overline(X) $
  - $X_i tilde Exp(theta), \, f_theta (x) = theta e^(-theta x) 1_(x >= 0)$, $E[X] = 1/theta <==> theta = 1/mu_1$, за методом моментів,
    $ hat(theta) = 1/(hat(mu)_1) = 1/(overline(X)) $
    $
      Theta (X_i) = 1/theta^2 &<==> theta^2 = 1/(E[X_i^2] - E[X_i]^2) \
      &<==> theta = 1/(sqrt(mu_2 - mu_1^2)) \
      &==> hat(theta)_2 = 1/(sqrt(1/n sum_(i=1)^n X_i^2 - (overline(X))^2))
    $
  - $X_1, ..., X_n$ i.i.d. з розподілу $P_theta$ з щільністю
    $ f_theta (x) = theta x^(theta - 1) 1_(x in [0, 1]) $
    $ E_theta [X_i] = theta integral_0^1 x^theta dif x = theta/(theta + 1) $
    Метод моментів:
    $
      (theta + 1)mu_1 = theta &<==> theta(1 - mu_1) = mu_1 <==> theta = (E[X_i])/(1 - E[X_i]) \
      &==> hat(theta)_(MM) = (overline(X))/(1 - overline(X)), \, P_theta (overline(X) = 1) = P_theta (X_1 = X_2 = ... = X_n = 1) = 0
    $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8a4744fbc3f9159586a9a514cc020c58b92bdad4f140d7494254525b976215ee
// --- CHUNK_METADATA_END ---
== Огляд L.A.C.
(L.A.C = лема неперервних відображень)
$(X_n)_(n >= 1)$ послідовність випадкових величин. Якщо $X_n$ збігається до $X$, що можна сказати про $g(X_n)_(n >= 1)$? Якщо $g$ неперервна, L.A.C.
- якщо $X_n -->^P X$ то $g(X_n) -->^P g(X)$
- якщо $X_n -->^(cal(L)) X$ то $g(X_n) -->^(cal(L)) g(X)$

#rmk(info: "Достатня умова")[
  $ D_g = { "точки розриву " g } $
  якщо $P(X in D_g) = 0$, то L.A.C. справедлива.
]

#ex[
  $ g(x) = x/(1 - x) $
  - ЗВВН: $overline(X) -->^P E[X]$
  - L.A.C.: $g(overline(X)) = hat(theta)_n -->_(n -> +infinity)^P g(E[X]) = theta$
]

L.A.C. для пар послідовностей випадкових величин:
- якщо $(X_n, Y_n) -->^P (X, Y)$, то $g(X_n, Y_n) -->^P g(X, Y)$, якщо $g: RR^2 -> RR$ або $RR^2$ неперервна
- якщо $(X_n, Y_n) -->^(cal(L)) (X, Y)$, то $g(X_n, Y_n) -->^(cal(L)) g(X, Y)$

#ex[
  $ hat(theta)_2 = 1/(sqrt(1/n sum_(i=1)^n X_i^2 - (overline(X))^2)) quad "узгоджений?" $
  ЗВВН:
  - $overline(X) -->^P mu_1$
  - $1/n sum_(i=1)^n X_i^2 -->^P mu_2$
  отже
  $ mat(overline(X); 1/n sum_(i=1)^n X_i^2) -->^P mat(mu_1; mu_2) $
  $g(x, y) = 1/(sqrt(y - x^2)) ==> hat(theta)^(MM)$ узгоджений для $theta$, $g$ неперервна, крім ${ (x, y) in RR^2, y = x^2 }$ з нульовою мірою.

  Але це невірно для збіжності за розподілом.
]

#prop(info: "Збіжність пар")[
  $ vec(X_n, Y_n) -->^P vec(X, Y) text(" т.т.к. ") cases(X_n -->^P X, Y_n -->^P Y) $
]

#proof[
  - $==>$ тоді L.A.C. $g(x, y) = x$ неперервна, отже $X_n -> X$ та $Y_n -> Y$
  - $<==$ збіжність пари?
    $ forall epsilon > 0, P(|X_n - X| + |Y_n - Y| > epsilon) <= underbrace(P(|X_n - X| > epsilon/2), -> 0) + underbrace(P(|Y_n - Y| > epsilon/2), -> 0) $
    #underline[Ця обернена умова невірна для збіжності за розподілом!]
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 444bd8813e627a5415a5add2d438b7a32752e1339eb3dfec3f54d0968e058de6
// --- CHUNK_METADATA_END ---
=== Емпірична дисперсія
Якщо  $X_i$ мають математичне сподівання  $mu$ та дисперсію  $sigma^2$, то емпіричною дисперсією називається
$
  hat(sigma)_n^2 &= 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n X_i^2 + 1/n sum_(i=1)^n overline(X)^2 - 2/n sum_(i=1)^n X_i overline(X) \
  &= 1/n sum_(i=1)^n X_i^2 + overline(X)^2 - 2 overline(X) overline(X) = tilde(sigma)^2
$
оцінювач моментів:
$ sigma^2 = E[X_i^2] - E[X_i]^2 $
Теоретичні моменти замінюються емпіричними:
$ arrow.r tilde(sigma^2)^(MM) = 1/n sum_(i=1)^n X_i^2 - (overline(X))^2 $

Консистентність:
$hat(sigma)^2 = 1/n sum_(i=1)^n X_i^2 - (overline(X))^2$,
$
  cases(overline(X) -->^P E[X], 1/n sum_(i=1)^n X_i^2 -->^P E[X^2])
  -->^("cv en proba")
  vec(overline(X), 1/n sum_(i=1)^n X_i^2)
  -->^("LAC") hat(sigma)^2 " що є консистентною оцінкою для " Var(X) = E[X^2] - E[X]^2
$

#ex[
  - обчислити зміщення для  $hat(sigma)_n^2$
  - обчислити ризик для  $hat(sigma)_n^2$
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 740da53fb2a113c61a8ad25589a0e6940dfa3d24e64a7347784d57f4599aaceb
// --- CHUNK_METADATA_END ---
== Метод максимальної правдоподібності// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 366c942d4a58b0ecd11e4bfd3db269de47415289ee9da8258ed80ca1c2ecf5ed
// --- CHUNK_METADATA_END ---
=== Дана модель
$(P_theta)_(theta in Theta)$ задається, якщо існує міра $mu$ (позитивна  $sigma$ -скінченна  $arrow.r$ $X_i$  зі значеннями в $E$, $E = union E_n$ де $mu(E_n)$ є скінченною) така, що $forall theta, P_theta$ має густину відносно $mu$.// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 88623d341c02aee235a26806a3b4ffba13309562d522bcd1f6fc0c4518d306c4
// --- CHUNK_METADATA_END ---
=== На практиці// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: e32922643275f56a321492eb91f1c8e785ada3b3e2f07ddbdea041d4b5ffb5d3
// --- CHUNK_METADATA_END ---
- нехай $E$ щонайбільше зліченна: $mu$ = лічильна міра. Якщо $exists \, { a_1, a_2, ... }$ така що $sum_(k >= 1) P_theta (X_i = a_k) = 1$, тоді $mu = sum_(k >= 1) delta_(a_k)$ з $delta_a ({a}) = 1$ міра Дірака.
  #ex[
    #Bern ($theta$), $X_i = 1$, ймовірності $theta -> mu = delta_0 + delta_1$
    Будемо писати
    $ f_theta (x) = underbrace(P_theta ({x}), = 1 - theta) - P_theta (X_i = x) " де " x in {a_1, a_2, ... } $
  ]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 253de0862f96022cca943d99a6060fe052b130120627fe0592074c148f42cfa5
// --- CHUNK_METADATA_END ---
- якщо $E = RR^p$, тоді $f_theta$ є звичайною щільністю// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9d20afeea966774fd7b199382bb4f86e70d4bba6b44f994403dde5b9b65e82d1
// --- CHUNK_METADATA_END ---
$f_theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8e0ca78b4a57c4ac83627da641ba799fc3bb7c47aba69351f0680ffacdd3b881
// --- CHUNK_METADATA_END ---
густина// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 22d42c92d2fb7695f8e96843f4512bbf66c36130a81bb036a5149082cf779cc1
// --- CHUNK_METADATA_END ---
$P_theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9b419d1cadfdca5280c1d10600adf703b80d99c238f1cab2a4bf083b8386425a
// --- CHUNK_METADATA_END ---
#defn[
  Правдоподібністю вибірки $(X_1, ..., X_n)$ називають функцію
  $ theta -> L_n (theta) = product_(i=1)^n f_theta (X_i) " (випадкова змінна)" $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a7795b7faf751e216a35116ccfe32623eee2449342a3f404a75b14ef7b0f0ac7
// --- CHUNK_METADATA_END ---
#defn[
  Оцінювач максимальної правдоподібності $hat(theta)_(M V)$ визначається як:
  $ forall theta in Theta, L_n (theta) <= L_n (hat(theta)) $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: babfde188dd2cb1b18504b4ce851625b1f5266ea44e5390d330de5e5cab2decb
// --- CHUNK_METADATA_END ---
Ми часто працюємо з *лог-правдоподібністю*
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 1fd2d99e5842e6106dbe92de9d69055b270c6557972c10d3026093d6315c1dd8
// --- CHUNK_METADATA_END ---
$ log L_n (theta) = sum_(i=1)^n ln f_theta (X_i) " сума випадкових величин" $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 910407cc18bdb9a54210a8c3ab1535e11402ba8a09b720d617779bfd27be2dc5
// --- CHUNK_METADATA_END ---
$ log L_n (hat(theta)) = sup_(theta in Theta) log L_n (theta) $// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8526f4cb85523aef0c1e99dc304d8d05fec5d10385db81b5ab84e0c64e6ab11e
// --- CHUNK_METADATA_END ---
#rmk[
  $hat(theta)$ є випадковою змінною
  #import "figures/remarque-max-vraisemblance.typ":diagram as remarque-max-vraisemblance
  #remarque-max-vraisemblance(width: 400pt)
  //
  // Image placeholder: \incfig{remarque-max-vraisemblance}
  // #figure(
  //   caption: "remarque-max-vraisemblance-1"
  // ) <fig:remarque-max-vraisemblance-1>
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b8de1c2935a3794cdd75bc82e407d57bd157384069c76ee7a420bbf3c2ac8a0a
// --- CHUNK_METADATA_END ---
// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 466e84a4d153ba03a924c61354b79e93773345f963be796ea4eceec5f9e36c80
// --- CHUNK_METADATA_END ---
#ex[
  - $Bern(theta)$, $f_theta (x) = theta^x (1 - theta)^(1 - x)$, $X_i$ з значеннями 0-1
    $ L_n (theta) = product_(i=1)^n theta^(X_i) (1 - theta)^(1 - X_i) = theta^(sum_(i=1)^n X_i) (1 - theta)^(n - sum_(i=1)^n X_i) $
    $ log L_n (theta) = (sum_(i=1)^n X_i) ln theta + (n - sum_(i=1)^n X_i) ln(1 - theta) $
    $ (log L_n)'(theta) = (sum_(i=1)^n X_i)/theta - (n - sum_(i=1)^n X_i)/(1 - theta) = (sum_(i=1)^n X_i - n theta)/(theta(1 - theta)) (overline(X) - theta) $
    Рівняння правдоподібності:
    $
      (log L_n)'(theta) = 0 &<==> (1 - theta) sum_(i=1)^n X_i = (n - sum_(i=1)^n X_i)theta \
      &<==> sum_(i=1)^n X_i = n theta ==> theta = (sum_(i=1)^n X_i)/n
    $
    критична точка, чи є вона максимумом?
    - Похідна змінює знак в $overline(X)$ $arrow.r$ ми дійсно маємо максимум $arrow.r$ $hat(theta)^(M V) = overline(X)$
    - Умова 2-го порядку, якщо $(log L_n)'' (theta) < 0$ для всіх $theta$ $==>$ $log L_n$ є вгнутою $==>$ глобальний максимум
    $ (log L_n)'' (theta) = - (sum_(i=1)^n X_i)/theta^2 - (n - sum_(i=1)^n X_i)/(1 - theta)^2 < 0, \, forall theta $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

