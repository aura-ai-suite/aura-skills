# Local evidence — what this machine's own history says about each model

Generated 2026-10-16 by `claude-code·sonnet-5.5`. Projects appear as repo A–G; raw notes stay outside this repo.

## How to read this

- **Sources:** `Agent:` commit trailers (`git log --all`) in 8 repos, plus each repo's closing log
  (one entry per merged task). A trailer is a **commit**, not a task. "Tasks" = closing-log entries.
- **Measured** = a count or a dated Gate observation in a log/commit. **Inferred** = my reading.
- **Markers** (`back`, `ff`) count closing entries that *mention* "returned/rejected" or
  "fix-forward" anywhere, Gate commentary included — a coarse upper bound on builder defects, and
  many `ff` are spec gaps, not builder faults. Compare across rows only as a hint.
- Spellings were merged (`deepseek-flash` = `v4-flash` = `v4.1-flash`; `luna`/`terra`/`sol` with or without `gpt-5.6`).

## Per model

Format: trailers (builder/gate/spec) · date range · tasks · markers.

### claude-code·opus-5 — Gate and Spec Author
- **Measured:** 1362 trailers (706/609/47), 2026-07-25 → 2026-09-22, 7 repos. 67 tasks as builder
  (2026-07-29 → 2026-09-22): back 24, ff 4. Its Gate work is the bulk of the evidence.
- **Measured:** on 2026-08-13 a task of this model closed with the Gate finding the risk engine failing *open*, not the task's goal (repo A); on 2026-09-14 it played Spec Author + Builder + Gate on 3 stacked
  specs (repo B) and the only safeguard was its own measurements; it corrected 2 errors in repo B's docs.
- **Lesson:** keep authorship and verification on different agents.

### claude-code·opus-5.5 — Gate, lead, heavy builder
- **Measured:** 484 trailers (423/61/0), 2026-09-22 → 2026-10-16, 5 repos. 73 tasks (2026-09-23 →
  2026-10-14): back 5, ff 4, 🔴 3 — the lowest `back` rate of any model with 50+ tasks.
- **Measured:** 2026-09-29, a layout fix hid controls (`overflow: hidden`, measured with a
  near-empty bar, not the worst case); Gate fixed forward. 2026-09-27, wrote an ADR and built it in
  one branch (accepted as an experiment, unsigned).
- **Inferred:** low markers may reflect newer, better-specified tasks. **Lesson:** ask for the worst-case fixture on layout tasks.

### opencode·deepseek-v4.1-flash — volume builder (incl. `deepseek-flash`, `v4-flash`)
- **Measured:** 511 trailers (497/12/2), 2026-08-24 → 2026-10-15, 5 repos. 233 tasks (2026-08-11 →
  2026-10-14): ff 81, back 22, rescued 2, false green 0.
- **Measured (repo B registry, 2026-09-08 → 2026-10-08):** 23 rows for this model; 3 carry a 🔴,
  none records a false green, and one session died before its first commit (2026-09-17, below).
  It stopped and asked instead of inventing on ≥4 occasions (2026-09-27 → 2026-10-08), and
  corrected a spec's wrong count (44 vs 43 tests) rather than faking a test.
- **Measured defects:** synchronous Rust commands blocking the UI in 2 of 2 tasks on 2026-09-27;
  a token passed in a process argument list (2026-09-27); one session died before its first commit
  (2026-09-17, recovered from the worktree); 2 Gate-rescued commits (2026-09-14, repo C).
- **Lesson:** cheap and protocol-clean, but state security and async rules in the spec itself and
  tell it to commit early.

### claude-code·sonnet-5 — builder and second Gate
- **Measured:** 413 trailers (300/112/1), 2026-07-25 → 2026-09-25, 7 repos. 95 tasks (2026-07-22 →
  2026-09-25): ff 28, back 16, 🔴 21, "not verified" 31.
- **Measured:** 2026-08-19, a code comment claimed more than the code did (found by the Gate);
  2026-08-19/20, two closes recorded "CI verified nothing" (billing outage, not the model).
- **Lesson:** reliable with tests; Gate should check claims in comments and docs.

