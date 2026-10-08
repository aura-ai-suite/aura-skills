---
name: aura-model-roster
description: Real, dated data on the AI models behind your coding agents — tier, what each is good and bad at, list price, limits and browser access, every vendor number with its official link — so the lead assigns each task to the right model. Load it when you are the lead and must decide who gets a task, or when the user asks which model to use. Meant to be refreshed regularly. Not for Builders.
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

## 0. Ground rules

- **No official link, no number.** Every vendor figure here links to the vendor's own page
  (§5) and carries the date it was read. Anything without one is marked **unverified** or left out.
- **Don't compare different benchmarks.** DeepSWE v1.1, Terminal-Bench 2.1 / 4.0, OSWorld 2.1
  and GDPval-AA v2.1 are not interchangeable.
- **The harness matters.** DeepSeek V4.1-Flash scores DeepSWE v1.1 **74.2** with mini-SWE but
  **65.5** inside OpenCode and **65.6** inside Codex [DS-card]. Use the number for *your* tool.
- **A big context window does not prove retention.**
- **The CLI is not the provider.** List API prices ≠ what a subscription charges you.
- **Price is not tier.** A cheap model with a good protocol can beat an expensive one (§4).

## 1. Tiers

| Tier | Gets | Never gets |
|---|---|---|
| **frontier** | Specs, architecture, the Gate, long tasks that bounced before | — |
| **strong** | Full features with tests, given a written spec | Open design decisions without a lead |
| **efficient** | Bounded, mechanical work: `file:line`, values, reference code, zero open choices | Anything it has to decide |
| **read-only** | Reading, summarizing, answering about the code | Writes and commits |

If you can't write the task that literally for an efficient model, it isn't an efficient-model task.

## 2. Active models (read 2026-10-08)

Prices are API list prices per 1M tokens: input / output (cache read).

| Model | Used through | Tier | Good at | Not for | Price | Limits | Browser |
|---|---|---|---|---|---|---|---|
| **Claude Opus 5.5** `claude-opus-5-5` | Claude Code | frontier | Vendor: "long-running agentic coding and knowledge work" [A-models] | — | $4 / $20 ($0.20) [A-price] | 1M context, 128K output, cutoff Jun 2026 [A-models] | **Yes** with Claude in Chrome (measured) |
| **Claude Sonnet 5.5** `claude-sonnet-5-5` | Claude Code | strong | Terminal-Bench 4.0 **70.6%**, OSWorld 2.1 offline **83.9%**, GDPval-AA v2.1 **1840** [A-haiku] | — | $2 / $10 ($0.10) [A-price] | 1M / 128K, cutoff Jun 2026 [A-models] | Same as Opus (not measured separately) |
| **Claude Haiku 5.5** `claude-haiku-5-5` | Claude Code (subagent) | efficient | Narrow tasks: compaction, summarization, subagent work [A-haiku]. Terminal-Bench 4.0 **39.2%**, OSWorld 2.1 offline **72.4%**, GDPval-AA v2.1 **1620** [A-haiku] | Vendor: "Sonnet 5.5 and Opus 5.5 remain better choices for complex agentic coding" [A-haiku] | ≤100K prompt: $0.10 / $0.50 ($0.01); >100K: $0.50 / $2.50 ($0.05) [A-price] | 1M / 128K, cutoff Jun 2026; released 2026-10-07 [A-models] | Not measured as a builder |
| **GPT-6.1 Sol** `gpt-6.1-sol` | Codex | frontier | DeepSWE: matches GPT-6 Astra at ~1/5 the cost, +6.4 over GPT-6 Sol; AutomationBench: +2.2 pp over Opus 5.5 at medium effort, ~1/3 the cost [O-sol] | Vendor points to GPT-6 Astra for the hardest reasoning [O-sol] | $2 / $10 ($0.10); >272K input: 2× input, 1.5× output for the whole request [O-model] | 1.05M context, 922K max input, 128K output, cutoff 2026-04-30 [O-model] | **No** in the Aura team's Codex sessions (measured) |
| **DeepSeek V4.1-Flash** `deepseek-flash` | OpenCode | strong (with a written API) | Inside OpenCode: DeepSWE v1.1 **65.5**, Terminal-Bench 2.1 **85.0** (Max effort) [DS-card]. Codeforces **3471** [DS-card] | Facts it must recall: SimpleQA-Verified **42.3** (base, 25-shot) [DS-card] — write the API into the task. Hard terminal chains: Terminal-Bench 4.0 **31.2** [DS-card] | Off-peak $0.15 / $0.60 ($0.003); peak 2×: 01:00–04:00 and 06:00–10:00 UTC Mon–Fri [DS-price] | 1M context; 384K max output; concurrency 2500 [DS-price] | **No** (measured) |

