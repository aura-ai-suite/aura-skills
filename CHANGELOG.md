# Changelog

## 0.2.3 — 2026-10-08

- **Only the five skills are needed.** The README says so up front.
- Removed the `project-context` and `design-system` templates: no agent loaded them and the Aura
  workflow doesn't need them. "Write your own skills" now shows a short example instead.
- The project profile template (`templates/project.md`) stays: `install.sh --profile` uses it.

## 0.2.2 — 2026-10-08

- **Consistent default permissions:** builders push their own task branch; the Gate asks you
  before merging into the target branch, unless your git policy says "without asking".
  `aura-workflow`, `aura-builder` and `aura-git-isolation` now say the same thing.
- **Upgrades just work.** `install.sh` recognizes every released version (`fingerprints.txt`), so
  installs from 0.1.0, copies made by hand and `npx skills add` installs update without `--force`
  — as long as you didn't edit them.
- **Install with `npx skills add aura-ai-suite/aura-skills`** (the [skills](https://skills.sh)
  CLI, 20+ agents), or with `install.sh` as before.
- README: a "Your first prompt" section with examples, and where the installed git policy lives.
- Maintainers: each release appends its fingerprints to `fingerprints.txt`.

## 0.2.1 — 2026-10-08

- **Fix in `aura-model-roster`:** `deepseek-v4-pro` is still DeepSeek V4-Pro. 0.2.0 said it routes
  to V4.1-Flash; DeepSeek reversed that plan on 2026-09-10. What was retired is V4-Flash, and the
  current id for V4.1-Flash is `deepseek-flash`.
- **Every vendor number in the roster now links to the vendor's own page** (§5). Figures without
  an official source were removed: the reference-model table, subscription quotas, and privacy
  claims (now "unverified" for every model).

## 0.2.0 — 2026-10-08

- **Everything is in English now.** A Spanish README is kept in `README.es.md`.
- **New skill `aura-model-roster`:** a dated catalog of the models behind your agents (tier,
  strengths, weaknesses, price, limits, privacy, browser access) for the lead to assign by. The
  lead warns you when it's more than 30 days old.
- **Plug and play.** Every file says whether you use it as is (`aura-workflow`, `aura-lead`,
  `aura-builder`), adapt it once (`aura-git-isolation`), keep it updated (`aura-model-roster`) or
  can skip it (`.aura/project.md`). The skills work with defaults when there's no profile.
- **Your git policy lives in `aura-git-isolation`**, in a table at the top: base and target branch,
  integration style, branch names, commit convention. Install it with `--user` to share it across
  repos.
- **The installer updates the skills you never edited** (it keeps a fingerprint of what it
  installed) and still keeps the ones you changed.
- The profile template is marked **DRAFT** until you fill it in, and authorizes nothing until then.
- Upgrading from 0.1.0: those installs have no fingerprint, so the installer treats them as edited.
  Run `install.sh --force` once.

## 0.1.0 — 2026-10-08

First public release (in Spanish): `aura-workflow`, `aura-lead`, `aura-builder`,
`aura-git-isolation`, project templates and `install.sh` for Claude Code, Codex and OpenCode.
Requires Aura Runtime 0.1.0-beta.6 or later for the `aura-mailbox` features.
