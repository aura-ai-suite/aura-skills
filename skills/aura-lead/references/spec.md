# Writing a spec

A spec exists so nobody builds the wrong thing. **If it doesn't reduce risk, don't write it.**

## Where it goes

Wherever the profile says (`.aura/project.md` → Specs). For example:

- a folder `docs/specs/<slug>/` with `requirements.md` and `tasks.md`;
- an entry in a versioned task board (`docs/TASKS.md`): the entry **is** the spec;
- in Builder + Gate mode, the request message itself.

No profile? Use the message for small tasks and `docs/specs/<slug>/` for team work.
This skill doesn't impose the file. **It imposes the content.**

## Template

```markdown
## <slug> — <short title>

**Goal:** <one sentence. What changes for the user.>

**Acceptance criteria** (each one can be run or seen):
- [ ] `npm test -- login.test.ts` passes, including the new case "expired token → 401"
- [ ] At 390×844 the button isn't clipped (screenshot in the handoff)

**Area:** src/auth/, tests/auth/
**Shared files:** src/lib/api.ts (held by <other task> — coordinate)
**Out of scope:** <what someone might think is included and isn't>
**Depends on:** <another spec, or "nothing">
**Needs a browser:** yes / no
**Verification:** normal / elevated / critical
**Read first:** <docs or files the Builder needs>
**Open questions:** <or "none">
```

## Rules

- **Criteria you can run, not wishes.** "Works well" is not a criterion. "Test X passes" is.
  "Looks good" is not. "At 1440×900 and 390×844, no horizontal scroll" is.
- **A medium spec fits on one page.** If it doesn't, it's two tasks.
- **No filler sections.** If a field doesn't apply, drop it.
- **The dial:** for a less capable model, write out the API — `file:line`, signatures, payloads,
  zero open decisions. For a more capable one, the contract plus an existing reference pattern is
  enough. Which model is which: `aura-model-roster`.
- **What changed after you wrote it** (another branch merged, a file moved) goes into the kickoff
  prompt as the "delta", with file and line — or you update the spec.
- **Architecture decisions** that compared alternatives go in a separate `design.md`, **only if
  there are any.**
