#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-causal = rgb("#1d4ed8")
  let col-box    = rgb("#fef9c3")   // light yellow for clock boxes
  let col-border = rgb("#ca8a04")   // amber border

  // ── Helper: draw a clock-value box above or below a point ────────────────────
  let clock-box(pos, label, anch) = {
    let (px, py) = pos
    content(
      (px, py),
      box(
        fill: col-box,
        stroke: (paint: col-border, thickness: 0.5pt),
        inset: (x: 3pt, y: 2pt),
        radius: 1.5pt,
        label,
      ),
      anchor: anch,
    )
  }

  // ── Process lines ─────────────────────────────────────────────────────────────
  let line-style = (stroke: (paint: luma(60), thickness: 0.6pt))
  line((0, 0),    (7.5, 0),    ..line-style)   // P1
  line((0, -2.5), (7.5, -2.5), ..line-style)   // P2

  // ── Process labels ────────────────────────────────────────────────────────────
  content((-0.1, 0),    [*P1*], anchor: "east")
  content((-0.1, -2.5), [*P2*], anchor: "east")

  // ── P1 event at x=1, C=1 ─────────────────────────────────────────────────────
  circle((1, 0), radius: 0.12, fill: black, stroke: none, name: "p1e1")
  clock-box((1, 0.45), [C=1], "south")
  content((1, -0.35), [$e_1$], anchor: "north")

  // ── P1 send event at x=2, C=2 ────────────────────────────────────────────────
  // (the send itself increments the counter before attaching)
  circle((2.5, 0), radius: 0.12, fill: black, stroke: none, name: "p1send")
  clock-box((2.5, 0.45), [C=2], "south")
  content((2.5, -0.35), [$s_1$], anchor: "north")

  // ── P1 event at x=5, C=3 ─────────────────────────────────────────────────────
  circle((5.5, 0), radius: 0.12, fill: black, stroke: none, name: "p1e2")
  clock-box((5.5, 0.45), [C=3], "south")
  content((5.5, -0.35), [$e_4$], anchor: "north")

  // ── P2 receive at x=3.5, C=max(0,2)+1=3 ─────────────────────────────────────
  circle((3.5, -2.5), radius: 0.12, fill: black, stroke: none, name: "p2recv")
  clock-box((3.5, -2.95), [C=max(0,2)+1=3], "north")
  content((3.5, -2.15), [$r_1$], anchor: "south")

  // ── P2 event at x=5, C=4 ─────────────────────────────────────────────────────
  circle((5.5, -2.5), radius: 0.12, fill: black, stroke: none, name: "p2e2")
  clock-box((5.5, -2.95), [C=4], "north")
  content((5.5, -2.15), [$e_3$], anchor: "south")

  // ── Message arrow P1 send → P2 receive (dashed blue) ─────────────────────────
  let arr-msg = (
    mark: (end: "stealth", fill: col-causal, scale: 0.5),
    stroke: (paint: col-causal, thickness: 0.65pt, dash: "dashed"),
  )
  line((2.5, 0), (3.5, -2.5), ..arr-msg)

  // ── "ts=2" label on the message arrow ─────────────────────────────────────────
  content((2.85, -1.25), box(
    fill: white,
    inset: (x: 2pt, y: 1pt),
    [#text(size: 0.72em, fill: col-causal)[ts=2]],
  ))

  // ── Bottom annotations ────────────────────────────────────────────────────────
  let ay = -3.75
  content((3.75, ay), [
    #set text(size: 0.82em)
    $e arrow.r f space.med arrow.r.double space.med L(e) < L(f)$ #h(1.5em)
    $L(e) < L(f) space.med arrow.r.not space.med e arrow.r f$
  ], anchor: "north")
})
