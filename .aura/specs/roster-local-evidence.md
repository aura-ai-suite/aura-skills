## roster-local-evidence — what our own history says about each model

**Goal:** turn the measured history of the models that worked on this machine's projects into an
anonymous, aggregated evidence file the model roster can cite (§4 "Your measured record").

**Sources to mine** (the team's 8 local repos — Aura's own and client projects; read-only — never
edit, commit or switch branches in any of them):
- Fleet registries and progress logs (each repo's model record and closing log, plus any
  `grep -rl "Agent:\|handoff\|Handoff" --include=*.md`, skipping `node_modules`, `target`, `.git`).
- Commit trailers: `git -C <repo> log --all --format='%ad|%(trailers:key=Agent,valueonly)|%s' --date=short`.
- Worktree names (`*--<tool>--<slug>`) as a hint of who did what.

**Deliverables:**
1. **Raw notes, local only:** a file outside this repo — may name projects and paths. **Never** inside `aura-skills`.
2. **Anonymous summary in your branch:** `.aura/research/local-evidence.md`, per model
   (`<tool·model>`, effort if known): number of tasks seen, date range, task types, deliverable
   outcome, protocol (isolated / pushed / handoff before done / honest "not verified"),
   false greens, repeated defects, and 1-3 concrete lessons for a lead assigning work.
   Plus a short "cross-model patterns" section.

**Acceptance criteria:**
- [ ] Every model that appears in an `Agent:` trailer in those repos has a row (or is listed as
  "seen, too few tasks to judge" with its count).
- [ ] Each claim carries a count and date range (`7 tasks, 2026-09-07 → 2026-10-15`), never "often".
- [ ] a grep for the private repo, client and user names over `.aura/research/local-evidence.md`
  returns nothing (anonymity). Use "repo A/B/C" if needed.
- [ ] The summary separates **measured** (log/commit evidence) from **inferred**.
- [ ] ≤ 150 lines.

**Area:** `.aura/research/local-evidence.md` (new) · raw file outside the repo
**Shared files:** none · **Depends on:** nothing · **Needs a browser:** no
**Verification:** elevated (the Gate spot-checks 5 claims against the raw notes)
**Out of scope:** editing any skill; vendor/web data (that's `roster-vendor-refresh`).
**Open questions:** none.
