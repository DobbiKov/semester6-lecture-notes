#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-idle    = rgb("#6b7280")   // gray – idle process
  let col-active  = rgb("#1d4ed8")   // blue – active process
  let col-msg     = rgb("#d97706")   // amber – message in transit
  let col-bad     = rgb("#dc2626")   // red – wrong/failure
  let col-react   = rgb("#059669")   // green – reactivation
  let col-line    = luma(60)

  // ── Timeline lines ────────────────────────────────────────────────────────────
  line((0, 0),    (8.5, 0),    stroke: (paint: col-line, thickness: 0.6pt))   // P1
  line((0, -2.5), (8.5, -2.5), stroke: (paint: col-line, thickness: 0.6pt))   // P2

  // ── Process labels ────────────────────────────────────────────────────────────
  content((-0.1, 0),    [*P1*], anchor: "east")
  content((-0.1, -2.5), [*P2*], anchor: "east")

  // ── P1: active segment (x=0 to x=2), then idle ────────────────────────────────
  rect((0.2, 0.12), (2.0, -0.12),
    fill: rgb("#dbeafe"), stroke: (paint: col-active, thickness: 0.5pt), radius: 0.05)
  content((1.1, 0), text(size: 0.72em, fill: col-active)[actif], anchor: "center")

  // P1 idle label after x=2
  content((3.2, 0.32), text(size: 0.72em, fill: col-idle)[inactif], anchor: "south")

  // ── P1: send event at x=1.5 ───────────────────────────────────────────────────
  circle((1.5, 0), radius: 0.1, fill: col-active, stroke: none)
  content((1.5, 0.32), text(size: 0.7em)[envoi $m$], anchor: "south")

  // ── P1 idle dot at x=2 ────────────────────────────────────────────────────────
  circle((2.0, 0), radius: 0.1, fill: col-idle, stroke: none)

  // ── P2: active segment (x=0 to x=2.5) ────────────────────────────────────────
  rect((0.2, -2.38), (2.5, -2.62),
    fill: rgb("#dbeafe"), stroke: (paint: col-active, thickness: 0.5pt), radius: 0.05)
  content((1.35, -2.5), text(size: 0.72em, fill: col-active)[actif], anchor: "center")

  // P2 becomes idle at x=2.5
  circle((2.5, -2.5), radius: 0.1, fill: col-idle, stroke: none)
  content((3.2, -2.18), text(size: 0.72em, fill: col-idle)[inactif], anchor: "south")

  // ── Message in transit: P1 (x=1.5) → P2 (x=3.0) dashed amber ────────────────
  let arr-transit = (
    mark: (end: "stealth", fill: col-msg, scale: 0.5),
    stroke: (paint: col-msg, thickness: 0.7pt, dash: "dashed"),
  )
  line((1.5, 0), (3.0, -2.5), ..arr-transit)
  content((2.05, -1.15), box(
    fill: white,
    inset: (x: 2pt, y: 1pt),
    text(size: 0.72em, fill: col-msg)[$m$ en transit],
  ))

  // ── Manager check box at x=2.5 ────────────────────────────────────────────────
  let bx = 4.8
  let by = -1.0
  rect((bx - 0.85, by + 0.45), (bx + 0.85, by - 0.45),
    fill: rgb("#fef2f2"), stroke: (paint: col-bad, thickness: 0.6pt), radius: 0.1)
  content((bx, by + 0.15), text(size: 0.75em)[Tous inactifs ?], anchor: "center")
  content((bx, by - 0.18), text(size: 0.75em, fill: col-bad)[*Terminaison !*], anchor: "center")

  // Dashed vertical line from manager to timelines
  line((4.8, 0.45), (4.8, 0.0), stroke: (paint: col-bad, thickness: 0.5pt, dash: "dashed"))
  line((4.8, -0.45), (4.8, -2.5), stroke: (paint: col-bad, thickness: 0.5pt, dash: "dashed"))

  // ── Red X above the box ───────────────────────────────────────────────────────
  content((5.85, -0.62), box(
    fill: rgb("#fef2f2"),
    stroke: (paint: col-bad, thickness: 0.5pt),
    inset: (x: 3pt, y: 2pt),
    radius: 2pt,
    text(size: 0.85em, fill: col-bad)[*FAUX !*],
  ))

  // ── P2 reactivates at x=3.0 when message arrives ─────────────────────────────
  circle((3.0, -2.5), radius: 0.12, fill: col-react, stroke: none)
  content((3.0, -2.82), text(size: 0.72em, fill: col-react)[réactivation], anchor: "north")

  // P2 active again (x=3.0 to x=5.0)
  rect((3.0, -2.38), (5.0, -2.62),
    fill: rgb("#d1fae5"), stroke: (paint: col-react, thickness: 0.5pt), radius: 0.05)
  content((4.0, -2.5), text(size: 0.72em, fill: col-react)[actif], anchor: "center")

  // ── Time arrow ───────────────────────────────────────────────────────────────
  line((0, -3.5), (8.3, -3.5),
    mark: (end: "stealth", fill: black, scale: 0.4),
    stroke: (paint: black, thickness: 0.5pt))
  content((4.15, -3.75), text(size: 0.8em)[temps], anchor: "north")

  // ── Bottom warning label ──────────────────────────────────────────────────────
  content((4.25, -4.3), [
    #set text(size: 0.78em, fill: col-bad)
    *Attention :* processus inactif #sym.eq.not terminé — les messages en transit comptent !
  ], anchor: "north")
})
