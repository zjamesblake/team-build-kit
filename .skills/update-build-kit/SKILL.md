---
name: update-build-kit
description: Pull the latest version of the Team Build Kit and re-install its skills. Use when there's a new version of the kit, or to make sure your lifecycle skills (new-workspace, memo, prd, build, ship, quick-fix) and the shared Documentation Standard are current. Never touches your own work — only refreshes the kit's skills.
---

# /update-build-kit

Refresh the Team Build Kit to its latest published version. This re-downloads the kit's skills and the shared Documentation Standard from GitHub and re-installs them into `~/.claude/skills/`. **It only touches the kit's own skills — never the user's workspaces or work.**

## When to Use

- You heard there's a new version of the kit.
- You want to confirm your lifecycle skills are current.

## When NOT to Use

- To change your own project files (that's `/quick-fix` or the lifecycle skills).

---

## How it works

The kit lives at a public GitHub repo. This skill pulls the current files straight from there, so it works whether the user cloned the repo or just downloaded the ZIP.

**Repo:** `https://github.com/zjamesblake/team-build-kit`
**Raw base:** `https://raw.githubusercontent.com/zjamesblake/team-build-kit/main`

### Step 1: Re-install from GitHub

Tell the user: *"Pulling the latest Team Build Kit and re-installing the skills — this won't touch any of your own work."* Then run:

```bash
BASE="https://raw.githubusercontent.com/zjamesblake/team-build-kit/main/.skills"
TMP=$(mktemp -d); ok=1
# 1) download EVERYTHING to a temp dir first — touch nothing installed yet
for s in new-workspace memo prd build ship quick-fix update-build-kit; do
  mkdir -p "$TMP/$s"; curl -fsSL "$BASE/$s/SKILL.md" -o "$TMP/$s/SKILL.md" || ok=0
done
mkdir -p "$TMP/_shared"; curl -fsSL "$BASE/_shared/documentation_standard.md" -o "$TMP/_shared/documentation_standard.md" || ok=0
# 2) only install if ALL 8 files downloaded cleanly (atomic — never leave a half-updated kit)
count=$(find "$TMP" -name '*.md' | wc -l | tr -d ' ')
if [ "$ok" = 1 ] && [ "$count" = 8 ]; then
  for s in new-workspace memo prd build ship quick-fix update-build-kit; do
    mkdir -p ~/.claude/skills/"$s"; cp "$TMP/$s/SKILL.md" ~/.claude/skills/"$s"/SKILL.md
  done
  mkdir -p ~/.claude/skills/_shared; cp "$TMP/_shared/documentation_standard.md" ~/.claude/skills/_shared/documentation_standard.md
  rm -rf "$TMP"; echo "Updated all 8 files."
else
  rm -rf "$TMP"; echo "Update FAILED ($count/8 downloaded). Your existing kit is UNTOUCHED — nothing was changed. Check your connection and try again, or re-download the repo."; exit 1
fi
```

> If the user also has the repo cloned locally and prefers git: `cd` into it, `git pull`, then re-run the install command from the kit's `CLAUDE.md`. The curl path above is the default because it needs no clone.

### Step 2: Verify

Confirm all 8 files were written (the command lists them). The four core lifecycle skills (`prd`, `build`, `ship`, `new-workspace`) depend on `~/.claude/skills/_shared/documentation_standard.md` — make sure it's present. If a `curl` failed (no network, repo moved), say so plainly and stop; don't leave a half-updated set.

### Step 3: Confirm

Tell the user: *"Done — your Team Build Kit skills are current. Nothing in your own workspaces was touched."*

---

## Principles

- **Only the kit's skills change.** This never modifies the user's projects, docs, or data.
- **All-or-nothing.** If a download fails, report it and stop — a half-updated kit is worse than a stale one.
- **The source of truth is GitHub.** This skill pulls; it never edits the kit's contents locally.
