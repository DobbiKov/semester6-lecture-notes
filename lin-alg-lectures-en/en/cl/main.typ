// ─────────────────────────────────────────────────────────────────────────────
// Chapter: Complex Analysis and Applications to Linear Algebra
// Based on Antoine Levitt's course — Université Paris-Saclay
// ─────────────────────────────────────────────────────────────────────────────

#import "@local/dobbikov:1.0.0": *
#import "@preview/cetz:0.4.2": canvas, draw

#set math.equation(numbering: "(1)")

#show: dobbikov.with(
  title: [Complex Analysis and its Applications to Linear Algebra],
  subtitle: [A self-contained introduction],
  author: "Based on Antoine Levitt's course, Université Paris-Saclay | By Yehor Korotenko",
  date: none,
  report-style: true,
  language: "en",
)

// ─────────────────────────────────────────────────────────────────────────────
// INTRODUCTION
// ─────────────────────────────────────────────────────────────────────────────

= Introduction

This chapter develops a short but self-contained introduction to complex analysis, with a single goal in mind: arriving at the *spectral projector* formula

$ Pi_mu = 1/(2 pi i) integral.cont_gamma R_A (z) dif z, $

which extracts the projector onto an eigenspace of a matrix $A$ from a contour integral of its resolvent. Along the way we will build genuine geometric and analytic intuition — not just formulas.

The central thread is a remarkable rigidity phenomenon. A function $f : RR -> RR$ can be differentiable everywhere without having a power series representation. A function $f : CC -> CC$ that is differentiable everywhere in the complex sense *is automatically* a power series. This single fact — whose proof runs through Stokes' theorem and Cauchy's formula — is what makes complex analysis so powerful.

*Roadmap.* We proceed in five steps:
+ *Holomorphic functions* — what complex differentiability means geometrically (§2)
+ *Contour integrals* — integrating along curves in $CC$ (§3)  
+ *Stokes' theorem* — why holomorphic functions have zero loop integrals (§4)
+ *Cauchy's formula* — boundary data determines interior values (§5)
+ *Application to linear algebra* — the spectral projector (§6)

// ─────────────────────────────────────────────────────────────────────────────
// §2  HOLOMORPHIC FUNCTIONS
// ─────────────────────────────────────────────────────────────────────────────

= Holomorphic Functions

== The geometric meaning of complex differentiability

A function $f : RR^2 -> RR^2$ is differentiable at $p_0$ if there exists a matrix $J f(p_0)$ — the Jacobian — such that
$ f(p_0 + h) = f(p_0) + J f(p_0) dot h + o(|h|). $
The Jacobian can be *any* $2 times 2$ matrix: it could represent a rotation, a shear, a reflection, an asymmetric stretch, or any combination.

The complex plane $CC$ carries extra structure that $RR^2$ does not: *multiplication*. Multiplying by a complex number $w = r e^(i theta)$ acts on $RR^2$ as simultaneous rotation by $theta$ and scaling by $r$. As a matrix:
$ z mapsto w z quad "corresponds to" quad mat(a, -b; b, a), quad w = a + i b. $
This is a *very* special $2 times 2$ matrix — it has only 2 free parameters instead of 4. The extra constraint is $a_(11) = a_(22)$ and $a_(12) = -a_(21)$.

#defn[
  Let $Omega subset CC$ be open and $f : Omega -> CC$. We say $f$ is *holomorphic* on $Omega$ if every pintegral.cont $z_0 in Omega$ has a neighbourhood on which $f$ is expressible as a convergent power series:
  $ f(z) = sum_(n=0)^infinity a_n (z - z_0)^n. $
]

#insight[
  Holomorphic = locally looks like multiplication by a complex number. Zooming
  in near any pintegral.cont $z_0$, the function $f$ behaves as $f(z_0 + h)
  approx f(z_0) + f'(z_0) dot h$ where $f'(z_0) in CC$ and the multiplication
  is *complex* multiplication — a rotation and scaling of the input
  displacement $h$. No reflections, no shears, no asymmetric stretches.
]

== The $overline(partial)$ operator and the Cauchy-Riemann equations

