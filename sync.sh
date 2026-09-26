#!/usr/bin/env bash
#
# Refreshes this Pages site from the VertaPane extension source so the hosted
# privacy policy never diverges from the one shipped inside the extension.
#
# Usage: ./sync.sh [path-to-extension-source]
#        defaults to the parent directory

set -euo pipefail

cd "$(dirname "$0")"

SRC="${1:-..}"

if [[ ! -f "$SRC/privacy-policy.html" ]]; then
  echo "error: $SRC does not look like the VertaPane source (no privacy-policy.html)" >&2
  exit 1
fi

echo "==> Syncing from $SRC"
cp "$SRC/privacy-policy.html" index.html
cp "$SRC/privacy-policy.css" privacy-policy.css
cp "$SRC/localization.js" localization.js
mkdir -p icons
cp "$SRC/icons/icon-32.png" icons/icon-32.png

# The extension page links the policy as privacy-policy.html; on the site it is
# served as index.html. Nothing else needs rewriting because every other
# reference is already relative.
echo "  ok  index.html, privacy-policy.css, localization.js, icons/icon-32.png"

echo "==> Sanity checks"
if ! grep -q 'data-vertapane-surface' index.html; then
  echo "  FAIL: index.html lost data-vertapane-surface, EN switching will break" >&2
  exit 1
fi

if grep -nE '<script[^>]+src="https?:|<link[^>]+href="https?:' index.html; then
  echo "  FAIL: remote asset reference found (see lines above)" >&2
  exit 1
fi

node --check localization.js
echo "  ok  surface attribute present, no remote assets, localization.js parses"

echo
echo "Review with:  git diff"
echo "Publish with: git add -A && git commit -m 'Update privacy policy' && git push"
