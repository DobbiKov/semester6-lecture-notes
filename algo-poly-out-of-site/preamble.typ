#import "@local/dobbikov:1.0.0": *
#import "@preview/cetz:0.4.2" as cetz

// Re-export cetz for figure files
#let canvas = cetz.canvas

// ── Arrow / drawing helpers shared by figure files ────────────────────────────
#let arr = (mark: (end: "stealth", fill: black, scale: 0.45), stroke: 0.55pt)
#let arr-red = (mark: (end: "stealth", fill: rgb("#dc2626"), scale: 0.45), stroke: (paint: rgb("#dc2626"), thickness: 0.55pt))
#let arr-blue = (mark: (end: "stealth", fill: rgb("#1d4ed8"), scale: 0.45), stroke: (paint: rgb("#1d4ed8"), thickness: 0.55pt))
#let arr-teal = (mark: (end: "stealth", fill: rgb("#0d9488"), scale: 0.45), stroke: (paint: rgb("#0d9488"), thickness: 0.55pt))

// ── Colour palette (matches the HTML source) ──────────────────────────────────
#let col-event   = black
#let col-causal  = rgb("#1d4ed8")    // blue   – causal chain
#let col-conc    = rgb("#0d9488")    // teal   – concurrent
#let col-ack     = rgb("#0d9488")    // teal   – ACK wave
#let col-token   = rgb("#d97706")    // amber  – token
#let col-cs      = rgb("#7c3aed")    // violet – critical section
#let col-byz     = rgb("#dc2626")    // red    – byzantine / wrong

// ── Heading numbering ─────────────────────────────────────────────────────────
#set heading(numbering: "1.1.1")
#set text(font: "New Computer Modern")