Writing $z = x + i y$, any smooth $f : CC -> CC$ can be thought of as depending on the two independent "coordinates" $z$ and $overline(z)$, since
$ x = (z + overline(z))/2, quad y = (z - overline(z))/(2i). $
The chain rule gives natural differential operators in this new basis:
$ partial_z = 1/2 (partial_x - i partial_y), quad overline(partial) equiv partial_(overline(z)) = 1/2 (partial_x + i partial_y). $
These are not defined this way — they are *derived* from the change of variables. One checks immediately that $partial_z (z^n) = n z^(n-1)$, $overline(partial)(z^n) = 0$, and $overline(partial)(overline(z)) = 1$. So $overline(partial)$ is the "anti-holomorphic derivative" — it detects dependence on $overline(z)$.

#thm("Cauchy-Riemann")[
  Let $f = u + i v$ (with $u, v$ real-valued) be $C^1$. The following are equivalent:
  + $overline(partial) f = 0$,
  + $partial_x u = partial_y v$ and $partial_y u = -partial_x v$ (Cauchy-Riemann equations),
  + The Jacobian $J f$ has the form $mat(a, -b; b, a)$ for some $a, b in RR$,
  + $f$ is complex-differentiable at every pintegral.cont, with $f'(z_0) = a + i b$.
]

#proof[
  The equivalence of (1) and (2) is a direct computation: $overline(partial) f = frac(1,2)(partial_x + i partial_y)(u + i v) = frac(1,2)[(partial_x u - partial_y v) + i(partial_x v + partial_y u)]$, which is zero if and only if $partial_x u = partial_y v$ and $partial_y u = -partial_x v$.

  For (2) $<=>$ (3): the Jacobian is $J f = mat(partial_x u, partial_y u; partial_x v, partial_y v)$. The Cauchy-Riemann equations are exactly the condition $partial_x u = partial_y v$ and $partial_y u = -partial_x v$, which gives $J f = mat(a, -b; b, a)$ with $a = partial_x u$, $b = partial_x v$.

  For (3) $<=>$ (4): $J f$ of the form $mat(a,-b;b,a)$ acts on $h = h_1 + i h_2$ as $(a + i b)(h_1 + i h_2)$ — precisely complex multiplication by $a + i b = f'(z_0)$. $square$
]

