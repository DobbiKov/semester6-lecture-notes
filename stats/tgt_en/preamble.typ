// --- CHUNK_METADATA_START ---
// needs_review: True
// src_checksum: 4bb82f069f285a2def8427648ae741c843773a46349c48edffc80424cc1f1155
// --- CHUNK_METADATA_END ---
#import "@local/dobbikov:1.0.0": *

#let argmax = math.op("argmax", limits: true)
#let Bern = math.op("Bernoulli")
#let Exp = math.op("Exp")
#let Var = math.op("Var")

#set text(font: "New Computer Modern")
#set heading(numbering: "1.1.1.1.1")