**Privacy (training on prompts, retention, ZDR): unverified for every row.** Read the provider's
data-use page for the channel you actually use: a subscription and the API can differ.
**Subscription quotas: unverified.** Check your plan's page.

## 3. Retired, renamed — and one correction

| Date | What changed (source) | What to do |
|---|---|---|
| 2026-09-10 | V4 Flash and V4 Flash Vision Exp **retired**; `deepseek-v4-flash` and `deepseek-v4-flash-vision-exp` temporarily route to V4.1-Flash [DS-log] | Write the agent as `deepseek-flash` / V4.1-Flash |
| 2026-09-10 | ⚠️ **Correction:** DeepSeek had announced that `deepseek-v4-pro` would route to V4.1-Flash on 2026-09-14. It reversed that: "we have decided to continue providing API services for DeepSeek V4 Pro after September 14, 2026, with the billing method remaining unchanged" [DS-log]. Pricing lists `deepseek-v4-pro` (DeepSeek-V4-Pro-0813) on its own [DS-price] | `deepseek-v4-pro` is still V4-Pro. Don't treat it as Flash |
| 2026-10-07 | Claude Haiku 5.5 released [A-models] | — |

Old commits signed with a retired name stay as they are: they were true when written.

## 4. Your measured record — it beats every benchmark

The lead adds a line to the **model record in `.aura/project.md`** when closing each task, with
what *they* saw, not what the Builder claimed:

```
YYYY-MM-DD · <tool·model> (effort) · <task> · ✅/❌ deliverable, tests · 🟢/⚠️/🔴 protocol: isolated, pushed, handoff before done, declared what it did NOT verify
```

What the Aura team's own logs show (two repos, 2026-09-07 → 2026-10-08; measured, not public):

- 🟢 **The cheapest model gave the best protocol.** DeepSeek V4/V4.1-Flash: most of its tasks
  ended "declared green = real green", including Rust. It stopped and asked before deviating,
  and wrote "not measured" instead of guessing. Repeated defects still go in the spec.
- 🔴 **The false greens came from mechanical tasks**, not hard ones. The lead re-runs the checks.
- 🔴 **The costliest failure was protocol, not code:** work left uncommitted when a session died.
  Ask for commit + push before "done".
- ⚠️ **Repeated defects go in the kickoff prompt.** A model that broke commit trailers twice
  kept doing it until the prompt said so.

## 5. Sources (read 2026-10-08)

- [A-models] https://platform.claude.com/docs/en/about-claude/models/overview
- [A-price] https://platform.claude.com/docs/en/about-claude/pricing
- [A-haiku] https://www.anthropic.com/claude-haiku-5-5
- [O-sol] https://openai.com/index/introducing-gpt-6-1-sol/
- [O-model] https://developers.openai.com/api/docs/models/gpt-6.1-sol
- [DS-card] https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
- [DS-price] https://api-docs.deepseek.com/quick_start/pricing
- [DS-log] https://api-docs.deepseek.com/updates/

## 6. How to refresh

1. **Vendors:** only the vendor's own pages: model page, pricing page, announcement, model or
   system card. Copy the number, the benchmark *name and version*, the effort and harness, and
   add the link to §5. A news article or aggregator is not a source.
2. **Your agents:** which model each tool actually runs today (`/model`, its config). Agent
   names like `codex-2` don't tell you the model — ask the user once and write it in the profile.
3. **Quotas and privacy:** your plan's page and the provider's data-use page for your channel.
4. Update "Last reviewed", move anything retired to §3, keep this file ≤ 170 lines.