#figure(
  canvas({
    import draw: *
    // Left: non-holomorphic (z-bar, reflection)
    set-style(stroke: (thickness: 0.8pt))
    
    // Input grid left
    for i in range(4) {
      line((0.5 + i * 0.6, 0.3), (0.5 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((0.3, 0.5 + i * 0.5), (2.1, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    rect((0.9, 0.9), (1.5, 1.5), stroke: (paint: blue.darken(20%), thickness: 1.2pt), fill: blue.lighten(85%))
    content((1.2, 1.2), text(size: 8pt, fill: blue.darken(30%))[$square$])
    content((1.1, 0.1), text(size: 8pt)[input $z$])
    
    // Arrow
    line((2.5, 1.2), (3.1, 1.2), mark: (end: ">", size: 0.2), stroke: (paint: blue.darken(20%)))
    content((2.8, 1.45), text(size: 7.5pt, fill: blue.darken(20%))[$f(z) = overline(z)$])

    // Output grid left (reflected)
    for i in range(4) {
      line((3.5 + i * 0.6, 0.3), (3.5 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((3.3, 0.5 + i * 0.5), (5.1, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    // Reflected square (same x, flipped y around center 1.2)
    rect((3.9, 0.9), (4.5, 1.5), stroke: (paint: red.darken(20%), thickness: 1.2pt), fill: red.lighten(85%))
    content((4.2, 1.2), text(size: 8pt, fill: red.darken(30%))[$square$])
    content((4.1, 0.1), text(size: 8pt)[reflected — not holo.])

    // Right: holomorphic (z^2, rotation+scale)
    for i in range(4) {
      line((6.2 + i * 0.6, 0.3), (6.2 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((6.0, 0.5 + i * 0.5), (8.0, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    rect((6.6, 0.9), (7.2, 1.5), stroke: (paint: blue.darken(20%), thickness: 1.2pt), fill: blue.lighten(85%))
    content((6.9, 1.2), text(size: 8pt, fill: blue.darken(30%))[$square$])
    content((6.8, 0.1), text(size: 8pt)[input $z$])

    line((8.3, 1.2), (8.9, 1.2), mark: (end: ">", size: 0.2), stroke: (paint: teal.darken(20%)))
    content((8.6, 1.45), text(size: 7.5pt, fill: teal.darken(20%))[$f(z) = z^2$])

    for i in range(4) {
      line((9.2 + i * 0.6, 0.3), (9.2 + i * 0.6, 2.1), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    for i in range(4) {
      line((9.0, 0.5 + i * 0.5), (11.0, 0.5 + i * 0.5), stroke: (paint: gray.lighten(30%), thickness: 0.4pt))
    }
    // Rotated square (parallelogram to suggest rotation+scale)
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
    content((9.9, 0.1), text(size: 8pt)[rotated+scaled — holo.])
  }),
  caption: [Left: $f(z) = overline(z)$ reflects the plane — the Jacobian has the form $mat(1,0;0,-1)$ which is *not* of the form $mat(a,-b;b,a)$, so it is not holomorphic. Right: $f(z) = z^2$ locally rotates and scales — Jacobian has the special form, so it is holomorphic.]
)

== Examples and non-examples

The following functions are holomorphic:
- Polynomials $p(z) = a_0 + a_1 z + dots + a_n z^n$ (power series terminating after finitely many terms)
- The complex exponential $z mapsto exp(z) = sum_(n=0)^infinity z^n / n!$  
- The matrix exponential $z mapsto exp(z A)$ for fixed $A in M_n (CC)$
- The resolvent $lambda mapsto R_A (lambda) = (A - lambda I)^(-1)$, on $CC without "Sp"(A)$

The following are *not* holomorphic:
- $f(z) = overline(z)$: gives $overline(partial) f = 1 != 0$
- $f(z) = |z|^2 = z overline(z)$: gives $overline(partial) f = z != 0$ (except at $z = 0$)
- $f(z) = "Re"(z) = x$: gives $overline(partial) f = 1/2 != 0$

#rmk[
  $f(z) = |z|^2$ is complex-differentiable at $z = 0$ (the limit $|h|^2 / h = overline(h) -> 0$ as $h -> 0$), but nowhere else. Being differentiable at a single isolated pintegral.cont is *not* holomorphic — holomorphicity requires differentiability on an open neighbourhood.
]

// ─────────────────────────────────────────────────────────────────────────────
// §3  CONTOUR INTEGRALS
// ─────────────────────────────────────────────────────────────────────────────

= Contour Integrals

== Definition
#defn(info: "Contour integral")[
A *contour* (or *curve*) in $CC$ is a $C^1$ map $gamma : [0, T] -> CC$. The
*contour integral* of $f$ along $gamma$ is defined by

$ integral_gamma f dif z := integral_0^T f(gamma(t)) dot gamma'(t) dif t. $
]

This is exactly like a real integral $integral_a^b f(x) dif x$, except that:
- We sum over a *curve* in $CC$ rather than a segment in $RR$
- At each pintegral.cont, we multiply $f(gamma(t))$ by $gamma'(t)$ — the *velocity* of the curve, a complex number encoding both speed and direction
- The result is a complex number

The factor $gamma'(t) dif t$ is the infinitesimal displacement $dif z$ along the curve. On a real segment $gamma(t) = t$, we have $gamma'(t) = 1$ and the definition reduces to an ordinary integral.

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

    // A pintegral.cont on the curve
    let pt = (2.2, 2.75)
    circle(pt, radius: 0.07, fill: blue.darken(20%), stroke: none)
    content((2.4, 2.95), text(size: 9pt, fill: blue.darken(30%))[$gamma(t)$])

    // Velocity arrow at that pintegral.cont
    line((2.2, 2.75), (1.5, 2.52), mark: (end: ">", size: 0.2), stroke: (paint: orange.darken(20%), thickness: 1.5pt))
    content((1.6, 2.2), text(size: 9pt, fill: orange.darken(30%))[$gamma'(t)$])

    // Tiny dz annotation
    content((3.0, 2.0), text(size: 8.5pt, fill: gray.darken(40%))[tiny step $dif z = gamma'(t) dif t$])
    
    // Pintegral.cont z0 inside
    circle((2.0, 1.4), radius: 0.07, fill: red.darken(20%), stroke: none)
    content((2.2, 1.3), text(size: 9pt, fill: red.darken(30%))[$z_0$])
  }),
  caption: [A contour $gamma$ in $CC$. At each pintegral.cont $gamma(t)$, the velocity $gamma'(t)$ gives the direction and speed of travel. The contour integral accumulates the products $f(gamma(t)) dot gamma'(t) dif t$ — tiny complex contributions — around the whole curve.]
)

== Path independence and closed loops

Two paths $gamma_1, gamma_2$ from $z_0$ to $z_1$ give the same integral when
$ integral_(gamma_1) f dif z = integral_(gamma_2) f dif z <==> integral_(gamma_1) f dif z - integral_(gamma_2) f dif z = 0. $
But "$gamma_1$ followed by $gamma_2$ reversed" is a *closed loop*. So path independence is equivalent to: *every closed-loop integral is zero*:
$ integral.cont_gamma f dif z = 0 quad "for every closed" gamma. $

== A fundamental example: the winding integral

Let $z_0 in CC$ and $gamma_epsilon : theta mapsto z_0 + epsilon e^(i theta)$, $theta in [0, 2 pi]$ be the circle of radius $epsilon$ around $z_0$. Then $gamma_epsilon' (theta) = i epsilon e^(i theta)$ and:

$ integral.cont_(gamma_epsilon) frac(1, z - z_0) dif z = integral_0^(2pi) frac(1, epsilon e^(i theta)) dot i epsilon e^(i theta) dif theta = integral_0^(2pi) i dif theta = 2 pi i. $

The $epsilon$ cancels completely — the answer $2 pi i$ is *independent of the radius*. This is the most important integral in complex analysis.

#rmk[
  The function $1/(z - z_0)$ acts like a "vortex" centered at $z_0$: it is holomorphic everywhere except at $z_0$ itself, and integrating around $z_0$ always gives $2 pi i$ regardless of the loop shape, as long as it winds once around $z_0$.
]

// ─────────────────────────────────────────────────────────────────────────────
// §4  STOKES' THEOREM AND ZERO LOOP INTEGRALS
// ─────────────────────────────────────────────────────────────────────────────

= Stokes' Theorem and Zero Loop Integrals

== The curl and Stokes' theorem

For a vector field $arrow(A) = A_x arrow(e)_x + A_y arrow(e)_y$ on $RR^2$, the *scalar curl* (rotationnel) measures local rotation:
$ "rot"(arrow(A)) = partial_x A_y - partial_y A_x. $
Geometrically: place a tiny paddle wheel at a pintegral.cont in the fluid. If the flow makes it spin, the curl is nonzero there. If the flow is locally "balanced" — as much coming from one side as the other — the curl is zero and the wheel stays still.

#figure(
  canvas({
    import draw: *
    set-style(stroke: (thickness: 0.8pt))

    // Left: zero curl (uniform flow)
    content((1.5, 3.3), text(size: 9pt, weight: "bold")[zero curl])
    for row in range(4) {
      for col in range(4) {
        let x = 0.4 + col * 0.8
        let y = 0.4 + row * 0.7
        line((x - 0.28, y), (x + 0.28, y), mark: (end: ">", size: 0.15), stroke: (paint: teal.darken(20%), thickness: 1pt))
      }
    }
    // Paddle wheel (still)
    circle((1.5, 1.55), radius: 0.22, stroke: (paint: orange.darken(20%), thickness: 1pt), fill: none)
    line((1.5, 1.33), (1.5, 1.77), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((1.28, 1.55), (1.72, 1.55), stroke: (paint: orange.darken(20%), thickness: 1pt))
    content((1.5, 0.1), text(size: 8pt, fill: orange.darken(30%))[wheel stays still])

    // Right: nonzero curl (vortex)
    content((6.2, 3.3), text(size: 9pt, weight: "bold")[nonzero curl])
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
    // Spinning paddle wheel
    circle((cx, cy), radius: 0.22, stroke: (paint: orange.darken(20%), thickness: 1pt), fill: none)
    line((cx, cy - 0.22), (cx + 0.18, cy + 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((cx + 0.22, cy), (cx - 0.18, cy + 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    line((cx, cy + 0.22), (cx - 0.18, cy - 0.12), stroke: (paint: orange.darken(20%), thickness: 1pt))
    content((cx, 0.25), text(size: 8pt, fill: orange.darken(30%))[wheel spins!])
    content((cx, 0.05), text(size: 8pt, fill: red.darken(30%))[singularity at center])
  }),
  caption: [Left: uniform flow has zero curl — a paddle wheel placed anywhere stays still. Right: a vortex has nonzero curl — the paddle wheel spins. The curl measures local rotation of the fluid.]
)

#thm("Stokes / Green")[
  Let $Omega subset RR^2$ be a bounded open set with smooth boundary $gamma = partial Omega$ (oriented counterclockwise), and $arrow(A) : overline(Omega) -> RR^2$ a $C^1$ vector field. Then
  $ integral.cont_(partial Omega) arrow(A) dot dif arrow(T) = integral.double_Omega "rot"(arrow(A)) dif x dif y. $
]

The proof idea: tile $Omega$ by tiny squares of side $epsilon$. On each square, contributions from shared interior edges cancel (opposite orientations). What remains is the outer boundary. On each tiny square the integrand is approximately constant, giving a contribution $approx "rot"(arrow(A)) dot epsilon^2$.

== Connecting to complex integrals

Writing the complex integral $integral_gamma f dif z$ in real coordinates with $f(x,y)$ and $arrow(A)(x,y) = f(x,y) arrow(e)_x + i f(x,y) arrow(e)_y$, one computes:
$ "rot"(arrow(A)) = i partial_x f - partial_y f = i(partial_x f + i partial_y f) = 2i overline(partial) f. $

#prop[
  Let $f : Omega -> CC$ be $C^1$ with $overline(partial) f = 0$. Then for every closed curve $gamma$ in $Omega$,
  $ integral.cont_gamma f dif z = 0. $
]

#proof[
  By Stokes, $integral.cont_gamma f dif z = integral.double_"interior" "rot"(arrow(A)) dif x dif y = integral.double 2i overline(partial) f dif x dif y = 0$.
]

#insight[
  Why does $overline(partial) f = 0$ give zero loop integrals? Because
  holomorphic functions *locally look like rotation and scaling*. Walking
  around any loop and multiplying each step by a local rotation+scaling, the
  contributions from opposite sides of the loop cancel perfectly.
  Non-holomorphic functions break this symmetry — they can stretch differently
  in different directions, and the cancellation fails. The curl
  $"rot"(arrow(A)) = 2i overline(partial) f$ measures exactly this asymmetry.
]

== The tiny-square computation

Let us verify the key estimate explicitly. Consider a square with corner at $z_0 = x_0 + i y_0$ and side $epsilon$. Walking counterclockwise, the four sides contribute:

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
  caption: [The four sides of a tiny square of side $epsilon$ with corner at $z_0$, traversed counterclockwise. Each side contributes $f("corner") times dif z$ to the contour integral.]
)

The sum of all four contributions is:
$ f(z_0) dot epsilon + f(z_0 + epsilon) dot i epsilon + f(z_0 + i epsilon) dot (-epsilon) + f(z_0) dot (-i epsilon). $

Grouping and using $f(z_0 + epsilon) approx f(z_0) + epsilon partial_x f$ and $f(z_0 + i epsilon) approx f(z_0) + i epsilon partial_y f$:

$ = epsilon^2 [i partial_x f - partial_y f] = epsilon^2 dot i (partial_x f + i partial_y f) = 2i epsilon^2 overline(partial) f(z_0). $

So $integral.cont_(partial square) f dif z approx 2i epsilon^2 overline(partial) f(z_0)$. If $overline(partial) f = 0$, every square contributes zero, and the full loop integral vanishes.

// ─────────────────────────────────────────────────────────────────────────────
// §5  CAUCHY'S FORMULA
// ─────────────────────────────────────────────────────────────────────────────

= Cauchy's Formula

== Statement

#thm("Cauchy's Integral Formula")[
  Let $f : Omega -> CC$ be $C^1$ with $overline(partial) f = 0$, and let $z_0 in Omega$. For any closed curve $gamma$ that winds once counterclockwise around $z_0$ and lies entirely in $Omega$:
  $ integral.cont_gamma frac(f(z), z - z_0) dif z = 2 pi i f(z_0). $
  Equivalently:
  $ f(z_0) = 1/(2 pi i) integral.cont_gamma frac(f(z), z - z_0) dif z. $
]

#insight[
  This formula says something astonishing: the value of a holomorphic function at a single interior pintegral.cont $z_0$ is *completely determined* by its values on the boundary loop $gamma$. In real analysis, a function's values at interior pintegral.conts are independent of boundary values. For holomorphic functions, the boundary values rigidly control everything inside — like a soap film stretched across a wire loop, where the wire (boundary) determines the film's shape (interior) completely.
]

#proof[
The function $g(z) = f(z)/(z - z_0)$ is holomorphic on $Omega without {z_0}$ but has a singularity at $z_0$.

*Step 1: deformation.* Since $g$ is holomorphic in the annular region between $gamma$ and any small circle $gamma_epsilon$ of radius $epsilon$ around $z_0$, Stokes gives:
$ integral.cont_gamma g dif z = integral.cont_(gamma_epsilon) g dif z. $
The big loop can be shrunk to a tiny loop without changing the integral.

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
    
    // z0 pintegral.cont
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
  caption: [Deformation of contour. Since $g = f slash (z - z_0)$ is holomorphic in the shaded annular region between $gamma$ and the small circle $gamma_epsilon$, both integrals are equal. We can shrink $gamma$ to the tiny circle without changing the integral.]
)

*Step 2: approximation.* On $gamma_epsilon$, as $epsilon -> 0$ we have $f(z) -> f(z_0)$, so:
$ integral.cont_(gamma_epsilon) frac(f(z), z - z_0) dif z approx f(z_0) integral.cont_(gamma_epsilon) frac(1, z - z_0) dif z = f(z_0) dot 2 pi i, $
where the last integral was computed explicitly in §3. The error in the approximation is $O(epsilon)$ and vanishes as $epsilon -> 0$, completing the proof. 
]

== From Cauchy's formula to power series

Cauchy's formula is a *power series generator*. Fix $z_0$ and write $w$ for a nearby pintegral.cont. Expand the Cauchy kernel in a geometric series:
$ frac(1, z - w) = frac(1, (z - z_0) - (w - z_0)) = frac(1, z - z_0) sum_(n=0)^infinity frac((w - z_0)^n, (z - z_0)^n). $

Substituting into Cauchy's formula and swapping the sum and integral (justified by uniform convergence):
$ f(w) = sum_(n=0)^infinity underbrace(lr([frac(1, 2 pi i) integral.cont_gamma frac(f(z), (z - z_0)^(n+1)) dif z], size: #100%))_(=: a_n) (w - z_0)^n. $

This is a genuine power series for $f$ around $z_0$ — proving that complex differentiability everywhere *forces* $f$ to be a power series. This is the miracle that has no analogue in real analysis.

// ─────────────────────────────────────────────────────────────────────────────
// §6  APPLICATION: THE SPECTRAL PROJECTOR
// ─────────────────────────────────────────────────────────────────────────────

= Application: the Spectral Projector

We now arrive at the linear algebra payoff. Throughout this section $A in M_n (CC)$.

== The resolvent

#defn[
  The *spectrum* of $A$ is $"Sp"(A) = {mu in CC | A - mu I "not invertible"}$. For $lambda in.not "Sp"(A)$, the *resolvent* is
  $ R_A (lambda) = (A - lambda I)^(-1). $
]

The resolvent is a matrix-valued function of $lambda$. It is holomorphic on $CC without "Sp"(A)$: by the Neumann series, for $|lambda - lambda_0| < 1 slash ||R_A (lambda_0)||$,
$ R_A (lambda) = sum_(n=0)^infinity (lambda - lambda_0)^n R_A (lambda_0)^(n+1). $
The singularities of $R_A (lambda)$ are precisely the eigenvalues of $A$.

== The spectral projector

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
  caption: [The contour $gamma$ winds once around the target eigenvalue $mu$ (blue cross), while all other eigenvalues (red crosses) remain outside $gamma$. The contour integral of the resolvent extracts the spectral projector onto the eigenspace $E_mu$.]
)

#prop("Spectral Projector")[
  Let $A in M_n (CC)$ be diagonalisable, $mu$ an eigenvalue of $A$, and $gamma$ a closed curve winding once counterclockwise around $mu$ but not around any other eigenvalue. Then
  $ Pi_mu := 1/(2 pi i) integral.cont_gamma R_A (z) dif z $
  is the projector onto the eigenspace $E_mu = ker(A - mu I)$, parallel to the sum of all other eigenspaces.
]

#proof[
  Since $A$ is diagonalisable, write $A = P^(-1) mat(mu, 0; 0, D') P$ where $mu in.not "Sp"(D')$.
  
  The resolvent block-diagonalises as:
  $ R_A (z) = (A - z I)^(-1) = P^(-1) mat((mu - z)^(-1), 0; 0, (D' - z I)^(-1)) P. $

  Integrating over $gamma$:
  $ frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z = P^(-1) mat(frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z), 0; 0, frac(1, 2 pi i) integral.cont_gamma (D' - z I)^(-1) dif z) P. $

  *Top-left block:* By the winding integral of §3,
  $ frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z) = frac(1, 2 pi i) integral.cont_gamma frac(dif z, mu - z) = 1. $

  *Bottom-right block:* $(D' - z I)^(-1)$ is holomorphic *inside* $gamma$ (since no eigenvalue of $D'$ lies inside $gamma$). By Proposition 3.1, its integral over $gamma$ is zero.

  Therefore:
  $ frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z = P^(-1) mat(1, 0; 0, 0) P = Pi_mu. qed $
]

== The functional calculus

The spectral projector is a special case of a much more general construction. For any function $f$ holomorphic in a neighbourhood of $"Sp"(A)$, define:
$ f(A) = frac(1, 2 pi i) integral.cont_C frac(f(z), z - A) dif z, $
where $C$ is any contour enclosing all of $"Sp"(A)$. This is the *holomorphic functional calculus*.

#insight[
  This extends the natural definition $f(A) = sum a_n A^n$ (for $f$ a power series) to *all* holomorphic $f$, regardless of convergence issues. Need $(I + A)^(-1)$ when $||A|| > 1$? Write it as a contour integral. Need $log(A)$ for a matrix with no zero eigenvalue? Use the functional calculus. The contour integral avoids all radius-of-convergence limitations.
]

The key properties are:
- $"Id"(A) = A$ (the identity function gives back $A$)
- $(f g)(A) = f(A) g(A)$ (multiplicativity)
- If $f(z) = sum a_n z^n$ converges and $||A|| < "radius"$, then $f(A) = sum a_n A^n$ (consistency with power series)

// ─────────────────────────────────────────────────────────────────────────────
// §7  SUMMARY: THE LOGICAL CHAIN
// ─────────────────────────────────────────────────────────────────────────────

= Summary: The Logical Chain

The whole chapter follows one thread:

#align(center)[
  #block(
    inset: 16pt, radius: 6pt,
    stroke: (paint: blue.lighten(40%), thickness: 0.8pt),
    fill: blue.lighten(96%),
    [
      $overline(partial) f = 0$ #h(0.5em) $=>$ #h(0.5em) *Stokes* #h(0.5em) $=>$ #h(0.5em) $integral.cont_gamma f dif z = 0$ #h(0.5em) $=>$ #h(0.5em) *path independence* \
      #v(0.5em)
      $=>$ #h(0.5em) *Cauchy* #h(0.5em) $=>$ #h(0.5em) $f(z_0) = frac(1, 2 pi i) integral.cont_gamma frac(f(z), z - z_0) dif z$ \
      #v(0.5em)
      $=>$ #h(0.5em) *power series* #h(0.5em) $=>$ #h(0.5em) *spectral projector* $Pi_mu = frac(1, 2 pi i) integral.cont_gamma R_A (z) dif z$
    ]
  )
]

Each arrow corresponds to one section of this chapter. The geometric intuition behind each step:

#table(
  columns: (auto, 1fr, 1fr),
  stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { (bottom: 0.3pt + gray.lighten(40%)) },
  inset: 8pt,
  table.header(
    text(weight: "bold")[Step],
    text(weight: "bold")[Formula],
    text(weight: "bold")[Geometric meaning]
  ),
  [§2], [$overline(partial) f = 0$], [Jacobian = rotation + scaling; no shear, no reflection],
  [§3], [$integral_gamma f dif z$], [Accumulate $f times$ velocity along a curve in $CC$],
  [§4], [$integral.cont f dif z = 0$], [Uniform rotation+scaling cancels around any loop],
  [§5], [Cauchy's formula], [Boundary values rigidly determine interior values],
  [§5], [Power series], [Cauchy's kernel expands into geometric series],
  [§6], [Spectral projector], [Contour around $mu$ picks out only the $mu$-eigenspace],
)

The deepest insight is that $overline(partial) f = 0$ — "no anti-holomorphic part" — is simultaneously four things: a condition on the Jacobian matrix, an absence of curl, path independence of integrals, and the rigid link between boundary and interior values that makes the spectral projector possible.
