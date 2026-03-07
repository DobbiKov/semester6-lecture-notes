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
// src_checksum: ea261629f98b0b8868d993e03ac8cb53aca961ea380784787475299d7694d6cf
// --- CHUNK_METADATA_END ---
= Інформація Фішера, ефективність

Нехай $(P_theta)_(theta in Theta)$, $Theta subset RR^p$ (ідентифіковане, задане). Позначимо $f_theta$ щільність $P_theta$
$ op("Supp") f_theta = { x in E, \, f_theta(x) > 0 } $

Дано $(X_1, ..., X_n)$, н.о.р. з розподілом $P_theta$ і $theta mapsto L(theta) = product_(i=1)^n f_theta(X_i)$ — функція правдоподібності вибірки. На $op("Supp") f_theta$ можна обчислити
$ log L_n(theta) = sum_(i=1)^n log f_theta(X_i) $
$ hat(theta) = op("argmax")_(theta in Theta) log L_n(theta) $

// #prop(name: "propriété de l'EMV")[
//   Якщо $hat(theta)$ ОМП#footnote[*ОМП* = *О*цінка *М*аксимуму *П*равдоподібності] для $theta$, то $g(hat(theta))$ є ОМП для $g(theta)$
// ]
#prop[
  Якщо $hat(theta)$ ОМП#footnote[*ОМП* = Оцінка Максимуму Правдоподібності] для $theta$, $g(hat(theta))$ є ОМП для $g(theta)$
]

Мета: що може бути "кращим" оцінювачем?
$-->$ регулярна модель

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 43f867c9e008c03fa4c8c5f85c22fb172a877f9478df2e0f4d50a5d1d3da53f7
// --- CHUNK_METADATA_END ---
== Регулярна модель

#defn[
  Модель $(P_(theta))_(theta in Theta)$ називається регулярною, якщо:
  1.  $Theta$ є відкритою множиною і  $theta |-> f_theta(x)$ є  $C^1$
  2. $op("Supp") f_theta$ не залежить від  $theta$:  $S = { x, #h(0.4em)f_theta(x) >0}$
  3. Для будь-якого $theta$ відображення
   $
  x |-> ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0)
  $
  є інтегрованою $(L, mu)$ і інтеграл
   $
  I(theta) = int_S ((partial f_theta)/(partial theta)(x))/(f_theta(x)) bb(1)_(f_theta(x) > 0) d x
  $
  є неперервним на $Theta$.
]

#notation[
  Позначаємо похідну від $f_theta(x)$ відносно  $theta$ як:  $(partial f_theta)/(partial theta)(x)$
  Величина  $I(theta)$ називається *Інформацією Фішера моделі*.
]

#ex[
  - $f_theta(x) = theta e^(-x theta)$ щільність відносно  $mu(d x) = bb(1)_(x >= 0) d x$

   $theta |-> theta e^(-x theta)$ є $C^(infinity)$ на  $Theta = ]0, +infinity[$,  $op("Supp") f_theta = RR_+$

    $
   (partial f_theta)/(partial theta)(x) = (1 - x theta)e^(-x theta)
   $ 

   $
   ((1 - x theta)^2 (e^(-x theta))^2)/(theta e^(-x theta)) = ((1 - x theta)^2)/theta e^(-x theta)
   $
   $
   I(theta) &= int_theta^infinity ((1 - x theta)^2)/(theta^2) theta e^(-x theta) d x \
   &= 1/(theta^2) E_theta (1 - X theta)^2 \
   &= 1/(theta^2) [ 1 - 2 theta E(X) + theta^2 E(X^2) ] = 1/(theta^2)
   $
   неперервна на $]0, +infinity[$
] 

#ex[
  $op("Bernoulli")(theta)$, $x = 0.1$,  $f_theta(0) = 1 - theta$,  $f_theta(1) = theta$, щільність відносно  $delta_0 + delta_1$


  Для будь-якого  $x in { 0, 1}$,  $theta |-> f_theta(x)$ є  $C^1$
  $
  (( (partial f_theta(0))/(partial theta) )^2)/(f_theta(0)) = 1/(1 - theta)
  $
  $
  (( (partial f_theta(1))/(partial theta) )^2)/(f_theta(1)) = 1/(theta) => I(theta) = 1/(1 - theta) + 1/(theta) = 1/(theta (1 - theta))
  $
  неперервна на $]0, 1[$
  
]

