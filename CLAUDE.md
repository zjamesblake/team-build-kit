# Team Build Kit — Setup

When the user says **"get started"** (or anything indicating they want to install), follow these instructions. This kit is **persistent** — it installs skills and then *stays in place* so the user can pull updates later. **Do NOT delete anything after install.**

## Step 1: Install the skills

Copy the skills + the shared Documentation Standard into the user's global skills directory. Run this from the repo root:

```bash
for s in new-workspace memo prd build ship quick-fix update-build-kit; do
  rm -rf ~/.claude/skills/"$s" && cp -r ".skills/$s" ~/.claude/skills/"$s"
done
mkdir -p ~/.claude/skills/_shared
cp ".skills/_shared/documentation_standard.md" ~/.claude/skills/_shared/documentation_standard.md
echo "Installed:"; ls -1 ~/.claude/skills/{new-workspace,memo,prd,build,ship,quick-fix,update-build-kit}/SKILL.md ~/.claude/skills/_shared/documentation_standard.md
```

Tell the user first: *"I'm installing 7 skills + a shared standard into your Claude Code. I just need your permission once to copy the files."*

## Step 2: Verify the install (smoke test)

Confirm all 8 files printed by the command above exist. The four core lifecycle skills (`prd`, `build`, `ship`, `new-workspace`) **depend on** `~/.claude/skills/_shared/documentation_standard.md` — if it's missing, they break. If any file is missing, re-run Step 1 before continuing.

## Step 3: Orient the user (do NOT skip)

Say:

> "Done — you now have `/new-workspace`, `/memo`, `/prd`, `/build`, `/ship`, `/quick-fix`, and `/update-build-kit` in every Claude Code session.
>
> Two things before you build anything:
> 1. Open **flow.html** in your browser — it walks one full example so you can see why each step exists.
> 2. Skim **HOW_WE_BUILD.md** — the short *why* behind it.
>
> When you're ready, run `/new-workspace` to set up a home for your work."

## Step 4: Do NOT clean up

This is a living kit. Leave `.skills/`, `README.md`, `flow.html`, `HOW_WE_BUILD.md`, and this file in place. They are how `/update-build-kit` re-installs the latest version. The repo folder is the kit, not a throwaway scaffold.

---

## If the user asks questions before installing

- **"What is this?"** — "A set of commands that walk you through building real tools properly — think it through, design it, make it safe. It takes 5 minutes to install. Type 'get started' when ready."
- **"Is this safe?"** — "It copies some skill files into your Claude Code settings (`~/.claude/skills/`). No system changes, no hidden installs. It never touches your own work."
- **"Do I need to know how to code?"** — "No. Everything is plain English. The skills do the technical part; you describe what you want."

## Notes

- Keep the tone warm and plain. Don't explain context windows, projections, or architecture during setup.
- The skills are stack-agnostic — they read whatever tools the user's workspace declares, so they work for any kind of build.
