---
name: aura-model-roster
description: Real, dated data on the AI models behind your coding agents — tier, what each is good and bad at, list price, limits and browser access, every vendor number with its official link — so the lead assigns each task to the right model. Load it when you are the lead and must decide who gets a task, or when the user asks which model to use. Meant to be refreshed regularly. Not for Builders.
---

# Model roster

> **Last reviewed: 2026-10-16** (partial update 2026-10-28: GPT-6.1 Terra, Beam Free only).
> **Freshness rule:** if today is more than 30 days after that date, tell the user *before*
> assigning ("the model roster was last reviewed on <date>; want me to refresh it?") and offer to
> refresh. Models, prices and quotas change monthly; a stale table assigns with confidence and
> gets it wrong.
>
> **🔄 Keep this file updated.** It's the one Aura skill that goes stale on purpose. Refresh it
> yourself (§5), or reinstall the latest `aura-skills` to get ours.
>
> The tables are a starting point. **How a model behaved on your own project** — the model record
> in `.aura/project.md` — **overrides them.** That record lives in your profile, not here, so
> updating this file never erases it.

## 0. Ground rules

- **No official link, no number.** Every vendor figure here links to the vendor's own page
  (`references/models.md`) and carries the date it was read. Anything without one is marked **unverified** or left out.
- **Don't compare different benchmarks.** DeepSWE v1.1, Terminal-Bench 2.1 / 4.0, OSWorld 2.1
  and GDPval-AA v2.1 are not interchangeable.
- **The harness matters.** DeepSeek V4.1-Flash scores DeepSWE v1.1 **74.2** with mini-SWE,
  **69.8** inside Claude Code, **65.6** inside Codex and **65.5** inside OpenCode. Use the number
  for *your* tool.
- **A big context window does not prove retention.**
- **The CLI is not the provider.** List API prices ≠ what a subscription charges you.
- **Price is not tier.** A cheap model with a good protocol can beat an expensive one (§3).

## 1. Tiers

| Tier | Gets | Never gets |
|---|---|---|
| **frontier** | Specs, architecture, the Gate, long tasks that bounced before | — |
| **strong** | Full features with tests, given a written spec | Open design decisions without a lead |
| **efficient** | Bounded, mechanical work: `file:line`, values, reference code, zero open choices | Anything it has to decide |
| **read-only** | Reading, summarizing, answering about the code | Writes and commits |

If you can't write the task that literally for an efficient model, it isn't an efficient-model task.

## 2. Pick by job

The full table (every selectable model, price, limits, benchmarks, source key per number) is
`references/models.md` — **load it only when choosing between models.** Read 2026-10-16.

| Job | Start with | Why / watch for |
|---|---|---|
| Specs, the Gate, long tasks that bounced | Claude Opus 5.5 · GPT-6.1 Sol | Frontier. Fable 5.1 and GPT-6 Astra cost 2.5-5× more: only for what these failed |
| Full feature with tests, written spec | Claude Sonnet 5.5 · DeepSeek V4.1-Flash · Gemini 4 Argon (self-reported scores) | Strong. Flash: write the API, security and async rules into the spec |
| Bounded mechanical work | Claude Haiku 5.5 · GPT-6 Luna · Gemini 3.8 Flash | Efficient: `file:line`, zero open choices; the Gate re-runs every claim |
| Reading, summarizing, bulk | Haiku 5.5 · Gemini 3.5 Flash-Lite | Read-only: no writes, no commits |

- **Open-weight and ⚠️ rows** (Grok 4.7, Kimi K3, GLM-5.3, MiniMax M3) come from search summaries of
  vendor pages: re-open the source before assigning on them. ⚠️ they are not measured here.
- **Dated prices:** Gemini 4 Argon doubles on 2026-12-01, Gemini 3.8 Flash on 2027-01-01.
- **Gone soon:** Claude 4.6 models and GPT-OSS 120B leave Antigravity on 2026-11-02.
- **Renamed:** `deepseek-v4-flash` routes to V4.1-Flash since 2026-09-10 — write `deepseek-flash`.
  `deepseek-v4-pro` is still V4-Pro (DeepSeek reversed the planned routing).
- **Browser:** Claude Code has it with Claude in Chrome (measured); Codex sessions of the Aura
  team have none (measured); OpenCode with DeepSeek has none (measured). Others: not measured.
