---
name: aura-git-isolation
description: How several AI coding agents work in the same git repository without stepping on each other — one task, one branch, one worktree; surgical staging; commit → sync → push; commits that say which agent made them; and who merges. Starts with YOUR git policy (base branch, target branch, merge style, commit convention), which you adapt once to your company or git flow. Use it before creating a branch or worktree, staging, committing, pushing or merging.
---

# Aura Git Isolation

## ✏️ Your git policy — adapt this section once

> **This is the one part of the Aura skills meant to be edited.** Set it to how your company or
> team works (GitHub flow, git flow, trunk-based…). Install it with `--user` and every repo
> follows the same policy. The installer never overwrites a skill you changed.
> A project can still override a value in its profile (`.aura/project.md`).

| Setting | Default | Your value |
|---|---|---|
| **Remote** | `origin` | |
| **Base branch** — where task branches start | the remote's default branch | |
| **Target branch** — where finished work is merged | same as the base | |
| **Integration** | `gate-merges` — the Gate verifies and merges | |
| **Task branch name** | `feature/<task>` (`fix/<task>` for bugs) | |
| **Commit convention** | [Conventional Commits](https://www.conventionalcommits.org/), in English | |
| **Who may push task branches** | Builders, without asking | |
| **Who may merge to the target** | The Gate, after verifying — **and it asks the user first**. Write "without asking" here to skip that | |
| **Always ask first** | Force-push, deleting branches, merging to a release or production branch | |

**An empty "Your value" means the default applies.** Out of the box, this works as-is.

Integration options:

| Value | What happens |
|---|---|
| `gate-merges` | The Builder pushes its branch. The Gate verifies and merges into the target. |
| `pull-request` | A PR is opened against the target and merged through your git provider, with its reviews. |
| `solo` | You work alone with the user: **no pushing or merging unless they ask.** Delivery is the local commit plus the handoff. |

Examples: **git flow** → base `develop`, target `develop`, releases cut by a human.
**Staging first** → base `main`, target `staging`. **Trunk-based** → base and target `main`,
`pull-request`.

**Protect the target branch in your git provider.** "The Builder never merges" is an instruction.
A protected branch is a guarantee.

---

Several agents may be working **on the same repository at the same time.** Everything below
exists so one doesn't break another's work.

## 1. The rule that hurts most when broken

> **Never switch branches in a directory other agents share.**
> A `git checkout` or `git switch` there changes the branch for **everyone** working in that
> folder and corrupts what they were doing.

If your task needs a branch, create a separate **worktree.**

## 2. One task = one branch = one worktree

```bash
git fetch origin
git worktree add ../<repo>--<agent>--<task> -b feature/<task> origin/<base>
cd ../<repo>--<agent>--<task>
```

- `origin`, `<base>` and the branch name come from the policy above. **Don't assume `main`.**
- If the repo has its own helper to claim tasks (a script, a command), the profile names it and
  you use it. If it doesn't name one, don't assume it exists: use `git worktree`.
- Dependencies aren't shared between worktrees: install them inside, if the task needs them.
- **A worktree can be expensive** (compiled dependencies, several GB). The profile says so. Think
  before opening another one.

## 3. Before you commit

- **Surgical staging:** `git add <specific paths>`. **Never** `git add .` or `git add -A`: they
  sweep in test files, `.env`, build junk or someone else's work.
- `git diff --staged` before every commit. If you see something you didn't do, don't commit it.
- **Never commit secrets.** No tokens, no `.env`, no "test" credentials that are real.
- If untracked junk shows up that should be ignored, fix `.gitignore` instead of dodging it.

## 4. Commit message

Your convention (above), and at the end, in **one block with no blank lines inside it**, the
trailers that say who did it:

```
feat(auth): reject expired tokens with 401

Agent: <tool·model>
Task: <task>
```

Check it after committing — a broken trailer doesn't show at a glance:

```bash
git log -1 --format='%(trailers:key=Agent,valueonly)'   # empty = broken; fix it before pushing
```

## 5. Delivery order: commit → sync → push

```bash
git add <paths> && git commit
git fetch origin && git rebase origin/<base>   # or the profile's sync helper
# conflicts → resolve them and run the checks again
git push -u origin feature/<task>              # if the policy allows it
```

You sync **after** committing because a rebase needs a clean tree.

## 6. Who integrates

**The Builder never merges its own work** when there is a Gate. Nothing gets merged red: the target
stays green. The integration style is the one in your policy.

## 7. Shared files

Files that many tasks want to touch: `CHANGELOG.md`, the task board and history
(`.aura/board.md`, `.aura/history.md`), shared types, routes, lock files. The profile lists yours.
On the board, each agent edits only its own section.

- **Two tasks touching the same shared file don't run in parallel**, unless one is the declared
  temporary owner.
- `CHANGELOG.md` and the board are usually closed by the Gate when merging, not by the Builder.

## 8. Releasing, resuming and cleaning up

- **Releasing a task is not deleting its worktree.** If someone else will pick it up, release the
  claim and keep the worktree, with the handoff saying where it is.
- **Resuming:** work on the remote branch. If someone already rescued it, don't rewrite it.
- **Clean up** only what's merged or abandoned: `git worktree remove <path>` and delete the local
  branch. Never delete a worktree with unpushed changes without asking.
- Never `git push --force` someone else's branch. On your own, `--force-with-lease`.
