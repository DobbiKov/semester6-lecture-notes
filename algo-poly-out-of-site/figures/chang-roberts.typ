#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ───────────────────────────────────────────────────────────────
  let col-fwd    = rgb("#1d4ed8")   // blue   – forwarded message
  let col-elim   = rgb("#dc2626")   // red    – eliminated
  let col-win    = rgb("#d97706")   // gold   – winner
  let col-node   = rgb("#374151")   // dark gray – ordinary node
  let col-stroke = rgb("#1e3a5f")
  let col-text   = rgb("#111827")

  // ── Pentagon layout: 5 processes, clockwise from top ─────────────────────
  // Angles (from top, clockwise): 90, 18, -54, -126, -198 degrees
  // converted to radians: 90° = π/2, step = -72° = -2π/5
  // Positions (centred at (4.5, 3.5), radius 2.6)
  let cx = 4.5
  let cy = 3.5
  let R  = 2.6
  let r  = 0.42

  import calc: cos, sin, pi
  let deg(a) = a * pi / 180.0

  // P1 at top (90°), going clockwise
  let p1 = (cx + R * cos(deg(90)),  cy + R * sin(deg(90)))   // id=3
  let p2 = (cx + R * cos(deg(18)),  cy + R * sin(deg(18)))   // id=5 (winner)
  let p3 = (cx + R * cos(deg(-54)), cy + R * sin(deg(-54)))  // id=1
  let p4 = (cx + R * cos(deg(-126)),cy + R * sin(deg(-126))) // id=4
  let p5 = (cx + R * cos(deg(-198)),cy + R * sin(deg(-198))) // id=2

  // IDs
  let ids = ("3", "5", "1", "4", "2")
  let positions = (p1, p2, p3, p4, p5)
  let names = ("P1", "P2", "P3", "P4", "P5")

  // ── Ring arrows (clockwise: P1→P2→P3→P4→P5→P1) ───────────────────────────
  // We draw slightly inside the node circumference
  let ring-arr = (
    mark: (end: "stealth", fill: col-node, scale: 0.42),
    stroke: (paint: col-node, thickness: 0.8pt),
  )

  // Helper to shorten a vector by 'rr' on each end
  let shorten(a, b, rr) = {
    let dx = b.at(0) - a.at(0)
    let dy = b.at(1) - a.at(1)
    let d  = calc.sqrt(dx*dx + dy*dy)
    let ux = dx / d
    let uy = dy / d
    ((a.at(0) + ux*rr, a.at(1) + uy*rr),
     (b.at(0) - ux*rr, b.at(1) - uy*rr))
  }

  let draw-ring-seg(a, b) = {
    let (s, e) = shorten(a, b, r + 0.04)
    line(s, e, ..ring-arr)
  }

  draw-ring-seg(p1, p2)
  draw-ring-seg(p2, p3)
  draw-ring-seg(p3, p4)
  draw-ring-seg(p4, p5)
  draw-ring-seg(p5, p1)

  // ══════════════════════════════════════════════════════════════════════════
  // Message flow annotations (simplified key interactions)
  // id=5 (P2) message travels all the way around: forwarded everywhere
  // id=3 (P1): forwarded to P2 (5>3), then dropped at P2
  // id=4 (P4): forwarded to P5 (2<4→fwd), then P5→P1 (3<4→fwd), then P1→P2 (5>4→dropped)
  // id=2 (P5): dropped immediately at P1 (3>2)
  // id=1 (P3): dropped immediately at P4 (4>1)

  // We annotate two illustrative messages with small labels on the segments
  let fwd-lbl(pos, txt) = {
    content(pos, box(fill: white, inset: (x:2pt, y:1pt),
      text(size: 0.6em, fill: col-fwd)[#txt]), anchor: "center")
  }
  let elim-x(pos) = {
    content(pos, text(size: 0.85em, fill: col-elim, weight: "bold")[✕], anchor: "center")
  }

  // id=5 forwarded on every segment (blue arrows labelled "5")
  fwd-lbl(((p2.at(0)+p3.at(0))/2, (p2.at(1)+p3.at(1))/2 + 0.22), "5→")
  fwd-lbl(((p3.at(0)+p4.at(0))/2 - 0.22, (p3.at(1)+p4.at(1))/2), "5→")
  fwd-lbl(((p4.at(0)+p5.at(0))/2 - 0.18, (p4.at(1)+p5.at(1))/2), "5→")
  fwd-lbl(((p5.at(0)+p1.at(0))/2 - 0.2, (p5.at(1)+p1.at(1))/2 + 0.1), "5→")
  // id=5 comes back to P2: ELECTED
  fwd-lbl(((p1.at(0)+p2.at(0))/2 + 0.25, (p1.at(1)+p2.at(1))/2 + 0.1), "5→★")

  // id=3 forwarded P1→P2, then eliminated
  fwd-lbl(((p1.at(0)+p2.at(0))/2 - 0.1, (p1.at(1)+p2.at(1))/2 - 0.22), "3→")
  elim-x(((p2.at(0)+p3.at(0))/2 + 0.3, (p2.at(1)+p3.at(1))/2 - 0.1))

  // id=1 eliminated immediately at P4
  elim-x(((p3.at(0)+p4.at(0))/2 + 0.2, (p3.at(1)+p4.at(1))/2 + 0.1))

  // ── Node circles ──────────────────────────────────────────────────────────
  // P2 (winner, id=5) in gold
  circle(p2, radius: r + 0.06, fill: col-win,
    stroke: (paint: rgb("#92400e"), thickness: 2pt))
  content(p2, text(fill: white, weight: "bold", size: 8.5pt)[P2\ id=5], anchor: "center")

  // Others
  let draw-node(pos, nm, id) = {
    circle(pos, radius: r, fill: col-node, stroke: (paint: col-stroke, thickness: 1pt))
    content(pos, text(fill: white, weight: "bold", size: 8pt)[#nm\ id=#id], anchor: "center")
  }
  draw-node(p1, "P1", "3")
  draw-node(p3, "P3", "1")
  draw-node(p4, "P4", "4")
  draw-node(p5, "P5", "2")

  // ── Crown symbol above P2 ─────────────────────────────────────────────────
  content((p2.at(0), p2.at(1) + r + 0.55),
    text(size: 1.1em)[♛], anchor: "center")

  // ── Legend ────────────────────────────────────────────────────────────────
  let lx = 0.2
  let ly = 0.4
  line((lx, ly), (lx+0.7, ly),
    mark: (end: "stealth", fill: col-fwd, scale: 0.4),
    stroke: (paint: col-fwd, thickness: 0.8pt))
  content((lx+0.8, ly), text(size: 0.65em)[message transféré], anchor: "west")

  content((lx, (ly - 0.45)), text(size: 0.7em, fill: col-elim, weight: "bold")[✕ #h(0.3em)],
    anchor: "west")
  content((lx+0.4, (ly - 0.45)), text(size: 0.65em)[message éliminé], anchor: "west")

  // ── Bottom label ─────────────────────────────────────────────────────────
  content((cx, -0.25), text(size: 0.76em, fill: col-text, weight: "bold")[
    Extinction sélective — le plus grand identifiant gagne (ici id=5, P2)
  ], anchor: "center")
})
