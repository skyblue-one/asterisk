#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

git config core.hooksPath .githooks
chmod +x .githooks/commit-msg .githooks/pre-push

if ! command -v cz >/dev/null 2>&1; then
  python3 -m pip install --user 'commitizen>=4'
fi

echo "hooksPath=$(git config core.hooksPath)"
echo "use: cz commit"
