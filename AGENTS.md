# mtgkubbur.github.io

MtG Kubbur event website built with Quarto. This site publishes rankings, player views, head-to-head stats, and event information in Icelandic.

## Commands

```bash
quarto preview                 # Local preview server
quarto render                  # Build docs/
cd en && quarto preview        # Preview the English /en subsite
cd en && quarto render         # Build docs/en
./update_rankings.sh           # Re-run historical rankings and rebuild the site
./update_rankings.sh --skip-analysis
```

Set `GOOGLE_MAIL` before commands that depend on the `cube_rankings` pipeline.

## Architecture

`R/` and `results/` are symlinks to `../cube_rankings/`. All ranking and match-history data comes from that repo. The English site lives in `en/` as a separate Quarto subproject that renders to `docs/en`.

- Quarto config: `_quarto.yml`
- Styling: `theme.scss`, `theme-dark.scss`, `styles.css`
- Deploy target: GitHub Pages from `docs/`

Useful shared guidance lives in the repo-level Claude rules:

- `../.claude/rules/styling.md`: styling and reactable conventions
- `../.claude/rules/quarto-ojs.md`: Quarto Observable JS notes
- `../.claude/rules/data-privacy.md`: handling player data and exports

## Key Pages

- `index.qmd`: rankings table with podium treatment and latest snapshot date
- `throun.qmd`: player profile with summary cards, cube stats, and charts passed from R into OJS
- `einvigi.qmd`: head-to-head comparison between two players
- `kubbar.qmd`: cube catalogue and cube metadata
- `dagatal.qmd`: event calendar
- `methods.qmd`: methodology and ranking explanation
- `en/*.qmd`: English `/en/` pages for rankings, player profiles, head-to-head, cubes, and calendar

## Conventions

- All user-facing copy is in Icelandic
- English copy for the podcast-facing site lives under `en/`
- Preserve Icelandic locale sorting for names and labels
- Rebuild `cube_rankings/` first if the source data changed, then render this site
- Keep generated output in `docs/`; do not hand-edit rendered HTML

## Data Reference

- `results/*/player_summary.csv`: ranking snapshots used by the site
- `results/*/processed_data.rds`: match history and prepared analysis data
- Google Sheets remain the source of truth for event inputs, cube names, and opt-in status
