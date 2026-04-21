#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ────────────────────────────────────────────────────────────────
  let col-down   = rgb("#1d4ed8")   // blue  – diffusion descente
  let col-ack    = rgb("#0d9488")   // teal  – ACK remontée
  let col-node   = rgb("#1e40af")
  let col-stroke = rgb("#1e3a5f")
  let col-text   = rgb("#111827")
  let r = 0.35

  // Tree: A(2,3) root; B(1,1.5) and C(3,1.5) children of A; D(0.5,0) child of B.
  // (Same structure as spec: A root, B and C children of A, D child of B)

  // ── PHASE 1: Downward diffusion (blue, solid) ─────────────────────────────
  let arr-down = (
    mark: (end: "stealth", fill: col-down, scale: 0.5),
    stroke: (paint: col-down, thickness: 1.7pt),
  )
  // A → B (slightly left)
  line((1.87, 2.72), (1.1, 1.78), ..arr-down)
  // A → C (slightly right)
  line((2.13, 2.72), (2.9, 1.78), ..arr-down)
  // B → D
  line((0.87, 1.22), (0.63, 0.28), ..arr-down)

  // ── PHASE 2: ACK wave (teal, dashed, going up) ────────────────────────────
  let arr-ack = (
    mark: (end: "stealth", fill: col-ack, scale: 0.5),
    stroke: (paint: col-ack, thickness: 1.5pt, dash: "dashed"),
  )
  // D → B (offset right)
  line((0.73, 0.28), (0.97, 1.22), ..arr-ack)
  // C → A (offset right of down arrow)
  line((2.97, 1.78), (2.23, 2.72), ..arr-ack)
  // B → A (offset right of down arrow)
  line((1.13, 1.78), (1.93, 2.72), ..arr-ack)

  // ── Node circles ──────────────────────────────────────────────────────────
  circle((2,3),   radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,3),   text(fill: white, weight: "bold", size: 9pt)[A], anchor: "center")

  circle((1,1.5), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((1,1.5), text(fill: white, weight: "bold", size: 9pt)[B], anchor: "center")

  circle((3,1.5), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((3,1.5), text(fill: white, weight: "bold", size: 9pt)[C], anchor: "center")

  circle((0.5,0), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((0.5,0), text(fill: white, weight: "bold", size: 9pt)[D], anchor: "center")

  // ── Phase annotation boxes ────────────────────────────────────────────────
  // Phase 1 label (left side)
  rect((-0.6, 2.0), (0.5, 2.5), fill: rgb("#dbeafe"), stroke: (paint: col-down, thickness: 0.7pt), radius: 0.1)
  content((-0.05, 2.25), text(fill: col-down, size: 6.5pt, weight: "bold")[Phase 1\ descente], anchor: "center")

  // Phase 2 label (right side)
  rect((3.5, 0.5), (4.6, 1.0), fill: rgb("#ccfbf1"), stroke: (paint: col-ack, thickness: 0.7pt), radius: 0.1)
  content((4.05, 0.75), text(fill: col-ack, size: 6.5pt, weight: "bold")[Phase 2\ ACK], anchor: "center")

  // ── Invariant annotation ──────────────────────────────────────────────────
  content((2, -0.65), text(fill: col-text, size: 7pt, style: "italic")[
    Invariant : $u$ envoie ACK $ arrow.l.r $ $u$ reçu ET tout sous-arbre de $u$ reçu
  ], anchor: "center")

  // ── Complexity label ──────────────────────────────────────────────────────
  content((2, -1.1), text(fill: col-text, size: 7.5pt)[Total : $2(N-1)$ messages], anchor: "center")
})
