#import "preamble.typ": *

= Tests d'un paramètre gauissien <lec10>
// 1. Résumé de la construction

#suboutline()

== Résumé de la construction

$X = (X_1, ..., X_n)$ i.i.d. de loi  $P_theta$

1. Préciser les hypothèses testées:
#align(center)[
 $H_0$:  $theta <= theta_0$ contre  $H_1$:  $theta > theta_0$ 
 ]
2. Statistique de test: $T(X)$: sous  $H_0$ $T(X)$ calculable.
  La loi de $T$ sous  $H_0$ permet de distinguer $H_0$ et $H_1$.

  $arrow.curve$  $cal(R) = {T(X) > c}$ (sous $H_1$, si la ... de $T$ s'écarte
  de  $H_0$ vers la droite), (si $H_1$ : $theta < theta_0$ $->$ $cal(R) = {T(X)
  < c}$, si test bilatère  $H_1: theta != theta_0$  $->$  $cal(R) = {|T(X)| >
  c} = {T(X) > c  " ou " T(X) < -c}$)
3. Règle de décision
  $alpha$ niveau fixé,
  - Condition de niveau: 
   $
  sup_(theta <= theta_0) P_(H_0) (T(X) > c) &= alpha "(si loi de " T " sous " H_0 " est continue)" \
                     &<= alpha "(si loi de " T " discrète)" \
                     &-->_(n -> +infinity) "(si loi de " T " est symptotique)"
  $ 
4. Application numérique:
  - calcul du seuil
  - calcul de la réalisation de $T = T^"obs" = T(X)$ si  $x = (x_1, ..., x_n)$
    réalisation de  $(X_1, ..., X_n)$ dans notre expérience
    - si $T^"obs" > c_alpha$ alors on rejette  $H_0$, avec un risque de se
      tromper de $alpha$. 
    - si $T^"obs" <= c_alpha$, on conserve  $H_0$, avec un risque de se tromper
      de #underline[inconnu] (en général)

#rmk[
  Le test de $H_0$:  $theta >= theta_0$ contre  $H_1$:  $theta < theta_0$, est
  le même que le test de  $H_0$: $theta = theta_0$ contre $H_1$:  $theta <
  theta_0$,  $cal(R) = {T < c}$
]

== $P$-valeur
#ex[
  $(X_1, ..., X_n)$ i.i.d. de loi $cal(N) (0, 1)$ ; test $H_0$:  $theta = 0$, contre  $H_1$:  $theta > 1$

   $arrow.curve$  $T = (hat(theta) - 0)/(1/sqrt(n)) = sqrt(n) hat(theta) ~_(H_0) cal(N) (0, 1)$ où $hat(theta) = overline(X)$;
    $cal(R) = {T > c}$ condition de niveau $P_(theta = 0) (underbrace(T, ->
    ~cal(N) (0, 1)) > c) = alpha => c_alpha = #math.op("qnorm")_(1 - alpha) =
    Phi^(-1) (1 - alpha)$ $=>$  $cal(R) = {sqrt(n) hat(theta) > Phi^(-1) (1 - alpha)}$

    rejet de $H_0$  $<=>$  $alpha > 1 - Phi(sqrt(n) hat(theta))$

     $alpha = 5%$ rejette-t-on à  $5%$?  $10%$?  $1%$?

     A.N  $hat(theta) = 0.3$,  $n=100$,  $sqrt(n) hat(theta) = 3$, $1 - Phi(3) approx 10^(-3)$
]
#defn[
  Si $(X_1, ..., X_n)$ i.i.d.,  $cal(R) = {T(X) > c_alpha}$. Pour une réalisation  $x = (x_1, ..., x_n)$ de  $X = (X_1, ..., X_n)$, on appelle  $p$-valeur du test de région de  $cal(R)$: 
  $
  #math.op("pval") &= inf {alpha in [0,1], T(X) > c_alpha} \
                   &= inf {alpha, H_0 " est rejetée au niveau " alpha}
  $ 
  pvalue ($phi(X) = bb(1)_(cal(R)) (X)$) - niveau de significativité probabilité critique
]<pvaleur>

  La @pvaleur peut sembler assez abstraite mais elle a une application assez
  intuitive. $T(X)$ dépend de notre échantillon observée et  $c_alpha$ dépend
  de la loi (sous $H_0$) et de $alpha$ (important: indépendant des données observée).

  Une propriétée improtante est que  $c_alpha$ est croissante en fonction de  $alpha$. Finalement, on calcule  $T(x_1, ..., x_n) in RR$, on cherche le plus petit alpha (équivalent à chercher le plus grand $c_alpha$ tel que  $T(x_1, ..., x_n) > c_alpha$). Puis $P(T(x_1, ..., x_n) > c_alpha) = alpha = #math.op("pval")$ d'après @pvaleur.
