#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ───────────────────────────────────────────────────────────────
  let col-node   = rgb("#1e40af")
  let col-stroke = rgb("#1e3a5f")
  let col-token  = rgb("#d97706")   // amber – token
  let col-cs     = rgb("#16a34a")   // green – critical section
  let col-ring   = rgb("#374151")
  let col-text   = rgb("#111827")
  let col-active = rgb("#7c3aed")   // violet – active token holder

  // ── Process positions (circle of radius 2.8 centred at (3,3)) ─────────────
  // P1 top, P2 right, P3 bottom, P4 left  (clockwise)
  let cx = 3.0
  let cy = 3.0
  let R  = 2.4
  let r  = 0.38

  // P1 = top    (angle 90°)
  let p1 = (cx, cy + R)
  // P2 = right  (angle 0°)
  let p2 = (cx + R, cy)
  // P3 = bottom (angle 270°)
  let p3 = (cx, cy - R)
  // P4 = left   (angle 180°)
  let p4 = (cx - R, cy)

  // ── Ring arrows (clockwise: P1→P2→P3→P4→P1) ──────────────────────────────
  let ring-arr = (
    mark: (end: "stealth", fill: col-ring, scale: 0.45),
    stroke: (paint: col-ring, thickness: 0.9pt),
  )

  // Helper: draw arc-like arrow between two nodes (straight, slightly offset)
  // P1 → P2 (top → right)
  line((cx + 0.27, cy + R - 0.27), (cx + R - 0.27, cy + 0.27), ..ring-arr)
  // P2 → P3 (right → bottom)
  line((cx + R - 0.27, cy - 0.27), (cx + 0.27, cy - R + 0.27), ..ring-arr)
  // P3 → P4 (bottom → left)
  line((cx - 0.27, cy - R + 0.27), (cx - R + 0.27, cy - 0.27), ..ring-arr)
  // P4 → P1 (left → top)
  line((cx - R + 0.27, cy + 0.27), (cx - 0.27, cy + R - 0.27), ..ring-arr)

  // ── Node circles ──────────────────────────────────────────────────────────
  // P1
  circle(p1, radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content(p1, text(fill: white, weight: "bold", size: 9pt)[P1], anchor: "center")

  // P2 – token holder (violet highlight + larger)
  circle(p2, radius: r + 0.05, fill: col-active,
    stroke: (paint: col-token, thickness: 2pt))
  content(p2, text(fill: white, weight: "bold", size: 9pt)[P2], anchor: "center")

  // P3
  circle(p3, radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content(p3, text(fill: white, weight: "bold", size: 9pt)[P3], anchor: "center")

  // P4
  circle(p4, radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content(p4, text(fill: white, weight: "bold", size: 9pt)[P4], anchor: "center")

  // ── Token symbol near P2 ──────────────────────────────────────────────────
  circle((cx + R + 0.75, cy + 0.65), radius: 0.32,
    fill: col-token, stroke: (paint: rgb("#92400e"), thickness: 1pt))
  content((cx + R + 0.75, cy + 0.65),
    text(fill: white, weight: "bold", size: 8pt)[T], anchor: "center")
  // dashed link from token to P2
  line((cx + R + 0.75, cy + 0.65), (cx + R + 0.38, cy + 0.1),
    stroke: (paint: col-token, thickness: 0.7pt, dash: "dashed"))
  content((cx + R + 0.75, cy + 1.05),
    text(size: 0.65em, fill: col-token, weight: "bold")[jeton], anchor: "center")

  // ── SC box next to P2 ─────────────────────────────────────────────────────
  rect((cx + R + 0.55, cy - 0.55), (cx + R + 1.55, cy - 0.1),
    fill: rgb("#dcfce7"), stroke: (paint: col-cs, thickness: 1pt), radius: 0.1)
  content((cx + R + 1.05, cy - 0.325),
    text(size: 0.7em, fill: col-cs, weight: "bold")[SC], anchor: "center")

  // ── Complexity labels (bottom) ────────────────────────────────────────────
  let by = cy - R - 1.0
  content((cx, by), text(size: 0.78em, fill: col-text, weight: "bold")[
    Meilleur cas : 0 message (jeton déjà là) #h(1.5em) Pire cas : $N-1$ messages
  ], anchor: "center")

  // ── Ring label ────────────────────────────────────────────────────────────
  content((cx, cy), text(size: 0.7em, fill: luma(100), style: "italic")[anneau\ logique], anchor: "center")
})
