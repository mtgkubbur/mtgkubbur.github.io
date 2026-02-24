# MtG Kubbur — Desktop-First Visual Improvements

Status tracking for aesthetic improvements focused on full-width viewport experience.

## 1. Widen Content & Use Full Viewport
**Impact:** High | **Effort:** Small

The site caps at 1100px `max-width`, leaving ~170px dead space per side at 1440px.

- Bump `max-width` to 1300px for main content
- Let the ELO chart on player profile span full container width
- Give the leaderboard table more breathing room between columns

## 2. Two-Panel Sidebar Layout for Player Profile
**Impact:** High | **Effort:** Medium

On Leikmaður, everything stacks vertically — selector, summary, cube table, ELO chart, 4 small charts. On wide screens this means endless scrolling.

- Left sidebar (~320px): player selector, summary stat cards, cube breakdown
- Right main area: full-width ELO chart, 2x2 smaller charts below
- Standard dashboard pattern (Grafana, Stripe) — identity + trends visible simultaneously

## 3. Hero Headers on All Pages
**Impact:** Medium | **Effort:** Small

Stigatafla has a small floating title; Leikmaður and Einvígi have no header at all.

- Taller header section (~100-120px) with larger title, subtitle, date badge
- Subtle warm background tint or thin MTG-themed decorative border
- Apply consistently across all three pages

## 4. Table Visual Enrichment (Leaderboard)
**Impact:** Medium | **Effort:** Small-Medium

Win-rate column is plain text next to tiny dashes. No visual distinction for top players.

- Wider win-rate progress bars (green fill proportional to %)
- Top-3 podium treatment: subtle gold/silver/bronze left-border accent
- More generous column spacing with the wider layout

## 5. Active Nav Indicator & Nav Polish
**Impact:** Low-Medium | **Effort:** Small

No visual indication of current page in the navbar. Text feels small for wide viewports.

- 2-3px colored bottom border on the active page link
- Slightly more spacing between nav links

## 6. Chart Height & Width Consistency
**Impact:** Medium | **Effort:** Small

The 2x2 chart grid uses small, cramped charts (~300px wide, variable height). Fixed pixel widths don't scale with viewport.

- Charts use `width: 100%` of container instead of fixed pixels
- Consistent chart heights (280px small charts, 350px main ELO chart)
- Remove hardcoded pixel widths from OJS Plot calls

## 7. Head-to-Head Horizontal Layout
**Impact:** Medium | **Effort:** Small

Two dropdowns stack vertically, wasting wide viewport. Stats and chart also stack.

- Horizontal selector row: `[Player 1] ⚔ [Player 2]` on one line
- H2H stats card + ELO difference chart side-by-side at desktop widths
