## roster-rewrite — the model roster with every selectable model and our measured record

**Goal:** `aura-model-roster` covers the models users of Claude Code, Codex, OpenCode and
Antigravity CLI can actually pick, with vendor-sourced data and our anonymous measured record.

**Inputs (merged to main before you start):** `.aura/research/vendors.md`,
`.aura/research/local-evidence.md`.

**Changes:**
- `skills/aura-model-roster/SKILL.md`: keep it the entry point, ≤ 170 lines: ground rules, tiers,
  a compact "pick by job" table (who gets specs/Gate, full features, mechanical work, read-only),
  §3 retired, §4 measured record rewritten from `local-evidence.md`, refresh procedure updated
  for 4 tools (how to list models in each). "Last reviewed" = the date of the vendor reads.
- New `skills/aura-model-roster/references/models.md`: the full per-model table from
  `vendors.md` (grouped by vendor), each number with its source key; sources list at the end.
  SKILL.md tells the lead to load it only when choosing between models.
- Keep the §0 rules intact and the "your profile's record overrides this" note.

**Acceptance criteria:**
- [ ] Every model in `vendors.md` Table B appears in `references/models.md`; every number there
  has a source key present in its sources list (`grep -o "\[[A-Z0-9-]*\]"` both sides match).
- [ ] `wc -l skills/aura-model-roster/SKILL.md` ≤ 170.
- [ ] §4 claims each carry a count/date range from `local-evidence.md`; anonymity grep from
  `roster-local-evidence` returns nothing on both files.
- [ ] Frontmatter `description` still says when to load it and "Not for Builders".
- [ ] Diff touches only `skills/aura-model-roster/**` (+ your board section).

**Area:** `skills/aura-model-roster/` · **Depends on:** roster-local-evidence, roster-vendor-refresh
**Needs a browser:** no · **Verification:** elevated
**Out of scope:** README, CHANGELOG, fingerprints (Gate), other skills.
**Open questions:** none.
