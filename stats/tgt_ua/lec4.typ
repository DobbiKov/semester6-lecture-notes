// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: b847744a1a0b38c4a68a842a1c9b662503616079d7bb62a4fb1135b6bc70c36d
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
// src_checksum: f50245ab868ac4c9a0c2b2505204781ac8a8cf0d66ca9f4924235a079162fcf4
// --- CHUNK_METADATA_END ---
= Асимптотичне дослідження оцінювачів

У параметричній моделі #underline([регулярній]), якщо $hat(theta)_n$ оцінювач $theta$, тоді 
$
Var(hat(theta)_n) >= 1/(I_n(theta)) = 1/(n I(theta))
$ 
якщо $Var(hat(theta)_n) = 1/(n I(theta))$ неупереджений, $hat(theta)_n$ є ефективним #underline([ефективним]) 

Асимптотика: $n -> +infinity$, 
 $
n Var(hat(theta)_n) -->_(n -> +infinity) 1/(I(theta))
$ 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 713139145d99aac2e688a7163c7942fee95fc5b6aec171c544f70201d9529081
// --- CHUNK_METADATA_END ---
== Збіжності
$(X_n)_(n >= 0)$ послідовність дійсних випадкових величин $(RR^d)$

-

- Збіжність за розподілом: $X_n -->_(n -> +infinity)^(cal(L)) X$ тоді й тільки тоді, коли $P(X_n <= x)
  --> P(X <= x)$ в кожній точці неперервності $x$.

#lem(info: "lemme de Portmanteau")[
  Еквівалентні характеристики:
  - Для будь-якої неперервної обмеженої функції $h$, 
    $
    E[h(X_n)] --> E[h(X)]
    $ 

    $=>$ збіжність за розподілом є стійкою щодо переходу до неперервних функцій
    (LAC) #underline([АЛЕ]) загалом #underline([неправильно]), що якщо $X_n -->^(cal(L)) X$ та $Y_n -->^(cal(L)) Y$, тоді $mat(X_n ; Y_n) -->^(cal(L)) mat(X; Y)$

    

    Це справедливо у 3 випадках:
    1. 
      $
      "якщо " cases(forall n\, X_n " et " Y_n " sont indépendantes", X " et " Y " sont indépendantes ") ", тоді " cases(" convergence en loi de " X_n " et " Y_n, " convergence en loi du couple " mat(X_n;Y_n))
      $ 
    2.  
    $
    "якщо " cases(X_n -->^P X, Y_n -->^p Y) ==> mat(X_n; Y_n) -->^P mat(X; Y) ==> mat(X_n; Y_n) -->^(cal(L)) mat(X; Y) 
    $ 
    3. (Лема Слуцького) (найважливіше)
    $
    "якщо " cases(X_n -->^(cal(L)) X, Y_n -->^(cal(L)) c) ", тоді " mat(X_n; Y_n) -->^(cal(L)) mat(X; c)
    $ 
    застосовуючи LAX,
    $
      h(x, y) &= x + y #h(40pt) X_n + Y_n -->^(cal(L)) X + c \
              &= x y #h(40pt) X_n Y_n -->^(cal(L)) -->^(cal(L)) c X \
              &= x/y #h(40pt) X_n/Y_n -->^(cal(L)) X/c
    $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 79aafe1277bc71b7f9e4a7f2123b7a2a9f8aee571979653b9f6966ad52d35b12
// --- CHUNK_METADATA_END ---
== Консистентність оцінок
#defn[
  $hat(theta)_n$ асимптотично незміщений тоді й лише тоді, коли
  $
  #math.op("Biais") (hat(theta)_n, theta) = E[hat(theta)_n] - theta -->_(n -> +infinity) 0
  $ 
]
#rmk[
  Збіжність за ймовірністю не передбачає збіжності математичних сподівань.

  Якщо $X_n -->^P X$,  $|X_n| <= Y in L'$, то за теоремою про доміновану збіжність  $X_n --> X$ в  $L_1$
]

