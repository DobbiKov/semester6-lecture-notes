#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-causal = rgb("#1d4ed8")
  let col-conc   = rgb("#0d9488")
  let col-event  = black

  // ── Process lines ─────────────────────────────────────────────────────────────
  let line-style = (stroke: (paint: luma(60), thickness: 0.6pt))
  line((0, 0),  (7, 0),  ..line-style)   // P1
  line((0, -2), (7, -2), ..line-style)   // P2
  line((0, -4), (7, -4), ..line-style)   // P3

  // ── Process labels ────────────────────────────────────────────────────────────
  let lbl = (anchor: "east", padding: 0.2, size: 0.85em)
  content((-0.1, 0),  [*P1*], anchor: "east")
  content((-0.1, -2), [*P2*], anchor: "east")
  content((-0.1, -4), [*P3*], anchor: "east")

  // ── Events ────────────────────────────────────────────────────────────────────
  // e1 on P1, x=1
  circle((1, 0), radius: 0.12, fill: col-event, stroke: none, name: "e1")
  content((1, 0.35), [$e_1$], anchor: "south")

  // e2 on P2, x=3
  circle((3, -2), radius: 0.12, fill: col-event, stroke: none, name: "e2")
  content((3, -1.65), [$e_2$], anchor: "south")

  // e3 on P3, x=5
  circle((5, -4), radius: 0.12, fill: col-event, stroke: none, name: "e3")
  content((5, -3.65), [$e_3$], anchor: "south")

  // e4 on P1, x=4.5 (concurrent with e2, e3)
  circle((4.5, 0), radius: 0.12, fill: col-event, stroke: none, name: "e4")
  content((4.5, 0.35), [$e_4$], anchor: "south")

  // ── Causal message arrows (blue) ──────────────────────────────────────────────
  let arr-causal = (
    mark: (end: "stealth", fill: col-causal, scale: 0.5),
    stroke: (paint: col-causal, thickness: 0.7pt),
  )
  line((1, 0), (3, -2), ..arr-causal)
  line((3, -2), (5, -4), ..arr-causal)

  // ── Concurrency indicator: dashed teal line e4 ↔ e2 ─────────────────────────
  let dash-conc = (
    stroke: (paint: col-conc, thickness: 0.6pt, dash: "dashed"),
  )
  line((4.5, 0), (3, -2), ..dash-conc)

  // ── Concurrency indicator: dashed teal line e4 ↔ e3 ─────────────────────────
  line((4.5, 0), (5, -4), ..dash-conc)

  // ── Legend (bottom) ───────────────────────────────────────────────────────────
  let lx = 0.2
  let ly = -5.2

  // Causal chain entry
  line((lx, ly), (lx + 0.9, ly), ..arr-causal)
  content((lx + 1.0, ly), [$e_1 arrow.r e_2 arrow.r e_3$ (chaîne causale)],
    anchor: "west", padding: 0.05)

  // Concurrent entry
  line((lx, ly - 0.55), (lx + 0.9, ly - 0.55), ..dash-conc)
  content((lx + 1.0, ly - 0.55), [$e_4 parallel e_2$ (concurrents)],
    anchor: "west", padding: 0.05)
})
