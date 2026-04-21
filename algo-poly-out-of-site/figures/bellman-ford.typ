#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ────────────────────────────────────────────────────────────────
  let col-edge   = rgb("#9ca3af")
  let col-sp     = rgb("#1d4ed8")    // shortest-path tree edges
  let col-skip   = rgb("#0d9488")    // shortcut edge (A-C)
  let col-node   = rgb("#dbeafe")
  let col-root   = rgb("#1d4ed8")
  let col-stroke = rgb("#374151")
  let col-text   = rgb("#111827")
  let col-dist   = rgb("#7c3aed")    // distance labels
  let r = 0.32

  // Nodes in a line: A(0,1), B(2,1), C(4,1), D(6,1)
  // Plus shortcut edge A-C (arc above)

  // ── Chain edges (gray) ────────────────────────────────────────────────────
  let eg = (paint: col-edge, thickness: 0.8pt)
  line((0,1),(2,1), stroke: eg)
  line((2,1),(4,1), stroke: eg)
  line((4,1),(6,1), stroke: eg)

  // ── Shortcut arc A→C drawn as a bezier-like approximation using line ───────
  // We'll draw a curved arc via a series of segments or use a bezier
  // cetz supports bezier: bezier(start, end, ctrl1, ctrl2, ...)
  // Let's use: arc from (0,1) to (4,1) curving up through (2, 2.1)
  // Use bezier with two control points
  // Actually cetz.draw has `bezier` command
  // bezier((x0,y0), (x1,y1), (cx0,cy0), (cx1,cy1))
  // shortcut A→C: arc above
  // We draw as a thick teal line curving through mid-point
  // Use merge-path or catmull – let's use a simple arc with line through (2, 2.1)
  // Note: cetz catmull-rom: not standard. Let's approximate with 3 lines.
  // Draw the shortcut arc using bezier
  // bezier expects: bezier(start, ctrl1, ctrl2, end)  [cubic]
  // syntax in cetz: bezier(pt0, pt1, ..., stroke: ...)
  // Only 3-point (quadratic-ish) available with catmull or with hobby curves
  // Use hobby/catmull: not directly. Use line with intermediate point.
  // We approximate arc with 5 line segments
  let arc-pts = ((0,1), (0.5, 1.6), (1.2, 2.05), (2, 2.2), (2.8, 2.05), (3.5, 1.6), (4,1))
  // draw shortcut as a multi-segment polyline (teal, dashed for "extra" edge)
  let col-short = rgb("#0d9488")
  line((0,1), (0.5, 1.6), stroke: (paint: col-short, thickness: 0.9pt))
  line((0.5, 1.6), (1.2, 2.05), stroke: (paint: col-short, thickness: 0.9pt))
  line((1.2, 2.05), (2, 2.2), stroke: (paint: col-short, thickness: 0.9pt))
  line((2, 2.2), (2.8, 2.05), stroke: (paint: col-short, thickness: 0.9pt))
  line((2.8, 2.05), (3.5, 1.6), stroke: (paint: col-short, thickness: 0.9pt))
  line((3.5, 1.6), (4, 1), stroke: (paint: col-short, thickness: 0.9pt))
  // Label the shortcut
  content((2, 2.45), text(fill: col-short, size: 6.5pt)[raccourci A–C], anchor: "center")

  // ── Shortest-path tree edges (thick blue, below node centers) ────────────
  // Shortest-path tree: A→B (d=1), A→C via shortcut (d=1), C→D (d=2)
  // Draw SP tree edges as thick blue below
  let arr-sp = (
    mark: (end: "stealth", fill: col-sp, scale: 0.5),
    stroke: (paint: col-sp, thickness: 2pt),
  )
  // A→B
  line((0.32, 0.88), (1.68, 0.88), ..arr-sp)
  // A→C (along shortcut, indicate with a separate arrow below arc at y=0.72)
  // Actually show the SP as: A→B→? No: shortest from A: d(A)=0, d(B)=1 (via A-B), d(C)=1 (via shortcut A-C), d(D)=2 (via C-D)
  // SP tree: A is parent of B and C; C is parent of D
  // Draw A→C as an arc below (to distinguish from chain)
  let arc2-pts = ((0, 0.88), (0.5, 0.35), (2, 0.1), (3.5, 0.35), (4, 0.88))
  line((0, 0.88), (0.6, 0.4), stroke: (paint: col-sp, thickness: 2pt))
  line((0.6, 0.4), (2, 0.15), stroke: (paint: col-sp, thickness: 2pt))
  line((2, 0.15), (3.4, 0.4), stroke: (paint: col-sp, thickness: 2pt))
  line((3.4, 0.4), (4, 0.88),
       mark: (end: "stealth", fill: col-sp, scale: 0.5),
       stroke: (paint: col-sp, thickness: 2pt))
  // C→D
  line((4.32, 0.88), (5.68, 0.88), ..arr-sp)

  // ── Node circles ──────────────────────────────────────────────────────────
  circle((0,1), radius: r, fill: col-root, stroke: (paint: col-stroke, thickness: 1pt))
  content((0,1), text(fill: white, weight: "bold", size: 9pt)[A], anchor: "center")

  circle((2,1), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((2,1), text(fill: col-text, weight: "bold", size: 9pt)[B], anchor: "center")

  circle((4,1), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((4,1), text(fill: col-text, weight: "bold", size: 9pt)[C], anchor: "center")

  circle((6,1), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((6,1), text(fill: col-text, weight: "bold", size: 9pt)[D], anchor: "center")

  // ── Distance labels (above each node) ─────────────────────────────────────
  content((0, 1.55), text(fill: col-dist, size: 8pt, weight: "bold")[$d=0$], anchor: "center")
  content((2, 1.55), text(fill: col-dist, size: 8pt)[$d=1$], anchor: "center")
  content((4, 1.55), text(fill: col-dist, size: 8pt)[$d=1$], anchor: "center")
  content((6, 1.55), text(fill: col-dist, size: 8pt)[$d=2$], anchor: "center")

  // ── Round labels (show BF rounds) ────────────────────────────────────────
  // Below nodes: show old → new distance evolution
  content((2, 0.45), text(fill: rgb("#6b7280"), size: 6pt)[$∞ → 1$], anchor: "center")
  content((4, 0.45), text(fill: rgb("#6b7280"), size: 6pt)[$∞ → 1$], anchor: "center")
  content((6, 0.45), text(fill: rgb("#6b7280"), size: 6pt)[$∞ → 2$], anchor: "center")

  // ── Complexity label ─────────────────────────────────────────────────────
  content((3, -0.4), text(fill: col-text, size: 7.5pt)[Messages : $O(N dot |E|)$ #h(1em) Convergence : $O(N)$ tours], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────
  let lx = 6.5
  line((lx, 2.0),(lx+0.5, 2.0), ..arr-sp)
  content((lx+0.55, 2.0), text(fill: col-text, size: 7pt)[arbre SP], anchor: "west")
  line((lx, 1.65),(lx+0.5, 1.65), stroke: (paint: col-short, thickness: 0.9pt))
  content((lx+0.55, 1.65), text(fill: col-text, size: 7pt)[raccourci], anchor: "west")
})
