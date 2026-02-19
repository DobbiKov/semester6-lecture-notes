#!/usr/local/bin
typst compile ode-prep-patiel/main.typ
typst compile stats/main.typ

mv ode-prep-patiel/main.pdf docs/ode-prep-partiel-td.pdf
mv stats/main.pdf docs/stats.pdf
