// --- CHUNK_METADATA_START ---
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// needs_review: True
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
// src_checksum: 109f237f94516d4790d5437da0c58b435acf7b2608b8458da1e844c72137d9d4
// needs_review: True
// --- CHUNK_METADATA_END ---
= Емпірична функція розподілу
$(X_1, ..., X_n)$ — i.i.d. вибірка з дійсними значеннями, що підпорядковується невідомому закону $F$.
 $
forall x in RR, F(x) = P(X_1 <= x) = E[bb(1)_(X_1 <= x)]
$ 

#defn[
  Функція #underline[емпіричного] розподілу, пов'язана з $(X_1, ..., X_n)$, визначається як:
   $
  hat(F)_n: RR &--> [0, 1] \
            x &|-> 1/n sum_(i=1)^n bb(1)_(X_i <= x)
  $ 
  $forall x in RR, hat(F)_n (x)$ є випадковою величиною, оцінювачем для $F(x)$. 
]

#defn[
  Емпіричний закон розподілу $P_n = 1/n sum_(i=1)^n delta_X_i$ є дискретним рівномірним законом розподілу на ${X_1, ..., X_n}$.
]

Графічне представлення

Умовно $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$

 $
x_((1)) <= x_((2)) <= ... <= x_((n)) " упорядковані значення"
$ 

#import "figures/repr-graphique-repartition-empirique.typ":diagram as repr-graphique-repartition-empirique
#repr-graphique-repartition-empirique(width: 400pt)
fdsa

#prop(info: "Безпосередні властивості")[
  - $n hat(F)_n (x) = sum_(i=1)^n bb(1)_(X_i <= x)$ підпорядковується біноміальному розподілу$(n, F(x))$ 
  - $R(hat(F)_n (x), F(x)) = 0 + 1/(n^2) Var(sum_(i=1)^n bb(1)_(X_i <= x)) underbrace(=, "indep") 1/n F(x) (1 - F(x)) -->_(n -> +infinity) 0$
    отже  $forall x in RR, hat(F)_n (x) -->^P F(x)$
  - або ж #underline[ЗВЧ]:  $hat(F)_n (x)$ є #underline[консистентним] оцінювачем  $F(x)$.
  - Ми маємо результат рівномірної збіжності:
     $
    sup_(x in RR) |hat(F)_n (x) - F(x)| -->_(n -> +infinity)^P 0 " (Теорема Гливенка-Кантеллі)"
    $ 
    .#footnote[ТМ Гливенка-Кантеллі: #link("https://fr.wikipedia.org/wiki/Th%C3%A9or%C3%A8me_de_Glivenko-Cantelli")]
  - Чи є $hat(F)_n (x)$ асимптотично нормальним?
// --- CHUNK_METADATA_START ---
// src_checksum: f3fa5be84b9f6ffbf3d0e3785d2af6acdb9b3e46ce691209a2e0aca6bcd069d7
// needs_review: True
// --- CHUNK_METADATA_END ---
$
    hat(F)_n (x) = 1/n sum_(i=1)^n bb(1)_(X_i <= x)
    $ ЦГТ: $X_i$ є н.о.р., тому ${bb(1)_(X_i <= x) = Y_i}$ є н.о.р.
     $
    forall x, F(x) in ]0, 1[, #h(1em) sqrt(n)(hat(F)_n (x) - F(x)) -->^(cal(L))_(n -> +infinity) cal(N)(0, F(x)(1 - F(x)))
    $ 
    $
    <==> (hat(F)_n (x) - F(x))/(sqrt((F(x)(1 - F(x)))/n)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
    $ 
]
// --- CHUNK_METADATA_START ---
// src_checksum: cebc3a2dab879021a16c99dc33a2e7a15b26eed8903e875313106205fa2d5d0d
// needs_review: True
// --- CHUNK_METADATA_END ---
== Емпіричне оцінювання "plug-in" або метод підстановки, параметр інтересу $theta = c(F)$, емпіричний метод визначає $hat(theta)$, емпіричну оцінку, замінюючи $F$ на $hat(F)_n -> hat(theta)_n = c(hat(F)_n)$.

#ex[
  $theta = E_F (X) -> hat(theta)_n = E_(hat(F)_n)(X) = sum_(i=1)^n X_i times 1/n = overline(X)$ якщо $X_i$ різні

   $
  theta = Var_F (X) -> hat(theta)_n = Var_(hat(F)_n)(X) = 1/n sum (X_i - overline(X))^2
  $ 
]
// --- CHUNK_METADATA_START ---
// src_checksum: 3c9872e903c5d398e6667322d88aac44df0c41a6b63c7dadb9d2aef30accb444
// needs_review: True
// --- CHUNK_METADATA_END ---
== Узагальнена обернена
#defn[
  Узагальнена обернена функція для $F$ визначається як:
   $
  F^(-1): [0, 1] --> RR
  $
  $
  forall alpha in [0, 1], F^(-1)(alpha) = inf{x in RR, F(x) >= alpha}
  $
  Якщо $F$ є строго зростаючою, то $inf x$ такий, що $F(x) >= a <=> x >= F^(-1) (alpha)$, якщо $F$ є функцією дискретного розподілу.

]
#pagebreak()
#import "figures/inverse-generalise.typ":diagram as inverse-generalise
#inverse-generalise(width: 400pt)

