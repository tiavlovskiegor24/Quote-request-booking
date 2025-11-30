# Quote Request Booking — Order-Theoretic Notes

This repo contains a single write-up in both Markdown and LaTeX form that rephrases container-shipping quote acceptance/rejection in terms of total orders and quantile embeddings, plus supporting figures in `figures/`.

## Contents
- `booking_probability.md` — main Markdown document explaining market and carrier quantile mappings, feasibility relations, rejection/booking curves, and SSR context.
- `booking_probability.tex` — LaTeX export of the same content (kept in sync with the Markdown).
- `figures/` — diagrams for market feasibility, carrier subset embedding, carrier feasibility, and willingness-to-pay geometry.

## How to view
- Open `booking_probability.md` directly in your editor or render it in any Markdown viewer.
- Or compile `booking_probability.tex` with your LaTeX toolchain (e.g., `pdflatex booking_probability.tex`) to produce a PDF.

## Editing tips
- Keep formulas in quantile coordinates after section 4.
- Reference figures with relative paths (e.g., `figures/market_feasibility_relation.jpg`).

## TODO
1. Relate the expected rejection probability to survival analysis.
2. Finish off the statistical estimation of the booking curve (current section 9).
3. Future post on fixed points of carrier rejection curves.
4. Use Lawvere’s fixed-point theorem to show that total orders are isomorphic to their duals (i.e., dual maps form a basis for monotone functions $Q \to \mathbf{Bool}$); explore whether an analogue holds for all monotone functions $Q \to [0,1]$.
