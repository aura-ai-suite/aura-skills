---
name: aura-model-roster
description: Real, dated data on the AI models behind your coding agents — tier, what each is good and bad at, reference price, limits, privacy and browser access — so the lead assigns each task to the right model. Load it when you are the lead and must decide who gets a task, or when the user asks which model to use. Meant to be refreshed regularly. Not for Builders.
---

# Model roster

> **Last reviewed: 2026-10-08.**
> **Freshness rule:** if today is more than 30 days after that date, tell the user *before*
> assigning ("the model roster was last reviewed on <date>; want me to refresh it?") and offer to
> refresh. Models, prices and quotas change monthly; a stale table assigns with confidence and
> gets it wrong.
>
> **🔄 Keep this file updated.** It's the one Aura skill that goes stale on purpose. Refresh it
> yourself (§6), or reinstall the latest `aura-skills` to get ours.
>
> The tables are a starting point. **How a model behaved on your own project** — the model record
> in `.aura/project.md` — **overrides them.** That record lives in your profile, not here, so
> updating this file never erases it.
>
> Vendor figures were transcribed from each vendor's announcement on the date shown. Check the
> vendor before you rely on one for a spending decision.

## 0. Ground rules

- **Every number has a source and a date.** Vendor numbers say "vendor, <date>". Numbers the Aura
  team measured say "measured, Aura team, <date>". Anything else is marked **unverified**.
- **Don't compare different benchmarks.** SWE Verified, DeepSWE, Terminal-Bench 2.1 and 4.0,
  OSWorld 2.0 and 2.1, GDPval-AA and GDP.pdf are not interchangeable.
- **The harness matters.** A vendor score is not the score inside OpenCode or Codex.
  Example: DeepSeek V4.1-Flash, DeepSWE v1.1 **74.2** (vendor) vs **65.5** inside OpenCode.
- **A big context window does not prove retention.** Only long-context retrieval benchmarks
  (MRCR, CorpusQA) say that.
- **The CLI is not the provider.** List API prices ≠ what a subscription charges you.
- **Price is not tier.** A cheap model with a good protocol can beat an expensive one (§5).

## 1. Tiers

| Tier | Gets | Never gets |
|---|---|---|
| **frontier** | Specs, architecture, the Gate, long tasks that bounced before | — |
| **strong** | Full features with tests, given a written spec | Open design decisions without a lead |
| **efficient** | Bounded, mechanical work: `file:line`, values, reference code, zero open choices | Anything it has to decide |
| **read-only** | Reading, summarizing, answering about the code | Writes, commits, private code if the provider trains on prompts |

If you can't write the task that literally for an efficient model, it isn't an efficient-model task.

## 2. Active models (reviewed 2026-10-08)

Price = reference list price per 1M tokens, input / output (/ cached input).

| Model | Used through | Tier | Good at | Not for | Price (source) | Limits | Privacy | Browser |
|---|---|---|---|---|---|---|---|---|
| **Claude Opus 5.5** | Claude Code | frontier | Complex agentic coding (vendor recommendation); Gate; UI work that must be seen | The cheapest path for long docs: GPT-6.1 Sol beats it on GDP.pdf at < ½ the cost (OpenAI, 2026-10-08) | $4 / $20 (Anthropic, 2026-10-08) | Subscription quota: unverified | Training / ZDR on subscription: **unverified** | **Yes**, with Claude in Chrome (measured, Aura team, 2026-10-08) |
| **Claude Sonnet 5.5** | Claude Code | strong | Complex coding at half Opus price. Terminal-Bench 4.0 **70.6**, OSWorld 2.1 **83.9**, GDPval-AA v2.1 **1840** (Anthropic, 2026-10-08) | — | $2 / $10, cache read $0.10 (Anthropic, 2026-10-08) | unverified | **unverified** | Same as Opus |
| **Claude Haiku 5.5** | Claude Code (as subagent) | efficient | Bounded literal tasks. Terminal-Bench 4.0 **39.2**, OSWorld 2.1 **72.4**, GDPval-AA v2.1 **1620** (Anthropic, 2026-10-08) | Complex coding: vendor still points to Sonnet/Opus | $0.10 / $0.50 up to 100K prompt; $0.50 / $2.50 above; cache read $0.01 (Anthropic, 2026-10-08) | Context 1M, output 128K, cutoff Jun 2026 (Anthropic, 2026-10-07) | **unverified** | Not as a builder (not measured) |
| **GPT-6.1 Sol** | Codex | frontier | Long multi-file tasks: matches GPT-6 Astra on DeepSWE v1.1 at ~1/5 the cost; human-facing docs (GDP.pdf); reports failed searches (misses it 2.1%) (OpenAI, 2026-10-08) | Recalling an API you didn't cite: 7.7% error on hard prompts (OpenAI, 2026-10-08) — cite it | $2 / $10 / $0.10 (OpenAI, 2026-10-08) | Subscription quota: unverified | **unverified** | **No** in the Aura team's sessions (measured, 2026-10-08) |
| **DeepSeek V4.1-Flash** | OpenCode | strong (with a written API) | Code + terminal: in OpenCode DeepSWE v1.1 **65.5**, Terminal-Bench 2.1 **85.0** (DeepSeek, 2026-09-14); Docker and migrations OK; best protocol in the Aura team's record (§5) | Facts it must remember: SimpleQA-Verified **42.3** (DeepSeek, 2026-09-14) — write the API into the task. Hard terminal chains: Terminal-Bench 4.0 **31.2** | Peak pricing **2×**: 01:00–04:00 and 06:00–10:00 UTC Mon–Fri; off-peak half price (DeepSeek, 2026-09-14). Per-token list price: unverified | Context 1M (DeepSeek, 2026-09-14) | Retention **0 days** (DeepSeek, as recorded 2026-09) — re-verify per channel | **No** (measured, Aura team, 2026-10-08) |