#ex[
  $hat(tau)_n = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum X_i^2 - (overline(X))^2$ оцінка моментів для $tau^2 = E[X^2)] - (E[X])^2$
   $
  #math.op("Biais") (hat(tau)_n^2, tau^2) = - 1/n tau^2 " асимптотично незміщена"
  $ 
  Консистентність $hat(tau)_n^2$?

  Інструменти для демонстрації консистентності:
  - LGN
  - якщо  $R(hat(theta)_n, theta) --> 0$ то  $hat(theta)_n$ консистентний, оскільки збіжність  $L^2 => $ збіжність за ймовірністю
  - повернутися до визначення збіжності за ймовірністю
  \ \ \ 
  - якщо  $(X_i)$ є н.о.р., то  $(X_i^2)$ є н.о.р.
     $
    E[X_i^2] < +infinity
    $ 
    ЗВЧ: $1/n sum_i X_i^2 -->^P E[X^2] = tau^2 - mu^2$ 
  - $overline(X) -->^P mu$ (ЗВЧ), з Лемою про неперервне відображення для  $h(x) = x^2$: $(overline(X))^2 -->^P mu^2$
  - Отже  $mat(1/n sum_(i=1)^n X_i^2; 1/n sum X_i) -->^P mat(tau^2 - mu^2; mu)$
  - Лема про неперервне відображення  $h(x, y) = x - y^2$

  Таким чином  $1/n sum X_i^2 - (overline(X))^2 -->^P tau^2 + mu^2 - mu^2 = tau^2$
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c185422258ac1db52f4e8867eb0f0d89c71cac9789c409994bd5d7b9c245cb2c
// --- CHUNK_METADATA_END ---
== Асимптотична нормальність
$hat(theta)_n$ для  $theta$. 

$->$ Питання: яка швидкість збіжності  $hat(theta)_n$ до  $theta$ ?

$(X_1, ..., X_n)$ н.о.р., з математичним сподіванням  $theta$,  $hat(theta) = overline(X)$ з дисперсією  $tau^2(theta)$

#underline([ЦГТ])  $sqrt(n)(overline(X) - theta) -->^(cal(L)) Z ~ cal(N)(0, tau^2(theta))$ #underline[незалежно від розподілу  $X_i$]

#defn[
  $hat(theta)_n$ є #underline([асимптотично нормальною]) оцінкою тоді і тільки тоді, якщо 
  - швидкість збіжності за  $sqrt(n)$
  - збіжність за розподілом
  - граничний розподіл є нормальним

   $
  sqrt(n) (hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, tau^2(theta))
  $ 
]