#ex[
  $f_theta(x) = 1/theta bb(1)_[0, theta] (x) = 1/theta bb(1)_[x, +infinity[ (theta)$ нерегулярна модель
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: fec51159001d31362a23a99fd60d517d14635c4487b12fe61fd822d7cb4b880b
// --- CHUNK_METADATA_END ---
== Оцінка та Інформація Фішера
$(X_1, ..., X_n)$ н.о.р. з розподілом  $P_theta, #h(0.3em) f_theta$

#defn[
  Називається *оцінкою* або *вектором оцінки* похідна логарифмічної функції правдоподібності $partial/(partial theta) log L_n(theta) = S_n(theta) = sum_(i=1)^n partial/(partial theta) log f_theta (X_i)$
] 

#ex[
  $X_i ~  cal(E)(theta)$, $L_n(theta) = theta^n e^(-theta sum_i X_i)$,  $log L_n (theta) = n log theta - theta sum_i X_i$, отже  $S-n(theta) = n/theta - sum_(i=1)^n X-i$
]

#rmk[
  $
  E(S_n (theta)) = E[ n(1/theta - (sum X_i)/n)]
  $ 
]

Додаткова гіпотеза регулярності:
$(H)$ для будь-якого оцінювача  $h(X)$ та будь-якого $theta$, наступні інтеграли існують і є рівними:
 $
partial/(partial theta) int_S h(x) f_theta (x) d x = int_S h(x) ( partial f_theta)/(partial theta) (x) d x
$ 
#rmk[
  умова застосування теореми Лебега про диференціювання.

  $
  h sup_(tilde(theta) in V_theta) |(partial f_theta)/(partial theta) (x)| in L_1 (mu)
  $ 
] 

#prop[
  За умови $(H)$, оцінка є центрованою  $(P_theta)$,  $n=1$

   $
  E_theta [partial/(partial theta) log L_1(theta)] = int_S partial/(partial
  theta) log f_theta (x) d x = int_S ( partial/(partial theta) f_theta(x)
)/cancel(f_theta (x)) cancel(f_theta (x)) d x = int_S (partial
f_theta)/(partial theta) (x) d x underbrace(=, (H)) partial/(partial theta)
overbracket(int f_theta (x) d x, = 1) = 0
  $ 
]

#defn[
  Інформація Фішера, пов'язана з $(X_1, dots, X_n)$ 
   $
  I_n (theta) underbrace(=, "def") E_theta [ (partial/(partial theta) log L_n(theta))^2] overbrace(=, "cor. de la prop 1") = op("Var")_theta [(partial log L_n (theta))/(partial theta)]
  $ 

  $
  (*) E_theta [ partial/(partial theta) log f_theta (X_1)]^2 = int_S ( (partial/(partial theta) f_theta (x))/(f_theta (x)) )^2 f_theta (x) d x = int_S ((partial/(partial theta) f_theta (x))^2)/(f_theta (x)) = "\"вираз з визначення 1\""
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9a815d0b3641e58af530b4555641f783c511528dae467c7f0067e9c0e9350726
// --- CHUNK_METADATA_END ---
#ex[
  $(X_1, ..., X_n) ~  cal(E)(theta)$, $partial/(partial theta) log L_n (theta) = n/theta - sum_(i=1)^n X_i$
   $
  I_n (theta) = E( (n/theta - sum X_i)^2) = n^2 E[(1/theta - (sum X_i)/n)^2] = n^2 op("Var")(overline(X)) = n^2 1/n 1/(theta^2) = n/(theta^2)
  $ 
]

#prop[
  $
  I_n (theta) = n I(theta)
  $
  справді,
  $
  I_n (theta) = op("Var")(partial/(partial theta) log L_n (theta)) = op("Var") (sum_(i=1)^n partial/(partial theta) log f_theta (X_i)) underbrace(=, "independance") = sum_(i=1)^n op("Var")(partial/(partial theta) log f_theta (X_i)) = \
  = n underbrace(op("Var")(partial/(partial theta) log f_theta (X_1))) = n I (theta)
  $ 
]