#ex[
  $
  F^(-1) (alpha) = x <=> F(x) = alpha <=> P(X <= x) = alpha <=> P(X > x) = 1 - alpha
  $
  #image("figures/inv-gen.JPG", width: 300pt)
]

Словник:
- $F^(-1)$ також називається #underline[квантильною функцією]
-  $F^(-1) (alpha) = $ квантиль порядку  $alpha$, розподілу  $F$
-  $F^(-1) (1/4) = $ 1-й квантиль
-  $F^(-1)(1/2) = $ медіана
-  $F^(-1) (3/4) = $ 3-й квантиль

#lem[
  Нехай $U$ — випадкова змінна на $[0, 1]$, $F$ — ф.р., тоді $F^(-1)(U)$ є випадковою змінною з розподілом $F$
]
- Якщо $F$ бієктивна:
 $
P(F^(-1)(U) <= x) underbrace(=, F "bijective") P(U <= F(x)) underbrace(=, "car" P(U <= x) = x "sur" [0, 1]) F(x)
$
- Якщо $F$ дискретна: $F^(-1)$ узагальнена обернена: $F^(-1)(y) <= x <=> y <= F(x)$
// --- CHUNK_METADATA_START ---
// src_checksum: f667f6c8e11448d8893b3de5db31780e3a611807e3195ed7d8831b69b5201f4e
// needs_review: True
// --- CHUNK_METADATA_END ---
== Емпіричний квантиль

#defn[
  Визначається #underline[емпіричний квантиль] (sample quantile) порядку
  $alpha$, як квантиль $hat(F)_n$: 
  $
  hat(q)_(n, alpha) = hat(F)_n^(-1)(alpha) = inf{x, hat(F)_n (x) >= alpha}
  $ 
] 

#prop[
  - Можна показати, що $hat(q)_(n, alpha) = X_(([n alpha]))$ де  $X_((1)) <=
    X_((2)) <= ... <= X_((n))$ є впорядкованою вибіркою з  $(X_i)_(1 <= i <
    n)$
    $
    [u] = "найменше ціле число" >= u
    $ 
]
#ex[
  $alpha = 1/2$,  $[n/2]$,
   $
  cases(
    "si" n=2k #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k)),
    "si" n=2k+1 #h(1em) "medianne" = hat(q)_(n, 1/2) = X_((k+1)))
  $ 
  - Узгодженість
    
    якщо $alpha in ]0,1[$, якщо  $F$ є строго зростаючою в околі $alpha$
]
// --- CHUNK_METADATA_START ---
// src_checksum: 704a0af81b7d1f09a4c7c23e227046d44f332fb69d463594fb4492014476e483
// needs_review: True
// --- CHUNK_METADATA_END ---
= Інтервали довіри
// --- CHUNK_METADATA_START ---
// src_checksum: ef9a514a12d201313dc6fa6c54081efcafd1c911dda4e802398c1e6c89c96e7a
// needs_review: True
// --- CHUNK_METADATA_END ---
== Визначення
$(X_1, ..., X_n)$ незалежні та однаково розподілені з розподілом $P in {P_theta, theta in Theta subset RR^p}$,
нас цікавить $theta in RR$ або $g(theta): RR^p --> RR$. 

