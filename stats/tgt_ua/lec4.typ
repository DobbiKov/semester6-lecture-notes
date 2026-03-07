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

У параметричній  #underline([регулярній]) моделі, якщо $hat(theta)_n$ є оцінювачем для $theta$, тоді 
$
Var(hat(theta)_n) >= 1/(I_n(theta)) = 1/(n I(theta))
$ 
якщо $Var(hat(theta)_n) = 1/(n I(theta))$ і  $hat(theta)_n$ є незміщеним, він є ефективним #underline([ефективним]) 

Асимптотично: $n -> +infinity$, 
 $
n Var(hat(theta)_n) -->_(n -> +infinity) 1/(I(theta))
$ 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 713139145d99aac2e688a7163c7942fee95fc5b6aec171c544f70201d9529081
// --- CHUNK_METADATA_END ---

== Збіжності
$(X_n)_(n >= 0)$ послідовність дійсних випадкових величин  $(RR^d)$

- збіжність за розподілом:  $X_n -->_(n -> +infinity)^(cal(L)) X$ т.т.л.  $P(X_n <= x)
  --> P(X <= x)$ у кожній точці неперервності $x$.

#lem(info: "лема Портманто")[
  Еквівалентні характеристики:
  - Для довільної неперервної обмеженої функції $h$, 
    $
    E[h(X_n)] --> E[h(X)]
    $ 

    $=>$ збіжність за розподілом є стійкою щодо переходу до неперервних функцій
    (LAC) #underline([АЛЕ]) загалом, є #underline([хибним]) що якщо $X_n -->^(cal(L)) X$ і  $Y_n -->^(cal(L)) Y$ тоді  $mat(X_n ; Y_n) -->^(cal(L)) mat(X; Y)$

    Це вірно у 3 випадках:
    1. 
      $
      "якщо " cases(forall n\, X_n " et " Y_n " sont indépendantes", X " et " Y " sont indépendantes ") " тоді " cases(" convergence en loi de " X_n " et " Y_n, " convergence en loi du couple " mat(X_n;Y_n))
      $ 
    2.  
    $
    "якщо " cases(X_n -->^P X, Y_n -->^p Y) ==> mat(X_n; Y_n) -->^P mat(X; Y) ==> mat(X_n; Y_n) -->^(cal(L)) mat(X; Y) 
    $ 
    3. (Лема Слуцького) (найважливіша)
    $
    "якщо " cases(X_n -->^(cal(L)) X, Y_n -->^(cal(L)) c) " тоді " mat(X_n; Y_n) -->^(cal(L)) mat(X; c)
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
== Узгодженість оцінок
#defn[
  $hat(theta)_n$ асимптотично незміщений тоді і тільки тоді, коли
  $
  #math.op("Biais") (hat(theta)_n, theta) = E[hat(theta)_n] - theta -->_(n -> +infinity) 0
  $ 
]
#rmk[
  Збіжність за ймовірністю не означає збіжності математичних сподівань.

  Якщо $X_n -->^P X$,  $|X_n| <= Y in L'$, то за теоремою про мажоровану збіжність  $X_n --> X$ в  $L_1$
]

#ex[
  $hat(tau)_n = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum X_i^2 - (overline(X))^2$ оцінка моментів для $tau^2 = E[X^2)] - (E[X])^2$
   $
  #math.op("Biais") (hat(tau)_n^2, tau^2) = - 1/n tau^2 " асимптотично незміщений"
  $ 
  Узгодженість $hat(tau)_n^2$?

  Інструменти для доведення узгодженості:
  - ЗВЧ
  - якщо  $R(hat(theta)_n, theta) --> 0$ то  $hat(theta)_n$ узгоджений  оскільки збіжність  $L^2 => $ збіжність за ймовірністю
  - повернутися до визначення збіжності за ймовірністю
  \ \ \ 
  - якщо  $(X_i)$ є н.о.р., то  $(X_i^2)$ є н.о.р.
     $
    E[X_i^2] < +infinity
    $ 
    ЗВЧ: $1/n sum_i X_i^2 -->^P E[X^2] = tau^2 - mu^2$ 
  - $overline(X) -->^P mu$ (ЗВЧ), за ТНВ з  $h(x) = x^2$: $(overline(X))^2 -->^P mu^2$
  - Отже  $mat(1/n sum_(i=1)^n X_i^2; 1/n sum X_i) -->^P mat(tau^2 - mu^2; mu)$
  - ТНВ  $h(x, y) = x - y^2$

  Отже  $1/n sum X_i^2 - (overline(X))^2 -->^P tau^2 + mu^2 - mu^2 = tau^2$
]

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0b032b3d8274eaa95f1e61e34749b2214a2211de2ed1978dac44bda15bf9b665
// --- CHUNK_METADATA_END ---
== Асимптотична нормальність// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 48851e09f467fb538d903ccc80730229b6b6b6d133a9cf873f7a60e1856c7720
// --- CHUNK_METADATA_END ---
$hat(theta)_n$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 109b0d99bdcda80faebea1b9aa0fc322d4d062d1cb4cb7bf90c0fa83fb2bbb5c
// --- CHUNK_METADATA_END ---
 для  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c7306518523986c1c42120bdd35c3c4f446af47a15fa3ae538440f629cddf010