### opencode·deepseek-v4-pro — builder, sometimes Gate
- **Measured:** 202 trailers (154/46/2), 2026-07-27 → 2026-09-14, 4 repos. 63 tasks: ff 34, back 16,
  🔴 20, rescued 1. 46 trailers as Gate (7 on 2026-08-28).
- **Measured:** 2026-08-24, an interrupted session left 2 WIP commits marked "unverified" that the
  Gate had to preserve. 2026-09-01, a docs-truth pass cited file:line for each claim.
- **Lesson:** use for audits and bounded features; a Gate role from it was possible but not
  independently re-checked here.

### opencode·luna (`gpt-5.6-luna`) — T2-capable on this machine
- **Measured:** 77 trailers (64/13/0), 2026-08-26 → 2026-09-16, 6 repos. 93 task entries
  (2026-08-20 → 2026-09-15): ff 46, back 10, 🔴 27, rescued 3. 4 Gate-rescued commits on 2026-09-08.
- **Measured (repo B, 2026-09-07 → 2026-09-14, 5 tasks):** stopped rather than hand-write missing
  types (1); honest "not verified" lists (3); **2 of 2** commits had broken trailers (blank line,
  then literal `\n`, 2026-09-07/08); 1 out-of-scope fix without a test (2026-09-08).
- **Lesson:** put the trailer check command and "report, don't fix other bugs" in its start prompt.

### opencode·terra (`gpt-5.6-terra`)
- **Measured:** 58 trailers (51/7/0), 2026-07-30 → 2026-09-10, 5 repos. 118 task entries
  (2026-07-30 → 2026-09-17): ff 44, back 30, 🔴 31, rescued 6.
- **Measured:** 3 tasks (2026-08-11, 2026-08-20 ×2) where the Gate wrote tests named by the criteria
  that did not exist or found the decisive criterion left open; a 7-task payments series on repo D
  needed 3 follow-up passes (2 review, 1 CI), c. 2026-08.
- **Lesson:** name the tests in the spec; the Gate re-runs the decisive criterion.

### claude-code·sonnet-5.5 — builder, new
- **Measured:** 61 trailers (61/0/0), 2026-10-01 → 2026-10-16, 4 repos. 12 tasks (2026-09-30 →
  2026-10-14): back 3, ff 3. 2026-10-14: one stack was rebased by the Gate and fixed forward
  (items had no ordering tie-break; 2 specs failed 1 in N).

### codex·gpt-6 and codex·gpt-6.1-sol
- **gpt-6 — measured:** 26 trailers, 2026-10-06 → 2026-10-13, 3 repos; 6 tasks (2026-10-06 →
  2026-10-16): back 1. Repo B registry, 2026-10-08: 2 of 2 clean (full protocol; re-run green = real).
  Moved its worktree inside the checkout because of its write sandbox (warned first).
- **gpt-6.1-sol — measured:** 12 trailers, 2026-10-08 → 2026-10-09, 3 repos; 10 tasks (2026-10-07 →
  2026-10-13): ff 3, back 1, "not verified" 2.
- **Lesson:** 8 days of data; confirm worktree placement up front.

### opencode·gpt-5.6-sol (incl. `solfast`)
- **Measured:** 17 trailers, 2026-08-11 → 2026-09-02, 1 repo; 25 task entries under this spelling
  plus 21 under other spellings (2026-08-03 → 2026-09-12): back 8, ff 5, 🔴 6.
- **Measured:** 2026-08-18/20, three closes carry a 🔴 (a missing hand test, two spec-side gaps).

### antigravity·gemini-3.1-pro (incl. 25 trailers with no model named)
- **Measured:** 21 trailers named + 25 unnamed, 2026-07-22 → 2026-09-07, 3 repos. 21 tasks (2026-08-19
  → 2026-09-01): ff 15, back 8, 🔴 14 — the highest ff ratio (71%) among models with 20+ tasks.

### opencode·ox-alpha (incl. `0x-alpha`)
- **Measured:** 31 trailers, 2026-08-21 → 2026-08-25, 4 repos; 13 tasks (2026-08-21 → 2026-08-27).
  3 closes mention a real defect: a lint error (2026-08-23), dead code in a rate limiter (2026-08-22),
  and a real bug the Gate fixed before merge (2026-08-21).
- **Inferred:** one-week window; read as "needed Gate fixes in 3 of 13", no more.

