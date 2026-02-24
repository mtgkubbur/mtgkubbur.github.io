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

Quarto config: `_quarto.yml` · Styling: `theme.scss` + `styles.css` · Deploy: GitHub Pages from `docs/`

## Pages

- **`index.qmd`** — Stigatafla (score table): interactive reactable with ELO rankings, date badge, top-3 podium highlighting
- **`throun.qmd`** — Leikmaður (player profile): player selector with summary card (ELO, rank, win rate, games, strongest cube type) + unified cube table showing per-category records (wins/losses/winrate) alongside gamma strength bars (red=negative, green=positive) + 5-chart dashboard (ELO full-width, rank + win rate, cube affinity over time + game count). R passes `combine_player_summaries()` data to OJS via `ojs_define()`; charts use Observable Plot. Gamma values are log-odds cube-type effects from the Bradley-Terry model.
- **`einvigi.qmd`** — Einvígi (head-to-head): two player selectors, shows win totals with percentage bar + per-cube breakdown table + ELO difference time series chart (green/red filled area split at y=0). Reads match data from Google Sheets (original cube names) and ELO history from `combine_player_summaries()`. OJS rendering logic looks up matches in both directions (p1→p2 and p2→p1) and inverts win counts for reverse matches.

## Conventions

- All text labels and UI are in **Icelandic**
- Icelandic locale sorting for player names
- MTG mana color system: blue (#0e68ab), green (#00733e), red (#d3202a), black (#150b00), white (#f9faf4), gold (#8b6914)
- Navbar and footer framed with blue (Islands) borders
- **Observable Plot version**: Quarto bundles Plot ~0.6.2 which lacks `Plot.clipY` and `Plot.differenceY`. Use `Math.max(0, val)`/`Math.min(0, val)` with two `areaY` marks as a workaround for split-color area charts.

## Available Data Assets (for future features)

### In player_summary.csv (historical snapshots)
- `score_median/q25/q75/lower/upper` — full posterior distribution
- `gamma_High/Low/Medium/Other` — cube-type affinity per player (used on Leikmaður page: strength bars + temporal chart)
- `wins/losses/total` — cumulative match stats

### In processed_data.rds
- Every match: `date, cube, player1, player2, winner, result`
- `cube` column contains power categories, not original names: **High** (Vintage, Bolti Vintage, Nerva's), **Medium** (Meta Memories, Modern Stories, Synergy, Bar), **Low** (Khans, Kaldheim, Old Border, Pauper, Ab Wheel, Horror Cube), **Other** (Boltalandið, Genesis, Stone Soup Cube, Super Turbo Time)
- Enables: per-category win rates, streaks, attendance
- For original cube names, read directly from Google Sheets (as Einvígi page does)

### Unused R functions (in cube_rankings/R/)
- `visualization.R` → `ranking_probability.png` heatmap (prob of each rank), `cube_effects.png`, `temporal_evolution.png`
- `n_players_historical.R` → attendance/games per night charts
- `timeseries_winrate.R` → rolling 4-session win rate
- `elo_table.R` → `deild` column (Deild 1/2/3 divisions) computed but hidden

### Google Sheets tabs
- `Players` sheet: `nickname`, `elo_table` opt-in
- `Cube calander` sheet: cube schedule by date (unused)

### Stan model outputs (never displayed)
- `halflife_present/absent` — weeks for 50% rating decay
- `phi_present/absent` — mean-reversion rates