#ex[
  Чи є $hat(tau)_n^2$ асимптотично нормальною ?

   $(X_1, dots, X_n)$ н.о.р. з математичним сподіванням  $mu$, дисперсією $tau^2$

    $
   hat(tau)_n^2 = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n (X_i - mu)^2 + (overline(X) - mu)^2 + underbrace(2/n sum_(i=1)^n (X_i - mu)(mu - overline(X)), = 2(mu - overline(X))(overline(X) - mu))
   $ 

  - ЦГТ: якщо $(X_i)$ н.о.р., тоді  $(X_i - mu)^2$ є н.о.р. з математичним сподіванням  $tau^2$,
     $
    sqrt(n) (1/n sum_(i=1)^n (X_i - mu)^2 - tau^2) -->^(cal(L)) Z ~ cal(N) (0, u_4 - tau^4)
    $ 
    $
    Var(X_i - mu)^2 = E[(X_i - mu)^4] - mu^4 = mu_4 - tau^4
    $ 
  - ЦГТ: $sqrt(n) (overline(X) - mu) -->^(cal(L)) cal(N)(0, tau^2)$ 
  - $sqrt(n) (hat(tau)_n^2 - tau^2) = sqrt(n) (1/n sum_i (X_i - mu)^2 - tau^2) - underbrace( sqrt(n)(overline(X) - mu)^2, sqrt(n) underbrace(( overline(X) - mu ), -->^(cal(L)) cal(N) (0, tau^2)) times underbrace( (overline(X) - mu), -->^(cal(L), P) 0 ))$ 
  $
  #math.cases([$overline(X) - mu -->^(cal(L)) 0$], [$sqrt(n) (overline(X) - mu) -->^(cal(L)) U ~ cal(N) (0, 1)$], reverse: true) ==>^("lemme de Slutsky") sqrt(n) (overline(X) - mu)^2 -->^(cal(L))_P 0
  $ 
  $
  sqrt(n) (hat(tau)_n^2 - tau^2) -->_(n -> +infinity)^(cal(L)) Z + 0
  $ 
  Отже, $hat(tau)_n^2$ є асимптотично нормальною оцінкою
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 83f34bc0268e8062ba8ad9008b42125418ed0cfe4fd927b3d8246065326d240a
// --- CHUNK_METADATA_END ---
#rmk[
  $sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N)(0, tau^2) <==> (sqrt(n)(hat(theta)_n - theta))/tau -->^(cal(L))_(n -> +infinity) cal(N)(0, 1)$ 
  Застосування леми Слуцького: якщо $hat(tau)^2$ є консистентною оцінкою $tau^2$, тоді ми все ще маємо 
  $ (sqrt(n)(hat(theta)_n - theta))/(hat(tau)) -->^(cal(L)) cal(N) (0, 1) $
]
#proof[
  $
  (sqrt(n) (hat(theta) - theta))/(hat(tau)) = underbrace(( sqrt(n) ((hat(theta) - theta))/tau), -->^(cal(L)) Z ~ cal(N)(0, 1) ) times underbrace( ( tau/hat(tau) ), -->^P 1 ) \
  -->^(cal(L)) 1 times Z "за Слуцьким та консистентністю " hat(tau)
  $ 
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c82a5690416cb70cd2ab7d2889a786e73cb0659dff9fe911c194a0684e37c371
// --- CHUNK_METADATA_END ---
== $delta$-метод
$hat(theta)$ асимптотично нормальна оцінка: який асимптотичний розподіл $g(theta)$?

#lem(info: "дельта-метод")[
  Нехай $Z_n$ — послідовність дійсних випадкових величин, таких, що
   $
  sqrt(n) (Z_n - mu) -->^(cal(L)) Z ~ cal(N)(0, tau^2)
  $
  Нехай $g$ — диференційовна функція, $g'(mu) != 0$. За цих припущень маємо
  $ 
  sqrt(n)[ g(Z_n) - g(mu) ] -->_(n -> +infinity)^(cal(L)) tilde(Z) ~ cal(N)(0, (g'(mu))^2 tau^2)
  $
   $
  g(x) = g(mu) + g'(mu)(x - mu) + (x - mu) R (x - mu) " де " R(y) ->_(y->0) 0
  $
  $
  sqrt(n)( g(Z_n) - g(mu) ) = underbrace( g'(mu) underbrace( sqrt(n) (Z_n -
  mu), -->^(cal(L)) Z ~ cal(N)(0, tau^2) ), --> cal(N) (0, (g'(mu))^2 tau^2)) +
  underbrace( underbrace( (sqrt(n)) (Z_n - mu), -->^(cal(L)) cal(N) (0, tau^2)) underbrace( R (Z_n - mu), -->^P 0 ? ),  )
  $
  Чи маємо $Z_n -->^P mu$ ?
   $
  P(|X_n - mu| > epsilon) &= P((sqrt(n)|Z_n - mu|)/tau > (sqrt(n) epsilon)/tau) \
  &= P((sqrt(n) (Z_n - mu))/tau > (sqrt(n) epsilon)/tau) + P( (sqrt(n) (Z_n - mu))/tau < - (sqrt(n) epsilon)/tau ) \
  &~= 1 - Phi_n ((sqrt(n) epsilon)/tau) + Phi_n (- (sqrt(n) epsilon)/tau) = 2(1 - Phi((sqrt(n) epsilon)/tau))
  $
]
