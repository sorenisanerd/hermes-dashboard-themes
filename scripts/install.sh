#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://raw.githubusercontent.com/sorenisanerd/hermes-dashboard-themes/main}"
THEME_DIR="${HOME}/.hermes/dashboard-themes"
DEFAULT_THEME="${1:-boring-dark}"

case "$DEFAULT_THEME" in
  boring-dark|boring-light) ;;
  *)
    echo "Usage: $0 [boring-dark|boring-light]" >&2
    exit 1
    ;;
esac

mkdir -p "$THEME_DIR"

for theme in boring-dark boring-light; do
  curl -fsSL "$REPO_URL/themes/${theme}.yaml" -o "$THEME_DIR/${theme}.yaml"
done

if command -v hermes >/dev/null 2>&1; then
  hermes config set display.dashboard_theme "$DEFAULT_THEME"
  echo "Installed themes and set default to: $DEFAULT_THEME"
  echo "Open the dashboard theme switcher to toggle between them."
else
  echo "Installed themes to $THEME_DIR"
  echo "Hermes CLI not found on PATH, so the default theme was not changed."
  echo "If you want, run: hermes config set display.dashboard_theme $DEFAULT_THEME"
fi
