# Vendor-sourced model inventory — Claude Code, Codex, OpenCode, Antigravity CLI

> **Read 2026-10-16** by claude-3 (Claude Code · Sonnet 5.5) for task `roster-vendor-refresh`.
> Method: local commands for Table A, vendor pages only (WebFetch / WebSearch) for Table B.
> Prices are API list prices, USD per 1M tokens: input / output (cache read). **List API price ≠ what
> a subscription charges you.** Benchmarks follow `aura-model-roster` §0: name **and version**, effort
> and harness as the vendor states them; never compared across benchmarks. "unverified" = no vendor
> page read today.
> Not covered by this file (other tasks): our own history (`roster-local-evidence`) and editing the skill
> (`roster-rewrite`).

## Table A — tool → models a user can select

Ids are spelled as the tool spells them. "Key?" = what the user needs beyond installing the tool.

### A1. Claude Code 2.1.302 (`claude --version`, 2026-10-16)

Source: [CC-model] (docs; there is no CLI listing command — `/model` opens the picker).

| Id / alias | Resolves to (Anthropic API) | Key? |
|---|---|---|
| `default` | **Opus 5.5** on Pro, Max, Team, Enterprise, API, Bedrock, Google Cloud; Sonnet 4.5 on Foundry [CC-model] | Claude plan or API key |
| `opus` / `opus[1m]` | Opus 5.5 `claude-opus-5-5` | same |
| `sonnet` / `sonnet[1m]` | Sonnet 5.5 `claude-sonnet-5-5` | same |
| `haiku` | Haiku 5.5 `claude-haiku-5-5` | same |
| `fable` | Fable 5.1 `claude-fable-5-1` (needs Claude Code ≥ 2.1.257); **not the default anywhere**; may bill to usage credits depending on plan and seat [CC-model] | same, plus consent prompt |
| `best` | Fable where available, else Opus [CC-model] | same |
| `opusplan` | Opus in plan mode, Sonnet to execute [CC-model] | same |
| full ids (`claude-opus-5-5`, …) | any pinned model, e.g. Opus 5 / 4.8 / 4.7 / 4.6, Sonnet 5 / 4.6, Haiku 4.5 [A-models] | same |

Minimum Claude Code versions: Opus 5.5 ≥ 2.1.280, Sonnet 5.5 ≥ 2.1.284, Haiku 5.5 ≥ 2.1.293 [CC-model].
Effort: `low|medium|high|xhigh|max` on the 5.x models; defaults `medium` on Opus/Haiku 5.5, `high` on Sonnet 5.5 and Fable 5.1 [CC-model][A-models].
`ANTHROPIC_BASE_URL`-style routing to non-Anthropic models: not read, out of this table.

### A2. Codex CLI 0.163.0 (measured by the Gate, 2026-10-16)

