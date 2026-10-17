# History

Closed tasks, newest first. Append only: never edit an old entry.


## roster-rewrite — claude-4 · Claude Code·Sonnet 5.5 — 2026-10-16

- **Result:** merged in local `main` (not pushed)
- **Gate:** SKILL.md 123 lines (≤ 170); source keys in `references/models.md` == its sources list
  (`comm` empty); 21 models present; frontmatter intact; diff limited to `aura-model-roster/**` +
  board. Anonymity grep: only "OSWorld" (a benchmark name, false positive). Fix-forward: SKILL.md
  pointed installed users at `.aura/research/local-evidence.md`, a file only this repo has —
  reworded; the dropped retired/renamed note (DeepSeek V4 Flash → V4.1, V4-Pro kept) restored in
  one line; GPT-6 Sol is reachable from Codex too (measured list).
- **Accepted debt:** no web source re-opened by the Builder (inputs were gated on their own merge).

## roster-vendor-refresh — claude-3 · Claude Code·Sonnet 5.5 — 2026-10-16

- **Result:** merged in local `main` (not pushed)
- **Gate:** re-opened 3 sources and every number matched — Google pricing (Argon $2/$10 → $4/$20
  on 2026-12-01; 3.8 Flash $0.75/$3.75 → doubles 2027-01-01), Anthropic pricing (Fable 5.1
  $10/$50, $0.25 cache hit), xAI models (grok-4.7 $2/$6/$0.50, ≥200K whole-request rate; 500K ctx).
  Fix-forward: Table A2 was "not measured" because `codex` lives under nvm's Node 24; the Gate ran
  it (`codex-cli 0.163.0`) and listed the account's models from `~/.codex/models_cache.json`.
- **Accepted debt:** Grok/Kimi/GLM/MiniMax cells read from search summaries (flagged ⚠️ in the
  file); GPT-6.1 Sol announcement 403; privacy/quotas unverified except OpenCode Console.

## roster-local-evidence — claude-2 · Claude Code·Sonnet 5.5 — 2026-10-16

- **Result:** merged in local `main` (not pushed)
- **Gate:** anonymity grep empty; 150 lines; spot-checks held (DeepSeek Flash trailers 511 = 511
  recounted; qwen false green 2026-09-07 and the 2026-09-17 session death are in the logs).
  🔴 one unsourced claim: "11 of 11 clean" for DeepSeek appears in no log and contradicts the
  2026-09-17 entry — fix-forward to the registry's real count (23 rows, 3 🔴, 0 false greens).
- **Accepted debt:** `back`/`ff` columns are keyword counts (upper bound), as the file says.

## task-import-skills — claude-4 · Claude Code·Sonnet 5.5 — 2026-10-16

- **Result:** merged in local `main` (not pushed)
- **Gate:** re-ran the spec greps — the 3 task tools hit the 4 files; "not assigned" in workflow
  and lead; `wc -l` workflow 135 · lead 114 · builder 114 (≤ 140); diff limited to the 4 files +
  board. Fix-forward on wording: the task tools exist inside Aura Desktop whether or not tasks
  were imported (the Builder had tied them to an import); Aura Web's Spanish field names
  ("Supuesto", "Por confirmar") replaced by their meaning; long line in `spec.md` wrapped.
- **Accepted debt:** which status to move when is still undecided by the user (out of scope).

Handoff (via mailbox): 4 files done, checks as above, ⚠️ not re-read by another model; board state
written as "Review" (not in the board vocabulary).
