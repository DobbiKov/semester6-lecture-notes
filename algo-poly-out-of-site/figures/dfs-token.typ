#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ────────────────────────────────────────────────────────────────
  let col-edge   = rgb("#9ca3af")   // thin gray for all edges
  let col-dfs    = rgb("#1d4ed8")   // blue – DFS tree forward edges
  let col-back   = rgb("#6b7280")   // gray dashed – backtrack
  let col-token  = rgb("#d97706")   // amber – token circle
  let col-node   = rgb("#e0e7ff")   // light blue-gray node fill
  let col-stroke = rgb("#374151")
  let col-text   = rgb("#111827")
  let r = 0.35

  // Nodes: A(1,2), B(3,2), C(3,0), D(1,0)

  // ── All graph edges (thin gray background) ────────────────────────────────
  let eg = (paint: col-edge, thickness: 0.8pt)
  line((1,2),(3,2), stroke: eg)   // A-B
  line((3,2),(3,0), stroke: eg)   // B-C
  line((3,0),(1,0), stroke: eg)   // C-D
  line((1,0),(1,2), stroke: eg)   // D-A
  line((1,2),(3,0), stroke: eg)   // A-C (diagonal)
  line((3,2),(1,0), stroke: eg)   // B-D (diagonal)

  // ── DFS forward tree edges (thick blue) ───────────────────────────────────
  // DFS path: A→B→C→D
  let arr-fwd = (
    mark: (end: "stealth", fill: col-dfs, scale: 0.55),
    stroke: (paint: col-dfs, thickness: 2pt),
  )
  // A→B (top, shift slightly above center to separate from backtrack)
  line((1.35, 2.05), (2.65, 2.05), ..arr-fwd)
  // B→C
  line((3.05, 1.65), (3.05, 0.35), ..arr-fwd)
  // C→D
  line((2.65, -0.05), (1.35, -0.05), ..arr-fwd)

  // ── Backtrack dashed arrows ────────────────────────────────────────────────
  // After visiting D, backtrack D→C→B→A
  let arr-back = (
    mark: (end: "stealth", fill: col-back, scale: 0.45),
    stroke: (paint: col-back, thickness: 1.2pt, dash: "dashed"),
  )
  // D→C (backtrack)
  line((1.35, 0.05), (2.65, 0.05), ..arr-back)
  // C→B (backtrack)
  line((2.95, 0.35), (2.95, 1.65), ..arr-back)
  // B→A (backtrack)
  line((2.65, 1.95), (1.35, 1.95), ..arr-back)

  // ── Node circles ──────────────────────────────────────────────────────────
  circle((1,2), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((1,2), text(fill: col-text, weight: "bold", size: 9pt)[A], anchor: "center")

  circle((3,2), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((3,2), text(fill: col-text, weight: "bold", size: 9pt)[B], anchor: "center")

  circle((3,0), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((3,0), text(fill: col-text, weight: "bold", size: 9pt)[C], anchor: "center")

  circle((1,0), radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
  content((1,0), text(fill: col-text, weight: "bold", size: 9pt)[D], anchor: "center")

  // ── Token indicator (gold circle near A, step-order annotation) ───────────
  // Show token "currently at A" (start) as a small gold badge at A
  circle((0.55, 2.45), radius: 0.22, fill: col-token,
         stroke: (paint: rgb("#92400e"), thickness: 0.8pt))
  content((0.55, 2.45), text(fill: white, weight: "bold", size: 6pt)[τ], anchor: "center")

  // Step number labels along arrows
  content((2, 2.3), text(fill: col-dfs, size: 6.5pt)[①], anchor: "center")
  content((3.35, 1),  text(fill: col-dfs, size: 6.5pt)[②], anchor: "center")
  content((2, -0.3), text(fill: col-dfs, size: 6.5pt)[③], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────
  let lx = 3.7
  line((lx, 1.5),(lx+0.6, 1.5), ..arr-fwd)
  content((lx+0.65, 1.5), text(fill: col-text, size: 7pt)[arête DFS (avant)], anchor: "west")

  line((lx, 1.1),(lx+0.6, 1.1), ..arr-back)
  content((lx+0.65, 1.1), text(fill: col-text, size: 7pt)[retour arrière], anchor: "west")

  circle((lx+0.2, 0.7), radius: 0.18, fill: col-token,
         stroke: (paint: rgb("#92400e"), thickness: 0.7pt))
  content((lx+0.2, 0.7), text(fill: white, size: 6pt)[τ], anchor: "center")
  content((lx+0.65, 0.7), text(fill: col-text, size: 7pt)[jeton], anchor: "west")

  // ── Complexity ────────────────────────────────────────────────────────────
  content((2, -0.8), text(fill: col-text, size: 7.5pt)[Messages : $2|E|$ #h(1em) Temps : $O(|E|)$ (séquentiel)], anchor: "center")
})
