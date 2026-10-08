# The Gate — verifying a delivery

The Gate separates **"it's implemented"** from **"it's ready to merge."** A Builder can say it's
done, with green tests, and the Gate still rejects it if it sees something that will hit users.

## 0. Is there a delivery?

```bash
git fetch origin
git log --oneline <base>..origin/<branch>     # are there commits on the remote?
```

- Does the branch exist **on the remote**? In a team, a commit that only lives on the Builder's
  disk doesn't exist. (Working solo without push permission, review the local branch at the
  commit named in the handoff.)
- Is there a handoff? With the mailbox, did it arrive as `kind: handoff`?
- Does the commit in the handoff match the remote?

If something is missing, ask for it. Don't go digging on someone else's disk.

## 1. Read the handoff bottom-up

1. **⚠️ Not verified.** That's where you start.
2. **Checks with numbers.** A bare ✅ is not a check.
3. **Deviations from the spec.** Are they justified?

## 2. Run, don't assume

- [ ] Every acceptance criterion, one by one, against the real code.
- [ ] The profile's Gate checks — **including what the Builder already declared green.**
- [ ] The whole diff: anything out of scope? New dependencies without a reason? Dead code?
      Secrets?
- [ ] The profile's **product rules** that apply.

## 3. Verify where the user runs it

- **UI:** in the browser, at the sizes the spec names. A green build proves nothing visual.
- **Anything shipped as a package:** against the package, not against dev mode.
- **Cross-platform:** on every platform the spec names, or declared unverified.
- **If you start a stack, make sure it's this branch's.** "I fixed it but it doesn't show up"
  usually means you're looking at another agent's stack.

## 4. By verification level

| Level | On top of the above |
|---|---|
| Normal | — |
| Elevated | A new test case that would have failed before the change |
| Critical | New tests for the happy path **and** for abuse (no permission, expired token, malicious input). Line-by-line review. No exceptions for size |

## 5. Decide

- **Reject:** send the branch back with the concrete defect — which command, what it printed, what
  you expected. Don't fix it yourself: the Builder learns, and you don't become the bottleneck.
  The exception is a trivial last-mile fix, recorded.
- **Approve:** integrate following the git policy (direct merge or PR) with **the evidence in the
  message**: what you ran and what came out.

## 6. Close

- Move the task from "active" to "history" on the repo's board, if it has one.
- Release the worktree once nobody will pick it up again.
- `CHANGELOG` if the project keeps one.
- **Model record** in the profile — one line: "2026-10-08 · codex · <model> · approved first
  time" or "rejected: stale cache; honest handoff".
