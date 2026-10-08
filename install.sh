#!/usr/bin/env bash
# Install the Aura skills into the skill folders of your AI coding tools.
#
# Usage:
#   ./install.sh [--project <dir> | --user] [--tool <name>]... [--profile] [--force] [--dry-run]
#
#   --project <dir>  Install into a repository (default: current directory).
#   --user           Install for every project of the current user (home directory).
#   --tool <name>    claude | codex | opencode. Repeatable. Default: every tool found.
#   --profile        Also copy templates/project.md to <dir>/.aura/project.md if missing.
#   --force          Replace skills that differ from this version. The old copy is moved to
#                    ~/.aura/skills-backup/<date>/ (outside the skill folders, so no tool loads it twice).
#   --dry-run        Print what would change; touch nothing.
#
# Never overwrites a skill you changed unless --force is given.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS=(aura-workflow aura-lead aura-builder aura-git-isolation)
BACKUP="$HOME/.aura/skills-backup/$(date +%Y%m%d-%H%M%S)"

scope=project dir="$PWD" force=0 dry=0 profile=0 tools=()
while [ $# -gt 0 ]; do
  case "$1" in
    --project) scope=project; dir="${2:?--project needs a directory}"; shift ;;
    --user) scope=user ;;
    --tool) tools+=("${2:?--tool needs a name}"); shift ;;
    --profile) profile=1 ;;
    --force) force=1 ;;
    --dry-run) dry=1 ;;
    -h|--help) sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "Unknown option: $1 (see --help)" >&2; exit 2 ;;
  esac
  shift
done

# Skill folder of each tool, per scope. Keep in sync with README.md.
# Measured 2026-10-08 on Linux: Claude Code 2.1.294 reads only .claude/skills; Codex 0.161.0
# reads .agents/skills (not .claude); OpenCode 1.18.35 reads both. So two folders cover all three,
# and OpenCode shares the Codex one instead of getting a copy of its own.
target() { # <tool> <scope>
  case "$1:$2" in
    claude:project)            echo "$dir/.claude/skills" ;;
    claude:user)               echo "$HOME/.claude/skills" ;;
    codex:project|opencode:project) echo "$dir/.agents/skills" ;;
    codex:user|opencode:user)       echo "$HOME/.agents/skills" ;;
    *) echo "Unknown tool: $1 (claude, codex, opencode)" >&2; return 1 ;;
  esac
}

if [ ${#tools[@]} -eq 0 ]; then
  for t in claude codex opencode; do command -v "$t" >/dev/null 2>&1 && tools+=("$t"); done
  if [ ${#tools[@]} -eq 0 ]; then
    echo "No tool found on PATH (claude, codex, opencode). Pass --tool <name>." >&2
    exit 1
  fi
fi
[ "$scope" = project ] && [ ! -d "$dir" ] && { echo "Not a directory: $dir" >&2; exit 1; }

run() { if [ "$dry" = 1 ]; then echo "  would: $*"; else "$@"; fi; }

changed=0 skipped=0 seen=" "
for t in "${tools[@]}"; do
  dst="$(target "$t" "$scope")"
  case "$seen" in *" $dst "*) echo "$t → $dst (already done)"; continue ;; esac
  seen="$seen$dst "
  echo "$t → $dst"
  for s in "${SKILLS[@]}"; do
    if [ -d "$dst/$s" ]; then
      if diff -rq "$SRC/skills/$s" "$dst/$s" >/dev/null 2>&1; then
        echo "  = $s (up to date)"; continue
      fi
      if [ "$force" != 1 ]; then
        echo "  ! $s differs from this version — kept yours (use --force to replace)"
        skipped=$((skipped + 1)); continue
      fi
      run mkdir -p "$BACKUP/$t-$scope"
      run mv "$dst/$s" "$BACKUP/$t-$scope/$s"
      echo "  ~ $s replaced (previous copy in $BACKUP/$t-$scope/$s)"
    else
      echo "  + $s"
    fi
    run mkdir -p "$dst"
    run cp -R "$SRC/skills/$s" "$dst/$s"
    changed=$((changed + 1))
  done
done

if [ "$profile" = 1 ]; then
  if [ "$scope" != project ]; then
    echo "--profile only applies to --project." >&2
  elif [ -e "$dir/.aura/project.md" ]; then
    echo "profile: $dir/.aura/project.md already exists — left untouched"
  else
    run mkdir -p "$dir/.aura"
    run cp "$SRC/templates/project.md" "$dir/.aura/project.md"
    echo "profile: $dir/.aura/project.md created from the template — fill it in"
  fi
fi

echo "Done: $changed installed or updated, $skipped kept as they were."
[ "$dry" = 1 ] && echo "(dry run: nothing was written)"
exit 0
