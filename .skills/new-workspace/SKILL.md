---
name: new-workspace
description: Instantiate (or bring up to standard) a workspace, system, or leaf with its full living-documentation foundation. Diagnoses the level from a short interview, then provisions exactly the graduated doc set it needs — greenfield (create from templates) or brownfield (reverse-engineer 100% ground truth from the live system, then fill gaps). Produces docs indistinguishable in format from the rest of the workspace, because every doc is generated from the canonical Documentation Standard. Run before /memo → /prd → /build so the lifecycle has a documentation substrate to stand on.
---

# /new-workspace

Stand up the **documentation foundation** for anything you'll build and operate over time — a new workspace, a new system inside one, or a leaf. The lifecycle skills (`/memo → /prd → /build → /ship`) *operate on* living docs; this skill is what creates and maintains the substrate they require.

**The single source of truth for all formats, rules, and the doc set is the Documentation Standard:** `~/.claude/skills/_shared/documentation_standard.md`. This skill is the *procedure*; the Standard is the *spec*. Read the Standard at the start of every run — never improvise structure, never copy a template in here.

## The two things this skill resolves

1. **Level** — is this a **workspace** (container of systems), a **system** (one buildable bounded context), or a **leaf** (static/reference)? The skill diagnoses it (Standard Part 1); the user confirms. The level decides the doc set (Standard Part 2).
2. **Fork** — is this **greenfield** (nothing built yet) or **brownfield** (already built, no standard docs)? The fork decides how the docs get populated. Both forks converge on the same end state (Standard Part 5).

## Usage

```
/new-workspace                      — interview decides level + fork
/new-workspace expense-tracker      — name given, interview the rest
/new-workspace --brownfield import   — skip the fork question, go straight to extraction
```

## When to Use

- Starting a brand-new build (greenfield) — before `/memo`
- Bringing an existing, undocumented build up to standard (brownfield)
- Adding a new system to an existing workspace
- A workspace has "graduated" — a system spawned a second system and needs splitting out

## When NOT to Use

- The thing already has standard-conformant docs (use `/build`/`/ship` to maintain them)
- A one-off fix (use `/quick-fix`)

---

## Phase 1: DISCERN — level + fork

**Read the Documentation Standard first.** Then a short, conversational interview (not a form).

### Diagnose the LEVEL (Standard Part 1)
Ask enough to place the thing:
- "What is this — one sentence?"
- "Does it hold multiple things you build and run separately, or is it one buildable thing?"  → workspace vs system
- "Is there ongoing development here, or is it static/reference?" → system vs leaf

**State the level back with reasoning, and the doc set it implies:**
```
This is a SYSTEM (one buildable bounded context — the bank-import pipeline).
Per the Standard it needs: CONTEXT.md now; CHANGELOG.md + decision_log.md as it earns them.
It does NOT yet need system_contracts.md (no second system sharing a boundary).
Confirm?
```
The user confirms or corrects. They never have to know the taxonomy — you carry it.

> **Graduate-up check:** if the user describes a second system appearing inside what was a standalone system, this is a *graduation*. Split the second system into its own folder and promote shared docs (contracts, decisions) to the workspace root. Don't pre-build a container for systems that don't exist.

### Determine the FORK
- "Is anything already built for this — workflows, tables, code, endpoints — or are we starting clean?"
  - **Nothing built → greenfield** (Phase 2a)
  - **Already built, no standard docs → brownfield** (Phase 2b)

---

## Phase 2a: GREENFIELD — define, then provision from templates

The thing doesn't exist yet, so the docs describe what *will* exist (kept minimal and accurate).

Interview to fill what each required doc needs (follow the conversation; stop when you have enough):
- **Purpose** — what it does, who it's for, why it exists.
- **Tech / integrations** — stack, external services, APIs, databases.
- **Pieces** (workspace only) — the systems inside it and how they connect.
- **Boundaries** — what it owns vs. explicitly does not.
- **Gotchas** — prerequisites, credentials, non-obvious first steps.

Then go to Phase 3 with the answers mapped onto the Standard's templates.

---

## Phase 2b: BROWNFIELD — reverse-engineer 100% ground truth, then fill gaps

The thing already exists with no standard docs. **The docs must describe what is *actually deployed* — verified, not assumed.** Apply the same bar as `/prd` Phase 1: observe the live system, don't infer.

