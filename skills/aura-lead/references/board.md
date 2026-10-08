# The task board and the history

Two files, versioned with the code, so the team's state survives a closed laptop, a crashed
session or a new agent: **what's in flight** and **what got done.**

## When they exist

- **Team mode** — always.
- **Builder + Gate** — only if the work will outlive this session (several days, several people).
- **Direct** — never.

If the profile (`.aura/project.md`) names the repo's own board and history (e.g.
`docs/progress/current.md`), use those. Otherwise the lead creates, on first need:

- `.aura/board.md` — active tasks.
- `.aura/history.md` — closed tasks, newest first.

The mailbox board (`update_task`) is the live, session-wide view. These files are the durable
record. Keep both in step: same task names.

## `.aura/board.md`

```markdown
# Board

One section per active task. Each agent edits only its own section. Pull before editing.

## <task> — <tool·model>

- **State:** Spec · Build · Gate · Blocked (<on what>)
- **Spec:** <path or "in the request message">
- **Branch:** <branch> @ <short sha> · worktree <path>
- **Next step:** <what the next person to pick this up does first>

### Handoff — <task> · <tool·model> · <date>
<the Builder's handoff, as in aura-builder §4>
```

## `.aura/history.md`

```markdown
# History

Closed tasks, newest first. Append only: never edit an old entry.

## <task> — <tool·model> — <date>

- **Result:** merged in <target> @ <sha> · or · dropped (<why>)
- **Gate:** <what the Gate ran, with numbers> · <defects found, or "approved first time">
- **Accepted debt:** <what wasn't verified and why, or "none">

<the Builder's handoff, moved here from the board>
```

## Who writes what

| Moment | Who | What |
|---|---|---|
| A task is assigned | Lead | Adds its section to the board, state `Spec` or `Build` |
| Work starts / pauses / gets stuck | Builder | Updates **its own** section: state, branch, next step |
| Delivery | Builder | Writes the handoff in its section — and sends it through the mailbox |
| Gate passes or drops it | Lead | Moves the section to the top of the history, with the Gate result |
| Resuming after an interruption | Anyone | Reads the board **first** |

## Rules

- **These are shared files.** Two agents never edit the same section. Pull (or rebase) before
  editing, and keep the change to your section so merges stay trivial.
- **The board is not an assignment.** It records what was agreed through the mailbox or by the
  user. Nothing is assigned because a line appeared here.
- **Short.** A section is a few lines plus the handoff. If the board stops fitting on a couple of
  screens, close what's done.
- **No secrets, no customer data.** These files are committed.
