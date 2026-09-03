#!/usr/bin/env bash
# PreToolUse hook (Bash matcher): blocks `git push` and `git commit` that
# target/land on main/master directly.
set -u

cmd="$(jq -r '.tool_input.command // empty' 2>/dev/null)"
[ -z "$cmd" ] && exit 0

has_push=0
has_commit=0
echo "$cmd" | grep -qE '(^|[;&|]|[[:space:]])git[[:space:]]+push([[:space:]]|$)' && has_push=1
echo "$cmd" | grep -qE '(^|[;&|]|[[:space:]])git[[:space:]]+commit([[:space:]]|$)' && has_commit=1
[ "$has_push" -eq 0 ] && [ "$has_commit" -eq 0 ] && exit 0

blocked=0
reason=""

if [ "$has_push" -eq 1 ]; then
  # Explicit main/master named as a ref/refspec anywhere in the command,
  # e.g. "git push origin main", "git push origin HEAD:main", "git push origin main:main".
  if echo "$cmd" | grep -qE '(^|[/:[:space:]])(main|master)([:[:space:]]|$)'; then
    blocked=1
    reason="this git push targets (or would target) main/master"
  fi

  # Bare "git push" / "git push <remote>" with no explicit refspec — falls back
  # to the current branch, so check it.
  if [ "$blocked" -eq 0 ]; then
    if echo "$cmd" | grep -qE '(^|[;&|][[:space:]]*)git[[:space:]]+push([[:space:]]+[^[:space:];&|]+)?[[:space:]]*($|[;&|])'; then
      branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
      if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
        blocked=1
        reason="this git push targets (or would target) main/master"
      fi
    fi
  fi
fi

# Unlike push, commit takes no ref/remote argument to scan for "main" — the
# only thing that matters is the branch currently checked out.
if [ "$blocked" -eq 0 ] && [ "$has_commit" -eq 1 ]; then
  branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
    blocked=1
    reason="this git commit would be made directly on main/master"
  fi
fi

if [ "$blocked" -eq 1 ]; then
  msg="Blocked by block-main-push.sh: ${reason}. Create/switch to a feature branch first (e.g. git checkout -b <name>) and open a PR instead. Edit or remove ~/.claude/hooks/block-main-push.sh if this was a false positive."
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$msg"
fi

exit 0
