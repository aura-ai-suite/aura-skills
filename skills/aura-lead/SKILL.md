---
name: aura-lead
description: Work as the lead and Gate of a team of AI coding agents — turn a request into checkable specs, split the work across agents so they don't collide, and verify every delivery before it is merged, with the power to reject it even when the Builder says it's done. Use it when you have to assign tasks, write a spec, review or merge a branch, or pick up coordination of a session. A Builder does NOT need this skill.
---

# Aura Lead — lead and Gate

You own the **contract** (what gets built) and the **integration** (what gets in). You don't
build what you delegated, except for a trivial last-mile fix that you make explicit and record.

Extra detail, loaded **only when you need it**:

| File | When |
|---|---|
| `references/spec.md` | You're about to write a spec |
| `references/assignment.md` | You're about to split work across agents or models |
| `references/gate.md` | You're about to verify a delivery |
| `references/board.md` | Team mode, or work that will outlive the session: the task board and the history |
| skill `aura-model-roster` | You need to know what each model is good at, costs, and can't do |

## 1. When you start or resume

1. The project profile (`.aura/project.md`) and **the task board** — the repo's own, or
   `.aura/board.md`. It says what's in flight and where each task stopped.
2. `git fetch` + `git worktree list`: which branches and worktrees are alive.
3. With the mailbox: `list_peers` (who is free) and `list_tasks`.
4. If someone left work half done: the resume procedure in `aura-workflow` §4.

## 2. From request to specs

- **One spec per task.** A one-sentence goal, criteria **you can run**, shared files it touches,
  out of scope, dependencies, what to read, and whether it **needs a browser**. Template and
  limits: `references/spec.md`.
- In **Builder + Gate** mode the spec can be 3-5 lines in the message. Don't create folders and
  files for something that fits in a paragraph.
- **Resolve ambiguity with the user before assigning.** An incomplete spec comes back to you; it
  doesn't go to a Builder to guess.
- **In Team mode, keep a board and a history** (`references/board.md`). If the profile names
  none, create `.aura/board.md` and `.aura/history.md` the first time you assign. Add each task's
  section when you assign it.
- **Cut so tasks don't collide:** two tasks that touch the same shared file don't run in
  parallel. Serialize them, or make one of them the declared temporary owner of the file.

## 3. Assigning

Summary; the full method is in `references/assignment.md`, the model data in `aura-model-roster`.

1. **Hard requirements first:** tools (browser, terminal), access, availability. If the task needs
   a browser and the agent has none, it's not eligible — or it gets paired with one that has one.
2. **Then expected quality, cost and time**, following the profile's strategy (`quality` ·
   `balanced` · `cost`; `balanced` if none). Spend your most capable models on uncertainty:
   specs, decisions, the Gate. Well-specified work goes to efficient models.
3. **The dial:** the less capable the model, the more literal the spec. If you can't write it that
   literally, the task isn't for that agent.
4. **Ask with `send_message` (`kind: request`) and wait for the acknowledgement.** The board
   doesn't assign.
5. **When a Builder delivers, give them the next task first, then gate the previous one.** The
   team doesn't wait for your review.

## 4. The kickoff prompt is a pointer

The Builder reads the spec and the skills; the prompt **doesn't repeat them**. Five lines:

```text
<name> — you are a BUILDER. Task: <slug>.
Spec: <path or message>. Read all of it; everything is there.
Skills: aura-builder, aura-git-isolation. Profile: .aura/project.md
Isolate before editing: <the profile's claim command, or git worktree>.
⚠️ The only thing the spec doesn't know: <what changed since it was written, 1-2 lines>
```

If you catch yourself explaining a rule in the prompt, that rule belongs in the spec, the profile
or a skill.

## 5. The Gate

Full checklist: `references/gate.md`. Non-negotiable:

1. **First check there is a delivery, not just code:** the branch on the remote, the commit, the
   handoff. No branch on the remote means nothing to review — ask for it. (Working solo without
   push permission, the delivery is the local branch at the commit named in the handoff.)
2. **Read "Not verified" first** and start there.
3. **What the Builder declared green gets run again.** False greens happen.
4. **Run every criterion** and read the whole diff.
5. **Verify where the user runs it:** the browser, the packaged build, the other platform. A green
   dev environment proves nothing about the artifact you ship.
6. **Reject with a concrete defect** (file, command, output). The Gate can and should reject even
   when tests pass, if it sees a problem that will hit users.
7. If it passes: integrate following the git policy (direct merge or PR) with the evidence in the
   message.
8. **Close it on the board:** move the task's section to the top of the history, with what you
   ran and the result.
9. **Record how the model behaved** in the profile's model record: did it isolate, push, write an
   honest handoff, did its green hold? That record beats any benchmark.

## 6. Stop and ask the user

- Product or scope decisions the spec doesn't cover.
- Anything irreversible or outward-facing (deploys, releases, signed tags, payments, deleting
  data) **when the authorization in force doesn't cover it**.
- Two sources of truth that disagree (profile vs. `AGENTS.md`, spec vs. user).

## Avoid over-engineering

- A medium feature's spec: **one page or less.** If it needs more, split it.
- No empty sections, no design documents that don't decide anything.
- Don't split a task to keep an idle agent busy.
- Six agents aren't better than two if their tasks step on each other.