`codex` is installed under nvm's Node 24 (`~/.nvm/versions/node/v24.18.1/bin/codex`), not on the
default PATH — that's why `codex --version` first failed. `codex --version` → `codex-cli 0.163.0`.
`~/.codex/models_cache.json` (the CLI's own model list for this account) shows, as `visibility: list`:
`gpt-6.1-sol`, `gpt-6-astra`, `gpt-6-sol`, `gpt-6-luna`, `gpt-5.6-sol`, `gpt-5.6-terra`, `gpt-5.6-luna`
(hidden: `gpt-reserve`, `codex-auto-review`). Config default: `model = "gpt-6.1-sol"`, effort `high`.
Descriptions from [CX-models]:

| Id (`codex -m <id>`) | Notes | Key? |
|---|---|---|
| `gpt-6-astra` | "most capable model for complex work" [CX-models] | ChatGPT plan or API key; Astra rollout began with enterprise trusted access (see B) |
| `gpt-6.1-sol` | recommended for complex coding and agentic work; Plus, Pro, Business, Enterprise, Edu at launch, **not Free/Go** [CX-models] | ChatGPT plan or API key |
| `gpt-6-luna` | "most efficient model for focused, high-volume tasks"; the page's pick for Free and Go [CX-models] | ChatGPT plan (incl. Free/Go) or API key |
| `gpt-6-sol`, `gpt-5.6-*` | older generations still selectable in this account's list | same |

Effort: Light/Low → Medium → High → Extra High; **Max** (more time on one task) and **Ultra** (parallel subagents; not on Luna) under `/model` → "More reasoning…" [CX-models].
API-key availability "follows your API organization and project"; the page has no per-model matrix [CX-models].

### A3. OpenCode 1.19.0 (`~/.opencode/bin/opencode --version`; `opencode models`, 2026-10-16)

Counts by provider from `opencode models | awk -F/ '{print $1}' | sort | uniq -c`:
`opencode` 45 · `opencode-go` 29 · `openai` 24 · `deepseek` 2 · `openrouter` 387 (**487 ids total**).
The command lists what the build ships/preloads; which providers are actually authenticated on a given
machine was **not measured** (⚠️). Sources for key requirements: [OC-zen], [OC-models].

| Provider prefix | What it is | Key? | Examples (exact ids) |
|---|---|---|---|
| `opencode/` | OpenCode Console, pay-as-you-go, `opencode/<model-id>` [OC-zen] | Console account + API key + credits; some `-free` ids need none beyond sign-in [OC-zen] | `claude-fable-5-1`, `claude-opus-5-5`, `claude-sonnet-5-5`, `claude-haiku-5-5`, `gpt-6.1-sol`, `gpt-6-astra`, `gemini-4-argon`, `gemini-3.8-flash`, `grok-4.7`, `kimi-k3`, `glm-5.3`, `minimax-m3`, `deepseek-v4.1-flash`, `deepseek-v4-pro`, `qwen3.8-max`, `mistral-large-4`, `muse-spark-1.3`, free: `deepseek-v4.1-flash-free`, `glm-5.3-flash-free`, `big-pickle`, `beam-free`, … |
| `opencode-go/` | OpenCode Go — subscription with included usage [OC-zen] | Go subscription (page gives no price: unverified) | `claude-haiku-5-5`, `deepseek-v4.1-flash`, `glm-5.3`, `kimi-k3`, `minimax-m3`, `gpt-6-luna`, `qwen3.8-max`, `mimo-v2.5-pro`, … |
| `openai/` | OpenAI directly | ChatGPT login or OpenAI API key (⚠️ mechanism not read today) | `gpt-6.1-sol`, `gpt-6.1-sol-fast`, `gpt-6.1-sol-ultrafast`, `gpt-6-astra`, `gpt-6-luna`, `gpt-5.6-terra`, `gpt-5.5`, `gpt-5.4-mini` |
| `deepseek/` | DeepSeek API | DeepSeek API key | `deepseek-flash`, `deepseek-v4-pro` |
| `openrouter/` | OpenRouter gateway (aliases like `~anthropic/claude-opus-latest`) | OpenRouter key (⚠️ not read today) | `anthropic/claude-opus-5.5`, `~openai/gpt-sol-latest`, … |

Selection: `--model/-m provider/model`, `model` in config, `/models` in the TUI; variants (effort) per
provider [OC-models]. Privacy notes for OpenCode-hosted free models are in §Privacy below.

### A4. Antigravity CLI `agy` 1.4.0 (`agy --version`; `agy models`, 2026-10-16)

`agy models` on this machine printed **6 ids** (id → label):
`gemini-3.8-flash-high|medium|low` (Gemini 3.8 Flash), `claude-sonnet-4-6` (Claude Sonnet 4.6 Thinking),
`claude-opus-4-6-thinking` (Claude Opus 4.6 Thinking), `gpt-oss-120b-medium` (GPT-OSS 120B Medium).
The vendor docs list more, gated by plan [AG-models]:

| Model | Free & Plus | Pro | Ultra | Enterprise |
|---|---|---|---|---|
| Gemini 4 Argon | No | Yes (non-trial only) | Yes | Yes |
| Gemini 3.8 Flash | Yes | Yes | Yes | Yes |
| Gemini 3.7 / 3.6 Flash, 3.1 Pro | No | No | No | Yes |
| Claude Sonnet 5.5, Opus 5.5 (Thinking) | No | Yes (non-trial only) | Yes | Yes |
| Claude Sonnet 4.6, Opus 4.6 (Thinking) | Yes | Yes | No | No |
| GPT-OSS 120B | Yes | Yes | Yes | No |

The local six ids equal the "Free & Plus" column exactly — **inference** that this account is on that
tier (not checked). **Claude 4.6 models and GPT-OSS 120B are scheduled for removal on 2026-11-02** [AG-models].
Thinking levels: Argon Low/Medium/High (default High); Flash 3.6–3.8 Low/Medium/High (default Medium) plus Fast;
3.1 Pro Low/High [AG-models]. Usage limits are tracked separately for Gemini vs Claude+GPT, weekly and 5-hour [AG-models].
Gemini 4 Argon is in the App, CLI and IDE extensions, **not** the standalone IDE [AG-models].

## Table B — per model

Tier is **proposed**, with the reason. "Good at / not for" quotes the vendor or says unverified.
Source keys resolve in §Sources. Models 1–5 are the current roster §2.

### Current roster §2 — re-checked 2026-10-16

| # | Model (id) | Vendor / via | Proposed tier | Good at / not for (vendor evidence) | Price in/out (cache) | Context / output / cutoff / release | Notes | Status vs roster |
|---|---|---|---|---|---|---|---|---|
| 1 | **Claude Opus 5.5** `claude-opus-5-5` | Anthropic · CC, OC, agy (Pro+) | frontier (vendor: "start with Opus 5.5 for most workloads"; scores at/above Fable 5.1 on most rows below) | "long-running agentic coding and knowledge work" [A-models]. Vendor table, adaptive thinking **max** effort unless noted: Terminal-Bench **4.0** 66.4% (xhigh); FrontierCode **v1.1** (Main) 54.4%; CursorBench **4.0** 57.8%; GDPval-AA **v2.1** 1846 Elo; OSWorld **2.1** (partial) 81.8%; HLE with tools 67.7% [A-opus]. At default (medium) effort: FrontierCode 54.6%, CursorBench 52.5% [A-opus]. "performs at the level of Claude Fable 5.1 on most work" [A-opus] | $4 / $20 ($0.20) [A-price] | 1M / 128K / Jun 2026 / **2026-09-22** [A-opus-pg]; default effort `medium` [A-models] | thinking always on; can't be disabled [A-opus-pg] | **Unchanged** (price, limits, cutoff read 2026-10-16). Roster lacks the benchmarks and release date above |
| 2 | **Claude Sonnet 5.5** `claude-sonnet-5-5` | Anthropic · CC, OC, agy (Pro+) | strong | "best combination of speed and intelligence" [A-models]. Terminal-Bench **4.0** 70.6% (pass@1), OSWorld **2.1** offline 83.9%, GDPval-AA **v2.1** 1840, HLE no tools 56.9%, FrontierCode **1.1** (Main) 52.1% **at xhigh** [A-haiku] | $2 / $10 ($0.10) [A-price] | 1M / 128K / Jun 2026 / **2026-09-28** [A-sonnet-pg]; default effort `high` | non-default `temperature/top_p/top_k` → 400 [A-sonnet-pg] | **Unchanged.** ⚠️ Roster's 70.6% Terminal-Bench 4.0 for Sonnet exceeds Opus 5.5's 66.4% *in the vendor's other table* — different pages, effort not stated for Sonnet's: don't rank them on it |
| 3 | **Claude Haiku 5.5** `claude-haiku-5-5` | Anthropic · CC (subagent), OC, OC-Go | efficient | "narrower tasks such as compaction, summarization, and subagent work"; "Sonnet 5.5 and Opus 5.5 remain better choices for complex agentic coding tasks like those measured by Terminal-Bench 4.0" [A-haiku]. Terminal-Bench **4.0** 39.2%, OSWorld **2.1** offline 72.4%, GDPval-AA **v2.1** 1620 [A-haiku] | ≤100K prompt: $0.10 / $0.50 ($0.01); >100K: $0.50 / $2.50 ($0.05) [A-price] | 1M / 128K / Jun 2026 / **2026-10-07** [A-models][A-haiku] | first Haiku with adjustable effort (Low…Max) [A-haiku] | **Unchanged** |
| 4 | **GPT-6.1 Sol** `gpt-6.1-sol` | OpenAI · Codex, OC, openai/ | frontier (roster) — vendor itself says "near-Astra performance … at a lower cost" [CX-models][O-api] | "close to Astra on complex coding, computer use, and professional work" [O-model]. Announcement benchmarks (DeepSWE, AutomationBench) **not re-read: the announcement page returned HTTP 403** — ⚠️ roster numbers from [O-sol] are *unverified this round*, not contradicted | $2 / $10 ($0.10); cache write $2.50; >272K input: 2× input and cache, 1.5× output for the whole request [O-model][O-price] | 1.05M ctx / 922K max input / 128K out / cutoff 2026-04-30 [O-model]; release date not on the model page | efforts low→max [O-api] | **Unchanged** (price, limits). Release date unverified (see §Retired) |
| 5 | **DeepSeek V4.1-Flash** `deepseek-flash` (OC: `deepseek-v4.1-flash`) | DeepSeek · OC, OC-Go, deepseek/ | strong with a written API (roster) | Max effort, N=8: DeepSWE **v1.1** — mini-SWE **74.2**, **Claude Code 69.8**, **Codex 65.6**, **OpenCode 65.5**; Terminal-Bench **2.1** (pass@1, N=3, no network) — OpenCode **85.0**, Claude Code 88.0, Codex 84.1; Terminal-Bench **4.0** 31.2; SimpleQA-Verified **42.3** (25-shot EM, *base* model); Codeforces 3471 [DS-card] | off-peak $0.15 / $0.60 ($0.003); peak 2×: $0.30 / $1.20 ($0.006) [DS-price] | 1M ctx / 384K out [DS-price]; released **2026-09-10** [DS-log] | peak = 01:00–04:00 and 06:00–10:00 UTC Mon–Fri, excl. Chinese holidays [DS-price]; vision supported [DS-price] | **Unchanged.** Added: Claude Code harness 69.8 (DeepSWE) / 88.0 (TB 2.1) — better than OpenCode's for the same model |

### Beyond the roster — models a user of these 4 tools can select (read 2026-10-16)

| # | Model (id) | Vendor / reachable via | Proposed tier + reason | Good at / not for | Price in/out (cache) | Context / output / cutoff / release | Browser / tools notes |
|---|---|---|---|---|---|---|---|
| 6 | **Claude Fable 5.1** `claude-fable-5-1` | Anthropic · CC (`fable`), OC | frontier+ (vendor: "demanding reasoning and long-horizon agentic work, or when your evals on Opus 5.5 at higher effort still fall short") [A-models] | Vendor's own Opus 5.5 table has Fable 5.1 *below* Opus 5.5 on every row (e.g. Terminal-Bench 4.0 55.8% vs 66.4%, GDPval-AA v2.1 1735 vs 1846) while saying the real gap is "narrower than these scores suggest" [A-opus]. Slower [A-models]. **Price tier is 2.5× Opus** — only for what Opus 5.5 failed | $10 / $50 ($0.25) [A-price] | 1M / 128K / Jun 2026 / **2026-09-01** [A-fable-pg] | forced tool use errors; thinking tied to the model [A-fable-pg]; not CC default; may bill to usage credits [CC-model]. Claude Mythos 5.1 = same model for verified orgs only [A-fable-pg] |
| 7 | **GPT-6 Astra** `gpt-6-astra` | OpenAI · Codex, OC, openai/ | frontier (vendor: "most capable model for the most demanding work") [O-api] | Anthropic's table: Terminal-Bench **4.0** 57.9% (Astra at **high** effort, "as reported by OpenAI") vs Opus 5.5 66.4% (xhigh) [A-opus] — **third-party-reported, different effort**; Google's card: FrontierSWE v2 Astra 65.5% vs Argon 55.0% [G-card]. Introduced 2026-09-03, enterprise trusted-access first (OpenAI/third-hand: **unverified**, from a search snippet) | $10 / $50 ($1.00) [O-price] | 1.05M / 128K / cutoff 2026-04-30 [O-api] | computer use, web search, file search [O-api]; efforts low→max, Ultra in Codex [CX-models] |
| 8 | **GPT-6 Luna** `gpt-6-luna` | OpenAI · Codex, OC, OC-Go, openai/ | efficient (vendor: "most efficient … focused, high-volume tasks") [O-api] | Anthropic's table: Terminal-Bench **4.0** 16.4%, OSWorld **2.1** offline 48.9%, GDPval-AA **v2.1** 1437 [A-haiku] — third-party-reported against Haiku 5.5 (39.2% / 72.4% / 1620) | $0.10 / $0.50 ($0.01) [O-price] | 1.05M / 128K / cutoff **2026-05-18** [O-api] | efforts none→max [O-api]; the Codex pick for Free/Go [CX-models] |
| 9 | **GPT-6 Sol** `gpt-6-sol` | OpenAI · OC, openai/ | strong (not re-measured; superseded by 6.1 Sol in Codex's docs) | no vendor benchmark read today: unverified | $2 / $10 ($0.20) [O-price] | not read: unverified | in OC list; absent from Codex docs list [CX-models] |
| 10 | **GPT-5.5** `gpt-5.5` | OpenAI · OC, openai/ | strong, **legacy** (reason: $5 / $30 vs Sol's $2 / $10) | unverified | $5 / $30 ($0.50); >272K: $10 / $45 [O-price] | not read | `gpt-5.5-pro` $30 / $180 [O-price] |
| 11 | **DeepSeek V4-Pro** `deepseek-v4-pro` (V4-Pro-0813) | DeepSeek · OC, OC-Go, deepseek/ | strong (written API) — not re-measured here; no vendor benchmark read today | **Not Flash:** DeepSeek reversed the routing plan, Pro "continues … after September 14, 2026" [DS-log] | off-peak $0.66 / $1.98 ($0.022); peak $1.32 / $3.96 ($0.044) [DS-price] | 1M / 384K [DS-price] | **no vision** [DS-price]; concurrency 500 [DS-price] |
| 12 | **Gemini 4 Argon** `gemini-4-argon` | Google · agy (Pro+), OC | frontier (vendor: "flagship reasoning model for complex software engineering … autonomous multi-step agents") [G-argon] | Vendor card (self-reported, scores as listed): DeepSWE **v1.1** 77.9%; Terminal-bench **4.0** 57.4% (Opus 5.5 66.4%); FrontierSWE **v2** 55.0% (Astra 65.5%); OSWorld-**2.0** offline partial 69.2%; AutomationBench 51.3% [G-card]. Limits: "can hallucinate … occasionally slow or time out" [G-card] | **$2 / $10 ($0.10) until 2026-11-30, then $4 / $20 ($0.20) from 2026-12-01** [G-price]; OC Console: 50% off through 2026-11-30 [OC-zen] | 1,048,576 / 65,536 default (1,048,576 with long decode) / cutoff **March 2026** / card **2026-10-13** [G-argon][G-card] | computer use *Preview*; implicit caching only [G-argon] |
| 13 | **Gemini 3.8 Flash** `gemini-3.8-flash` | Google · agy (all plans incl. Free), OC, OC-Go | efficient→strong (no vendor benchmark read today) | vendor: "most capable Flash model … long-running software engineering, autonomous agents" [G-flash]; benchmark: unverified | **$0.75 / $3.75 ($0.075) until 2027-01-01, then $1.50 / $7.50**; storage $0.50/1M tok/h [G-price]. Free tier free of charge [G-price] | 1,048,576 / 65,536 / cutoff not stated / updated Sept 2026 (page 2026-09-02) [G-flash] | `minimal` thinking unsupported [G-flash]; computer use preview |
| 14 | **Gemini 3.5 Flash-Lite** `gemini-3.5-flash-lite` | Google · OC | efficient (read-only/bulk) — price only | unverified | $0.30 / $2.50 ($0.03) [G-price] | not read | — |
| 15 | **Grok 4.7** `grok-4.7` | xAI (SpaceXSI) · OC, OC-Go | strong (vendor: "frontier model for coding, agentic tasks, and knowledge work") | Vendor announcement: DeepSWE **v1.1** 71.0% (high effort), CursorBench **4.0** 46.3%, Terminal-Bench **4.0** 57.9%; model card: Terminal-Bench 4.0 **38.0% at xhigh, Grok Build harness** — same benchmark, different setting, "do not compare" [X-news][X-card] (read via search snippets, ⚠️ not fetched in full) | <200K prompt: $2 / $6 ($0.50); ≥200K: $4 / $12 ($1.00), applied to the whole request [X-models] | 500K / output not listed / cutoff May 2026 [X-models]; card 2026-09-21 [X-card] | "Grok 4.7 Fast" is Cursor/Grok Build only, not in the API [X-models] |
| 16 | **grok-build-0.1** `grok-build-0.1` | xAI · OC | strong→efficient (coding model, 0.x) — unverified | unverified | <200K: $1 / $2 ($0.20); ≥200K: $2 / $4 ($0.40) [X-models] | 256K / not listed / not listed [X-models] | — |
| 17 | **Kimi K3** `kimi-k3` | Moonshot · OC, OC-Go | strong (open-weight; vendor: "still trails the most powerful proprietary models" — via a third-party quote, ⚠️) | HF card (vendor), reasoning **max**, temperature 1.0: GPQA Diamond 93.5, BrowseComp 91.2, SWE-Marathon 42.0, Terminal-Bench **2.1** 88.3 [K-hf]. Scores mix harnesses/third-party leaderboards per the card's footnotes — do not rank | $3 / $15 ($0.30); cache write $3 (5 min) / $6 (1 h) [K-price] | 1,048,576 / output not listed / API launch 2026-07-16 and weights 2026-07-27 (search snippet of a *third-party* overview: **unverified**) [K-price][K-hf] | 2.8T params, native vision [K-hf] |
| 18 | **Kimi K2.7 Code** `kimi-k2.7-code` | Moonshot · OC, OC-Go | efficient→strong (coding) — unverified | unverified | $0.95 / $4.00 ($0.19 hit) [K-price] | 262,144 / not listed [K-price] | — |
| 19 | **GLM-5.3** `glm-5.3` | Z.ai · OC, OC-Go | strong (open-weight) | HF card (vendor): Terminal-Bench **3.0** 28.3 (GLM-5.2: 4.6), DeepSWE **v1.1** 66.9 (GLM-5.2: 46.2), Terminal-Bench **2.1** 88.2, CyberGym 84.5% [Z-hf]. Z.ai's own evals; a Flash blog gives other numbers — ⚠️ sources disagree on some figures | $1.40 / $4.40 ($0.26) [Z-price] | context/output not listed on the pricing page: unverified; release date unverified | same base as GLM-5.2, post-training only [Z-docs] |
| 20 | **GLM-5.3-Flash** `glm-5.3-flash` (+ `-free` on OC) | Z.ai · OC, OC-Go | efficient (320B total / 18B active) | HF/blog: Terminal-Bench 2.1 **84.3** (vendor blog) [Z-docs]; unverified beyond that | $0.15 / $0.50 ($0.03) [Z-price] | not listed | OC's free variant: zero-retention, no training per OpenCode [OC-zen] |
| 21 | **MiniMax M3** `minimax-m3` | MiniMax · OC, OC-Go | strong→efficient (open-weight, 428B/23B active) | vendor blog (internal evals / own scaffolds, per its notes): BrowseComp 83.5; PostTrainBench 37.1 (Opus 4.7 42.4, GPT-5.5 39.3) [M-blog] — ⚠️ search snippet, not fetched in full | ≤512K: $0.30 / $1.20 ($0.06); >512K: $0.60 / $2.40 ($0.12) (includes a "permanent 50% discount") [M-price] | up to 1M, guaranteed min 512K / output not listed / released **2026-06-01** [M-blog] | Priority tier 1.5× [M-price] |

**Listed in `opencode models` but not source-read today** (Table A only; no price/benchmark claim made):
`qwen3.8-max`, `qwen3.8-flash`, `qwen3.7-plus` (Alibaba page lists names only, no price/limits [Q-list]), `mistral-large-4`
(Mistral page: "open-weight, general-purpose multimodal", v26.10, **no id/price/context listed** [Mis-ov]),
`muse-spark-1.3` (Meta), `mimo-v2.6-*` (Xiaomi), `longcat-*`, `nemotron-*`, `step-5-preview`, `hy3/hy4`, `big-pickle`, `beam-free`, `space-bunny`.
All **unverified** beyond existence in the CLI list.

## Retired, renamed, or newly changed since 2026-10-08

Nothing below is a change to a number read on 2026-10-08 — the five roster models are all **unchanged** (see B). What
is new or was missing:

| Date | Event | Source |
|---|---|---|
| 2026-10-07 | Claude Haiku 5.5 released (already in roster) | [A-haiku] |
| 2026-10-13 | Gemini 4 Argon model card published; API doc updated 2026-10-14 | [G-card][G-argon] |
| 2026-12-01 | **Gemini 4 Argon price doubles** to $4 / $20 ($0.20) | [G-price] |
| 2027-01-01 | **Gemini 3.8 Flash price doubles** to $1.50 / $7.50 ($0.15) | [G-price] |
| 2026-11-30 | End of OpenCode Console's 50%-off on Gemini 4 Argon and Mistral Large 4 (the page words the discount end for Argon only) | [OC-zen] |
| 2026-11-02 | **Claude Sonnet/Opus 4.6 and GPT-OSS 120B removed from Antigravity** | [AG-models] |
| 2026-09-01 (Fable 5.1), 2026-09-22 (Opus 5.5), 2026-09-28 (Sonnet 5.5) | release dates of roster models (roster had none) | [A-fable-pg][A-opus-pg][A-sonnet-pg] |
| — | Anthropic: Opus 4.1, Opus 4, Sonnet 4, Haiku 3.5 shown as **retired** (still on Bedrock/Google Cloud for some) | [A-price] |

## What in the current roster §2 is wrong or incomplete

1. **No error found in any price, limit or cutoff** of the 5 rows (re-read 2026-10-16).
2. **Missing:** Fable 5.1 (`fable` alias in Claude Code) — a model the user can pick today, 2.5× Opus. Also GPT-6 Astra and Luna, both in Codex's own model list.
3. **GPT-6.1 Sol row — unverified this round:** [O-sol] returned HTTP 403; its benchmark claims are neither confirmed nor refuted. OpenAI's model page confirms price/limits only.
4. **"Used through" understates reach:** Opus/Sonnet/Haiku 5.5 are also in OpenCode (`opencode/…`, Console key) and in Antigravity (Pro+ plans); GPT-6.1 Sol also in OpenCode (`openai/`, `opencode/`); DeepSeek Flash is scored in the Claude Code harness too (69.8 / 88.0).
5. **Opus 5.5 row has no benchmark**; the vendor now publishes them [A-opus]. Haiku row correctly cites [A-haiku].
6. **§0 harness rule** can be sharpened for DeepSeek Flash: DeepSWE 65.5 (OpenCode) < 65.6 (Codex) < 69.8 (Claude Code) < 74.2 (mini-SWE).

## Privacy and quota (only the provider's own page)

- **OpenCode Console** (opencode.ai): "Models are hosted in the US and EU. Providers generally follow a zero-retention policy and don't train on your data. Exceptions include OpenAI and Anthropic APIs, which retain requests for 30 days, and the free-model caveats" [OC-zen].
  Free ids: zero retention, no training — GLM-5.3-Flash Free, DeepSeek V4.1 Flash Free, Space Bunny Free, LongCat 2.5 Preview Free.
  **Collected data may be used to improve the model:** Big Pickle, Exo Free, MiMo-V2.6-Flash Free, MiMo-V2.5 Free, LL Alpha Free (30 days) and the Nemotron Free models (trial only, no confidential data).
  Beam Free: not trained on, retained 30 days. Muse Spark 1.3 Contributor: discount in exchange for training permission. [OC-zen]
  → **Never send private code to a `*-free` id other than the four zero-retention ones above.**
- **Everything else — Anthropic, OpenAI, Google, DeepSeek, xAI, Moonshot, Z.ai, MiniMax data-use for the channel you actually use: unverified.** No data-use page was read today.
- **Subscription quotas (Claude plans, ChatGPT plans, Antigravity Pro/Ultra, Go): unverified** — only Antigravity states that limits are weekly and 5-hourly and separate for Gemini vs Claude/GPT [AG-models]; no numbers.
- Fable usage "may bill to usage credits depending on your plan and seat tier" [CC-model].

## Third-party numbers (kept apart, never mixed with vendor numbers)

None used. Where one vendor's page quotes a competitor's score (e.g. Anthropic quoting GPT-6 Astra, Google quoting Opus 5.5), the row says so; treat it as that vendor's claim about someone else's model.

## Not verified / limits of this file

- Which `opencode` providers are authenticated on this machine was not tested; Table A3 is the build's catalog.
- Several Table B cells for Grok 4.7, Kimi K3, GLM-5.3, MiniMax M3 come from **search-result summaries of vendor pages**, not a full fetch; flagged ⚠️ — the Gate should re-open those sources first.
- Gemini 4 Argon, Kimi K3, GLM-5.3, MiniMax M3 benchmark tables are **self-reported** and use different harnesses.

## Sources (all read 2026-10-16 unless stated)

- [A-models] https://platform.claude.com/docs/en/about-claude/models/overview (fetched as /docs/en/models/overview)
- [A-price] https://platform.claude.com/docs/en/about-claude/pricing
- [A-opus-pg] https://platform.claude.com/docs/en/models/opus-5-5/overview
- [A-sonnet-pg] https://platform.claude.com/docs/en/models/sonnet-5-5/overview
- [A-fable-pg] https://platform.claude.com/docs/en/models/fable-5-1/overview
- [A-opus] https://www.anthropic.com/claude-opus-5-5
- [A-haiku] https://www.anthropic.com/claude-haiku-5-5
- [CC-model] https://code.claude.com/docs/en/model-config
- [O-api] https://developers.openai.com/api/docs/models
- [O-price] https://developers.openai.com/api/docs/pricing
- [O-model] https://developers.openai.com/api/docs/models/gpt-6.1-sol
- [O-sol] https://openai.com/index/introducing-gpt-6-1-sol/ — **HTTP 403, not read**
- [CX-models] https://learn.chatgpt.com/docs/models (redirect of developers.openai.com/codex/models)
- [DS-card] https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
- [DS-price] https://api-docs.deepseek.com/quick_start/pricing
- [DS-log] https://api-docs.deepseek.com/updates/
- [G-argon] https://ai.google.dev/gemini-api/docs/models/gemini-4-argon
- [G-flash] https://ai.google.dev/gemini-api/docs/models/gemini-3.8-flash
- [G-price] https://ai.google.dev/gemini-api/docs/pricing
- [G-card] https://deepmind.google/models/model-cards/gemini-4-argon/
- [AG-models] https://antigravity.google/docs/models
- [X-models] https://docs.x.ai/docs/models
- [X-news] https://x.ai/news/grok-4-7 — search summary only
- [X-card] https://media.x.ai/v1/website/4p7card-5eccc980.pdf — search summary only
- [K-price] https://platform.kimi.ai/docs/pricing/chat
- [K-hf] https://huggingface.co/moonshotai/Kimi-K3 — search summary only
- [Z-price] https://docs.z.ai/guides/overview/pricing
- [Z-docs] https://docs.z.ai/guides/llm/glm-5.3 and https://docs.z.ai/guides/vlm/glm-5.3-flash — search summary only
- [Z-hf] https://huggingface.co/zai-org/GLM-5.3 — search summary only
- [M-price] https://platform.minimax.io/docs/guides/pricing-paygo
- [M-blog] https://www.minimax.io/blog/minimax-m3 — search summary only
- [Q-list] https://www.alibabacloud.com/help/en/model-studio/models
- [Mis-ov] https://docs.mistral.ai/getting-started/models/models_overview/
- [OC-zen] https://opencode.ai/docs/zen/
- [OC-models] https://opencode.ai/docs/models/
- Local commands (2026-10-16): `claude --version` → 2.1.302; `agy --version` → 1.4.0; `agy models`; `~/.opencode/bin/opencode --version` → 1.19.0; `~/.opencode/bin/opencode models`; `codex --version` → not found; `~/.codex/config.toml`.
