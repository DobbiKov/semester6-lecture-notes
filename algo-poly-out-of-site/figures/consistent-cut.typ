#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-before  = rgb("#1d4ed8")   // blue  – events/msgs before cut
  let col-after   = luma(170)        // gray  – events/msgs after cut
  let col-cut     = rgb("#dc2626")   // red   – cut line
  let col-chan    = rgb("#d97706")   // amber – channel state (msg crossing cut)
  let col-line    = luma(60)

  // ── Timeline lines ────────────────────────────────────────────────────────────
  line((0, 0),    (8.5, 0),    stroke: (paint: col-line, thickness: 0.6pt))   // P1
  line((0, -2),   (8.5, -2),   stroke: (paint: col-line, thickness: 0.6pt))   // P2
  line((0, -4),   (8.5, -4),   stroke: (paint: col-line, thickness: 0.6pt))   // P3

  // ── Process labels ────────────────────────────────────────────────────────────
  content((-0.15, 0),  [*P1*], anchor: "east")
  content((-0.15, -2), [*P2*], anchor: "east")
  content((-0.15, -4), [*P3*], anchor: "east")

  // ── Helper: event dot ─────────────────────────────────────────────────────────
  let ev(x, y, col) = {
    circle((x, y), radius: 0.13, fill: col, stroke: none)
  }
  // ── Helper: message arrow ─────────────────────────────────────────────────────
  let msg(x1, y1, x2, y2, col) = {
    line((x1, y1), (x2, y2),
      mark: (end: "stealth", fill: col, scale: 0.45),
      stroke: (paint: col, thickness: 0.65pt))
  }

  // ══ Events and messages BEFORE cut (blue) ════════════════════════════════════
  // P1 events
  ev(1.0, 0, col-before)
  ev(2.2, 0, col-before)
  ev(3.4, 0, col-before)

  // P2 events
  ev(0.8, -2, col-before)
  ev(2.5, -2, col-before)

  // P3 events
  ev(1.5, -4, col-before)
  ev(3.0, -4, col-before)

  // Messages before cut (blue)
  msg(2.2, 0, 2.5, -2, col-before)        // P1 → P2
  msg(0.8, -2, 1.5, -4, col-before)       // P2 → P3
  msg(3.0, -4, 3.4, 0, col-before)        // P3 → P1 (goes up)

  // ══ Message CROSSING the cut (amber — channel state) ═════════════════════════
  // Sent by P1 at x=3.4 (before cut on P1), received by P2 at x=5.2 (after cut on P2)
  line((3.4, 0), (5.2, -2),
    mark: (end: "stealth", fill: col-chan, scale: 0.5),
    stroke: (paint: col-chan, thickness: 0.8pt, dash: "dashed"))
  content((4.15, -0.85), box(
    fill: white,
    inset: (x: 2pt, y: 1pt),
    text(size: 0.7em, fill: col-chan)[état du canal $c_(12)$],
  ))

  // ══ Events and messages AFTER cut (gray) ═════════════════════════════════════
  ev(5.2, -2, col-after)
  ev(6.5, -2, col-after)
  ev(5.0, 0,  col-after)
  ev(6.8, 0,  col-after)
  ev(4.5, -4, col-after)
  ev(6.2, -4, col-after)

  msg(5.2, -2, 5.0, 0, col-after)         // P2 → P1 (after cut)
  msg(6.8, 0,  6.2, -4, col-after)        // P1 → P3 (after cut)

  // ══ Consistent cut line (red zigzag) ═════════════════════════════════════════
  // P1 cut at x≈3.7, P2 cut at x≈4.0, P3 cut at x≈4.2
  let cut-style = (paint: col-cut, thickness: 1.2pt, dash: "dashed")
  line((3.7,  0.45), (4.0, -1.55), stroke: cut-style)   // P1 to between P1 and P2
  line((4.0, -2.45), (4.2, -3.55), stroke: cut-style)   // P2 to between P2 and P3
  line((4.2, -4.45), (4.2, -4.6),  stroke: cut-style)   // P3 to bottom

  // Cut top cap
  line((3.7, 0.45), (3.7, 0.55), stroke: cut-style)

  // Cut labels
  content((3.45, 0.7),  text(size: 0.68em, fill: col-cut)[$c_1=3$], anchor: "south")
  content((3.75, -2.0), text(size: 0.68em, fill: col-cut)[$c_2=2$], anchor: "west")
  content((4.0,  -4.0), text(size: 0.68em, fill: col-cut)[$c_3=2$], anchor: "west")

  // "Coupe C" label
  content((4.6, 0.6), text(size: 0.78em, fill: col-cut)[*Coupe C*], anchor: "west")

  // ── "Avant" / "Après" labels ──────────────────────────────────────────────────
  content((2.0, 0.75),  text(size: 0.75em, fill: col-before)[avant la coupe], anchor: "south")
  content((6.5, 0.75),  text(size: 0.75em, fill: col-after)[après la coupe],  anchor: "south")

  // ── Time arrow ────────────────────────────────────────────────────────────────
  line((0, -5.0), (8.3, -5.0),
    mark: (end: "stealth", fill: black, scale: 0.4),
    stroke: (paint: black, thickness: 0.5pt))
  content((4.15, -5.25), text(size: 0.8em)[temps], anchor: "north")

  // ── Bottom annotation ─────────────────────────────────────────────────────────
  content((4.25, -5.8), [
    #set text(size: 0.75em)
    *Coupe cohérente :* aucun message envoyé après la coupe n'est reçu avant.
    #h(0.5em) Le message en transit (en tirets ambrés) constitue l'*état du canal*.
  ], anchor: "north")
})
