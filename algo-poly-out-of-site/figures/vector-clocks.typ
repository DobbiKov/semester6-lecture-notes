#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-causal  = rgb("#1d4ed8")
  let col-conc    = rgb("#dc2626")   // red for incomparable annotation
  let col-leq     = rgb("#16a34a")   // green for ≤ annotation
  let col-box-bg  = rgb("#eff6ff")   // very light blue
  let col-box-bd  = rgb("#3b82f6")   // blue border

  // ── Helper: vector label box ─────────────────────────────────────────────────
  let vbox(pos, v, anch) = {
    content(
      pos,
      box(
        fill: col-box-bg,
        stroke: (paint: col-box-bd, thickness: 0.5pt),
        inset: (x: 3.5pt, y: 2pt),
        radius: 1.5pt,
        text(size: 0.78em)[#v],
      ),
      anchor: anch,
    )
  }

  // ── Process lines ─────────────────────────────────────────────────────────────
  let line-style = (stroke: (paint: luma(60), thickness: 0.6pt))
  line((0, 0),  (8, 0),  ..line-style)   // P1
  line((0, -2), (8, -2), ..line-style)   // P2
  line((0, -4), (8, -4), ..line-style)   // P3

  // ── Process labels ────────────────────────────────────────────────────────────
  content((-0.1, 0),  [*P1*], anchor: "east")
  content((-0.1, -2), [*P2*], anchor: "east")
  content((-0.1, -4), [*P3*], anchor: "east")

  // ── P1 first event at x=1.5: [1,0,0] ─────────────────────────────────────────
  circle((1.5, 0), radius: 0.12, fill: black, stroke: none, name: "p1e1")
  vbox((1.5, 0.45), [[1,0,0]], "south")
  content((1.5, -0.32), [$e_1$], anchor: "north")

  // ── P1 send event at x=3.0 (same vector, incremented before send) ─────────────
  // Actually per the algo: before any event V[i]++ — send is the event that
  // triggers the message, so we show the send event at x=3.0 as [2,0,0]
  // but per spec, P1's second distinct event is at x=4.5 → [2,0,0].
  // Here we show: P1 sends at x=2.5 (this is also an event → [2,0,0]),
  // then P2 receives at x=3.5.
  // To keep the diagram clear: P1 send-event at x=2.5 with [2,0,0] but label
  // it as "envoi" so the reader understands.
  // Actually let's follow the spec exactly: P1 second event at x=3.5 → [2,0,0],
  // and the send is implied as part of it (simplification common in textbooks).

  // ── P1 second event (send) at x=2.5: [2,0,0] ─────────────────────────────────
  circle((2.5, 0), radius: 0.12, fill: black, stroke: none, name: "p1send")
  vbox((2.5, 0.45), [[2,0,0]], "south")
  content((2.5, -0.32), [$s_1$], anchor: "north")

  // ── P2 receive at x=3.5: [2,1,0] ─────────────────────────────────────────────
  // After receive: max([0,0,0],[2,0,0]) = [2,0,0] then V2[2]++ → [2,1,0]
  circle((3.5, -2), radius: 0.12, fill: black, stroke: none, name: "p2recv")
  vbox((3.5, -2.55), [[2,1,0]], "north")
  content((3.5, -1.68), [$r_1$], anchor: "south")

  // ── P2 send event at x=4.5: [2,2,0] ─────────────────────────────────────────
  circle((4.5, -2), radius: 0.12, fill: black, stroke: none, name: "p2send")
  vbox((4.5, -2.55), [[2,2,0]], "north")
  content((4.5, -1.68), [$s_2$], anchor: "south")

  // ── P3 receive at x=5.5: [2,2,1] ─────────────────────────────────────────────
  circle((5.5, -4), radius: 0.12, fill: black, stroke: none, name: "p3recv")
  vbox((5.5, -3.55), [[2,2,1]], "south")
  content((5.5, -4.35), [$r_2$], anchor: "north")

  // ── P1 independent event at x=4.5: [3,0,0] ──────────────────────────────────
  // (concurrent with P2's send [2,2,0] and P3's receive [2,2,1])
  circle((4.5, 0), radius: 0.12, fill: black, stroke: none, name: "p1e3")
  vbox((4.5, 0.45), [[3,0,0]], "south")
  content((4.5, -0.32), [$e_2$], anchor: "north")

  // ── Causal message arrows ─────────────────────────────────────────────────────
  let arr-causal = (
    mark: (end: "stealth", fill: col-causal, scale: 0.5),
    stroke: (paint: col-causal, thickness: 0.7pt, dash: "dashed"),
  )
  // P1 send → P2 receive
  line((2.5, 0), (3.5, -2), ..arr-causal)
  // P2 send → P3 receive
  line((4.5, -2), (5.5, -4), ..arr-causal)

  // ── Concurrency annotation: [3,0,0] vs [2,1,0] → incomparable ────────────────
  let dash-conc = (
    stroke: (paint: col-conc, thickness: 0.55pt, dash: "dashed"),
  )
  line((4.5, 0), (3.5, -2), ..dash-conc)

  // Red annotation label
  content((3.55, -0.85), box(
    fill: white,
    stroke: (paint: col-conc, thickness: 0.4pt),
    inset: (x: 2.5pt, y: 1.5pt),
    radius: 1pt,
    text(size: 0.72em, fill: col-conc)[incomparables ($parallel$)],
  ))

  // ── ≤ annotation: [1,0,0] ≤ [2,2,1] (causal precedence) ─────────────────────
  // Draw a subtle green annotation arc / label
  content((3.5, -1.2), box(
    fill: white,
    stroke: none,
    inset: (x: 2pt, y: 1pt),
    text(size: 0.72em, fill: col-leq)[
      $[1,0,0] lt.eq [2,2,1]$ #linebreak() $(e_1 arrow.r r_2)$
    ],
  ), anchor: "west")

  // ── Bottom key ───────────────────────────────────────────────────────────────
  let ky = -5.2
  // causal arrow sample
  line((0.2, ky), (1.1, ky), ..arr-causal)
  content((1.2, ky), text(size: 0.80em)[message (chaîne causale)], anchor: "west")

  // concurrent sample
  line((4.0, ky), (4.9, ky), ..dash-conc)
  content((5.0, ky), text(size: 0.80em, fill: col-conc)[événements concurrents],
    anchor: "west")
})
