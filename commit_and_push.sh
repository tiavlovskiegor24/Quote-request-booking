#!/usr/bin/env bash
set -euo pipefail

# Commit message can be passed as first argument; otherwise use a default.
MSG="${1:-"Update docs formatting and math rendering"}"

# Show status for awareness.
echo "== Git status =="
git status --short

# Stage all tracked/untracked changes in the repo root.
git add -A

# Commit if there is something to commit.
if git diff --cached --quiet; then
  echo "No staged changes; nothing to commit."
  exit 0
fi

echo "== Committing =="
git commit -m "${MSG}"

# Push to the current branch on origin.
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "== Pushing to origin/${BRANCH} =="
git push origin "${BRANCH}"

echo "Done."
