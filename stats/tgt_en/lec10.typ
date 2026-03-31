// --- CHUNK_METADATA_START ---
// src_checksum: b354653e7b9adaf80837bb223a819025ddc6155ea9baa7456432f394dfad723a
// --- CHUNK_METADATA_END ---
#import "preamble.typ": *

// --- CHUNK_METADATA_START ---
// src_checksum: 3678b5a63bc11d898e42a900baa602a74de506e28b19764036ce5f556ecf1da8
// needs_review: True
// --- CHUNK_METADATA_END ---
= Tests of a Gaussian parameter <lec10>
// 1. Summary of the construction

#suboutline()

// --- CHUNK_METADATA_START ---
// src_checksum: 0694bf2bd16af4ae1073fb28726f399317758356f0210362d01b288e4adb4875
// needs_review: True
// --- CHUNK_METADATA_END ---
== Summary of construction

$X = (X_1, ..., X_n)$ i.i.d. with law $P_theta$

1. Specify the hypotheses tested:
#align(center)[
 $H_0$:  $theta <= theta_0$ against $H_1$:  $theta > theta_0$
 ]
2. Test statistic: $T(X)$: under $H_0$ $T(X)$ is computable.
The distribution of $T$ under $H_0$ allows distinguishing between $H_0$ and $H_1$.


  $arrow.curve$  $cal(R) = {T(X) > c}$ (under $H_1$, if the distribution of ... of $T$ deviates
from $H_0$ to the right); if $H_1$: $theta < theta_0$ $->$ $cal(R) = {T(X)
  < c}$, if two-tailed test $H_1: theta != theta_0$  $->$  $cal(R) = {|T(X)| >
  c} = {T(X) > c  " or " T(X) < -c}$)
3. Decision rule
$alpha$ fixed level,
- Level condition:
$
  sup_(theta <= theta_0) P_(H_0) (T(X) > c) &= alpha "(if the distribution of " T " under " H_0 " is continuous) " \
                     &<= alpha "(if the distribution of " T " is discrete)" \
                     &-->_(n -> +infinity) "(if the distribution of " T " is asymptotic)"
  $
4. Numerical application:
- calculation of the threshold
- calculation of the realization of $T = T^"obs" = T(X)$ if $x = (x_1, ..., x_n)$
is a realization of $(X_1, ..., X_n)$ in our experiment
- if $T^"obs" > c_alpha$ then we reject $H_0$, with a risk of being wrong of $alpha$.
- if $T^"obs" <= c_alpha$, we retain $H_0$, with an unknown risk of being wrong #underline[unknown] (in general)

#rmk[
The test of $H_0$: $theta >= theta_0$ against $H_1$: $theta < theta_0$ is
the same as the test of $H_0$: $theta = theta_0$ against $H_1$: $theta <
  theta_0$, $cal(R) = {T < c}$
]

// --- CHUNK_METADATA_START ---
// src_checksum: df949013b3b40d44aa1fc775ddcd83870eef96655d0f4cf36bbf6d01aaeaa000
// needs_review: True
// --- CHUNK_METADATA_END ---
== $P$-value
#ex[
  $(X_1, ..., X_n)$ i.i.d. following $cal(N) (0, 1)$; test $H_0$: $theta = 0$, against $H_1$: $theta > 1$

   $arrow.curve$
   $T = (hat(theta) - 0)/(1/sqrt(n)) = sqrt(n) hat(theta) ~_(H_0) cal(N) (0, 1)$ where $hat(theta) = overline(X)$;
  $cal(R) = {T > c}$ with the level condition $P_(theta = 0) (underbrace(T, ->
    ~cal(N) (0, 1)) > c) = alpha => c_alpha = #math.op("qnorm")_(1 - alpha) =
    Phi^(-1) (1 - alpha)$ $=>$ $cal(R) = {sqrt(n) hat(theta) > Phi^(-1) (1 - alpha)}$

    
  $H_0$ $<=>$ $alpha > 1 - Phi(sqrt(n) hat(theta))$

     $alpha = 5%$
  $5%$? $10%$? $1%$? 

     
  Numerically: $hat(theta) = 0.3$, $n=100$, $sqrt(n) hat(theta) = 3$, $1 - Phi(3) approx 10^(-3)$
]
#defn[
  If $(X_1, ..., X_n)$ i.i.d., $cal(R) = {T(X) > c_alpha}$. For a realization $x = (x_1, ..., x_n)$ of $X = (X_1, ..., X_n)$, we call it the $p$-value of the test with region $cal(R)$:
  $
  #math.op("pval") &= inf {alpha in [0,1], T(X) > c_alpha} \
                   &= inf {alpha, H_0 " is rejected on level" alpha}
  $
  p-value ($phi(X) = bb(1)_(cal(R)) (X)$) - significance level, critical probability
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


