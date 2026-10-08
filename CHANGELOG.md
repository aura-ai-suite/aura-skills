# Changelog

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
