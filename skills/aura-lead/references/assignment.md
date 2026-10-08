# Assigning work across agents and models

Assign by **capabilities and permissions, not by brand.** This file is the **method**, which
doesn't go stale. The **data** — which models exist, what they cost, what they're good at — is in
the skill `aura-model-roster`, which gets refreshed. **How each model behaved on your project** is
in the profile's model record (`.aura/project.md`), and that beats both.

## 1. Hard filter: who is eligible?

Drop anyone who misses a hard requirement:

- **Tools:** does the task need a browser? A terminal? Docker? Pushing?
- **Access:** can it see the repo? Does it have the test credentials it needs?
- **Availability:** is it free (`list_peers` / `set_status`)? Never assign to an agent that's gone.
- **Quota and context:** does it have enough quota to finish? Enough context to hold the spec and
  the profile to the end? An agent that runs out of quota halfway leaves a half-built tree, which
  is worse than never starting.
- **Privacy:** a provider that trains on your prompts doesn't build proprietary code. The roster
  says which ones do.

If the task needs a browser and the best candidate has none, **pair it** with one that has, and
the handoff includes the steps for the other one to look.

## 2. Among the eligible: quality, cost, time

Following the profile's strategy:

| Strategy | Rule |
|---|---|
| `quality` | The most capable free agent, unless that's an obvious waste |
| `balanced` (default) | Capable models for specs, decisions and the Gate; efficient ones for well-specified work |
| `cost` | The cheapest eligible one, with the spec at the most literal setting of the dial |

**What to look at in a model**, in this order:

1. **Agentic** benchmarks (real issues, terminal work, tool use) — not trivia.
2. **Real** long context: does it still remember what it read at the start?
3. **The reasoning effort it runs at.** It weighs more than the tier: a cheap model thinking hard
   can beat an expensive one with reasoning off.
4. **Protocol and honesty:** does it isolate, push, write the handoff, declare what it didn't
   verify? No benchmark measures this. **Only your record does.**
5. Quota — and only then price.

## 3. The dial: how much detail the spec carries

| Who takes it | How it's written |
|---|---|
| Frontier model | Contract, criteria and an existing reference pattern |
| Strong model | Plus the steps and the exact files |
| Efficient or narrow model | The API written out: `file:line`, signatures, values, zero open decisions |

**If you can't write it that literally, the task isn't for that agent.**

## 4. Assignment rules

- **One task per agent at a time.** One claim, one branch, one worktree.
- **Separate areas, or one after the other.** Two agents never share a shared file.
- **Watch out for expensive isolation:** if a worktree weighs several GB or compiles for minutes
  (the profile says), don't open six in parallel.
- **A model with no record gets a small trial task first.** Watch whether it isolates, pushes,
  declares what it didn't verify in the handoff, and **stops** when the spec is wrong.
- **Whoever frees up gets the next task before you gate their previous one.**

## 5. Anti-rules

- Don't split a task to keep an idle agent busy. Split it because it doesn't fit in one spec.
- Don't give the hardest task to the cheapest model: a bounce costs more than the difference.
- Reputation doesn't decide. Your record does.
- Don't write model names or prices in this file. They live in `aura-model-roster`, which is
  meant to change.
