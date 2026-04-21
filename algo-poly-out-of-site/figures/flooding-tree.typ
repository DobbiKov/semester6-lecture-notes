#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ────────────────────────────────────────────────────────────────
  let col-edge    = rgb("#9ca3af")   // thin gray – original graph edges
  let col-bfs     = rgb("#1d4ed8")   // blue – BFS tree edges
  let col-reject  = rgb("#dc2626")   // red – rejected cross-edges
  let col-root    = rgb("#1d4ed8")   // root fill
  let col-child   = rgb("#93c5fd")   // light blue – BFS children
  let col-stroke  = rgb("#374151")
  let col-text    = rgb("#111827")
  let r = 0.35

  // Graph: A(2,2) center root, B(1,0.5), C(3,0.5), D(2,3.5) – star + cross edges
  // Let's use: A(2,2), B(0.5,0.5), C(3.5,0.5), D(2,3.5)
  // Edges: A-B, A-C, A-D, B-C (cross), B-D (cross), C-D (cross)

  // ── All original graph edges (thin gray) ─────────────────────────────────
  let eg = (paint: col-edge, thickness: 0.7pt)
  line((2,2),(0.5,0.5), stroke: eg)
  line((2,2),(3.5,0.5), stroke: eg)
  line((2,2),(2,3.5),   stroke: eg)
  line((0.5,0.5),(3.5,0.5), stroke: eg)
  line((0.5,0.5),(2,3.5),   stroke: eg)
  line((3.5,0.5),(2,3.5),   stroke: eg)

  // ── BFS tree arrows (A → B, A → C, A → D simultaneously) ─────────────────
  let arr-bfs = (
    mark: (end: "stealth", fill: col-bfs, scale: 0.55),
    stroke: (paint: col-bfs, thickness: 2pt),
  )
  // A→B
  line((1.82, 1.85), (0.68, 0.65), ..arr-bfs)
  // A→C
  line((2.18, 1.85), (3.32, 0.65), ..arr-bfs)
  // A→D
  line((2, 2.35), (2, 3.15), ..arr-bfs)

  // ── Rejected cross-edge arrows (dashed red) ───────────────────────────────
  let arr-rej = (
    mark: (end: "stealth", fill: col-reject, scale: 0.45),
    stroke: (paint: col-reject, thickness: 1pt, dash: "dashed"),
  )
  // B→C rejected
  line((0.85, 0.5), (3.15, 0.5), ..arr-rej)
  // B→D rejected
  line((0.65, 0.78), (1.85, 3.25), ..arr-rej)
  // C→D rejected
  line((3.35, 0.78), (2.18, 3.25), ..arr-rej)

  // ── Node circles ──────────────────────────────────────────────────────────
  // A – root (deep blue)
  circle((2,2), radius: r, fill: col-root, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,2), text(fill: white, weight: "bold", size: 9pt)[A], anchor: "center")

  // B, C, D – BFS children
  circle((0.5,0.5), radius: r, fill: col-child, stroke: (paint: col-stroke, thickness: 1pt))
  content((0.5,0.5), text(fill: col-text, weight: "bold", size: 9pt)[B], anchor: "center")

  circle((3.5,0.5), radius: r, fill: col-child, stroke: (paint: col-stroke, thickness: 1pt))
  content((3.5,0.5), text(fill: col-text, weight: "bold", size: 9pt)[C], anchor: "center")

  circle((2,3.5), radius: r, fill: col-child, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,3.5), text(fill: col-text, weight: "bold", size: 9pt)[D], anchor: "center")

  // ── "Rejected" labels ─────────────────────────────────────────────────────
  content((2, 0.18), text(fill: col-reject, size: 6pt)[rejeté], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────
  let lx = 4.2
  line((lx, 2.8),(lx+0.6, 2.8), ..arr-bfs)
  content((lx+0.65, 2.8), text(fill: col-text, size: 7pt)[arbre BFS], anchor: "west")

  line((lx, 2.4),(lx+0.6, 2.4), ..arr-rej)
  content((lx+0.65, 2.4), text(fill: col-text, size: 7pt)[rejeté (déjà vu)], anchor: "west")

  // ── Complexity/result labels ──────────────────────────────────────────────
  content((2, -0.35), text(fill: col-text, size: 7.5pt)[Résultat : arbre BFS (plus courts chemins depuis A)], anchor: "center")
  content((2, -0.75), text(fill: col-text, size: 7.5pt)[Temps : $O("diam")$ #h(0.8em) Messages : $O(|E|)$], anchor: "center")
})
