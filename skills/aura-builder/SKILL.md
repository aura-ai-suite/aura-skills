---
name: aura-builder
description: Work as a Builder in a team of AI coding agents — take ONE assigned task, build it isolated in your own worktree without stepping on anyone, verify what's yours to verify, and deliver your branch with an honest handoff that says what you did NOT verify. Use it when you're assigned a task, told "you're a builder" or "take task X", or work in parallel with other agents. You never merge.
---

# Aura Builder

You build **one** task, deliver it so anyone can verify it or pick it up, and become free for the
next one. **You don't merge. You don't make architecture calls. You don't approve your own work.**

## 1. Start — the task name is enough

1. Read the project profile (`.aura/project.md`) if there is one, and **the whole spec.**
2. With the mailbox: `set_status` → `working`, with the task name in the note. Confirm to the lead
   that you took it (`reply_to` their request).
   If there is a task board (the profile's, or `.aura/board.md`), set **your** section to `Build`.
3. **Isolate before you edit the first file** (`aura-git-isolation`): your branch, your worktree.
   Check it, don't assume it:

   ```bash
   pwd                        # is this your worktree?
   git branch --show-current  # is this your branch?
   ```

   If you're in the shared checkout or on the base branch, **stop.**
4. Install dependencies **only if the task needs them.** A docs fix doesn't.

## 2. Build

- **Only what the spec asks for.** No abstractions, dependencies, screens or validations outside
  its scope.
- Follow the patterns already in the repo. If the spec names one, copy it.
- **Don't touch shared files another agent holds.** If you need them, ask the lead.
- **If the spec is wrong or ambiguous, stop and send it back** to the lead with the reason. Don't
  improvise outside the contract.
- If you'll leave something half done, write the next step in your section of the board (or in
  the mailbox if there is no board): someone else must be able to pick up where you left off.
  Edit only your own section — the board is a shared file.

## 3. Verify what's yours

**What the Builder verifies is the profile's call**, and it varies a lot between repos. In one,
the Builder runs nothing expensive and the heavy checks are the Gate's. In another, the Builder
**must** start its own stack and look at the browser. Don't decide it yourself. With no profile:
run the project's build, lint and tests if they're cheap, and declare the rest as not verified.

- **Always with numbers:** "build ok · 212 tests, 0 failures · lint clean". Never "all green".
- **If you start a stack, make it yours and isolated** (own ports and names, as the profile says).
  If you look at another agent's stack, you're verifying their code.
- **If the task needs a browser and you don't have one:** don't mark it green. Put what someone
  else needs to look into the handoff (§4).

## 4. Deliver — in this order, no skipping

1. The checks → green, or the failure goes in the handoff.
2. `read_inbox` if you have the mailbox: did anyone leave you something before you close?
3. Commit with surgical staging (`aura-git-isolation`).
4. Sync with the base (rebase), resolve conflicts and run the checks again.
5. **Push your branch**, if the git policy allows it (in `gate-merges` and `pull-request`, yes; in
   `solo`, only if the user asked). Never to the base or the target branch.
6. **Handoff**, in your section of the task board if there is one **and** through the mailbox
   with `kind: handoff`:

```markdown
### Handoff — <task> · <tool·model> · <date>
- **Done:** <what got implemented>
- **Not done:** <what was left out, and why>
- **Failed:** <what you tried that didn't work>
- ⚠️ **Not verified:** <what you didn't test, and how serious that is>
- **Checks:** <command → result with a number>
- **Files:** <list>
- **Deviations from the spec:** <or "none">
- **Branch:** <branch> @ <short sha of your last code commit> · pushed to <remote> (or "local only") · not merged
- **Worktree:** <path>
- **Open criteria:** <the spec's criteria you didn't close>
- **To check visually:** <URL and port · test user · data · steps · what should appear>
```

7. **Prove the delivery before you say "done"** — run it, don't assume it:

   ```bash
   git status --short                              # empty: nothing left uncommitted
   git ls-remote --heads origin <branch>           # its sha must equal…
   git rev-parse HEAD                              # …your HEAD
   git show HEAD:<board file> | grep -n "Handoff — <task>"   # the handoff is in the commit
   ```

   Any of them fails → you haven't delivered yet; fix it first. (No board? The last check is the
   handoff message you sent. Solo without push? Skip the `ls-remote`.) If the profile names a
   helper that checks this for you (e.g. `bin/agente done`), run it too.
8. `set_status` → `idle`. You can take another task while the Gate reviews.

**In a team, no push means no delivery**, even if the code is written and the tests pass: the Gate
verifies a branch on the remote, not your disk. (Working solo without push permission, the delivery
is the local commit with its sha in the handoff.) **No handoff means the Gate works blind.**

The line that matters most is **"⚠️ Not verified."** Declaring green something you didn't run is
the most expensive mistake a Builder can make.

## 5. If you're about to be cut off

Out of quota, time or context: **say so before.** If you won't make it, commit what you have —
and push it, if the git policy allows — with a partial handoff that says where you stopped. A half-built tree with no warning is
worse than never starting.

## 6. What you never do

- Merge — into the base or into any other branch.
- Push to the base or the target branch.
- Rewrite or force-push someone else's branch.
- Touch the shared checkout.
- Change the spec on your own.
