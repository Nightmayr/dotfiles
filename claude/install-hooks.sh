#!/usr/bin/env bash
# Idempotent installer for this repo's claude/hooks/*.sh files.
#
# On every run, for each claude/hooks/*.sh script:
#   1. Symlinks it into ~/.claude/hooks/<name> (matching how the rest of
#      this repo's dotfiles get deployed — see roles/dotfiles in
#      umayr-ansible, or run this script by hand on any machine).
#   2. Registers it in ~/.claude/settings.json under
#      hooks.PreToolUse[matcher="Bash"].hooks, creating that structure if
#      missing. Every other key in settings.json (model, theme, autoMode,
#      etc.) is left untouched — only hooks.PreToolUse is read/written, and
#      only entries whose "command" isn't already present get appended, so
#      re-running this never duplicates an entry.
#
# Requires jq (also a runtime dependency of the hooks themselves).
#
# Output contract (relied on by umayr-ansible's roles/dotfiles): the final
# line is always exactly "changed=true" or "changed=false" — callers should
# key off that line, not the human-readable message before it.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
hooks_src_dir="$repo_dir/hooks"
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
hooks_dest_dir="$claude_dir/hooks"
settings_file="$claude_dir/settings.json"

if ! command -v jq >/dev/null 2>&1; then
  echo "install-hooks.sh: jq is required but not found on PATH" >&2
  exit 1
fi

changed=0
mkdir -p "$hooks_dest_dir"

commands=()
for script in "$hooks_src_dir"/*.sh; do
  [ -e "$script" ] || continue
  name="$(basename "$script")"
  dest="$hooks_dest_dir/$name"
  before="$(readlink "$dest" 2>/dev/null || true)"
  # Replace a plain (non-symlink) file at dest, if any, so a fresh machine
  # that already has a hand-copied version of this script converges onto
  # the dotfiles-managed symlink instead of erroring on `ln`.
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    rm -f "$dest"
  fi
  ln -sfn "$script" "$dest"
  [ "$before" != "$script" ] && changed=1
  commands+=("~/.claude/hooks/$name")
done

[ -f "$settings_file" ] || { echo '{}' > "$settings_file"; changed=1; }

if [ "${#commands[@]}" -gt 0 ]; then
  new_hooks_json="$(printf '%s\n' "${commands[@]}" | jq -R '{"type":"command","command":.}' | jq -s '.')"
  before_content="$(cat "$settings_file")"
  tmp="$(mktemp)"
  jq --argjson new "$new_hooks_json" '
    .hooks = (.hooks // {})
    | .hooks.PreToolUse = (.hooks.PreToolUse // [])
    | ( .hooks.PreToolUse | map(.matcher) | index("Bash") ) as $i
    | if $i == null then
        .hooks.PreToolUse += [{"matcher":"Bash","hooks":$new}]
      else
        .hooks.PreToolUse[$i].hooks = (.hooks.PreToolUse[$i].hooks + ($new - .hooks.PreToolUse[$i].hooks))
      end
  ' "$settings_file" > "$tmp"
  mv "$tmp" "$settings_file"
  [ "$before_content" != "$(cat "$settings_file")" ] && changed=1
fi

if [ "$changed" -eq 1 ]; then
  echo "install-hooks: settings.json updated"
  echo "changed=true"
else
  echo "install-hooks: no changes needed"
  echo "changed=false"
fi
