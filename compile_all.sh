#!/usr/local/bin
typst compile ode-prep-patiel/main.typ
typst compile stats/main.typ
pdflatex stats-cheatsheet/main.tex

rm -f docs/ode-prep-partiel-td.pdf docs/stats.pdf docs/stats-cheatsheet.pdf

cp ode-prep-patiel/main.pdf docs/ode-prep-partiel-td.pdf
cp stats/main.pdf docs/stats.pdf
cp stats-cheatsheet/main.pdf docs/stats-cheatsheet.pdf
