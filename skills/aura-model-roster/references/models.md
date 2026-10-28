# Models — the full per-model table

Read **2026-10-16** from vendor pages (GPT-6.1 Terra and Beam Free added 2026-10-28; the rest not re-read). Load this only when choosing between models; `SKILL.md` has
the tiers and the pick-by-job table. Prices are API list prices per 1M tokens: input / output
(cache read). **List API price ≠ what a subscription charges you.** Benchmarks keep their name,
version, effort and harness; never compare across benchmarks. "unverified" = no vendor page read.
⚠️ = the cell comes from a search-result summary of the vendor page, not a full fetch: re-open the
source before relying on it. Tier is a proposal, with its reason.

Reach: **CC** Claude Code · **CX** Codex · **OC** OpenCode (Console key) · **OC-Go** OpenCode Go
subscription · **agy** Antigravity CLI (plan-gated).

## Anthropic

| Model (id) | Via | Tier | Good at / not for | Price | Context / output / cutoff / release | Notes |
|---|---|---|---|---|---|---|
| **Claude Opus 5.5** `claude-opus-5-5` | CC, OC, agy (Pro+) | frontier | "long-running agentic coding and knowledge work" [A-models]. Max effort: Terminal-Bench 4.0 66.4% (xhigh), FrontierCode v1.1 54.4%, CursorBench 4.0 57.8%, GDPval-AA v2.1 1846, OSWorld 2.1 (partial) 81.8%, HLE with tools 67.7% [A-opus] | $4 / $20 ($0.20) [A-price] | 1M / 128K / Jun 2026 / 2026-09-22 [A-opus-pg] | Default effort `medium` [A-models]; thinking always on [A-opus-pg] |
| **Claude Sonnet 5.5** `claude-sonnet-5-5` | CC, OC, agy (Pro+) | strong | "best combination of speed and intelligence" [A-models]. Terminal-Bench 4.0 70.6% (pass@1), OSWorld 2.1 offline 83.9%, GDPval-AA v2.1 1840, FrontierCode 1.1 52.1% at xhigh [A-haiku] | $2 / $10 ($0.10) [A-price] | 1M / 128K / Jun 2026 / 2026-09-28 [A-sonnet-pg] | Default effort `high`; non-default `temperature/top_p/top_k` → 400 [A-sonnet-pg]. Don't rank it against Opus on Terminal-Bench: different pages, effort unstated |
| **Claude Haiku 5.5** `claude-haiku-5-5` | CC (subagent), OC, OC-Go | efficient | "compaction, summarization, and subagent work"; Sonnet/Opus 5.5 "remain better choices for complex agentic coding" [A-haiku]. Terminal-Bench 4.0 39.2%, OSWorld 2.1 offline 72.4%, GDPval-AA v2.1 1620 [A-haiku] | ≤100K: $0.10 / $0.50 ($0.01); >100K: $0.50 / $2.50 ($0.05) [A-price] | 1M / 128K / Jun 2026 / 2026-10-07 [A-models] | Adjustable effort, Low…Max [A-haiku] |
| **Claude Fable 5.1** `claude-fable-5-1` | CC (`fable`), OC | frontier+, only for what Opus 5.5 failed | "demanding reasoning and long-horizon agentic work" [A-models]. Vendor's own table has it *below* Opus 5.5 on every row (Terminal-Bench 4.0 55.8% vs 66.4%) while calling the gap "narrower than these scores suggest" [A-opus]. Slower [A-models] | $10 / $50 ($0.25), 2.5× Opus [A-price] | 1M / 128K / Jun 2026 / 2026-09-01 [A-fable-pg] | Not the default anywhere; may bill to usage credits [CC-model]; forced tool use errors [A-fable-pg] |

## OpenAI

