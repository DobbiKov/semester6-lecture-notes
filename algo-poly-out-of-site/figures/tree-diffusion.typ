#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ────────────────────────────────────────────────────────────────
  let col-node   = rgb("#1d4ed8")    // blue fill
  let col-stroke = rgb("#1e3a5f")
  let col-down   = rgb("#1d4ed8")    // descente arrows
  let col-ack    = rgb("#0d9488")    // remontée / ACK arrows
  let col-text   = rgb("#111827")
  let r = 0.35

  // ── Tree nodes: A(2,3), B(1,1.5), C(3,1.5), D(0.5,0), E(1.5,0) ───────────

  // ── Downward diffusion arrows (thick blue) ────────────────────────────────
  let arr-down = (
    mark: (end: "stealth", fill: col-down, scale: 0.5),
    stroke: (paint: col-down, thickness: 1.6pt),
  )
  // A → B
  line((1.88, 2.73), (1.12, 1.77), ..arr-down)
  // A → C
  line((2.12, 2.73), (2.88, 1.77), ..arr-down)
  // B → D
  line((0.88, 1.23), (0.62, 0.27), ..arr-down)
  // B → E
  line((1.12, 1.23), (1.38, 0.27), ..arr-down)

  // ── ACK arrows (upward, teal, offset right) ───────────────────────────────
  let arr-ack = (
    mark: (end: "stealth", fill: col-ack, scale: 0.5),
    stroke: (paint: col-ack, thickness: 1.4pt, dash: "dashed"),
  )
  // D → B
  line((0.68, 0.27), (0.94, 1.23), ..arr-ack)
  // E → B
  line((1.44, 0.27), (1.18, 1.23), ..arr-ack)
  // B → A
  line((1.18, 1.77), (1.94, 2.73), ..arr-ack)
  // C → A
  line((2.94, 1.77), (2.18, 2.73), ..arr-ack)

  // ── Node circles ──────────────────────────────────────────────────────────
  circle((2,3),   radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,3),   text(fill: white, weight: "bold", size: 9pt)[A], anchor: "center")

  circle((1,1.5), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((1,1.5), text(fill: white, weight: "bold", size: 9pt)[B], anchor: "center")

  circle((3,1.5), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((3,1.5), text(fill: white, weight: "bold", size: 9pt)[C], anchor: "center")

  circle((0.5,0), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((0.5,0), text(fill: white, weight: "bold", size: 9pt)[D], anchor: "center")

  circle((1.5,0), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((1.5,0), text(fill: white, weight: "bold", size: 9pt)[E], anchor: "center")

  // ── Phase labels ──────────────────────────────────────────────────────────
  // Descente label near A→B
  content((1.22, 2.12), text(fill: col-down, size: 6.5pt, style: "italic")[desc.], anchor: "east")
  // ACK label near D→B
  content((0.56, 0.78), text(fill: col-ack, size: 6.5pt, style: "italic")[ACK], anchor: "west")

  // ── Legend ────────────────────────────────────────────────────────────────
  let lx = 3.6
  line((lx, 2.6), (lx+0.6, 2.6),
       mark: (end: "stealth", fill: col-down, scale: 0.45),
       stroke: (paint: col-down, thickness: 1.4pt))
  content((lx+0.65, 2.6), text(fill: col-text, size: 7pt)[diffusion], anchor: "west")

  line((lx, 2.2), (lx+0.6, 2.2),
       mark: (end: "stealth", fill: col-ack, scale: 0.45),
       stroke: (paint: col-ack, thickness: 1.2pt, dash: "dashed"))
  content((lx+0.65, 2.2), text(fill: col-text, size: 7pt)[acquittement], anchor: "west")

  // ── Complexity label ──────────────────────────────────────────────────────
  content((2, -0.7), text(fill: col-text, size: 8pt)[$N - 1 = 4$ messages (descente)], anchor: "center")
  content((2, -1.1), text(fill: col-text, size: 8pt)[$2(N-1) = 8$ messages (total avec ACK)], anchor: "center")
})
