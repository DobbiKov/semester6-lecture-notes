#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ───────────────────────────────────────────────────────────────
  let col-p1req  = rgb("#1d4ed8")   // P1's REQ (blue)
  let col-p2req  = rgb("#7c3aed")   // P2's REQ (violet)
  let col-teal   = rgb("#0d9488")   // immediate reply
  let col-defer  = rgb("#d97706")   // deferred box
  let col-cs     = rgb("#16a34a")   // CS box
  let col-line   = luma(60)
  let col-text   = rgb("#111827")

  let msg(col) = (
    mark: (end: "stealth", fill: col, scale: 0.5),
    stroke: (paint: col, thickness: 0.85pt),
  )
  let msg-dash(col) = (
    mark: (end: "stealth", fill: col, scale: 0.5),
    stroke: (paint: col, thickness: 0.85pt, dash: "dashed"),
  )

  // ── Process lines ─────────────────────────────────────────────────────────
  let ls = (stroke: (paint: col-line, thickness: 0.6pt))
  line((0, 0),  (12, 0),  ..ls)
  line((0, -2), (12, -2), ..ls)
  line((0, -4), (12, -4), ..ls)

  content((-0.15, 0),  [*P1*], anchor: "east")
  content((-0.15, -2), [*P2*], anchor: "east")
  content((-0.15, -4), [*P3*], anchor: "east")

  // Time axis
  line((0, -5.1), (12, -5.1),
    mark: (end: "stealth", fill: col-line, scale: 0.4),
    stroke: (paint: col-line, thickness: 0.5pt))
  content((12.2, -5.1), text(size: 0.8em, fill: col-text)[temps], anchor: "west")

  // ══════════════════════════════════════════════════════════════════════════
  // P1 broadcasts REQ(ts=3) at t=1.5
  // ══════════════════════════════════════════════════════════════════════════
  circle((1.5, 0), radius: 0.13, fill: col-p1req, stroke: none)
  // P1 → P2
  line((1.5, 0), (2.5, -2), ..msg(col-p1req))
  circle((2.5, -2), radius: 0.13, fill: col-p1req, stroke: none)
  // P1 → P3
  line((1.5, 0), (2.8, -4), ..msg(col-p1req))
  circle((2.8, -4), radius: 0.13, fill: col-p1req, stroke: none)

  content((1.55, -0.85), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-p1req)[REQ(ts=3, P1)]), anchor: "west")

  // ══════════════════════════════════════════════════════════════════════════
  // P2 broadcasts REQ(ts=5) at t=2
  // ══════════════════════════════════════════════════════════════════════════
  circle((2.0, -2), radius: 0.13, fill: col-p2req, stroke: none)
  // P2 → P1
  line((2.0, -2), (3.2, 0), ..msg(col-p2req))
  circle((3.2, 0), radius: 0.13, fill: col-p2req, stroke: none)
  // P2 → P3
  line((2.0, -2), (3.3, -4), ..msg(col-p2req))
  circle((3.3, -4), radius: 0.13, fill: col-p2req, stroke: none)

  content((2.05, -3.15), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-p2req)[REQ(ts=5, P2)]), anchor: "west")

  // ══════════════════════════════════════════════════════════════════════════
  // Reactions
  // ══════════════════════════════════════════════════════════════════════════

  // P2 receives P1's REQ(ts=3): ts_P1=3 < ts_P2=5 → P1 has priority → P2 replies immediately
  circle((3.5, -2), radius: 0.13, fill: col-teal, stroke: none)
  line((3.5, -2), (4.5, 0), ..msg-dash(col-teal))
  circle((4.5, 0), radius: 0.13, fill: col-teal, stroke: none)
  content((3.6, -0.95), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-teal)[OK (immédiat)]), anchor: "west")

  // P1 receives P2's REQ(ts=5): ts_P1=3 < ts_P2=5 → P1 a priorité → P1 DIFFÈRE la réponse
  rect((3.0, -0.45), (4.7, 0.45), fill: rgb("#fef3c7"),
    stroke: (paint: col-defer, thickness: 1pt), radius: 0.1)
  content((3.85, 0), text(size: 0.68em, fill: col-defer, weight: "bold")[différé (ts_1 < ts_2)], anchor: "center")

  // P3 replies to P1's REQ immediately
  circle((3.8, -4), radius: 0.13, fill: col-teal, stroke: none)
  line((3.8, -4), (5.0, 0), ..msg-dash(col-teal))
  circle((5.0, 0), radius: 0.13, fill: col-teal, stroke: none)
  content((4.15, -1.9), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-teal)[OK(P3→P1)]), anchor: "west")

  // P3 replies to P2's REQ immediately (P2 is not in CS yet)
  circle((4.2, -4), radius: 0.13, fill: col-teal, stroke: none)
  line((4.2, -4), (5.3, -2), ..msg-dash(col-teal))
  circle((5.3, -2), radius: 0.13, fill: col-teal, stroke: none)
  content((4.4, -2.95), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-teal)[OK(P3→P2)]), anchor: "west")

  // ── P1 enters SC (has OK from P2 and P3) ──────────────────────────────────
  rect((5.2, -0.38), (7.2, 0.38), fill: rgb("#dcfce7"),
    stroke: (paint: col-cs, thickness: 1pt), radius: 0.12)
  content((6.2, 0), text(size: 0.75em, fill: col-cs, weight: "bold")[SC (P1)], anchor: "center")

  // ── P1 exits SC → sends deferred reply to P2 ──────────────────────────────
  circle((7.4, 0), radius: 0.13, fill: col-p2req, stroke: none)
  line((7.4, 0), (8.2, -2), ..msg-dash(col-teal))
  circle((8.2, -2), radius: 0.13, fill: col-teal, stroke: none)
  content((7.5, -0.9), box(fill: white, inset: (x:2pt,y:1pt),
    text(size: 0.65em, fill: col-teal)[OK différé → P2]), anchor: "west")

  // ── P2 enters SC ──────────────────────────────────────────────────────────
  rect((8.5, -2.38), (10.5, -1.62), fill: rgb("#dcfce7"),
    stroke: (paint: col-cs, thickness: 1pt), radius: 0.12)
  content((9.5, -2), text(size: 0.75em, fill: col-cs, weight: "bold")[SC (P2)], anchor: "center")

  // ── Bottom summary ────────────────────────────────────────────────────────
  content((6.0, -4.7), text(size: 0.78em, fill: col-text, weight: "bold")[
    Total : $2(n-1) = 4$ messages par entrée — sans diffusion de sortie
  ], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────
  line((0.2, -5.75), (0.9, -5.75), ..msg(col-p1req))
  content((1.0, -5.75), text(size: 0.67em)[REQ de P1 (ts=3)], anchor: "west")
  line((3.8, -5.75), (4.5, -5.75), ..msg(col-p2req))
  content((4.6, -5.75), text(size: 0.67em)[REQ de P2 (ts=5)], anchor: "west")
  line((7.3, -5.75), (8.0, -5.75), ..msg-dash(col-teal))
  content((8.1, -5.75), text(size: 0.67em)[réponse OK], anchor: "west")
})
