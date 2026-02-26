# AGENTS.md

Lean, local instructions for coding agents in `mtgkubbur.github.io/`.

## Read Order

1. This file.
2. Local `CLAUDE.md`.
3. `../AGENTS.md` and `../CLAUDE.md`.
4. `../.claude/rules/*.md` (canonical, path-scoped).

## Must-Keep Constraints

- UI text and labels stay Icelandic.
- `R/` and `results/` are symlinks to `../cube_rankings/`.
- Public player-facing outputs must include only opted-in players (`elo_table == TRUE`).
- Site build output is `docs/`.

## Build Order

- If rankings/data changed, run `cube_rankings/` first, then `quarto render` here.
