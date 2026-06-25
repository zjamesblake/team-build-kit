# How We Build

This is the *why* behind the Team Build Kit. The skills walk you through the *how* — read this once to understand what they're protecting you from. It's short on purpose.

> **Open [`flow.html`](flow.html) alongside this** — it shows the same ideas as one worked example you can click through.

---

## The one idea, if you remember nothing else

**Complexity is the enemy. If you can't explain it simply, it's probably too complicated — or built poorly.**

Almost every build that goes wrong goes wrong the same way: it tried to do too much, too soon, and the person got in over their head before they realized it. The whole kit exists to catch that early, when it's cheap, instead of late, when it's a mess.

Good systems are *simple* systems. Spending time up front making something simple always pays off.

---

## Why gates?

A "gate" is just a checkpoint you clear before moving on. You don't need anyone's permission — **the gate checks itself.** If you can't answer its question, you haven't passed, and you'll know it.

There are three, and they fire at different moments because some questions are only worth asking once you've earned them.

### Gate 1 — `/memo` · *Should this exist?*
Before you build anything real, prove it's worth building. What problem does it solve? What's the payoff? What is it in one sentence — and **what is it NOT**?

That last one matters most. "While I'm at it, let me also…" is how a weekend idea becomes a month-long swamp. Naming what you're *not* building is the cheapest way to stay out of trouble.

A memo whose honest answer is "actually, don't build this" is a **win** — it just saved you a build that wasn't worth it.

### Gate 2 — `/prd` · *Is it designed right?*
Now figure out how it works — on paper, before you build. Map the pieces and how they connect. Check that the things you're assuming are actually true. Reuse what already exists instead of inventing new stuff.

The test: **can you explain it in a short paragraph, or draw it?** If not, you don't understand it yet — and building something you don't understand is how you end up unable to fix it when it breaks.

### Gate 3 — `/ship` · *Is it safe to rely on?*
This one only fires when the stakes get real. The kit calls it **blast radius** — and it's the single most important idea here.

> **Ask: if this is wrong or breaks, does anything outside me get hurt?**
>
> It crosses the line if **any** of these is true:
> - Someone other than you depends on it
> - It changes real data
> - Its output is used to make decisions
> - It touches money or anyone outside

If none are true, it's a toy — play freely. If **any** are true, it's the real deal, and you don't get to ship it until you've answered: **what happens when it breaks? Who notices? What's the fallback?**

You'll notice the kit doesn't make you *decide* whether you've crossed the line — it checks automatically and stops you. That's on purpose: the most important gate is the one you can't accidentally skip.

---

## Why the boring setup step (`/new-workspace`)?

Before any of the gates, you run `/new-workspace` once. It sets up a small, tidy set of documents that keep your work organized — a map of what's where, a record of decisions, a changelog.

This feels like overhead. It isn't. It's what lets you (or Claude, or a teammate) come back weeks later and instantly know what's going on, instead of re-reading everything to remember how it works. **The documents are the memory of your project.** A few rules they follow:

- **Point to where things live; don't copy them.** A copy goes stale the moment the real thing changes.
- **Only write what's true right now.** A confidently-wrong note is worse than no note.
- **Don't create empty sections.** A doc only earns its place when it has something to say.

You don't have to learn any of this — `/new-workspace` and the other skills maintain it for you. Just don't skip the setup.

---

## What you bring vs. what the skills handle

You are **not** expected to know how to build anything technically. The skills (and Claude) carry that load. Your job is the part no tool can do for you:

| You decide | The skills handle |
|------------|-------------------|
| What's worth building | Designing the pieces |
| What "done" means | Checking the technical assumptions |
| What it's *not* | Writing the actual thing |
| Whether the stakes are acceptable | Keeping the docs current |

Communicate clearly what you're trying to do, answer the gates honestly, and the kit does the rest.

---

## When it gets too big

If, partway through, something turns out bigger or harder than expected — a skill will **stop and tell you**, and point you back to the right starting place. That's not failure. That's the system working: catching the problem while it's still cheap to fix.

---

*Now open `flow.html`, click through the expense-tracker example, then run `/new-workspace` and build something.*
