# Project profile — <repo name>

> ⚠️ **DRAFT — not filled in yet.** While this line exists, agents treat the profile as missing:
> it authorizes nothing and its commands are not run. Fill it in and delete this line.

<!--
Optional. The Aura skills work without it: agents read your AGENTS.md / CLAUDE.md / README and
your package scripts. Write this file when you want them to stop guessing.

- It holds what is specific to THIS repo. Your company-wide git policy lives in the skill
  aura-git-isolation (adapt it once); override a value here only if this repo is different.
- It adds to AGENTS.md / CLAUDE.md; it never replaces them. If something is already written
  there, link to it instead of copying it.
- Delete every section you don't need. A short profile gets read in full; a long one doesn't.
- Aura doesn't parse this file. Your agents read it. It's text for a model, not configuration.
-->

## 🔴 Changes that override earlier rules
<!-- Newest first, with a date, so an agent knows which old rule no longer holds. -->
- YYYY-MM-DD: <what changed>

## How we work

- **Default mode:** <adaptive>          <!-- adaptive · direct · builder-gate · team -->
- **Allowed without asking:** <e.g. pushing task branches>   <!-- empty = nothing; ask for everything -->
- **Always ask:** <e.g. deploys, releases, production migrations, deleting data>
- **Git policy overrides:** <none>      <!-- e.g. "target branch: staging" -->

## Tasks and specs

- **Specs:** <docs/specs/<slug>/>       <!-- or: an entry in docs/TASKS.md · or: in the message -->
- **Task board:** <docs/progress/current.md>   <!-- or: "only the Aura mailbox" -->
- **History:** <docs/progress/history.md>
- **Claim a task:** <git worktree … (default) or your helper, e.g. bin/agent start <task>>

## Verification

**Builder runs:**
```bash
<e.g. npm run build && npm test>
```

**Gate also runs:**
```bash
<e.g. npm run e2e>
```
<!-- and what isn't a command: "check in the browser at 1440×900 and 390×844",
     "test the installed package, not dev mode" -->

**Stack isolation** (if the Builder starts services): <e.g. "ports = 3000 + slot; compose project = <repo>-<slot>">

**Cost of a worktree:** <e.g. "~5 GB and 2 min to compile: at most 2 in parallel">

## Areas and shared files

| Area | Directories |
|---|---|
| <API> | <src/api/> |

**Shared files** (one task at a time): <CHANGELOG.md, src/lib/types.ts, package-lock.json>

## Product rules (the Gate doesn't merge without them)

- <e.g. "no dangerouslySetInnerHTML with text that comes from the server">

## Known traps

- <what already cost someone, e.g. "/usr/bin/node is v18 and breaks vite: use v24">

## Our agents

**Assignment strategy:** <balanced>     <!-- quality · balanced · cost -->

| Agent | Tool · model | Browser | Notes (quota, privacy) |
|---|---|---|---|
| <claude-1> | <Claude Code · model> | <yes> | |

What each model is good at in general lives in the skill `aura-model-roster`.
**This** is how they behaved here — it outranks the roster.

**Model record** (the Gate adds a line when closing each task; newest first):
- YYYY-MM-DD · <tool·model> · <task> · <approved first time / rejected: reason> · <honest handoff?>
