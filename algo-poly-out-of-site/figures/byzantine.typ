#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-honest  = rgb("#1d4ed8")   // blue  – honest nodes
  let col-byz     = rgb("#dc2626")   // red   – byzantine node
  let col-msg1    = rgb("#1d4ed8")   // blue  – message "1" (honest)
  let col-msg0    = rgb("#dc2626")   // red   – message "0" (lie)
  let col-edge    = luma(170)        // light gray – background edges
  let col-ok      = rgb("#059669")   // green – agree

  // ── Node positions: A(0,2), B(4,2), D(0,0), C(4,0) ──────────────────────────
  let nA = (0.5, 3.5)
  let nB = (5.5, 3.5)
  let nD = (0.5, 1.0)
  let nC = (5.5, 1.0)

  // ── Background edges (complete graph, light) ──────────────────────────────────
  let edge(p1, p2) = {
    line(p1, p2, stroke: (paint: col-edge, thickness: 0.5pt))
  }
  edge(nA, nB)
  edge(nA, nD)
  edge(nA, nC)
  edge(nB, nD)
  edge(nB, nC)
  edge(nD, nC)

  // ── Honest node circles (blue border) ────────────────────────────────────────
  let honest-node(pos, lbl, val) = {
    circle(pos, radius: 0.48,
      fill: rgb("#dbeafe"),
      stroke: (paint: col-honest, thickness: 1.2pt))
    content(pos, [
      #set text(size: 0.78em, fill: col-honest)
      *#lbl*#linebreak()#text(size: 0.65em)[$v=#val$]
    ], anchor: "center")
  }

  honest-node(nA, "A", "1")
  honest-node(nB, "B", "1")
  honest-node(nD, "D", "1")

  // ── Byzantine node C (red border, red fill) ───────────────────────────────────
  circle(nC, radius: 0.48,
    fill: rgb("#fee2e2"),
    stroke: (paint: col-byz, thickness: 2pt))
  content(nC, [
    #set text(size: 0.78em, fill: col-byz)
    *C*#linebreak()#text(size: 0.65em)[BYZANTIN]
  ], anchor: "center")

  // ── C sends "1" to A and B (blue arrows) ─────────────────────────────────────
  let arr1 = (
    mark: (end: "stealth", fill: col-msg1, scale: 0.45),
    stroke: (paint: col-msg1, thickness: 0.8pt),
  )
  // C → A
  line((5.08, 1.32), (0.92, 3.18), ..arr1)
  content((2.7, 2.55), box(
    fill: white, inset: (x: 3pt, y: 1pt),
    stroke: (paint: col-msg1, thickness: 0.4pt), radius: 1pt,
    text(size: 0.75em, fill: col-msg1)[*"1"*],
  ))

  // C → B
  line((5.02, 1.48), (5.5, 3.02), ..arr1)
  content((5.85, 2.25), box(
    fill: white, inset: (x: 3pt, y: 1pt),
    stroke: (paint: col-msg1, thickness: 0.4pt), radius: 1pt,
    text(size: 0.75em, fill: col-msg1)[*"1"*],
  ))

  // ── C sends "0" to D (red arrow — the lie) ───────────────────────────────────
  let arr0 = (
    mark: (end: "stealth", fill: col-byz, scale: 0.5),
    stroke: (paint: col-byz, thickness: 0.9pt),
  )
  // C → D
  line((5.02, 1.02), (0.98, 1.0), ..arr0)
  content((3.0, 1.22), box(
    fill: white, inset: (x: 3pt, y: 1pt),
    stroke: (paint: col-byz, thickness: 0.5pt), radius: 1pt,
    text(size: 0.75em, fill: col-byz)[*"0"* — mensonge !],
  ))

  // ── Received vectors annotation ───────────────────────────────────────────────
  // A: sees [A=1, B=1, C=1, D=1] → majority = 1
  content((-0.15, 4.2), box(
    fill: rgb("#eff6ff"), inset: (x: 4pt, y: 3pt),
    stroke: (paint: col-honest, thickness: 0.4pt), radius: 2pt,
    text(size: 0.68em)[A reçoit: {1,1,1} → décide *1*],
  ), anchor: "east")

  // B: sees [A=1, B=1, C=1, D=1] → majority = 1
  content((6.15, 4.2), box(
    fill: rgb("#eff6ff"), inset: (x: 4pt, y: 3pt),
    stroke: (paint: col-honest, thickness: 0.4pt), radius: 2pt,
    text(size: 0.68em)[B reçoit: {1,1,1} → décide *1*],
  ), anchor: "west")

  // D: sees [A=1, B=1, C=0, D=1] → majority = 1 but C said 0
  content((-0.15, 0.35), box(
    fill: rgb("#fef2f2"), inset: (x: 4pt, y: 3pt),
    stroke: (paint: col-byz, thickness: 0.4pt), radius: 2pt,
    text(size: 0.68em)[D reçoit: {1,1,0} → décide *?*],
  ), anchor: "east")

  // ── DÉSACCORD label ───────────────────────────────────────────────────────────
  rect((0.8, -0.25), (6.2, -0.92),
    fill: rgb("#fef2f2"),
    stroke: (paint: col-byz, thickness: 0.6pt), radius: 0.1)
  content((3.5, -0.58), [
    #set text(size: 0.76em, fill: col-byz)
    *A, B décident 1 ;  D décide 0  →  DÉSACCORD avec vote naïf*
  ], anchor: "center")

  // ── n ≥ 3f+1 label ───────────────────────────────────────────────────────────
  content((3.0, -1.4), [
    #set text(size: 0.8em)
    Condition nécessaire et suffisante : $n gt.eq 3f+1$
    #h(0.5em) (ici $n=4, f=1$ : 4 ≥ 3×1+1=4 ✓, mais protocole en 1 tour insuffisant)
  ], anchor: "north")
})
