// --- CHUNK_METADATA_START ---
// src_checksum: c73d14cc0aa534d91fae3bc97d1900fa738cf14d91bb50b82379fecf8a22a4e5
// needs_review: True
// --- CHUNK_METADATA_END ---
#import "@local/dobbikov:1.0.0": *
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.3": plot

#let argmax = math.op("argmax", limits: true)
#let Bern = math.op("Bernoulli")
#let Exp = math.op("Exp")
#let Var = math.op("Var")

#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.1.1.1")