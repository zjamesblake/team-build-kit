# Documentation Standard

**The single source of truth for every living document the development lifecycle produces.** Discernment rules (what am I instantiating?), the graduated doc set (which docs does it need?), and one canonical template per doc type (so any author's output is indistinguishable from any other's).

**Who points here:**
- `/new-workspace` — **creates** docs from these templates (greenfield) or maps reverse-engineered ground truth into them (brownfield).
- `/build` + `/ship` — **maintain** docs to these specs at the moment of change, and **verify** at close that the docs match the live system and conform to these templates.

When this Standard changes, every skill inherits it. Never copy a template into a skill — point here.

---

## Part 1 — Discernment Rules (what am I instantiating?)

Before any doc is created, place the thing on the spectrum. The level decides the doc set.

| Level | What it is | Examples | Test |
|-------|-----------|----------|------|
| **Workspace** (C4 L1) | A *container* holding multiple separately-built systems | `expense-tracker/`, `marketing-site/` | "Does it hold ≥2 things I build and operate separately?" |
| **System** (C4 L3) | A single *buildable thing* with its own internal logic, state, and workflows | `bank-import/`, `categorizer/`, `reports/` | "Is it one thing I develop and run over time?" |
| **Leaf** | Static / reference material, no ongoing build | `design-assets/`, `_reference/` | "Is there no ongoing build here?" |

**The graduate-up rule (the common team case):** a thing often *starts* as a system that is its own workspace — one build, no container yet. It **graduates** to a workspace the moment it spawns a second system. When that happens, run `/new-workspace` again at the system level to split the second system out, and promote the shared docs (contracts, decisions) to the workspace root. Don't pre-build a container for systems that don't exist yet.

**The interview decides the level — not the user.** `/new-workspace` diagnoses the level from what the user describes and states it back ("This is a *system* — here's the doc set it needs and why"). The user confirms; they never have to know the taxonomy.

---

## Part 2 — The Graduated Doc Set (which docs does it need?)

Required docs scale with what exists. Never create a doc before it's earned — an empty doc is noise that reads as "covered" when it isn't.

| Doc | Required when | Level it lives at |
|-----|--------------|-------------------|
| **`CONTEXT.md`** | Always — every workspace, system, and leaf | The thing itself |
| **`CHANGELOG.md`** | The first build ships | Workspace (or system if standalone) |
| **`decision_log.md`** | The first non-obvious decision is made | Workspace root (cross-cutting) |
| **`system_contracts.md`** | The moment a **second** system shares a boundary with the first | Workspace root (cross-cutting) |
| **`architecture.md`** (L2) | Multiple systems with data flows between them | Workspace root |
| **`flow.html`** | A system is a *process* (steps, handoffs, owners) | The system folder |

**Leaf** = `CONTEXT.md` header only. **Standalone system** (its own workspace) = `CONTEXT.md` + `CHANGELOG.md` + `decision_log.md` as it earns them; contracts/architecture only after it graduates. **Mature workspace** = all of the above.

`flow.html` is not templated here — it has its own base template. This Standard governs the markdown docs.

---

## Part 3 — Universal Content Rules (apply to every doc)

1. **Point to the source of truth — don't copy it.** Reference identifiers, table and field names, and the system's own descriptions — never paste raw exports or schema dumps. When the live system changes, a reference still points right; a copy goes stale. (Where the live system stores its own descriptions — e.g. database field comments — those are authoritative; reference them by name rather than copying.)
2. **Accuracy over completeness.** Whatever is written must be 100% true *now*. A confidently-wrong line is worse than an omission. A thin accurate doc beats a thorough drifted one.
3. **Living, not historical.** These docs answer "what is true now?" — update them at the moment of change, not at session close. (Completed memos/PRDs/logs are the *static* record; these are not.)
4. **Never create empty sections.** Include a section only when it has content. A template section with no content is deleted, not left as a placeholder.
5. **One canonical home per fact.** If a fact crosses a system boundary it lives at the workspace root (contracts/decisions); if it's internal to one system it lives in that system's `CONTEXT.md`. Everywhere else references it.

---

## Part 4 — The Templates (one per doc type)

Fill the skeleton; delete any section without content. These are the exact shapes — do not improvise structure.

---

### 4.1 — Workspace `CONTEXT.md` (L1 — the map)

