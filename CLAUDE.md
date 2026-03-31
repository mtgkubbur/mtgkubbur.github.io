# mtgkubbur.github.io

MtG Kubbur event website — Quarto site with interactive ELO rankings and player dashboards.

## Commands

```bash
quarto preview                        # Local dev server (Icelandic site only)
quarto render                         # Build both IS + EN sites to docs/ (post-render hook renders en/)
quarto render en                      # Build English site only to docs/en/
./update_rankings.sh                  # Re-run cube_rankings pipeline and rebuild site
./update_rankings.sh --skip-analysis  # Rebuild site without re-running the pipeline
```

Requires `GOOGLE_MAIL` environment variable (for Google Sheets auth via cube_rankings).

## Architecture

`R/` and `results/` are **symlinks** to `../cube_rankings/` — this site depends on the cube_rankings pipeline for all player data. Rebuild `cube_rankings/` first if the source data changed, then render this site.

- Quarto config: `_quarto.yml`
- Styling: `theme.scss` + `theme-dark.scss` + `styles.css`
- Deploy: GitHub Pages from `docs/`

### Multilingual setup

The English site lives in `en/` as a separate Quarto project (`en/_quarto.yml`) outputting to `docs/en/`. The main `_quarto.yml` has a `post-render` hook that automatically renders the English site after the Icelandic site. This ensures `quarto render` builds both languages in one command without the main site's output clean deleting `docs/en/`.

### Shared rules

Useful shared guidance lives in the repo-level Claude rules:

- `../.claude/rules/styling.md` — dark/light mode, Reactable styling, MTG colour palette
- `../.claude/rules/quarto-ojs.md` — Observable Plot version constraints, OJS cell patterns
- `../.claude/rules/data-privacy.md` — player opt-in requirement for all published data

## Key Pages

- **`index.qmd`** — Stigatafla (score table): interactive reactable with ELO rankings, date badge, top-3 podium highlighting
- **`throun.qmd`** — Leikmaður (player profile): player selector with summary card + cube table + 5-chart dashboard. R passes data to OJS via `ojs_define()`.
- **`einvigi.qmd`** — Einvígi (head-to-head): two player selectors, win totals + per-cube breakdown + ELO difference time series chart.
- **`kubbar.qmd`** — Kubbar (cubes): per-cube stats, trophies, and event history.
- **`dagatal.qmd`** — Dagatal (calendar): upcoming and past cube draft events.
- **`methods.qmd`** — Aðferðafræði (methodology): ranking explanation and model description.
- **`en/*.qmd`** — English pages for rankings, player profiles, head-to-head, cubes, and calendar.

## Conventions

- All user-facing copy is in **Icelandic**; English copy for the podcast-facing site lives under `en/`
- Icelandic locale sorting for player names
- Navbar and footer framed with blue (Islands) borders
- Keep generated output in `docs/`; do not hand-edit rendered HTML

## Data Reference

- `results/*/player_summary.csv` — ranking snapshots used by the site
- `results/*/processed_data.rds` — match history and prepared analysis data
- Google Sheets remain the source of truth for event inputs, cube names, and opt-in status