// --- CHUNK_METADATA_END ---
$theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: a74ea03aa83a4194d06ea36a1cc5121e94141068d07d575bd9fbb3664841478a
// --- CHUNK_METADATA_END ---
. 

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: e407816a3568d8cdc354e00f8e968082966a8cbb3b4d5785d47fbf629b2b4abe
// --- CHUNK_METADATA_END ---
$->$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f23b466d4e4070923e6e9ba3332f91c77d39537d5a9d2a4642f6a7b9379507d4
// --- CHUNK_METADATA_END ---
 Питання: яка швидкість збіжності  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 48851e09f467fb538d903ccc80730229b6b6b6d133a9cf873f7a60e1856c7720
// --- CHUNK_METADATA_END ---
$hat(theta)_n$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 457562965c590e21bd9fbecca4d5471e1c94bbd53c867f4c07bf5e351612ad2a
// --- CHUNK_METADATA_END ---
 до  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c7306518523986c1c42120bdd35c3c4f446af47a15fa3ae538440f629cddf010
// --- CHUNK_METADATA_END ---
$theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ff2a1b9b67c120ed32484cb60d9b10c62e5980afc82c1b8bf1500865b95ae275
// --- CHUNK_METADATA_END ---
 ?

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 0fb7f75a6eff6284b4aa3b3da8804809eea2c36cacf898d15998e6e4c317c27e
// --- CHUNK_METADATA_END ---
$(X_1, ..., X_n)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7b014b89ea977ea1c978c7cd39c9e073ef91ea4d3b22d44d7b8c3c90f9eb26f9
// --- CHUNK_METADATA_END ---
 i.i.d., d// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 265fda17a34611b1533d8a281ff680dc5791b0ce0a11c25b35e11c8e75685509
// --- CHUNK_METADATA_END ---
'// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 779503bcc538884d8699ab5734bb45aa8b2a316e71d68d0b0f57d4606aa28a76
// --- CHUNK_METADATA_END ---
сподівання  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c7306518523986c1c42120bdd35c3c4f446af47a15fa3ae538440f629cddf010
// --- CHUNK_METADATA_END ---
$theta$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 74d67bd06f253a3197fcae95a7643c3abd4381807ce739a7b30b3271589daf35
// --- CHUNK_METADATA_END ---
,  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: f1fecb5f08b465d3a09d9adcbfb39ee9bcd2a7239181a7fab4ebc619ef8fd32e
// --- CHUNK_METADATA_END ---
$hat(theta) = overline(X)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 9ffbb6a184e9240bf4714539d2d4a4214d1f0246bc87ae289af1a9014aa02f09
// --- CHUNK_METADATA_END ---
 дисперсії  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 05b37fa1d22b7f3b093ca757c2412bea297e688e7a40408762fbb0aeb34aae80
// --- CHUNK_METADATA_END ---
$tau^2(theta)$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: cfe7ff26385e2546b24aa08a4a22a54389c0d5981e8f2f177df757c4a2f5488b
// --- CHUNK_METADATA_END ---
#underline([TLC])// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 6c179f21e6f62b629055d8ab40f454ed02e48b68563913473b857d3638e23b28
// --- CHUNK_METADATA_END ---
  // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 5a878b18d2c2233f8052f452432508759c40e49e06f1e04ee52af4a3105a38b0
// --- CHUNK_METADATA_END ---
$sqrt(n)(overline(X) - theta) -->^(cal(L)) Z ~ cal(N)(0, tau^2(theta))$// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 36a9e7f1c95b82ffb99743e0c5c4ce95d83c9a430aac59f84ef3cbfab6145068
// --- CHUNK_METADATA_END ---
 // --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 8099f59d37eee3944d88ee6fbd6c68c00bf3f53a987da789ebdf8140d489923c
