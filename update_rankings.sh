#!/bin/bash
# Update ELO rankings and rebuild website
# Usage: ./update_rankings.sh [--skip-analysis]

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CUBE_RANKINGS_DIR="$SCRIPT_DIR/../cube_rankings"

echo "=== Updating ELO Rankings ==="

# Step 1: Run analysis pipeline (unless --skip-analysis flag)
if [[ "$1" != "--skip-analysis" ]]; then
  echo "Step 1: Running analysis pipeline..."
  cd "$CUBE_RANKINGS_DIR"
  Rscript run_analysis.R
  echo ""
else
  echo "Step 1: Skipped (--skip-analysis flag)"
fi

# Step 2: Render site
echo "Step 2: Rendering site..."
cd "$SCRIPT_DIR"
quarto render

echo ""
echo "=== Done! ==="
echo "Site updated in docs/"
echo ""
echo "To deploy, run:"
echo "  git add docs/"
echo "  git commit -m 'Update rankings'"
echo "  git push"
