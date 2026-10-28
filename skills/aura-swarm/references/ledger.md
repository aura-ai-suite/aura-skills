# The swarm ledger

> **Draft.** Event names follow `swarm-perimeter` design §"Causal history" (aura `feature/mission-swarm-mode`). The line format is the Runtime's event envelope v1 (`runtime/events/envelope.go`),
> and the event names follow what the Runtime owner publishes. If they differ from the Runtime
> release you run, the Runtime wins.

## 1. Two sources that never mix

| Source | Holds | Written by |
|---|---|---|
| **Runtime events** | Facts: `swarm.started/paused/resumed/stopped/restarted` (states `running`, `paused`, `stopped`), `swarm.halted {reason}`, `swarm.approval_auto`, `swarm.approval_denied`, `swarm.agent_requested/granted/refused`, `swarm.terminal_requested/granted/refused/opened/closed`, `swarm.grant_expired`, `swarm.accepted`; new agents appear as `mission.members_added` with `parent_session_id` | **Only the Runtime.** An agent cannot write them and must not imitate them |
| **Ledger entries** (this file) | What agents **declare** | Agents |

With Aura, the Runtime events are the source of truth for facts, and the ledger is what the
agents declared through the Aura ledger tool. **Without Aura**, you keep the file below yourself
and write only declared entries; do not invent Runtime events.

## 2. An entry

One JSON object per line, append-only, never edited (a correction is a new entry that points to
the old one):

```json
{"v":1,"id":"e-017","type":"swarm.ledger_entry","seq":17,"ts":"2026-10-28T09:12:03Z",
 "tool":"claude","session_id":"claude-4",
 "payload":{"mission_id":"m-1","cause_id":"e-014",
            "kind":"finding","text":"...","evidence":"path:line | command → output"}}
```

| Field | Meaning |
|---|---|
| `session_id` | who. With the Aura ledger tool the **Runtime sets the actor** from the calling process, so you never send `actor`. In a local file, put your own session id here; `human` and `runtime` are not yours to claim |
| `payload.kind` | `finding` · `hypothesis` · `experiment` · `decision` · `blocker` · `objective_met` |
| `payload.text` | what — one or two sentences |
| `payload.cause_id` | why — the id of the entry or message that caused this. Optional only for the first entries |
| `ts` | when, UTC |
| `payload.evidence` | the result: a `file:line`, or a command and its output. `objective_met` and `experiment` require it |

Kinds are labels for humans and agents. Nothing automatic acts on them.

## 3. Where the file lives

Per mission, in the user's state folder or in `<repo>/.aura/swarm/<mission_id>/ledger.jsonl`.
**Never commit it:** if it lives in the repo, `.aura/swarm/` goes in `.gitignore` **before** the
first entry. Check with `git check-ignore .aura/swarm/` and fix it first if it prints nothing.

## 4. The final summary

Built only from the ledger and the Runtime events, in order: the objective, the decisions (with
their causes), the seats and terminals the Runtime recorded, the blockers and how they were
handled, the `objective_met` evidence, and what is **not** verified. Anything not in the trail is
not in the summary.