**Purpose:** Answer "what is this workspace, what systems are inside it, and where do I go for X?" in one read. It is the routing layer.
**Maintained by:** `/build`/`/ship` when a system is added/renamed/removed.

```markdown
# {Workspace Name}

{One-paragraph description — what it does, who it's for, why it exists.}
{Example: "A personal expense tracker — imports bank transactions, categorizes them, and produces monthly spending reports."}

**Tech Stack:** {technologies}
{Example: your automation tool, your database, your spreadsheet/app, your bank-sync service}

---

## Systems & Routing                    ← only if ≥2 systems exist
| System | What it does | Go here for |
|--------|--------------|-------------|
| {folder}/ | {one line} | {tasks that belong here} |
| {Example: bank-import/} | {Pulls + de-dupes bank transactions} | {Import runs, connection issues, new accounts} |

## Canonical Homes                      ← only once cross-cutting docs exist
| Doc | What lives there |
|-----|------------------|
| system_contracts.md | Field mappings + boundary contracts |
| decision_log.md | Cross-cutting decisions + rationale |
| CHANGELOG.md | What shipped |

## Integrations                         ← only if external systems connect
| System | Purpose | Details |
|--------|---------|---------|
| {Example: a bank-sync service} | {Transaction import} | {API key in .env; sandbox + prod} |

## Quick Start                          ← only if non-obvious first steps exist
1. {Example: "Auth: gcloud auth application-default print-access-token"}
```

---

### 4.2 — System `CONTEXT.md` (L3 — the local index)

**Purpose:** Answer "how does this system work and where does X live?" without leaving the folder. This is what makes the handoff test pass.
**Maintained by:** `/build`/`/ship` at the end of each work item that changes structure.

```markdown
# {System Name}

{One-paragraph: what this system does and its current state.}

**Owns:** {the one thing this system is responsible for — its boundary in a sentence.}
{Example: "Owns importing + de-duping bank transactions. Does NOT own categorization or reporting."}

---

## What lives here
| File | What it is | Living / Disposable |
|------|-----------|---------------------|
| {file} | {purpose} | {living/disposable} |
| {Example: import_rules.md} | {De-dupe + matching logic} | {living} |

## How to find X                        ← only for non-obvious lookups
| Question | Where to look |
|----------|---------------|
| {Example: "Why is a transaction missing?"} | {import log + the de-dupe rules} |

## Workflows                            ← only if it has workflows
| Workflow / component | ID / location | Trigger | Purpose |
|----------------------|---------------|---------|---------|
| {Example: Nightly Import} | {automation id / file path} | {daily schedule} | {pulls new transactions} |

## Current State
- **Status:** {what's deployed / in progress}
- **Pending:** {open items, or "none"}

## Points up                            ← cross-system contracts this system participates in
- system_contracts.md — {which boundaries}
- decision_log.md — {relevant decisions}

## Points down                          ← only if it has sub-areas / where implementation lives
- {sub-folder}/ — {what's inside}
- {Example: scripts/ — import + backfill jobs}

## Don't Load (for this system)         ← only if sibling docs are commonly mis-loaded
- {folder}/ — {why irrelevant to this context}
```

---

### 4.3 — `system_contracts.md` (workspace root — cross-system)

**Purpose:** Single source of truth for every data handoff between systems. Change a field in one system → check here for what else must change.
**Required when:** a second system shares a boundary with the first.
**Maintained by:** `/build`/`/ship` whenever a field crosses a boundary is added/renamed/removed.

```markdown
# System Contracts

**Purpose:** Single source of truth for every data handoff between systems. When you change a field in one system, check this doc to see what else needs to change.

**Rule:** If a field crosses a system boundary, it goes in this doc. Update it whenever you add/rename/remove a boundary field.

---

## Canonical Field Names
These names mean the same thing everywhere. Never mix them.

| Canonical Name | Meaning | Example Value |
|---------------|---------|---------------|
| `{name}` | {meaning} | `{example}` |
| `txn_id` | Transaction's unique ID (from the bank) | `TXN-7K9M2` |
| `category_id` | Category slug (URL-safe identifier) | `groceries` |

**When naming a URL param, hidden field, variable, or column — use the canonical name.**

---

## Boundary: {System A → System B}
**Produces:** `{field: type, ...}`
**Consumes:** `{field: type, ...}`
**Source of truth:** {where the value is authoritative}

{Example —
**Boundary: Bank Import → Reports**
**Produces:** `{txn_id: text, amount: integer, category_id: text, posted_at: timestamptz}`
**Consumes:** `{txn_id, amount, posted_at}` (reports group spend by the posting period)
**Source of truth:** the import table — see its field description}
```