#insight[
  Pvaleur nous dit: quelle est la probabilité d'avoir telles données
  aussi loin de notre région où on conserve $H_0$. Plus  $alpha$ est petit,
  moins des valeurs extrêmes ($T(x_1, ..., x_n)$ observées), donc plus est la
  tendance à rejetter $H_0$.
]
#ex[
  $
  #math.op("pval") &= 1 - Phi(sqrt(n) hat(theta)^"obs") \
                   &= 1 - Phi(T^"obs") \
                   &= 1 - P(cal(N) (0, 1) <= T^"obs") \
 #math.op("pval")  &= P(underbrace(cal(N) (0,1), "loi de " T) > T^"obs") \
                   &= P(T > underbrace( T^"obs", in RR ))
  $ 
]

=== Généralisation(formule de calcul d'une p-valeur).

$T(X)$ statistique de test
-  $cal(R) = {T(X) > c}$, alors  $p$-valeur  $= P_(H_0) (T(X) > T^"obs")$
-  $cal(R) = {T(X) < c}$, alors  $p$-valeur  $= P_(H_0) (T(X) < T^"obs")$ 
-  $cal(R) = { |T(X)| > c}$,  $p$-valeur $= P_(H_0)(|T(X)| > |T^"obs"|)$

=== Remarques
#rmk[
  Sur l'exemple 
  $
  P_(H_0) (|T| > T^"obs") &= P_(H_0) (T > T^"obs" " ou " T < -T^"obs") \
                          &= P_(H_0) (T > T^"obs") + P(T < -T^"obs") \
                          &= 1 - Phi(T^"obs") + Phi(-T^"obs") \
            "(symétrie)"  &= 2(1 - Phi(T^"obs"))
  $
  la  $p$-valeur du test bilatère est le double de la $p$-valeur du test unilatère.
  // img here
  #align(center)[
#canvas({
  import draw: *

  let bell(x) = { calc.exp(-x * x / 2) * 1.8 }
  let t = 1.65

  // Shade left tail
  merge-path(
    {
      catmull(
        (-3.2, 0),
        (-3.2, 0.02),
        (-2,   bell(-2)),
        (-t,   bell(-t)),
      )
      line((-t, bell(-t)), (-t, 0))
      line((-t, 0), (-3.2, 0))
    },
    fill: gray.lighten(20%),
    stroke: none,
  )

  // Shade right tail
  merge-path(
    {
      catmull(
        (t,    bell(t)),
        (2,    bell(2)),
        (3.2,  0.02),
        (3.2,  0),
      )
      line((3.2, 0), (t, 0))
      line((t, 0), (t, bell(t)))
    },
    fill: gray.lighten(20%),
    stroke: none,
  )

  // Bell curve (drawn on top)
  catmull(
    (-3.2, 0.02),
    (-2,   bell(-2)),
    (-1,   bell(-1)),
    (0,    bell(0)),
    (1,    bell(1)),
    (2,    bell(2)),
    (3.2,  0.02),
    stroke: black,
  )

  // Axes
  line((-3.5, 0), (3.5, 0), mark: (end: ">"))
  line((0, -0.2), (0, 2.2), mark: (end: ">"))
  content((0, 2.4), $T$)

  // Dashed verticals
  line((-t, 0), (-t, bell(-t)), stroke: (dash: "dashed"))
  line(( t, 0), ( t, bell( t)), stroke: (dash: "dashed"))

  // Labels
  content((-t, -0.35), $-t_(alpha\/2)$)
  content(( t, -0.35), $+t_(alpha\/2)$)
})
]
] 
#rmk[
  Si la loi de $T$ sous  $H_0$ est #underline[discrète].
]

