# Roles

Single source of truth: `../roles.json`. Aura Desktop will vendor a copy of it for its role
presets (not shipped yet), so the ids in the tile, the missions and these skills stay the same.

| id | Load | Notes |
|---|---|---|
| `lead` | `aura-workflow`, `aura-lead`, `aura-model-roster` | Specs, assignment, merge. |
| `orchestrator` | `aura-workflow`, `aura-swarm`, `aura-lead`, `aura-model-roster`, `aura-git-isolation` | Swarm lead seat only. A swarm worker is a `builder`. |
| `builder` | `aura-workflow`, `aura-builder`, `aura-git-isolation` | One task, own branch, handoff. |
| `gate` | `aura-workflow`, `aura-lead` (`references/gate.md`), `aura-git-isolation` | Verifies and may reject. |
| `qa` | `aura-workflow`, `aura-lead` (`references/gate.md` §2 "Run, don't assume") | Adversarial testing; reports defects, doesn't merge or build features. |

A role is metadata for the user and the team; free-text roles remain valid. Add a role by
editing `roles.json` and this table together.