---

### 4.4 — `decision_log.md` (workspace root — cross-cutting)

**Purpose:** Record major architectural/design decisions with rationale. Explains WHY things were built this way.
**Required when:** the first non-obvious decision is made.
**Maintained by:** `/build`/`/ship` (append) and `/prd` (when a design decision is locked). Append-only; numbered sequentially.

```markdown
# {Workspace} - Decision Log

**Purpose:** Record all major architectural and design decisions with rationale. Explains WHY things were built the way they are.
**Format:** Each entry includes the decision, alternatives considered, rationale, and potential future changes.
**Archive:** {Entries 1-N archived at `_admin/_archive/decision_log_archive.md`}   ← add once the log grows large

---

## Decision Index
N. [{Title}](#n-{anchor})

---

## {N}. {Title}
**Decision:** {what was decided}
**Alternatives considered:** {what else was on the table}
**Rationale:** {why this won}
**Future changes:** {what might revisit this, or "none anticipated"}
**Date:** {YYYY-MM-DD}

{Example —
## 3. Why Store Amounts in Cents, Not Dollars
**Decision:** Store every amount as an integer number of cents, not a decimal dollar value.
**Alternatives considered:** Floating-point dollars; a fixed-precision decimal type.
**Rationale:** Integer cents avoid floating-point rounding errors that silently corrupt totals; every report stays exact.
**Future changes:** Revisit only if multi-currency support needs sub-cent precision.
**Date:** 2026-03-02}
```

---

### 4.5 — `CHANGELOG.md`

**Purpose:** What shipped, in human terms. Keep a Changelog format.
**Required when:** the first build ships.
**Maintained by:** `/build`/`/ship` with an entry per build.

```markdown
# Changelog

All notable changes to {workspace/system}. Format: [Keep a Changelog](https://keepachangelog.com).

## [Pre-Production]
### Added
- {what was built}
- {Example: "CSV export: a monthly report can now be downloaded as a spreadsheet."}
### Changed
- {what changed}
### Fixed
- {what was fixed}
```

---

### 4.6 — `architecture.md` (L2 — optional)

**Purpose:** How the systems connect — the container-level data-flow view between L1 (map) and L3 (system internals).
**Required when:** multiple systems with data flows between them.
**Maintained by:** `/build`/`/ship` when a cross-system flow is added or changed.

```markdown
# {Workspace} Architecture

How the systems connect. (System internals live in each system's CONTEXT.md; field-level contracts live in system_contracts.md — this is the flow view.)

---

## System Map
{Systems and the direction of data flow between them — ASCII diagram preferred.}
{Example:
  Bank Import ──transactions──▶ Categorizer ──categorized──▶ Reports
       │                              │
       └──────▶ Dashboard ◀───────────┘  (reads both via shared views)}

## Data Flows
| From | To | What flows | Via |
|------|----|-----------|----|
| {system} | {system} | {data} | {trigger / table / API call} |
| {Example: Bank Import} | {Categorizer} | {new transactions} | {transactions table} |
```

---

## Part 5 — Definition of Done (both forks converge here)

`/new-workspace` is done — greenfield **or** brownfield — when:

1. The thing's **level is named** (workspace / system / leaf) and confirmed.
2. **Exactly the graduated doc set** for that level exists — nothing required missing, nothing unearned created.
3. Every doc **conforms to its template** in Part 4 (an outsider couldn't tell who authored it).
4. Every doc is **100% accurate to reality:**
   - **Greenfield** — accurate to the just-defined (minimal) reality.
   - **Brownfield** — *verified* against the live deployed system (the `/prd` Phase 1 bar: observed, not assumed), with interview only to fill genuine gaps.
5. Root `CLAUDE.md` routing is updated (flag for approval per the Living Documentation Rule).

The forks differ only in how the docs get populated and what "accurate" measures against — the destination is identical.
