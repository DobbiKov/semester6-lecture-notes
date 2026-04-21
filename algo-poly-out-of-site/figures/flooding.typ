#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colour palette ─────────────────────────────────────────────────────────
  let col-fill-init  = rgb("#1d4ed8")   // deep blue – initiator / informed
  let col-fill-inf   = rgb("#93c5fd")   // light blue – informed node
  let col-fill-none  = white
  let col-stroke     = rgb("#374151")   // dark gray
  let col-edge       = rgb("#9ca3af")   // gray edges
  let col-arrow      = rgb("#1d4ed8")   // blue message arrows
  let col-text       = rgb("#111827")

  // ── Node positions ─────────────────────────────────────────────────────────
  // A(2,3), B(1,1.5), C(3,1.5), D(2,0)
  let r = 0.35

  // ── Background edges (all graph edges) ────────────────────────────────────
  // A-B, A-C, B-C, B-D, C-D
  let edge-style = (paint: col-edge, thickness: 0.8pt)

  line((2,3), (1,1.5), stroke: edge-style)
  line((2,3), (3,1.5), stroke: edge-style)
  line((1,1.5), (3,1.5), stroke: edge-style)
  line((1,1.5), (2,0), stroke: edge-style)
  line((3,1.5), (2,0), stroke: edge-style)

  // ── Message-flow arrows (flood path) ──────────────────────────────────────
  // Phase 1: A → B and A → C
  let arr-msg = (
    mark: (end: "stealth", fill: col-arrow, scale: 0.5),
    stroke: (paint: col-arrow, thickness: 1.4pt),
  )
  // A→B: offset slightly so arrow doesn't overlap edge exactly
  line((1.9, 2.73), (1.08, 1.72), ..arr-msg)
  // A→C
  line((2.1, 2.73), (2.92, 1.72), ..arr-msg)
  // Phase 2: B → D and C → D
  line((1.08, 1.28), (1.9, 0.27), ..arr-msg)
  line((2.92, 1.28), (2.1, 0.27), ..arr-msg)

  // ── Node circles ──────────────────────────────────────────────────────────
  // A – initiator (deep blue)
  circle((2,3), radius: r, fill: col-fill-init, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,3), text(fill: white, weight: "bold", size: 9pt)[A], anchor: "center")

  // B – informed (light blue)
  circle((1,1.5), radius: r, fill: col-fill-inf, stroke: (paint: col-stroke, thickness: 1pt))
  content((1,1.5), text(fill: col-text, weight: "bold", size: 9pt)[B], anchor: "center")

  // C – informed (light blue)
  circle((3,1.5), radius: r, fill: col-fill-inf, stroke: (paint: col-stroke, thickness: 1pt))
  content((3,1.5), text(fill: col-text, weight: "bold", size: 9pt)[C], anchor: "center")

  // D – informed (light blue)
  circle((2,0), radius: r, fill: col-fill-inf, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,0), text(fill: col-text, weight: "bold", size: 9pt)[D], anchor: "center")

  // ── Phase labels on arrows ────────────────────────────────────────────────
  content((1.25, 2.25), text(fill: col-arrow, size: 6.5pt)[_m_], anchor: "center")
  content((2.75, 2.25), text(fill: col-arrow, size: 6.5pt)[_m_], anchor: "center")
  content((1.35, 0.75), text(fill: col-arrow, size: 6.5pt)[_m_], anchor: "center")
  content((2.65, 0.75), text(fill: col-arrow, size: 6.5pt)[_m_], anchor: "center")

  // ── Legend box ────────────────────────────────────────────────────────────
  // Informed node sample
  circle((0.45, -0.7), radius: 0.2, fill: col-fill-init,
         stroke: (paint: col-stroke, thickness: 0.7pt))
  content((0.45, -0.7), text(fill: white, size: 6pt)[A], anchor: "center")
  content((1.05, -0.7), text(fill: col-text, size: 7pt)[initiateur], anchor: "west")

  circle((0.45, -1.15), radius: 0.2, fill: col-fill-inf,
         stroke: (paint: col-stroke, thickness: 0.7pt))
  content((1.05, -1.15), text(fill: col-text, size: 7pt)[informé], anchor: "west")

  // ── Complexity labels ─────────────────────────────────────────────────────
  content((2, -0.7), text(fill: col-text, size: 7.5pt)[Messages : $≤ 2|E|$], anchor: "center")
  content((2, -1.1), text(fill: col-text, size: 7.5pt)[Temps : $O("diam")$], anchor: "center")
})
