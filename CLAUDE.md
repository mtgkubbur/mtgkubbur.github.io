# mtgkubbur.github.io

MtG Kubbur event website — Quarto site with interactive ELO rankings and player dashboards.

## Commands

```bash
quarto preview          # Local dev server
quarto render           # Build to docs/
./update_rankings.sh    # Re-run cube_rankings pipeline and rebuild site
```

Requires `GOOGLE_MAIL` environment variable (for Google Sheets auth via cube_rankings).

## Architecture

`R/` and `results/` are **symlinks** to `../cube_rankings/` — this site depends on the cube_rankings pipeline for all player data.

Quarto config: `_quarto.yml` · Styling: `theme.scss` + `theme-dark.scss` + `styles.css` · Deploy: GitHub Pages from `docs/`

## Pages

- **`index.qmd`** — Stigatafla (score table): interactive reactable with ELO rankings, date badge, top-3 podium highlighting
- **`throun.qmd`** — Leikmaður (player profile): player selector with summary card + cube table + 5-chart dashboard. R passes data to OJS via `ojs_define()`.
- **`einvigi.qmd`** — Einvígi (head-to-head): two player selectors, win totals + per-cube breakdown + ELO difference time series chart.

## Conventions

- All text labels and UI are in **Icelandic**
- Icelandic locale sorting for player names
- MTG mana color system: blue (#0e68ab), green (#00733e), red (#d3202a), black (#150b00), white (#f9faf4), gold (#8b6914)
- Navbar and footer framed with blue (Islands) borders

## Styling Rules

- **Dark/light mode**: `theme.scss` (light) + `theme-dark.scss` (dark) + `styles.css` (component overrides). Use `.quarto-dark` prefix for dark-mode CSS selectors.
- **Never set colors as inline styles in R** `reactable`/`colDef`. Use CSS classes and handle light/dark mode in `styles.css`.
- See `elo_table.R` for the reactable rendering pattern — styling belongs in CSS, not in R code.

## Data Reference

See `Available Data Assets` section in git history or ask for a summary. Key data flows: `processed_data.rds` (match history), `player_summary.csv` (ELO snapshots), Google Sheets (original cube names, player opt-in).