// --- CHUNK_METADATA_START ---
// src_checksum: 2441d5b18b801420f57b87060f0aa69bf3293c67be163a348f5039f74d48b98b
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Generalization (formula for calculating a p-value).

$T(X)$ test statistic
- $cal(R) = {T(X) > c}$, then the $p$-value $= P_(H_0) (T(X) > T^"obs")$
- $cal(R) = {T(X) < c}$, then the $p$-value $= P_(H_0) (T(X) < T^"obs")$
- $cal(R) = { |T(X)| > c}$, the $p$-value $= P_(H_0)(|T(X)| > |T^"obs"|)$

// --- CHUNK_METADATA_START ---
// src_checksum: 41386233e84660dd9feda600d93d602b9dac89deffb90bd630d1f02ea6e04d7f
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Remarks
#rmk[
In the example
$
  P_(H_0) (|T| > T^"obs") &= P_(H_0) (T > T^"obs" " or " T < -T^"obs") \
                          &= P_(H_0) (T > T^"obs") + P(T < -T^"obs") \
                          &= 1 - Phi(T^"obs") + Phi(-T^"obs") \
            "by symmetry"  &= 2(1 - Phi(T^"obs"))
  $
the $p$-value of the two-tailed test is double the $p$-value of the one-tailed test.
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
If the distribution of $T$ under $H_0$ is #underline[discrete].
]

// --- CHUNK_METADATA_START ---
// src_checksum: fd130d8e6731560faf37b21972d2a5ca943bf2611449be1648f3998a020224d0
// needs_review: True
// --- CHUNK_METADATA_END ---
=== Decision rule using the $p$-value
#ex[
  $theta = 0$, against $theta > 0$,  $T = sqrt(n) hat(theta) ~ cal(N) (0, 1)$

  #image("figures/pvalue_diagram.png")
]

// --- CHUNK_METADATA_START ---
// src_checksum: 401b475764590a1bc9fb2bb6c74ca1fd4e67c4c5b706a4c84e0b8badade46c81
// needs_review: True
// --- CHUNK_METADATA_END ---
1. $H_0$: $mu = mu_0$ versus $H_1$: $mu != mu_0$, $hat(mu) = overline(X)$
$
  T = (overline(X) - mu_0)/(S_n/sqrt(n)) ~^"loi exacte"_(H_0) #math.op("Student") (n-1)
  $
$H_1$ $=>_"bilatère" cal(R) = {|T|> c}$, what is the decision rule?

   $arrow.curve$ calculation of $c = c_alpha$ with the level condition $=>$
$c_alpha = #math.op("qt")_(1 - alpha/2) (n-1)$ quantile $#math.op("Student")
   (n-1)$ 

   $
   #math.op("pvaleur") &= P_(H_0) (|T| > |T^"obs"|) \
  "(symmetry of Student's law)"          &= 2  P(T > |T^"obs"|) \
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

  - If the $p$-value $< alpha$, we reject $H_0$- If the $p$-value $>= alpha$ - we retain $H_0$
// --- CHUNK_METADATA_START ---
// src_checksum: 395ca3306ea1438d05a89fc25b304731f63a6fd13c5e7800b332e0b98758b3a3
// needs_review: True
// --- CHUNK_METADATA_END ---

2. $H_0$: $sigma^2 = sigma_0^2$ against $H_1$: $sigma^2 != sigma_0^2$. Since $sigma^2$ is unknown, we estimate it:
- $S_n^2$ unbiased
- $hat(sigma^2)$ MLE

  
by the theorem of the estimators' distribution in the Gaussian model
$
    0 <= T = (n hat(sigma^2))/sigma^2  = ((n-1)S_n^2)/sigma^2 = (sum_i^n (X_i - overline(X))^2)/sigma^2 ~_(H_0) chi^2 (n-1)
  $
$
  cal(R) = {T > q_(1 - alpha/2) chi^2 (n-1) " or " T < q_(alpha/2) chi^2 (n-1)} 
  $
#image("figures/chi2_diagram.png")
We calculate $T^"obs"$: we reject $H_0$ iff $T_"obs" > q_(1 - alpha/2) chi^2$ or $T_"obs" < q chi^2_(alpha/2)$ 

  

What is the $p$-value?
$
  #math.op("pvaleur") underbrace(=, "par convention") 2 P(T > T^"obs") " or " 2 P(T < T^"obs")
  $
$p$-value $< 5%$


