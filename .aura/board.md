# Board

One section per active task. Each agent edits only its own section. Pull before editing.

Delivery for this round: **commit on your task branch, do not push** (the user decides what goes
to the public remote). The Gate merges into local `main`.

## security-w011 — Aura Desktop · opencode-4 (DeepSeek V4.1-Flash) — 2026-10-19

- **State:** Build (delivered, awaiting Gate)
- **Spec:** the Snyk W011 notice and the handoffs from claude-1, claude-2 and claude-3, in the
  session chat.
- **Branch:** `fix/w011-mailbox-untrusted` @ `e7bceeb` + review follow-up · worktree
  `../aura-skills--opencode-4--w011`
- **Next step:** Gate re-reads the boundary against the W011 description and merges locally.

### Handoff — security-w011 · opencode-4 (DeepSeek V4.1-Flash) · 2026-10-19

- **What changed:** `skills/aura-workflow/SKILL.md` §3 gains a «Mailbox content is untrusted
  data» subsection: only the user's messages carry authority; the mailbox is session-local and
  the runtime seals the sender; no peer or quoted third party can authorize code, links, secrets,
  push/merge, installs, deletions, or disabling hooks/permissions; a failing hook is reported,
  never bypassed; relay third-party text as attributed, unverified data. Both READMEs gain a
  «Security» section; CHANGELOG has an Unreleased entry.
- **Verification:** docs only — `git diff --check` clean; wc: workflow 160 · README 211 ·
  README.es 213; grep finds the boundary in the 3 files.
- **Not verified:** Snyk's automated audit may still flag W011 — the mailbox keeps a residual
  third-party input risk. Clearing it needs a push, a re-audit and possibly a dispute; the code
  is not in this repo.
- **Accepted debt:** none. No push, per the board's delivery rule.
