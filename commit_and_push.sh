#!/usr/bin/env bash
set -euo pipefail

# Commit message can be passed as first argument; otherwise use a default tailored
# to the most recent documentation tweaks.
# Usage: ./commit_and_push.sh ["your commit message"]
MSG="${1:-"Fix market rejection formula braces"}"

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

# Push to the current branch on origin (or its upstream if configured).
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
UPSTREAM="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)"
TARGET_REMOTE="origin"
TARGET_REF="${BRANCH}"
if [ -n "${UPSTREAM}" ]; then
  TARGET_REMOTE="${UPSTREAM%%/*}"
  TARGET_REF="${UPSTREAM#*/}"
fi

echo "== Pushing to ${TARGET_REMOTE}/${TARGET_REF} =="
git push "${TARGET_REMOTE}" "${BRANCH}:${TARGET_REF}"

echo "Done."
