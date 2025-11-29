#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./commit_and_push.sh ["commit message"] [files...]
# If no files are given, booking_probability.md and commit_and_push.sh are staged.
# If no message is given, a default is used.

MSG="Fix section image paths for split docs"
if [[ $# -ge 1 ]]; then
  MSG="$1"
fi

# Determine targets to stage
if [[ $# -ge 2 ]]; then
  shift
  TARGETS=("$@")
else
  TARGETS=("booking_probability.md" "commit_and_push.sh")
fi

echo "== Git status =="
git status --short

echo "== Staging: ${TARGETS[*]} =="
git add "${TARGETS[@]}"

# Commit only if there are staged changes
if git diff --cached --quiet; then
  echo "No staged changes; nothing to commit."
  exit 0
fi

echo "== Committing =="
git commit -m "$MSG"

# Push to upstream if set, otherwise to origin/current branch
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
UPSTREAM="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || true)"
REMOTE="origin"
REF="$BRANCH"
if [[ -n "$UPSTREAM" ]]; then
  REMOTE="${UPSTREAM%%/*}"
  REF="${UPSTREAM#*/}"
fi

echo "== Pushing to ${REMOTE}/${REF} =="
git push "$REMOTE" "$BRANCH:$REF"

echo "Done."
