#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-ring    = luma(80)
  let col-tok-w   = rgb("#fef08a")   // light yellow – white token
  let col-tok-b   = rgb("#374151")   // dark gray – black/tainted token
  let col-node    = rgb("#1d4ed8")   // blue – process nodes
  let col-ok      = rgb("#059669")   // green – termination
  let col-bad     = rgb("#dc2626")   // red – restart

  // ── Process positions (ring: P1 top, P2 bottom-left, P3 bottom-right) ─────────
  let p1 = (3.5, 3.0)
  let p2 = (1.2, 0.8)
  let p3 = (5.8, 0.8)

  // ── Ring arrows (clockwise: P1→P3, P3→P2, P2→P1) ─────────────────────────────
  let arr-ring = (
    mark: (end: "stealth", fill: col-ring, scale: 0.45),
    stroke: (paint: col-ring, thickness: 0.7pt),
  )
  // P1 → P3 (top to bottom-right)
  line((3.5 + 0.35, 3.0 - 0.2), (5.8 - 0.35, 0.8 + 0.2), ..arr-ring)
  // P3 → P2 (bottom-right to bottom-left)
  line((5.8 - 0.38, 0.8 - 0.05), (1.2 + 0.38, 0.8 - 0.05), ..arr-ring)
  // P2 → P1 (bottom-left to top)
  line((1.2 + 0.25, 0.8 + 0.25), (3.5 - 0.3, 3.0 - 0.2), ..arr-ring)

  // ── Process circles ───────────────────────────────────────────────────────────
  circle(p1, radius: 0.38, fill: rgb("#dbeafe"), stroke: (paint: col-node, thickness: 1pt))
  circle(p2, radius: 0.38, fill: rgb("#dbeafe"), stroke: (paint: col-node, thickness: 1pt))
  circle(p3, radius: 0.38, fill: rgb("#dbeafe"), stroke: (paint: col-node, thickness: 1pt))

  content(p1, [*P1*], anchor: "center")
  content(p2, [*P2*], anchor: "center")
  content(p3, [*P3*], anchor: "center")

  // ── "Initiateur" label under P1 ──────────────────────────────────────────────
  content((3.5, 3.55), text(size: 0.7em, fill: col-node)[initiateur], anchor: "south")

  // ═══════════════════════════════════════════════════════════════════════════════
  // LEFT panel: round with WHITE token (success path)
  // ═══════════════════════════════════════════════════════════════════════════════
  let lx = -0.2   // left panel x offset
  let ly = -1.5

  rect((lx - 0.05, ly + 0.4), (lx + 3.6, ly - 2.6),
    fill: rgb("#f0fdf4"), stroke: (paint: col-ok, thickness: 0.5pt), radius: 0.12)

  content((lx + 1.75, ly + 0.4), text(size: 0.75em, fill: col-ok)[*Cas 1 : jeton blanc*],
    anchor: "south")

  // Token steps (small circles with labels)
  let tok(x, y, col, lbl) = {
    circle((x, y), radius: 0.22,
      fill: col,
      stroke: (paint: luma(100), thickness: 0.5pt))
    content((x + 0.38, y), text(size: 0.68em)[#lbl], anchor: "west")
  }

  tok(lx + 0.4, ly - 0.2, col-tok-w, [P1 → P3])
  tok(lx + 0.4, ly - 0.9, col-tok-w, [P3 → P2])
  tok(lx + 0.4, ly - 1.6, col-tok-w, [P2 → P1])

  // small downward arrows between steps
  let mini = (
    mark: (end: "stealth", fill: col-ok, scale: 0.35),
    stroke: (paint: col-ok, thickness: 0.5pt),
  )
  line((lx + 0.4, ly - 0.43), (lx + 0.4, ly - 0.67), ..mini)
  line((lx + 0.4, ly - 1.13), (lx + 0.4, ly - 1.37), ..mini)

  // result box
  rect((lx + 0.05, ly - 1.95), (lx + 3.5, ly - 2.55),
    fill: col-ok, stroke: none, radius: 0.08)
  content((lx + 1.78, ly - 2.25),
    text(size: 0.75em, fill: white)[*Terminaison détectée !*], anchor: "center")

  // ═══════════════════════════════════════════════════════════════════════════════
  // RIGHT panel: round with BLACK token (tainted, restart)
  // ═══════════════════════════════════════════════════════════════════════════════
  let rx = 4.3
  let ry = -1.5

  rect((rx - 0.05, ry + 0.4), (rx + 3.6, ry - 2.6),
    fill: rgb("#fef2f2"), stroke: (paint: col-bad, thickness: 0.5pt), radius: 0.12)

  content((rx + 1.75, ry + 0.4), text(size: 0.75em, fill: col-bad)[*Cas 2 : jeton noirci*],
    anchor: "south")

  tok(rx + 0.4, ry - 0.2, col-tok-w, [P1 → P3 : blanc])

  // P3 tints the token black (sent messages since last hold)
  circle((rx + 0.4, ry - 0.9), radius: 0.22,
    fill: col-tok-b,
    stroke: (paint: luma(100), thickness: 0.5pt))
  content((rx + 0.78, ry - 0.9), text(size: 0.68em)[P3 noircit ! → P2], anchor: "west")

  tok(rx + 0.4, ry - 1.6, col-tok-b, [P2 → P1 : noir])

  line((rx + 0.4, ry - 0.43), (rx + 0.4, ry - 0.67), ..mini)
  line((rx + 0.4, ry - 1.13), (rx + 0.4, ry - 1.37), ..mini)

  // restart box
  rect((rx + 0.05, ry - 1.95), (rx + 3.5, ry - 2.55),
    fill: col-bad, stroke: none, radius: 0.08)
  content((rx + 1.78, ry - 2.25),
    text(size: 0.75em, fill: white)[*Rejet — nouveau tour blanc*], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────────
  let legy = -4.2
  circle((2.6, legy), radius: 0.18, fill: col-tok-w,
    stroke: (paint: luma(100), thickness: 0.5pt))
  content((2.85, legy), text(size: 0.73em)[ jeton blanc (inoffensif)], anchor: "west")
  circle((5.5, legy), radius: 0.18, fill: col-tok-b,
    stroke: (paint: luma(100), thickness: 0.5pt))
  content((5.75, legy), text(size: 0.73em)[ jeton noir (contaminé)], anchor: "west")
})
