#import "@preview/cetz:0.4.2" as cetz
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let col-line    = luma(60)
  let col-event   = black
  let col-marker  = rgb("#7c3aed")   // violet – marker messages
  let col-rec     = rgb("#059669")   // green  – recording state
  let col-msg     = rgb("#1d4ed8")   // blue   – regular messages
  let col-chan    = rgb("#d97706")   // amber  – channel state messages

  // ── Timeline lines ────────────────────────────────────────────────────────────
  line((0, 0),    (9.0, 0),    stroke: (paint: col-line, thickness: 0.6pt))   // P1
  line((0, -2.2), (9.0, -2.2), stroke: (paint: col-line, thickness: 0.6pt))   // P2
  line((0, -4.4), (9.0, -4.4), stroke: (paint: col-line, thickness: 0.6pt))   // P3

  content((-0.15, 0),    [*P1*], anchor: "east")
  content((-0.15, -2.2), [*P2*], anchor: "east")
  content((-0.15, -4.4), [*P3*], anchor: "east")

  // ── Helper closures ───────────────────────────────────────────────────────────
  let ev(x, y) = {
    circle((x, y), radius: 0.12, fill: col-event, stroke: none)
  }
  let msg-arr(x1, y1, x2, y2, col) = {
    line((x1, y1), (x2, y2),
      mark: (end: "stealth", fill: col, scale: 0.45),
      stroke: (paint: col, thickness: 0.65pt))
  }
  let marker-arr(x1, y1, x2, y2) = {
    line((x1, y1), (x2, y2),
      mark: (end: "stealth", fill: col-marker, scale: 0.5),
      stroke: (paint: col-marker, thickness: 0.8pt))
  }
  let snap-line(x, y-top, y-bot) = {
    line((x, y-top), (x, y-bot),
      stroke: (paint: col-rec, thickness: 1.0pt, dash: "dashed"))
    circle((x, y-top), radius: 0.1, fill: col-rec, stroke: none)
    circle((x, y-bot), radius: 0.1, fill: col-rec, stroke: none)
  }

  // ══ Regular application messages (blue) ══════════════════════════════════════
  // P1 sends m1 to P2 at x=1.0 (before snapshot)
  ev(1.0, 0)
  msg-arr(1.0, 0, 2.0, -2.2, col-msg)
  content((1.3, -0.9), box(fill: white, inset: (x:2pt, y:1pt),
    text(size: 0.68em, fill: col-msg)[$m_1$]))

  // P2 receives m1 at x=2.0, produces event
  ev(2.0, -2.2)

  // P2 sends m2 to P3 at x=2.6 (before snapshot of P2)
  ev(2.6, -2.2)
  msg-arr(2.6, -2.2, 3.5, -4.4, col-chan)   // this will be channel state of c23
  content((2.9, -3.2), box(fill: white, inset: (x:2pt, y:1pt),
    text(size: 0.68em, fill: col-chan)[$m_2$]))

  // ══ P1 initiates snapshot at x=3.0 ═══════════════════════════════════════════
  // P1 records its state at x=3.0 (dashed green vertical on P1)
  snap-line(3.0, 0.45, -0.45)
  content((3.0, 0.62), text(size: 0.7em, fill: col-rec)[état local P1], anchor: "south")

  // P1 sends MARKER to P2 at x=3.0
  marker-arr(3.0, -0.02, 4.2, -2.18)
  content((3.4, -0.95), box(fill: rgb("#ede9fe"), inset: (x:2pt, y:1pt),
    stroke: (paint: col-marker, thickness: 0.4pt), radius: 1pt,
    text(size: 0.68em, fill: col-marker)[MARQUEUR]))

  // P1 sends MARKER to P3 at x=3.0
  marker-arr(3.0, -0.04, 5.5, -4.36)
  content((3.8, -2.6), box(fill: rgb("#ede9fe"), inset: (x:2pt, y:1pt),
    stroke: (paint: col-marker, thickness: 0.4pt), radius: 1pt,
    text(size: 0.68em, fill: col-marker)[MARQUEUR]))

  // ══ P2 receives MARKER at x=4.2 → records state ══════════════════════════════
  snap-line(4.2, -1.75, -2.65)
  content((4.2, -1.58), text(size: 0.7em, fill: col-rec)[état local P2], anchor: "south")

  // Channel state c12: messages received on c12 after P2 recorded state (none here)
  // The message m2 was sent before P2 recorded its state → channel c23 records m2

  // P3 receives m2 at x=3.5 (BEFORE P3 records state at x=5.5) → channel state!
  ev(3.5, -4.4)
  // label m2 received (this is BEFORE P3's marker arrives → P3 not yet recording)

  // P2 sends MARKER to P3 at x=4.2
  marker-arr(4.2, -2.22, 5.8, -4.38)
  content((4.8, -3.25), box(fill: rgb("#ede9fe"), inset: (x:2pt, y:1pt),
    stroke: (paint: col-marker, thickness: 0.4pt), radius: 1pt,
    text(size: 0.68em, fill: col-marker)[MARQUEUR]))

  // ══ P3 receives MARKER from P1 at x=5.5 → records state ══════════════════════
  snap-line(5.5, -3.95, -4.85)
  content((5.5, -3.78), text(size: 0.7em, fill: col-rec)[état local P3], anchor: "south")

  // P3 receives MARKER from P2 at x=5.8 → stops recording channel c23
  ev(5.8, -4.4)
  content((5.8, -4.72), text(size: 0.65em, fill: col-marker)[fin enreg. $c_(23)$],
    anchor: "north")

  // Channel state of c23: message m2 received between P3 recording and P2's marker arriving
  rect((3.5, -4.55), (5.8, -4.72),
    fill: rgb("#fef3c7"), stroke: (paint: col-chan, thickness: 0.5pt), radius: 0.04)
  content((4.65, -4.635), text(size: 0.62em, fill: col-chan)[état canal $c_(23)$ = {$m_2$}],
    anchor: "center")

  // ══ Late events after snapshots ═══════════════════════════════════════════════
  ev(6.5, 0)
  ev(7.0, -2.2)
  ev(7.5, -4.4)

  // ── Time arrow ────────────────────────────────────────────────────────────────
  line((0, -5.4), (8.8, -5.4),
    mark: (end: "stealth", fill: black, scale: 0.4),
    stroke: (paint: black, thickness: 0.5pt))
  content((4.4, -5.65), text(size: 0.8em)[temps], anchor: "north")

  // ── Legend ────────────────────────────────────────────────────────────────────
  let ly = -6.25
  line((0.5, ly), (1.1, ly),
    mark: (end: "stealth", fill: col-msg, scale: 0.4),
    stroke: (paint: col-msg, thickness: 0.65pt))
  content((1.2, ly), text(size: 0.72em)[ message applicatif], anchor: "west")

  line((3.8, ly), (4.4, ly),
    mark: (end: "stealth", fill: col-marker, scale: 0.4),
    stroke: (paint: col-marker, thickness: 0.8pt))
  content((4.5, ly), text(size: 0.72em)[ marqueur (snapshot)], anchor: "west")

  line((7.0, ly), (7.6, ly),
    stroke: (paint: col-rec, thickness: 1.0pt, dash: "dashed"))
  content((7.7, ly), text(size: 0.72em)[ enregistrement état local], anchor: "west")
})