// --- CHUNK_METADATA_END ---
#underline[незалежно від закону розподілу $X_i$]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 4e0d05a94aa7a7c5eec1a6de80f15ed5c11aff1a8560378544093a6a1491e3a3
// --- CHUNK_METADATA_END ---
#defn[
  $hat(theta)_n$ є #underline([асимптотично нормальною]) оцінкою тоді і лише тоді, коли: 
  - швидкість збіжності за  $sqrt(n)$
  - збіжність за розподілом
  - граничний розподіл є нормальним

   $
  sqrt(n) (hat(theta)_n - theta) -->^(cal(L)) Z ~ cal(N) (0, tau^2(theta))
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: ca5c83ef520f56278e692192af235490cb8c26cc9b770c258e7b102178debc38
// --- CHUNK_METADATA_END ---
#ex[
  $hat(tau)_n^2$ чи є асимптотично нормальною ?

   $(X_1, dots, X_n)$ н.о.р. із математичним сподіванням  $mu$, дисперсією $tau^2$

    $
   hat(tau)_n^2 = 1/n sum_(i=1)^n (X_i - overline(X))^2 = 1/n sum_(i=1)^n (X_i - mu)^2 + (overline(X) - mu)^2 + underbrace(2/n sum_(i=1)^n (X_i - mu)(mu - overline(X)), = 2(mu - overline(X))(overline(X) - mu))
   $ 

  - ЦГТ: якщо $(X_i)$ н.о.р., тоді  $(X_i - mu)^2$ є н.о.р. із математичним сподіванням  $tau^2$,
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
  Отже $hat(tau)_n^2$ є асимптотично нормальною оцінкою
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7fe8d6ae79b2b092f64c584fd85ee615fd7b871b869aed36a4bc092c5862e5d3
// --- CHUNK_METADATA_END ---
#rmk[
  $sqrt(n) (hat(theta)_n - theta) -->^(cal(L))_(n -> +infinity) cal(N)(0, tau^2) <==> (sqrt(n)(hat(theta)_n - theta))/tau -->^(cal(L))_(n -> +infinity) cal(N)(0, 1)$ 
  Застосування леми Слуцького:  якщо $hat(tau)^2$ є консистентною оцінкою для  $tau^2$, тоді ми також маємо  
  $ (sqrt(n)(hat(theta)_n - theta))/(hat(tau)) -->^(cal(L)) cal(N) (0, 1) $
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 01ba4719c80b6fe911b091a7c05124b64eeece964e09c058ef8f9805daca546b
// --- CHUNK_METADATA_END ---

// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 7f961d9f231f539cc5047ea23e03f34fc44964807af009fe72d2759307c56d80
// --- CHUNK_METADATA_END ---
#proof[
  $
  (sqrt(n) (hat(theta) - theta))/(hat(tau)) = underbrace(( sqrt(n) ((hat(theta) - theta))/tau), -->^(cal(L)) Z ~ cal(N)(0, 1) ) times underbrace( ( tau/hat(tau) ), -->^P 1 ) \
  -->^(cal(L)) 1 times Z "за Слуцьким та консистентність " hat(tau)
  $ 
]// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 75a11da44c802486bc6f65640aa48a730f0f684c5c07a42ba3cd1735eb3fb070
// --- CHUNK_METADATA_END ---


// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: c82a5690416cb70cd2ab7d2889a786e73cb0659dff9fe911c194a0684e37c371
// --- CHUNK_METADATA_END ---
== $delta$-метод 
$hat(theta)$  асимптотично нормальний оцінювач: який асимптотичний закон розподілу   $g(theta)$?

#lem(info: "дельта-метод")[
  Нехай $Z_n$ — послідовність дійсних випадкових величин така, що 
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
  Чи має місце $Z_n -->^P mu$ ?
   $
  P(|X_n - mu| > epsilon) &= P((sqrt(n)|Z_n - mu|)/tau > (sqrt(n) epsilon)/tau) \
  &= P((sqrt(n) (Z_n - mu))/tau > (sqrt(n) epsilon)/tau) + P( (sqrt(n) (Z_n - mu))/tau < - (sqrt(n) epsilon)/tau ) \
  &~= 1 - Phi_n ((sqrt(n) epsilon)/tau) + Phi_n (- (sqrt(n) epsilon)/tau) = 2(1 - Phi((sqrt(n) epsilon)/tau))
  $ 
]