- **Privacy:** a `*-free` OpenCode id may train on your prompts, except the four zero-retention
  ones (GLM-5.3-Flash Free, DeepSeek V4.1 Flash Free, Space Bunny Free, LongCat 2.5 Preview Free).
  **Never send private code to the others** — Beam Free is not one of the four: it doesn't train on prompts, but keeps them 30 days, and it is blocked in many countries. Data-use for every other channel and **subscription
  quotas: unverified** — read the provider's page for the channel you use.

## 3. Your measured record — it beats every benchmark

The lead adds a line to the **model record in `.aura/project.md`** when closing each task, with
what *they* saw, not what the Builder claimed:

```
YYYY-MM-DD · <tool·model> (effort) · <task> · ✅/❌ deliverable, tests · 🟢/⚠️/🔴 protocol: isolated, pushed, handoff before done, declared what it did NOT verify
```

What the Aura team's own logs show (8 repos, closing logs and `Agent:` trailers, 2026-06-07 →
2026-10-16; measured unless marked inferred; anonymized in the aura-skills repo, `.aura/research/`):

- 🟢 **The cheapest model gave the cleanest protocol.** DeepSeek V4.1-Flash: 233 tasks
  (2026-08-11 → 2026-10-14), 0 false greens; in one repo's registry 23 rows, 0 false greens, and
  it stopped and asked on ≥4 occasions (2026-09-27 → 2026-10-08). Defects: synchronous Rust
  commands blocking the UI in 2 of 2 tasks (2026-09-27), a token in a process argument list
  (2026-09-27), one session dead before its first commit (2026-09-17). **State security and async
  rules in the spec, and tell it to commit early.**
- 🔴 **Work that never left the worktree is the costliest failure.** 13 trailers from 4 model
  families record Gate rescues of uncommitted or unpushed work (2026-07-30 → 2026-09-14), plus 2
  session deaths (2026-09-07, 2026-09-17). Ask for commit + push before "done".
- 🔴 **False greens are rare and came from mechanical tasks.** 1 builder claim proven false
  (2026-09-07), 1 test-level false green (2026-07-31). `qwen3.7`: 3 of 3 logged tasks had problems
  on 2026-09-07 (unpushed commit, a false green, 2 defects at merge): mechanical tasks only.
- ⚠️ **A repeated defect goes in the kickoff prompt.** `gpt-5.6-luna`: 2 of 2 commits with broken
  trailers (2026-09-07/08) — give it the trailer check command. `gpt-5.6-terra`: 3 tasks
  (2026-08-11 → 2026-08-20) with tests the criteria named that did not exist — name the tests.
- **Opus 5.5:** 73 tasks (2026-09-23 → 2026-10-14), 5 sent back — the lowest rate among models
  with 50+ tasks (inferred: newer, better-specified tasks). Ask for the worst-case fixture on
  layout work (2026-09-29, a fix hid controls).
- **Authorship and verification on different agents.** On 2026-09-14 one model wrote the spec,
  built and gated 3 stacked specs; the only safeguard was its own measurements.
- **Too little data:** Codex `gpt-6.1-sol` 10 tasks (2026-10-07 → 2026-10-13); `haiku-5.5` 11
  trailers (2026-10-15 → 2026-10-16); `gpt-6-astra` 15 trailers, no closing entries. Don't judge.

## 4. Which models can the user pick? — list them, don't guess

| Tool | How to list |
|---|---|
| Claude Code | `/model` opens the picker (no CLI listing); aliases `default`, `opus`, `sonnet`, `haiku`, `fable`, `best`, `opusplan`, or a full id |
| Codex | `codex -m <id>`; the account's list is in `~/.codex/models_cache.json` (`visibility: list`); `codex` may live under nvm's Node, not on the PATH |
| OpenCode | `opencode models` (487 ids on 2026-10-16: it lists the catalog, **not** which providers are logged in); `-m provider/model` |
| Antigravity CLI | `agy models` — the ids your plan allows; the docs list more, gated by plan |

## 5. How to refresh

1. **Vendors:** only the vendor's own pages: model page, pricing page, announcement, model or
   system card. Copy the number, the benchmark *name and version*, the effort and harness, and add
   the link to `references/models.md`. A news article or aggregator is not a source. A search
   summary is marked ⚠️ until the page is fetched.
2. **Your agents:** which model each tool actually runs today (§4). Agent names like `codex-2`
   don't tell you the model — ask the user once and write it in the profile.
3. **Quotas and privacy:** your plan's page and the provider's data-use page for your channel.
4. **Your own history:** count it from your `Agent:` trailers and closing logs (or the profile's
   model record); back every §3 claim with a count and a date range.
5. Update "Last reviewed", move anything retired out, keep this file ≤ 170 lines.