| Model (id) | Via | Tier | Good at / not for | Price | Context / output / cutoff / release | Notes |
|---|---|---|---|---|---|---|
| **GPT-6 Astra** `gpt-6-astra` | CX, OC, `openai/` | frontier | "most capable model for the most demanding work" [O-api]. Terminal-Bench 4.0 57.9% at high effort "as reported by OpenAI" vs Opus 5.5 66.4% (xhigh): third-party-reported, different effort [A-opus]; FrontierSWE v2 65.5% vs Argon 55.0% in Google's card [G-card] | $10 / $50 ($1.00) [O-price] | 1.05M / 128K / 2026-04-30 [O-api] | Computer use, web search, file search; Ultra effort in Codex [O-api][CX-models]. Enterprise trusted-access first: unverified |
| **GPT-6.1 Sol** `gpt-6.1-sol` | CX, OC, `openai/` | frontier (vendor: "near-Astra performance … at a lower cost") [CX-models] | "close to Astra on complex coding, computer use, and professional work" [O-model]. Announcement benchmarks not re-read (HTTP 403): unverified this round | $2 / $10 ($0.10); >272K input: 2× input, 1.5× output for the whole request [O-model][O-price] | 1.05M / 128K / 2026-04-30 [O-model]; release date unverified | Efforts low→max [O-api]; Codex default; not on Free/Go [CX-models] |
| **GPT-6.1 Terra** `gpt-6.1-terra` | CX (CLI ≥ 0.159.0), API; OC unverified | efficient→strong, unverified for coding | "A fast, efficient model for visual reasoning, precise computer use, and clear, natural writing" [O-terra]; Codex docs: "clear writing, visual understanding, and computer use" [CX-models]. No coding benchmark read | $1 / $5 ($0.05) [O-terra] | 1.05M / 128K / cutoff 2026-06-01 [O-terra]; release date not stated | Efforts none→max, default `medium` [O-terra]. Announcement page returned HTTP 403, so figures come from the API model page. Read 2026-10-28; not in the Codex IDE extension per the Codex table [CX-models] |
| **GPT-6 Luna** `gpt-6-luna` | CX, OC, OC-Go, `openai/` | efficient | "most efficient … focused, high-volume tasks" [O-api]. Terminal-Bench 4.0 16.4%, OSWorld 2.1 offline 48.9%, GDPval-AA v2.1 1437, third-party-reported against Haiku 5.5 [A-haiku] | $0.10 / $0.50 ($0.01) [O-price] | 1.05M / 128K / 2026-05-18 [O-api] | The Codex pick for Free/Go [CX-models] |
| **GPT-6 Sol** `gpt-6-sol` | CX, OC, `openai/` | strong, superseded by 6.1 Sol in Codex's docs | unverified | $2 / $10 ($0.20) [O-price] | not read | Absent from Codex docs list [CX-models], but still in the CLI's own list (measured 2026-10-16) |
| **GPT-5.5** `gpt-5.5` | OC, `openai/` | strong, **legacy** ($5 / $30 vs Sol's $2 / $10) | unverified | $5 / $30 ($0.50); >272K: $10 / $45 [O-price] | not read | `gpt-5.5-pro` $30 / $180 [O-price] |

## Google

| Model (id) | Via | Tier | Good at / not for | Price | Context / output / cutoff / release | Notes |
|---|---|---|---|---|---|---|
| **Gemini 4 Argon** `gemini-4-argon` | agy (Pro+), OC | frontier | "flagship reasoning model for complex software engineering" [G-argon]. Self-reported: DeepSWE v1.1 77.9%, Terminal-Bench 4.0 57.4%, FrontierSWE v2 55.0%, OSWorld 2.0 offline partial 69.2%, AutomationBench 51.3% [G-card]. "can hallucinate … occasionally slow or time out" [G-card] | $2 / $10 ($0.10) until 2026-11-30, then $4 / $20 ($0.20) from 2026-12-01 [G-price] | 1,048,576 / 65,536 / March 2026 / card 2026-10-13 [G-argon][G-card] | Computer use is Preview; in the App, CLI and IDE extensions, not the standalone IDE [AG-models] |
| **Gemini 3.8 Flash** `gemini-3.8-flash` | agy (all plans), OC, OC-Go | efficient→strong | "most capable Flash model … long-running software engineering" [G-flash]; benchmark unverified | $0.75 / $3.75 ($0.075) until 2027-01-01, then $1.50 / $7.50 [G-price] | 1,048,576 / 65,536 / cutoff not stated / Sept 2026 [G-flash] | `minimal` thinking unsupported [G-flash] |
| **Gemini 3.5 Flash-Lite** `gemini-3.5-flash-lite` | OC | efficient (read-only, bulk), price only | unverified | $0.30 / $2.50 ($0.03) [G-price] | not read | — |

## DeepSeek

| Model (id) | Via | Tier | Good at / not for | Price | Context / output / release | Notes |
|---|---|---|---|---|---|---|
| **DeepSeek V4.1-Flash** `deepseek-flash` (OC `deepseek-v4.1-flash`) | OC, OC-Go, `deepseek/` | strong with a written API | Max effort, N=8: DeepSWE v1.1 mini-SWE 74.2, **Claude Code 69.8**, Codex 65.6, OpenCode 65.5; Terminal-Bench 2.1 OpenCode 85.0, Claude Code 88.0, Codex 84.1; Terminal-Bench 4.0 31.2; SimpleQA-Verified 42.3 (base, 25-shot) [DS-card] | Off-peak $0.15 / $0.60 ($0.003); peak 2× [DS-price] | 1M / 384K / 2026-09-10 [DS-price][DS-log] | Peak 01:00–04:00 and 06:00–10:00 UTC Mon–Fri [DS-price]; vision supported |
| **DeepSeek V4-Pro** `deepseek-v4-pro` | OC, OC-Go, `deepseek/` | strong (written API), not re-measured | Not Flash: DeepSeek kept Pro "after September 14, 2026" [DS-log]; no benchmark read | Off-peak $0.66 / $1.98 ($0.022); peak 2× [DS-price] | 1M / 384K [DS-price] | No vision [DS-price] |

## Other vendors — ⚠️ cells from search summaries, not full fetches

| Model (id) | Via | Tier | Good at / not for | Price | Context / output / release | Notes |
|---|---|---|---|---|---|---|
| **Grok 4.7** `grok-4.7` ⚠️ | OC, OC-Go | strong | ⚠️ DeepSWE v1.1 71.0% (high), CursorBench 4.0 46.3%, Terminal-Bench 4.0 57.9% [X-news]; model card: Terminal-Bench 4.0 38.0% at xhigh in the Grok Build harness, same benchmark, different setting: do not compare [X-card] | <200K: $2 / $6 ($0.50); ≥200K: $4 / $12 [X-models] | 500K / output not listed / cutoff May 2026 [X-models] | "Grok 4.7 Fast" is not in the API [X-models] |
| **grok-build-0.1** `grok-build-0.1` | OC | strong→efficient, unverified | unverified | <200K: $1 / $2 ($0.20) [X-models] | 256K / not listed [X-models] | — |
| **Kimi K3** `kimi-k3` ⚠️ | OC, OC-Go | strong (open-weight) | ⚠️ HF card: GPQA Diamond 93.5, BrowseComp 91.2, SWE-Marathon 42.0, Terminal-Bench 2.1 88.3; footnotes mix harnesses, do not rank [K-hf] | $3 / $15 ($0.30) [K-price] | 1,048,576 / output not listed; dates unverified [K-price] | 2.8T params, native vision [K-hf] |
| **Kimi K2.7 Code** `kimi-k2.7-code` | OC, OC-Go | efficient→strong, unverified | unverified | $0.95 / $4.00 ($0.19) [K-price] | 262,144 [K-price] | — |
| **GLM-5.3** `glm-5.3` ⚠️ | OC, OC-Go | strong (open-weight) | ⚠️ Z.ai's own evals: Terminal-Bench 3.0 28.3, DeepSWE v1.1 66.9, Terminal-Bench 2.1 88.2 [Z-hf]; a Flash blog gives other numbers, sources disagree [Z-docs] | $1.40 / $4.40 ($0.26) [Z-price] | not listed: unverified | Same base as GLM-5.2, post-training only [Z-docs] |
| **GLM-5.3-Flash** `glm-5.3-flash` ⚠️ | OC (`-free`), OC-Go | efficient | ⚠️ Terminal-Bench 2.1 84.3 (vendor blog) [Z-docs]; unverified beyond that | $0.15 / $0.50 ($0.03) [Z-price] | not listed | OC's free variant: zero-retention, no training [OC-zen] |
| **MiniMax M3** `minimax-m3` ⚠️ | OC, OC-Go | strong→efficient (open-weight) | ⚠️ vendor blog, own scaffolds: BrowseComp 83.5; PostTrainBench 37.1 [M-blog] | ≤512K: $0.30 / $1.20 ($0.06); >512K: $0.60 / $2.40 [M-price] | up to 1M / output not listed / 2026-06-01 [M-blog] | Priority tier 1.5× [M-price] |
| **Beam Free** `beam-free` | OC (free) | unverified | Free "for a limited time"; no benchmark read [OC-zen]. A third-party blog names it Reflection Beam 1.0 (501B-A23B, 1,048,576 context, Apache-2.0 weights): **unverified**, the Zen page does not say it [Beam-blog] | Free input/output/cache [OC-zen] | 1M per the blog, unverified | Read 2026-10-28. Prompts "not used for training" but "retained for 30 days for safety reasons" [OC-zen]. Blocked in many countries (China, Russia, Iran, Cuba, Belarus…; full list in [OC-zen]) |

Listed in `opencode models` but not source-read (existence only): `qwen3.8-max`, `qwen3.8-flash`,
`qwen3.7-plus` [Q-list], `mistral-large-4` [Mis-ov], `muse-spark-1.3`, `mimo-v2.6-*`, `longcat-*`,
`nemotron-*`, `step-5-preview`, `hy3/hy4`, `big-pickle`, `space-bunny`.

## Sources (read 2026-10-16)

- [A-models] https://platform.claude.com/docs/en/about-claude/models/overview
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
- [O-terra] https://developers.openai.com/api/docs/models/gpt-6.1-terra (read 2026-10-28)
- [CX-models] https://learn.chatgpt.com/docs/models
- [DS-card] https://huggingface.co/deepseek-ai/DeepSeek-V4.1-Flash
- [DS-price] https://api-docs.deepseek.com/quick_start/pricing
- [DS-log] https://api-docs.deepseek.com/updates/
- [G-argon] https://ai.google.dev/gemini-api/docs/models/gemini-4-argon
- [G-flash] https://ai.google.dev/gemini-api/docs/models/gemini-3.8-flash
- [G-price] https://ai.google.dev/gemini-api/docs/pricing
- [G-card] https://deepmind.google/models/model-cards/gemini-4-argon/
- [AG-models] https://antigravity.google/docs/models
- [X-models] https://docs.x.ai/docs/models
- [X-news] https://x.ai/news/grok-4-7 ⚠️ search summary only
- [X-card] https://media.x.ai/v1/website/4p7card-5eccc980.pdf ⚠️ search summary only
- [K-price] https://platform.kimi.ai/docs/pricing/chat
- [K-hf] https://huggingface.co/moonshotai/Kimi-K3 ⚠️ search summary only
- [Z-price] https://docs.z.ai/guides/overview/pricing
- [Z-docs] https://docs.z.ai/guides/llm/glm-5.3 and https://docs.z.ai/guides/vlm/glm-5.3-flash ⚠️ search summary only
- [Z-hf] https://huggingface.co/zai-org/GLM-5.3 ⚠️ search summary only
- [M-price] https://platform.minimax.io/docs/guides/pricing-paygo
- [M-blog] https://www.minimax.io/blog/minimax-m3 ⚠️ search summary only
- [Q-list] https://www.alibabacloud.com/help/en/model-studio/models
- [Mis-ov] https://docs.mistral.ai/getting-started/models/models_overview/
- [OC-zen] https://opencode.ai/docs/zen/ (Beam Free read 2026-10-28)
- [Beam-blog] https://www.orcarouter.ai/es/blog/beam-1-0-free-opencode-1m-context ⚠️ third-party, search summary only