=== Règle de décision avec la $p$-valeur
#ex[
  $theta = 0$, contre  $theta > 0$,  $T = sqrt(n) hat(theta) ~ cal(N) (0, 1)$

  #image("figures/pvalue_diagram.png")
]

1. $H_0$:  $mu = mu_0$ contre  $H_1$:  $mu != mu_0$,  $hat(mu) = overline(X)$
  $
  T = (overline(X) - mu_0)/(S_n/sqrt(n)) ~^"loi exacte"_(H_0) #math.op("Student") (n-1)
  $ 
  $H_1$  $=>_"bilatère" cal(R) = {|T|> c}$, quelle est la règle de décision?

   $arrow.curve$ calcul de  $c = c_alpha$ avec la condition de niveau  $=>$
   $c_alpha = #math.op("qt")_(1 - alpha/2) (n-1)$ quantile $#math.op("Student")
   (n-1)$ 

   $
   #math.op("pvaleur") &= P_(H_0) (|T| > |T^"obs"|) \
  "(symètrie de loi de Student)"          &= 2  P(T > |T^"obs"|) \
                       &= 2 (1 - F_"Student" (|T^"obs"|))
   $ 
    #align(center)[
#canvas({
    import draw: *

    let bell(x) = { calc.exp(-x * x / 2) * 1.8 }
    let t = 1.65

    // Shade left tail
    merge-path(
      {
        catmull(
          (-3.2, 0),
          (-3.2, 0.02),
          (-2,   bell(-2)),
          (-t,   bell(-t)),
        )
        line((-t, bell(-t)), (-t, 0))
        line((-t, 0), (-3.2, 0))
      },
      fill: gray.lighten(20%),
      stroke: none,
    )

    // Shade right tail
    merge-path(
      {
        catmull(
          (t,    bell(t)),
          (2,    bell(2)),
          (3.2,  0.02),
          (3.2,  0),
        )
        line((3.2, 0), (t, 0))
        line((t, 0), (t, bell(t)))
      },
      fill: gray.lighten(20%),
      stroke: none,
    )

    // Bell curve (drawn on top)
    catmull(
      (-3.2, 0.02),
      (-2,   bell(-2)),
      (-1,   bell(-1)),
      (0,    bell(0)),
      (1,    bell(1)),
      (2,    bell(2)),
      (3.2,  0.02),
      stroke: black,
    )

    // Axes
    line((-3.5, 0), (3.5, 0), mark: (end: ">"))
    line((0, -0.2), (0, 2.2), mark: (end: ">"))
    content((0, 2.4), $T$)

    // Dashed verticals
    line((-t, 0), (-t, bell(-t)), stroke: (dash: "dashed"))
    line(( t, 0), ( t, bell( t)), stroke: (dash: "dashed"))

    // Labels
    content((-t, -0.35), $T < -c$)
    content(( t, -0.35), $T > C$)
  })
  ]

  - Si $p$-valeur $< alpha$ - on rejet  $H_0$
  - Si $p$-valeur $>= alpha$ - on conserve  $H_0$
2. $H_0$:  $sigma^2 = sigma_0^2$ contre  $H_1$:  $sigma^2 != sigma_0^2$,  $sigma^2$ inconnu donc on l'estime 
  -  $S_n^2$ sans biais
  -  $hat(sigma^2)$ EMV

  par le théorème de la loi des estimateurs dans le modèle gaussien
  $
    0 <= T = (n hat(sigma^2))/sigma^2  = ((n-1)S_n^2)/sigma^2 = (sum_i^n (X_i - overline(X))^2)/sigma^2 ~_(H_0) chi^2 (n-1)
  $ 
  $
  cal(R) = {T > q_(1 - alpha/2) chi^2 (n-1) " ou " T < q_(alpha/2) chi^2 (n-1)} 
  $ 
  #image("figures/chi2_diagram.png")
  On calcule $T^"obs"$: on rejette  $H_0$ ssi  $T_"obs" > q_(1 - alpha/2) chi^2$ ou  $T_"obs" < q chi^2_(alpha/2)$ 

  Quelle est la $p$-valeur?
  $
  #math.op("pvaleur") underbrace(=, "par convention") 2 P(T > T^"obs") " ou " 2 P(T < T^"obs")
  $ 
  $p$-valeur $< 5%$