## 3. Reference models (not in the Aura team's current roster)

| Model | Used through | Tier | Notes (source, date) |
|---|---|---|---|
| GPT-6 Astra | OpenCode / API | frontier | Terminal-Bench 4.0 **57.9**, MRCR v2 512K–1M **96.3**, hallucination **4.2%**. $10 / $50 / $1; > 272K input bills 2× in / 1.5× out. Context 1.05M, output 128K. Supports ZDR (OpenAI, 2026-09-14) |
| Gemini 3.1 Pro | Antigravity | frontier | SimpleQA-Verified **75.6**, SWE Verified **80.6**; MRCR-1M **76.3** (Google, as recorded 2026-08-29). Browser in Antigravity: **unverified** |
| GPT-5.6 Terra | OpenCode | strong | $2 / $12, context 1.05M (OpenAI, as recorded 2026-08-29) |
| GPT-5.6 Luna | OpenCode | efficient by price, **measured strong** | $0.20 / $1.20, 2,050 requests / 5h (OpenAI, as recorded 2026-08-29). Behaved as strong on two hard specs (measured, Aura team, 2026-09-07) |
| Muse Spark 1.2 Contributor | OpenCode | read-only at most | **Trains on your prompts, no ZDR** (as recorded by the Aura team, 2026-09) → never on private code |

## 4. Retired or renamed

| Date | What changed | What to do |
|---|---|---|
| 2026-09-14 04:00 UTC | `deepseek-v4-pro` **routes to V4.1-Flash**, at Flash rates, until V4.1-Pro ships (DeepSeek) | Its old numbers describe a model that no longer answers. Write the agent as `deepseek-v4.1-flash` |
| 2026-09-14 | `deepseek-v4-flash` retired; the id is V4.1-Flash (DeepSeek) | Same |
| 2026-09-14 | V4.1-Flash: Terminal-Bench 2.1 **90.6** vendor (V4-Flash had **56.6**) | The old "no Docker / no migrations" rule for Flash expired |
| 2026-10-08 | In the Aura team's sessions, GPT-6.1 Sol took over the work of GPT-5.6 Terra | Don't default to an agent you no longer run |

Old commits signed with a retired name stay as they are: they were true when written.

## 5. Your measured record — it beats every benchmark

The lead adds a line to the **model record in `.aura/project.md`** when closing each task, with
what *they* saw, not what the Builder claimed:

```
YYYY-MM-DD · <tool·model> (effort) · <task> · ✅/❌ deliverable, tests · 🟢/⚠️/🔴 protocol: isolated, pushed, handoff before done, declared what it did NOT verify
```

What the Aura team's record showed (three repos, 2026-09-07 → 2026-10-08):

- 🟢 **The cheapest model gave the best protocol.** DeepSeek V4/V4.1-Flash: 23 record lines in
  one repo alone (one covers six tasks), most marked "declared green = real green",
  including Rust. It stopped and asked before deviating, and wrote "not measured" instead of
  guessing. It still repeats some defects (sync commands that call a CLI) — those go in the spec.
- 🟢 **GPT-5.6 Luna ($0.20/$1.20) behaved as strong** on two hard specs. Price is not tier.
- 🔴 **Both false greens came from mechanical tasks**, not hard ones. The lead re-runs the checks.
- 🔴 **The costliest failure was protocol, not code:** work left uncommitted when a session died
  (twice). Ask for commit + push before "done".
- ⚠️ **Repeated defects go in the kickoff prompt.** A model that broke commit trailers twice
  kept doing it until the prompt said so.

## 6. How to refresh

1. **Vendors:** the official announcement, model card and API pricing page of each model.
   Copy the number, the benchmark *name and version*, and the date. Keep the link with it.
2. **Your agents:** which model each tool actually runs today (`/model`, its config). Agent
   names like `codex-2` don't tell you the model — ask the user once and write it in the profile.
3. **Quotas and billing:** your plan's page, not the API price list.
4. **Privacy:** the provider's data-use page for *the channel you use*. A subscription and the
   API can have different terms.
5. Update "Last reviewed", move anything retired to §4, and keep this file ≤ 170 lines.
   Drop history the decision doesn't need.
