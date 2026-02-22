#!/usr/local/bin
typst compile ode-prep-patiel/main.typ
typst compile stats/main.typ
pdflatex stats-cheatsheet/main.tex

mv ode-prep-patiel/main.pdf docs/ode-prep-partiel-td.pdf
mv stats/main.pdf docs/stats.pdf
mv stats-cheatsheet/main.pdf docs/stats-cheatsheet.pdf
