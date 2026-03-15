# mtgkubbur.github.io

MtG Kubbur event website — Quarto site with interactive ELO rankings and player dashboards.

## Commands

```bash
quarto preview          # Local dev server (Icelandic site only)
quarto render           # Build both IS + EN sites to docs/ (post-render hook renders en/)
quarto render en        # Build English site only to docs/en/
./update_rankings.sh    # Re-run cube_rankings pipeline and rebuild site
```

Requires `GOOGLE_MAIL` environment variable (for Google Sheets auth via cube_rankings).

## Architecture

`R/` and `results/` are **symlinks** to `../cube_rankings/` — this site depends on the cube_rankings pipeline for all player data.

Quarto config: `_quarto.yml` · Styling: `theme.scss` + `theme-dark.scss` + `styles.css` · Deploy: GitHub Pages from `docs/`

### Multilingual setup

The English site lives in `en/` as a separate Quarto project (`en/_quarto.yml`) outputting to `docs/en/`. The main `_quarto.yml` has a `post-render` hook that automatically renders the English site after the Icelandic site. This ensures `quarto render` builds both languages in one command without the main site's output clean deleting `docs/en/`.

## Pages (Icelandic — root)

- **`index.qmd`** — Stigatafla (score table): interactive reactable with ELO rankings, date badge, top-3 podium highlighting
- **`throun.qmd`** — Leikmaður (player profile): player selector with summary card + cube table + 5-chart dashboard. R passes data to OJS via `ojs_define()`.
- **`einvigi.qmd`** — Einvígi (head-to-head): two player selectors, win totals + per-cube breakdown + ELO difference time series chart.
- **`kubbar.qmd`** — Kubbar (cubes): per-cube stats, trophies, and event history.
- **`dagatal.qmd`** — Dagatal (calendar): upcoming and past cube draft events.

## Pages (English — `en/`)

- **`en/index.qmd`** — Rankings
- **`en/player.qmd`** — Player profile
- **`en/head-to-head.qmd`** — Head-to-head
- **`en/cubes.qmd`** — Cubes
- **`en/calendar.qmd`** — Calendar

## Conventions

- All text labels and UI are in **Icelandic**
- Icelandic locale sorting for player names
- Navbar and footer framed with blue (Islands) borders
- Styling rules (dark/light mode, MTG colours, reactable patterns) are in `.claude/rules/styling.md`

## Data Reference

See `Available Data Assets` section in git history or ask for a summary. Key data flows: `processed_data.rds` (match history), `player_summary.csv` (ELO snapshots), Google Sheets (original cube names, player opt-in).
