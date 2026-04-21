#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ───────────────────────────────────────────────────────────────
  let col-blue   = rgb("#1d4ed8")   // Phase 1 – DEMANDE
  let col-teal   = rgb("#0d9488")   // Phase 2 – ACK
  let col-green  = rgb("#16a34a")   // Phase 3 – SORTIE
  let col-cs     = rgb("#7c3aed")   // Critical section box
  let col-line   = luma(60)
  let col-text   = rgb("#111827")

  // ── Helper: message arrow factory ─────────────────────────────────────────
  let msg(col) = (
    mark: (end: "stealth", fill: col, scale: 0.5),
    stroke: (paint: col, thickness: 0.85pt),
  )
  let msg-dash(col) = (
    mark: (end: "stealth", fill: col, scale: 0.5),
    stroke: (paint: col, thickness: 0.85pt, dash: "dashed"),
  )

  // ── Process timeline lines ─────────────────────────────────────────────────
  let line-style = (stroke: (paint: col-line, thickness: 0.6pt))
  line((0, 0),  (10, 0),  ..line-style)   // P1
  line((0, -2), (10, -2), ..line-style)   // P2
  line((0, -4), (10, -4), ..line-style)   // P3

  // ── Process labels ────────────────────────────────────────────────────────
  content((-0.15, 0),  [*P1*\ _(dem.)_], anchor: "east")
  content((-0.15, -2), [*P2*], anchor: "east")
  content((-0.15, -4), [*P3*], anchor: "east")

  // ── Time axis arrow ───────────────────────────────────────────────────────
  line((0, -5.1), (10, -5.1),
    mark: (end: "stealth", fill: col-line, scale: 0.4),
    stroke: (paint: col-line, thickness: 0.5pt))
  content((10.2, -5.1), text(size: 0.8em, fill: col-text)[temps], anchor: "west")

  // ══════════════════════════════════════════════════════════════════════════
  // PHASE 1 – broadcast DEMANDE (blue, t=1)
  // ══════════════════════════════════════════════════════════════════════════

  // Emission event on P1
  circle((1.5, 0), radius: 0.13, fill: col-blue, stroke: none)

  // P1 → P2
  line((1.5, 0), (2.5, -2), ..msg(col-blue))
  // P1 → P3
  line((1.5, 0), (3.0, -4), ..msg(col-blue))

  // Reception dots on P2 and P3
  circle((2.5, -2), radius: 0.13, fill: col-blue, stroke: none)
  circle((3.0, -4), radius: 0.13, fill: col-blue, stroke: none)

  // Arrow labels
  content((1.65, -1.1), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-blue)[DEMANDE(1,1)]), anchor: "west")
  content((2.0, -2.5), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-blue)[DEMANDE(1,1)]), anchor: "west")

  // Phase 1 bracket annotation
  rect((1.1, 0.55), (3.4, 0.92), fill: rgb("#dbeafe"),
    stroke: (paint: col-blue, thickness: 0.6pt), radius: 0.08)
  content((2.25, 0.735), text(size: 0.65em, fill: col-blue, weight: "bold")[Phase 1 — diffusion DEMANDE (n-1=2 msg)], anchor: "center")

  // ══════════════════════════════════════════════════════════════════════════
  // PHASE 2 – ACK replies (teal, dashed)
  // ══════════════════════════════════════════════════════════════════════════

  // P2 → P1 ACK
  circle((3.5, -2), radius: 0.13, fill: col-teal, stroke: none)
  line((3.5, -2), (4.5, 0), ..msg-dash(col-teal))
  circle((4.5, 0), radius: 0.13, fill: col-teal, stroke: none)
  content((3.7, -0.9), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-teal)[ACK(2)]), anchor: "west")

  // P3 → P1 ACK
  circle((4.0, -4), radius: 0.13, fill: col-teal, stroke: none)
  line((4.0, -4), (5.0, 0), ..msg-dash(col-teal))
  circle((5.0, 0), radius: 0.13, fill: col-teal, stroke: none)
  content((4.2, -1.8), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-teal)[ACK(3)]), anchor: "west")

  // Phase 2 annotation
  rect((3.1, 0.55), (5.4, 0.92), fill: rgb("#ccfbf1"),
    stroke: (paint: col-teal, thickness: 0.6pt), radius: 0.08)
  content((4.25, 0.735), text(size: 0.65em, fill: col-teal, weight: "bold")[Phase 2 — acquittements (n-1=2 msg)], anchor: "center")

  // ── Critical Section box on P1 ────────────────────────────────────────────
  rect((5.2, -0.35), (6.8, 0.35), fill: rgb("#ede9fe"),
    stroke: (paint: col-cs, thickness: 1pt), radius: 0.12)
  content((6.0, 0), text(size: 0.72em, fill: col-cs, weight: "bold")[SC], anchor: "center")

  // ══════════════════════════════════════════════════════════════════════════
  // PHASE 3 – broadcast SORTIE (green)
  // ══════════════════════════════════════════════════════════════════════════

  circle((7.2, 0), radius: 0.13, fill: col-green, stroke: none)
  // P1 → P2
  line((7.2, 0), (8.0, -2), ..msg(col-green))
  circle((8.0, -2), radius: 0.13, fill: col-green, stroke: none)
  // P1 → P3
  line((7.2, 0), (8.5, -4), ..msg(col-green))
  circle((8.5, -4), radius: 0.13, fill: col-green, stroke: none)

  content((7.4, -0.9), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-green)[SORTIE(1)]), anchor: "west")
  content((7.6, -2.6), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.68em, fill: col-green)[SORTIE(1)]), anchor: "west")

  rect((6.8, 0.55), (9.0, 0.92), fill: rgb("#dcfce7"),
    stroke: (paint: col-green, thickness: 0.6pt), radius: 0.08)
  content((7.9, 0.735), text(size: 0.65em, fill: col-green, weight: "bold")[Phase 3 — diffusion SORTIE (n-1=2 msg)], anchor: "center")

  // ── Bottom summary ────────────────────────────────────────────────────────
  content((5.0, -4.7), text(size: 0.78em, fill: col-text, weight: "bold")[
    Total : $3(n-1) = 6$ messages pour $n=3$
  ], anchor: "center")
})
