#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ── Colours ───────────────────────────────────────────────────────────────
  let col-byz    = rgb("#dc2626")   // red    – Byzantine
  let col-omit   = rgb("#ea580c")   // orange – Omission
  let col-crash  = rgb("#1d4ed8")   // blue   – Crash
  let col-text   = rgb("#111827")
  let col-note   = rgb("#374151")

  // ── Nested rectangles (centred layout) ────────────────────────────────────
  // Outer (Byzantine): x ∈ [0.3, 9.7], y ∈ [0.3, 5.7]
  rect((0.3, 0.3), (9.7, 5.7),
    fill: rgb("#fff1f2"),
    stroke: (paint: col-byz, thickness: 2pt),
    radius: 0.25)

  // Middle (Omission): x ∈ [1.1, 8.9], y ∈ [0.9, 4.8]
  rect((1.1, 0.9), (8.9, 4.8),
    fill: rgb("#fff7ed"),
    stroke: (paint: col-omit, thickness: 2pt),
    radius: 0.2)

  // Inner (Crash): x ∈ [2.0, 8.0], y ∈ [1.5, 3.9]
  rect((2.0, 1.5), (8.0, 3.9),
    fill: rgb("#eff6ff"),
    stroke: (paint: col-crash, thickness: 2pt),
    radius: 0.18)

  // ── Labels inside each region ─────────────────────────────────────────────

  // Crash (inner)
  content((5.0, 2.7), text(size: 0.85em, fill: col-crash, weight: "bold")[
    Crash (arrêt franc)
  ], anchor: "center")
  content((5.0, 2.25), text(size: 0.72em, fill: col-crash)[
    Le processus s'arrête définitivement.\ Absence de message détectable.
  ], anchor: "center")

  // Omission (between inner and middle)
  content((5.0, 4.35), text(size: 0.82em, fill: col-omit, weight: "bold")[
    Omission
  ], anchor: "center")
  content((5.0, 4.0), text(size: 0.7em, fill: col-omit)[
    Perd ou ignore certains messages.
  ], anchor: "center")

  // Byzantine (outer strip)
  content((5.0, 5.3), text(size: 0.82em, fill: col-byz, weight: "bold")[
    Byzantin (arbitraire)
  ], anchor: "center")
  content((5.0, 4.95), text(size: 0.7em, fill: col-byz)[
    Comportement quelconque : mensonges, collusion…
  ], anchor: "center")

  // ── Inclusion chain ───────────────────────────────────────────────────────
  content((5.0, 0.0), text(size: 0.75em, fill: col-note, weight: "bold")[
    Crash $subset$ Omission $subset$ Byzantin
  ], anchor: "center")

  // ── Tolerance thresholds (right side) ────────────────────────────────────
  rect((10.1, 2.8), (13.9, 5.7),
    fill: rgb("#f0fdf4"),
    stroke: (paint: rgb("#16a34a"), thickness: 0.8pt),
    radius: 0.15)
  content((12.0, 5.35), text(size: 0.75em, fill: rgb("#15803d"), weight: "bold")[
    Seuils de tolérance
  ], anchor: "center")
  content((12.0, 4.85), text(size: 0.72em, fill: col-text)[
    $f$ fautes crash :
  ], anchor: "center")
  content((12.0, 4.45), text(size: 0.75em, fill: col-crash, weight: "bold")[
    $n >= 2f+1$
  ], anchor: "center")
  content((12.0, 3.95), text(size: 0.72em, fill: col-text)[
    $f$ fautes byzantines :
  ], anchor: "center")
  content((12.0, 3.55), text(size: 0.75em, fill: col-byz, weight: "bold")[
    $n >= 3f+1$
  ], anchor: "center")
  content((12.0, 3.05), text(size: 0.67em, fill: col-note, style: "italic")[
    (tolérer 1 faute byzantine\ requiert $n >= 4$ processus)
  ], anchor: "center")
})
