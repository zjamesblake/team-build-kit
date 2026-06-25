---
name: memo
description: Write a build-intent memo (Gate 1 — "I intend to build this"). Forces the author to prove a build is worth doing BEFORE any design or code, using the business proposition — problem, cost of inaction, value if solved, why now — plus a one-sentence scope boundary and an observable success definition. WHAT and WHY only, never HOW. First step in the /memo → /prd → /build lifecycle.
---

# /memo

**Definition of done:** A memo proves a build is worth doing **before** any design or code exists. It answers **WHAT** (the problem in one sentence — and what it is deliberately NOT) and **WHY** (cost of inaction, value if solved, why now), and defines what "solved" looks like. It explicitly does **NOT** describe **HOW** — we don't know how yet; that's the PRD's job. The memo is **Gate 1**: if you can't write the problem in one sentence and say what success looks like, you fail the gate yourself — you're not ready to build.

**Self-administered — the artifact IS the proof.** Can't articulate the problem in one sentence? You're not ready. Can't name what you'd gain? It's not worth building. Nobody has to grade this; the gate grades itself. The emitted doc is also the **audit surface** — it lets a teammate (or a fresh session) verify the thinking was sound in one read, without reverse-engineering a half-built system.

**The problem this prevents:** building far outside your depth, realizing it mid-flight, and needing someone to reverse-engineer and clean up afterward. The memo is the point of friction that forces you to clearly state the specific outcome you want *before* you start — because groundbreaking opportunities are almost never discovered in the middle of development.

---

## When you can SKIP the memo

Below this line, build freely — no memo needed:
- **Throwaway** — an experiment or spike you'll delete.
- **Only-you** — nobody else depends on it and it changes no shared/real data.
- **Trivially reversible** — undoing it is a single step.
- **A contained fix** — known issue, no new architecture → use `/quick-fix`.

A memo is required when you intend to **build something non-trivial that should exist past today.** When in doubt, the one-sentence problem test settles it: if you can't write it in one sentence, you need the memo more, not less.

---

## Usage

```
/memo a tool to auto-categorize my expenses
/memo we need a monthly spending dashboard
/memo proposal to switch importing from manual CSV to bank sync
/memo [topic] — will interview you to fill the input contract
```

## When to Use

- You intend to build a new system, workflow, or significant change
- Any time you'd otherwise start building from a hunch without stating the outcome
- A strategic change that affects multiple people or systems
- A pure policy decision that needs justification and a recommendation

## When NOT to Use

- Anything under the skip line above
- System design / scoping (use `/prd` after the memo)
- Implementation (use `/build` after the PRD)
- Bug fixes or config changes (use `/quick-fix`)

---

## The Required Input Contract

This is the gate. Before a memo can be written, every input below must be known. If the author supplies them, structure them. If any is missing, **that** is what the GATHER interview targets — do not write around a gap.

| Input | The question it answers |
|-------|------------------------|
| **Problem** | What specifically is broken, missing, or painful? |
| **Cost of inaction** | What does leaving it unsolved cost us? |
| **Value if solved** | What do we gain by fixing it? |
| **Why now** | Why this, over everything else, right now? |
| **One sentence + what it is NOT** | What is it in one line — and what is it deliberately *not*? (kills scope sprawl) |
| **Success definition** | How will we know it's solved? What does "solved" look like? |

Together these are the **business proposition**: *What problem are we experiencing? What does it cost us? What would we gain by fixing it? Why should we do it now?* If the value doesn't justify the cost of building it, the memo's correct conclusion is **don't build** — and that is a successful memo.

---

## The Framework

The memo is WHAT + WHY. There is no HOW.

| Section | Purpose | Guiding Question |
|---------|---------|-----------------|
| **Constraint** | The problem in one sentence | What single bottleneck does this address? |
| **Problem & Cost** | The pain + the stakes | What's broken — and what does leaving it cost us? |
| **Value & Why Now** | The upside + urgency | What do we gain, and why now over everything else? |
| **Scope** | The boundary | What is it in one sentence — and what is it NOT? |
| **Success Definition** | What "solved" looks like | How will we know we succeeded? |
| **The Ask** | Force the go/no-go | Proceed to `/prd`, or not? (options only if a real fork exists) |

### Core Rules