Довірчий інтервал для $theta$, з рівнем довіри $1 - alpha,
alpha in ]0, 1[$ це інтервал, межі якого є #underline[випадковими],
функціями вибірки і НЕ залежить від невідомих параметрів моделі, і такий, що
 $
 P([B inf (X_1, ..., X_n); B sup (X_1, ..., X_n)] in.rev theta) >= 1 - alpha
$ 
#footnote[$B inf$ для нижньої межі та $B sup$ для верхньої межі]
- ДІ можна обчислити з даних 
- якщо нерівність є рівністю $=$ рівень довіри є #underline[точним].
- якщо ми маємо $P(theta in [B inf, B sup]) -->_(n -> +infinity) 1 - alpha$, рівень є #underline[асимптотичним].
- зазвичай $alpha = 1%, 5%$
// --- CHUNK_METADATA_START ---
// src_checksum: 7feb4aaa8f7ed83598ea2a7fa4b270c7562eabff3de9087464e681b8d714ea64
// needs_review: True
// --- CHUNK_METADATA_END ---
== Інтерпретація
// fig 1 here

#grid(columns: (50%, 50%),
[
  #image("figures/interv-confiance.png")
],
[
 $I C = [B inf(X_1, ..., X_n), B sup(X_1, ..., X_n)]$ математична формула, яка гарантує рівень  $1 - alpha$.
 Спостерігаємо  $X_1 = x_1, X_2 = x_2, ..., X_n = x_n$, реалізація випадкової вибірки. Обчислюємо
 $I C = [2.3; 5.1]$ з рівнем довіри $95%$ ($alpha = 5%$).

 В середньому, зі 100 обчислених інтервалів (за тією ж формулою) є 5
 інтервалів, які не містять $theta$. 

 $
 P(theta in [B inf, B sup]) = 1 - alpha
 $ 
 $
 cancel(P(theta in [2.3, 5.1]) = 95%) "оскільки " theta "число"
 $ 
]
)
// --- CHUNK_METADATA_START ---
// src_checksum: b7489a5808454697c4056bedbd6d78c8ebd47f27f6689dde2e27c88f72bd53e3
// needs_review: True
// --- CHUNK_METADATA_END ---
== Півотальний метод
$(X_1, ..., X_n)$ незалежні та однаково розподілені з математичним сподіванням $theta in RR$ та дисперсією $sigma^2(theta)$. Нехай $hat(theta)$ є асимптотично нормальною: 
 $
sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N) (0, sigma^2(theta)) \
<=> (sqrt(n) (hat(theta)_n - theta))/(sigma(theta)) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1)
$ 

За визначенням гаусових квантилів, $q_alpha = Phi^(-1) (alpha)$, де $Phi$ — функція розподілу $cal(N) (0, 1)$

#grid(columns: (50%, 50%),
[
$
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/sigma(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha
$ 
],
[
  #image("figures/methode-pivotale.png")
]
)

- *півот або півотальна статистика* = $(sqrt(n) (hat(theta) - theta))/(hat(sigma))$ — стандартизована статистика, отримана з $hat(theta)$, де $sigma^2(theta)$ оцінюється за допомогою $hat(sigma)^2$, #underline[консистентного] для оцінки $sigma^2(theta)$.  

  Якщо це так, 
  $
  underbrace( (sqrt(n) (hat(theta) - theta))/(sigma(theta)), -->^(cal(L))_(hat(theta) "as. normal") cal(N) (0, 1) ) times underbrace( (sigma^2(theta))/(hat(sigma)^2), -->^(P)_("estimateur consistant") 1) -->^(cal(L))_(n -> +infinity) cal(N) (0, 1) " par lemme de Slutsky"
  $ 
- З цього випливає, що 
  $
P(q_(alpha/2) <= (sqrt(n) (hat(theta) - theta))/hat(sigma)(theta) <= q_(1 - alpha/2)) -->_(n -> +infinity) 1 - alpha \
P(hat(theta) - 1/(sqrt(n))hat(sigma)q_(1 - alpha/2) <= theta <= hat(theta) - 1/(sqrt(n)) hat(sigma) q_(alpha/2)) --> 1 - alpha
  $