#ex[
  $(X_1, ..., X_n)$ i.i.d  $cal(P)(theta)$,  $f_theta (x) = e^(- theta)(theta^x)/(x!)$
   $
  log L_n (theta) = -n theta + (sum X_i) log theta - log product_(i=1)^n X_i !
  $ 
  $
  partial/(partial theta) log L_n (theta) = -n + (sum X_i)/theta => I_n (theta) = op("Var")((sum X_i)/theta) = 1/(theta^2) n theta = n/theta
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c85a73d5c9c7868f0d365e6a16b3b724dc1d0da05df618da87545186fa45a6c9
// --- CHUNK_METADATA_END ---
== Інформація Фішера та друга похідна
#prop[
  Якщо додати, що $theta |-> f_theta (x)$ є $C^2$ і що $(H)$ справедливо для $(theta^2)/(partial theta^2)$, то інформація Фішера також записується як
   $
  I_n (theta) = -E_theta [ (partial^2 log L_n (theta))/(partial theta^2) ]
  $ 
  якщо $hat(theta)$ є ОМВ, $I_n(hat(theta)) > 0$

  $n=1$
  
   $(partial^2)/(partial theta^2) log f_theta (x) = (( (partial^2 f_theta (x))/(partial theta^2) )^2)/(f_theta (x)) - (( (partial f_theta)/(partial theta)(x) )^2)/(f_theta^2 (x))$ 

    $
   E[ (partial^2)/(partial theta^2) log f_theta (X_1)] = int_S ((partial^2 f_theta(x))/(partial theta^2))/(cancel(f_theta (x))) cancel(f_theta (x)) d x - underbrace(int_S (( (partial f_theta (x))/partial theta )^2)/(f_theta^2 (x)) d x, I (theta))
   $ 
]

#import "figures/visual-example-for-info-fisher.typ":diagram as visual-example-for-info-fisher
#visual-example-for-info-fisher(width: 400pt)

Якщо крива дуже "гостра" в ОМВ (тобто інформація Фішера велика), то ОМВ локалізується точно

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 2eacd4ed04abb0acd533684cde6bd097e7cb106356ccc543169a09b3888e66d2
// --- CHUNK_METADATA_END ---
== Нерівність Крамера - Рао
Нехай $g(theta)$ — параметр, що цікавить, де $g: Theta -> RR$

#prop[
  За припущеннями регулярної моделі, якщо для кожного $theta$ $I(theta) > 0$, тоді для будь-якого #underline("незміщенного") $T = T(X_1, ..., X_n)$оцінювача, для якого $E_theta T^2 < +infinity$, виконується
   $
  forall theta in Theta, underbracket( op("Var")_theta (T) >= ((g'(theta)^2))/(I_n (theta)) ) = ((g'(theta))^2)/(n I(theta))
  $ 
] 
#proof[
  $
  &forall theta #h(0.5em) E_theta(T) = g(theta) \
  =>& partial/(partial theta) E_theta (T) = g'(theta) \
  script(T=T(X_1)) <=>& partial/(partial theta) int_S T(x) f_theta (x) d x = g'(theta) \
  script((H)) <=>& int_S T(x) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g' (theta) \
  <=>& int_S (T(x) - g(theta)) (partial/(partial theta) f_theta (x))/(f_theta (x)) f_theta (x) d x = g'(theta)
  $ 
]
Нерівність Коші-Шварца для $angle.l h_1, h_2 angle.r = int h_1(x) h_2(x) f_theta (x) d x$ з $h_1(X)$ та $h_2(X)$ центрованими

 $
( angle.l T(X) - g(theta), (partial/(partial theta) f_theta (x))/(f_theta (x)) angle.r_theta )^2 = (g'(theta))^2 underbrace(=, "c.s") underbrace(int (T(x) - g(theta))^2 f_theta (x) d x, = op("Var")_theta (T)) times underbrace(int ((partial/(partial theta) f_theta (x))/(f_theta (x)))^2 f_theta (x) d x, = I(theta))
$ 

#defn[
  Якщо $T$ досягає рівності, тоді $T$ називається *ефективним*.
]