### opencode·qwen3.7 (plus/max)
- **Measured:** 10 trailers, 2026-08-14 → 2026-09-09, 3 repos; 6 tasks (2026-08-19 → 2026-09-09).
  On 2026-09-07, 3 of 3 logged tasks had problems: a commit never pushed and a handoff that arrived
  after the merge, blocking another spec; a **false green** (reproducibility claimed, not measured);
  2 real defects found at merge (hang after ~64 kB of output; a flag that detached nothing).
- **Lesson:** mechanical tasks only, and the Gate re-runs every claim.

### Claude family without a version in the trailer
- `claude·sonnet`: 28 trailers, 2026-06-07 → 2026-09-03, 22 tasks (2026-07-23 → 2026-08-31), ff 9,
  back 6; 1 test-level false green on 2026-07-31 (a test passed though the feature was broken).
- `claude·opus`: 21 trailers, 2026-07-23 → 2026-08-04, 8 tasks; 9 fix/revert subjects among 21.
- `claude·haiku` (unstated 16 trailers, 2026-06-07 → 2026-07-31; 14 tasks, ff 9) and `haiku-4.5` (11
  trailers, 2026-07-24 → 2026-08-18; 3 tasks, ff 2): ff/total is high; **inferred:** the tasks were small.
- `claude-code·haiku-5.5`: 11 trailers, 2026-10-15 → 2026-10-16, 1 repo — **seen, too few to judge.**

### Seen, too few tasks to judge
`opencode·gpt-6-astra` 15 trailers (2026-09-14 → 2026-09-23, 1 repo, no closing entries) · `opencode·glm-5` 6
(2026-07-24 → 2026-08-19; 3 tasks) · `windsurf·sonnet` 2 and `windsurf·glm-5` 2 (2026-07-29) ·
`windsurf` unnamed 17 (2026-06-07 → 2026-07-23) · `gemini·flash-3.6` 3 (2026-08-06) · `devin` 3
(2026-08-05) · `opencode·grok-4.5` 1 (2026-08-18) · `opencode·kimi-k3` 3 tasks in logs only
(2026-08-03 → 2026-08-09) · unnamed `claude-code` 87 (2026-06-07 → 2026-09-08, 1 repo) · unnamed `claude`
30 (2026-07-22 → 2026-07-23) · unnamed `opencode` 88 (2026-06-07 → 2026-09-12, 2 repos).

## Cross-model patterns

1. **Work that never left the worktree is the costliest protocol failure.** **Measured:** 13 trailers
   from 4 model families record Gate rescues of uncommitted/unpushed work (2026-07-30 → 2026-09-14),
   plus 2 recorded session deaths (2026-09-07, 2026-09-17). The fix is in the start prompt: commit
   early, push, handoff before "done".
2. **False greens are rare and came from mechanical tasks.** **Measured:** 1 builder claim proven
   false (2026-09-07), 1 test-level false green (2026-07-31), 1 Gate-side false green (2026-07-30 →
   2026-08-22). Even so, the Gate re-ran claims in every logged closing.
3. **The cheapest model gave the cleanest protocol record.** **Measured:** `deepseek-v4.1-flash`
   23 registry rows, 0 false greens vs `luna` 2 of 2 with broken trailers and `qwen3.7` 0 of 3 clean (all repo B,
   2026-09-07 → 2026-10-08). Price is not tier; protocol is taught in the prompt, not bought.
4. **A repeated defect is a pattern, so move it into the spec or prompt.** **Measured:** synchronous
   Rust commands (2 of 2, 2026-09-27), trailers (2 of 2, 2026-09-07/08), process-argument secrets (1).
5. **Specs inherit blame.** **Inferred:** many `ff` entries trace to spec wording (a button that
   is not on that screen, a count off by one); say which screen a spec refers to.
6. **Verify against the emitter, not the fixtures.** **Measured:** on 2026-09-08 every fixture in a
   repo agreed on a wrong event name while the single real emitter used another (repo B).
7. **The Gate's own pre-push step matters.** **Measured:** on 2026-09-16 a batch of specs was
   assigned before being pushed, leaving every builder without its contract.
8. **Effort level is not in most logs.** **Inferred:** weighting by effort is impossible from this
   data; record it in the trailer going forward.