### Step 1 — Observe (agents, one per area the build touches)
Spawn ground-truth agents (they report facts, not designs — divide by area freely, you reassemble). Use the right observation tool for the workspace's stack — load its tool-skill where one exists; observe live state, never infer:
- **Automations / workflows** — observe each live automation directly; its configuration, connections, credentials, data flow, identifiers.
- **Data stores** — inspect a real sample of the live data; fields, types, relationships, conventions, stored procedures, views, embedded descriptions.
- **App / code** — routes, handlers, modules, entry points, deploy state.
- **External services** — endpoints, auth, real request/response shapes.
- **Existing scraps** — any READMEs, notes, partial docs already lying around.

### Step 2 — Reassemble into the verified picture
You (main session) reassemble agent reports into one coherent ground-truth picture: what exists, how it connects, what the boundaries actually are. Note anything observation can't settle — those become interview questions, not assumptions.

### Step 3 — Interview only to fill genuine gaps
Ask the user only what the live system can't tell you: *why* decisions were made (→ decision_log), what's intentional vs. accidental, what's deprecated, what the boundaries are *meant* to be.

Then go to Phase 3, mapping the verified picture onto the Standard's templates. Every line must trace to something observed or explicitly confirmed.

---

## Phase 3: PROVISION — write the doc set

1. **Determine the required set** for the confirmed level (Standard Part 2). Create *exactly* that — nothing required missing, nothing unearned.
2. **Create the folder(s)** if greenfield (or if a brownfield system needs a home).
3. **Write each doc from its Standard template** (Part 4), applying the universal content rules (Part 3): point-to-source, accuracy over completeness, never empty sections, one canonical home.
4. **Create-if-missing for canonical homes:** if a required cross-cutting doc (`system_contracts.md`, `decision_log.md`) doesn't exist at the workspace root and the level now needs it, create it now — never defer (CLAUDE.md: undocumented architecture is a blocking task).
5. **Update root `CLAUDE.md` routing** — Workspaces table + Routing table. Flag for approval per the Living Documentation Rule before writing.

**Confirm the plan before creating anything** (show the folder tree + the doc set + why each doc). Never overwrite an existing file — if one exists, offer to update or skip.

---

## Phase 4: VERIFY — against the Definition of Done

Walk the Standard Part 5 checklist explicitly:
1. Level named and confirmed.
2. Exactly the graduated doc set exists — nothing required missing, nothing unearned.
3. Every doc conforms to its template (an outsider couldn't tell who authored it).
4. Every doc is 100% accurate:
   - Greenfield → accurate to the minimal just-defined reality.
   - **Brownfield → every line traces to something observed or explicitly confirmed** (the hard gate — no assumed facts).
5. Root CLAUDE.md routing updated.

For brownfield especially: re-read each doc and ask "could I have made this up?" If any line isn't backed by observation or confirmation, verify it or cut it.

---

## Phase 5: SUMMARY

```
{LEVEL} {READY / BROUGHT TO STANDARD}: {name}
━━━━━━━━━━━━━━━━━━━━━━━━━━
  {folder}/CONTEXT.md            ✓
  {canonical homes, if created}  ✓
  Root CLAUDE.md routing         ✓

Fork: {greenfield / brownfield}
{brownfield: N systems observed, M facts confirmed by interview}

Ready to build:
  /memo {first thing to build}     (greenfield)
  /prd  {next change}              (brownfield — docs now reflect ground truth)
```

---

## Safety Rules

1. **Never overwrite existing files** — check first; offer update-or-skip.
2. **Confirm before writing** — show the Phase 3 plan and wait.
3. **Stay inside the target root** — all paths relative to the workspace/system root.
4. **Handle re-runs gracefully** — create only what's missing.
5. **No secrets in generated files** — reference `.env`, never create it.
6. **Brownfield: observe before you write** — no doc line that isn't traceable to the live system or an explicit answer.

---

## Principles

- **The Standard is the spec; this skill is the procedure.** All formats, rules, and the doc set live in `_shared/documentation_standard.md`. Point there — never duplicate it here, so a change to the Standard flows through automatically.
- **The interview carries the taxonomy.** The user describes their thing in plain terms; the skill decides the level and the doc set. They never have to learn the model.
- **Both forks, one destination.** Greenfield fills the templates forward; brownfield fills them from verified ground truth. The end state is identical: a standard-conformant, accurate doc set.
- **Accurate or cut.** Especially brownfield — a doc that describes what you *assume* is deployed is worse than no doc. Observe, then write.
- **Create the substrate, then hand off.** This skill produces the docs the lifecycle stands on; `/memo → /prd → /build → /ship` maintain them from there.