1. **WHAT and WHY only — never HOW.** If you find yourself writing steps, mechanics, data schemas, component names, or "first we'll… then we'll…" — stop. You don't know the how yet, and pretending you do is exactly the failure this gate prevents. The how is the PRD.
2. **Name what it is NOT.** Every memo states an explicit non-goal. Scope sprawl — "while we're here, let's also…" — is the number-one way builds blow past their depth. The boundary is load-bearing.
3. **The business proposition must hold.** Problem → cost → value → why-now, in that order. If a reader can't see why the gain justifies the build, the memo isn't done (or the build isn't worth it).
4. **Success must be observable.** "We'll know it's solved when X," where X is something you can actually check — not "it works better."
5. **Force a decision, don't inform.** The memo ends in a go/no-go to `/prd`. Information with no decision point is a status update, not a memo.

---

## Phase 1: GATHER

**Goal:** Fill the input contract. Every input, or a deliberate interview to get it.

### If the user provides a detailed prompt:
1. Map what they gave you onto the six input-contract rows.
2. Identify which rows are missing or thin.
3. Ask at most 2-3 targeted questions to fill only the critical gaps. Don't re-ask what they already answered.

### If the user provides a short prompt:
Interview to fill the contract. Lead with the two that are hardest and most load-bearing:
- **Problem in one sentence** — push until it's one sentence, not a paragraph.
- **What it is NOT** — the non-goal. People resist this; insist on it.

Then fill cost, value, why-now, and success. Use judgment — don't interrogate; extract what's needed.

### Research (if the topic touches the codebase):
- Read relevant CONTEXT.md, architecture docs, system contracts — enough to state the problem and cost accurately.
- Check live state only if it changes the problem statement (you are NOT designing here — resist diagnosing the solution).
- Reference memory for prior decisions or context.

**Compress for the user.** Don't present raw research — synthesize it into the minimum context the memo needs. The author's attention is expensive, and the memo is supposed to be cheap.

---

## Phase 2: STRUCTURE

**Goal:** Organize the contract into the memo's sections.

### Constraint (one sentence)
The single bottleneck this addresses. If you can't name it in one sentence, the thinking isn't clear enough yet — go back to GATHER.

### Problem & Cost (1-2 paragraphs)
- What's broken, missing, or painful — concretely, no abstractions.
- What leaving it unsolved costs us (time, money, risk, missed upside). This is the stakes; make the reader feel them honestly, without hype.

### Value & Why Now (1-2 paragraphs)
- What we gain by solving it.
- Why this is the priority *now* — what changed, what window is open, what it blocks.
- Anchor to a North Star metric or strategic theme if one applies.

### Scope
- **What it is:** one sentence.
- **What it is NOT:** the explicit non-goals. List what this deliberately excludes. This is where you kill the "and also…" before it starts.

### Success Definition
- "We'll know this is solved when ___." Observable and checkable.

### The Ask
- A clear go/no-go recommendation → proceed to `/prd`.
- **Options table only if a genuine strategic fork exists** (e.g. a pure policy choice like a rate change with 2-4 real alternatives). For a normal build-intent memo, there is no options table — the ask is simply "build this, here's why, proceed to PRD."

---

## Phase 3: WRITE

**Goal:** Produce the memo document.

### Format

```markdown
# [Title]

_Build-intent memo (Gate 1). [Author] | [Date]_

**Constraint:** [One sentence naming the specific bottleneck this addresses.]

---

## Problem & Cost

[What's broken/missing/painful. What leaving it unsolved costs us.]

## Value & Why Now

[What we gain by solving it. Why now, over everything else.]

## Scope

**What it is:** [one sentence]

**What it is NOT:** [explicit non-goals — what this deliberately excludes]

## Success Definition

We'll know this is solved when: [observable, checkable outcome]

## The Ask

[Go/no-go recommendation. If go: "Proceed to `/prd` to design the implementation."]

<!-- Optional — include ONLY if a genuine strategic fork exists: -->
### Decision: [name]
| Option | Tradeoff |
|--------|----------|
| A | ... |
| **B (recommended)** | ... |
```

### Where to save

- Default: `{workspace}/_admin/memos/{topic-slug}.md`
- Create `_admin/memos/` if it doesn't exist.
- Name descriptively: `auto_categorize.md`, not `memo_001.md`.
- When a memo's build ships and the project is archived, move the memo to `_admin/memos/_done/` (the PRD links to it by path until then).
- One memo may spawn multiple PRDs/projects.

---

## Phase 4: REVIEW

**Goal:** Pressure-test the memo before it ships. Run these checks:

1. **One-sentence problem:** Is the Constraint a single, specific sentence?
2. **Non-goal stated:** Does Scope explicitly say what this is NOT?
3. **Proposition holds:** Reading Problem → Cost → Value → Why Now, is it obvious the gain justifies the build? (If not: either sharpen it, or the honest answer is don't build.)
4. **Success observable:** Is the success definition something you could actually check?
5. **Zero HOW leaked:** Scan for mechanics, steps, schema, workflow names, "first/then." If any appear, cut them — they belong in the PRD.
6. **Forces the ask:** After reading, is the go/no-go decision unambiguous?

Present the memo to the user for review. Flag any thin section and suggest the fix.

---

## Close: hand off or pause

Once approved, the memo lives as a standalone artifact at `{workspace}/_admin/memos/{slug}.md` — a fresh session can pick it up from the file alone. Don't auto-advance. Ask the user explicitly:

> **Memo cleared Gate 1.** Want to proceed to **`/prd`** now to design it — or pick it up in a new session? (A fresh session continues with `/prd {workspace}/_admin/memos/{slug}.md`.)

---

## Principles

- **Writing forces clarity.** If you can't write it clearly, you don't understand it clearly. The memo is a thinking tool first, a communication tool second.
- **What and why, never how.** The moment you're describing the how, you've left the memo. You don't know the how yet — that's the whole point of having a PRD next.
- **The boundary is the product.** "What it is NOT" prevents more failed builds than any other line in the memo. Scope sprawl is how people end up far outside their depth.
- **The proposition decides.** A memo whose honest conclusion is "don't build" is a win — it just saved a build that wasn't worth it.
- **The artifact is the proof and the audit surface.** Self-administered means the doc has to stand on its own: a fresh reader verifies the thinking from the memo alone, with nothing half-built to reverse-engineer.
