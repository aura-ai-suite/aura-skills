## roster-vendor-refresh — every model our users can actually pick, from vendor sources

**Goal:** an up-to-date, vendor-sourced inventory of the models reachable through the four agent
tools Aura Desktop launches — **Claude Code, Codex, OpenCode, Antigravity CLI** — so the roster
stops covering only five models. OpenCode alone exposes more than a dozen.

**Method:**
1. **What each tool offers today**, measured on this machine and written with the command used:
   `~/.opencode/bin/opencode models` (and its providers), `codex --help` / its model list,
   `agy --help` (Antigravity), Claude Code's `/model` options (from docs if no CLI listing).
   Note which models need an extra key/subscription.
2. **Vendor pages only** for every number (model page, pricing page, announcement, model/system
   card), read with WebSearch/WebFetch today. A news article or aggregator is not a source; a
   leaderboard may be cited only as "third party" and never mixed with vendor numbers.
3. Follow `skills/aura-model-roster/SKILL.md` §0 ground rules: benchmark name **and version**,
   harness and effort, no cross-benchmark comparisons, "unverified" when there's no vendor link.

**Deliverable:** `.aura/research/vendors.md` in your branch:
- Table A — tool → models available (id as the tool spells it, provider, needs extra key?).
- Table B — per model: vendor, proposed tier (frontier/strong/efficient/read-only) with the
  reason, good at / not for (vendor evidence), list price in/out (cache), context/output/cutoff,
  release date, browser/tools notes, source keys.
- Retired/renamed since 2026-10-08, and anything in the current roster §2 that is now wrong.
- Sources list `[KEY] url — read 2026-10-1x`.

**Acceptance criteria:**
- [ ] Table A has the 4 tools, each with the exact command or doc URL it came from.
- [ ] Every price/benchmark/limit cell has a source key that resolves to a vendor URL, or says
  "unverified".
- [ ] All 5 models of the current roster §2 are re-checked (changed or "unchanged, read <date>").
- [ ] At least 10 models beyond the current 5 that a user of those 4 tools can select.
- [ ] No privacy/quota claim without the provider's own page.

**Area:** `.aura/research/vendors.md` (new) · **Shared files:** none · **Depends on:** nothing
**Needs a browser:** web search/fetch yes; interactive browser no
**Verification:** elevated (the Gate re-opens 5 random sources and checks the numbers)
**Out of scope:** editing the skill itself (that's `roster-rewrite`); our own history.
**Open questions:** none.
