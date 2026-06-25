#!/usr/bin/env bash
# Team Build Kit installer — copies the skills into ~/.claude/skills/.
# Atomic: downloads everything first; only installs if all 8 files arrive.
set -u
BASE="https://raw.githubusercontent.com/zjamesblake/team-build-kit/main/.skills"
TMP=$(mktemp -d); ok=1
for s in new-workspace memo prd build ship quick-fix update-build-kit; do
  mkdir -p "$TMP/$s"; curl -fsSL "$BASE/$s/SKILL.md" -o "$TMP/$s/SKILL.md" || ok=0
done
mkdir -p "$TMP/_shared"; curl -fsSL "$BASE/_shared/documentation_standard.md" -o "$TMP/_shared/documentation_standard.md" || ok=0
count=$(find "$TMP" -name '*.md' | wc -l | tr -d ' ')
if [ "$ok" = 1 ] && [ "$count" = 8 ]; then
  for s in new-workspace memo prd build ship quick-fix update-build-kit; do
    mkdir -p ~/.claude/skills/"$s"; cp "$TMP/$s/SKILL.md" ~/.claude/skills/"$s"/SKILL.md
  done
  mkdir -p ~/.claude/skills/_shared; cp "$TMP/_shared/documentation_standard.md" ~/.claude/skills/_shared/documentation_standard.md
  rm -rf "$TMP"
  echo "✅ Team Build Kit installed. In Claude Code you now have: /new-workspace /memo /prd /build /ship /quick-fix /update-build-kit"
  echo "   Start with: /new-workspace"
else
  rm -rf "$TMP"; echo "❌ Install failed ($count/8 downloaded). Nothing was changed — check your connection and try again."; exit 1
fi
