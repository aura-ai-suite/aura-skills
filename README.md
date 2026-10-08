# Aura Skills

*[Leer en español](README.es.md)*

**Teach your AI coding agents to work as a team — without turning every request into a
project.**

Aura Skills are instruction files that AI coding agents (Claude Code, Codex, OpenCode) load on
their own when a task calls for them. With them installed, your agents:

- **size each request before acting.** A typo gets fixed directly. A feature gets a few checkable
  criteria and a review. A big job gets split across agents.
- **don't step on each other.** Each task gets its own branch and its own folder (a git worktree).
- **hand over honestly.** Every delivery says what was done, with real test counts, and what was
  **not** verified.
- **get a second pair of eyes.** Someone other than the builder checks the work before it's
  merged, and can send it back even when the tests pass.
- **assign work by what each model is actually good at**, using a dated catalog of models.

They come from how the [Aura](https://aura-ai.dev) team builds Aura itself: six agents from three
providers working in parallel on three repositories. They work **with or without** Aura.

> **The process adapts to the work. Never the work to the process.**

## Quick start

You need `git` and at least one AI coding agent. Pick one way to install:

**With the [skills](https://skills.sh) CLI** — fastest, and works with 20+ agents (Claude Code,
Codex, OpenCode, Cursor, Copilot, Windsurf, Gemini…):

```bash
cd your-project
npx skills add aura-ai-suite/aura-skills
```

That CLI sends anonymous install counts to skills.sh; set `DISABLE_TELEMETRY=1` to opt out.

**With our installer** — for Claude Code, Codex and OpenCode. It can also create the project
profile, and it updates the skills you never edited without touching the ones you changed:

```bash
git clone https://github.com/aura-ai-suite/aura-skills.git
cd your-project
../aura-skills/install.sh --profile
```

That's it: the skills work right away with sensible defaults. Then, when you have five minutes,
adapt the git policy to your team (below).

### Your first prompt

You don't have to name the skills. Ask as usual; the agent loads them when they apply:

- *"Fix the typo in the login button."* → it does it directly, no process.
- *"Add password reset by email."* → it states the mode ("Builder + Gate · critical, it touches
  auth"), writes 3-5 checkable criteria, builds, then reviews against them.
- *"You're the lead. Split these five tasks between codex-1 and opencode-1 and review what they
  deliver."* → it writes specs, assigns by model, and gates each branch.
- *"You're a builder. Take task `password-reset`."* → it isolates in a worktree, builds, and
  delivers a handoff.

## What's inside, and what you do with each file

| File | What it does | What you do |
|---|---|---|
| [`aura-workflow`](skills/aura-workflow/SKILL.md) | The entry point. Sizes every request on two axes — how much process (direct · builder + reviewer · team) and how much verification (normal · elevated · critical) — and picks the lightest mode that covers the risk. Also covers the Aura mailbox and resuming after a crash. | ✅ **Use as is** |
| [`aura-lead`](skills/aura-lead/SKILL.md) | For the agent that plans, assigns and reviews. Turns requests into checkable specs, splits work so agents don't collide, and runs the **Gate**: verifies every delivery and can reject it. Loads its guides on [specs](skills/aura-lead/references/spec.md), [assignment](skills/aura-lead/references/assignment.md) and [the Gate](skills/aura-lead/references/gate.md) only when needed. | ✅ **Use as is** |
| [`aura-builder`](skills/aura-builder/SKILL.md) | For the agent that builds. One task, isolated, verified with numbers, delivered with an honest handoff. Never merges. | ✅ **Use as is** |
| [`aura-git-isolation`](skills/aura-git-isolation/SKILL.md) | One task = one branch = one worktree; safe staging; commits that say which agent made them. **Starts with your git policy:** base branch, target branch, merge style, commit convention. | ✏️ **Adapt once** to your company or git flow. Works with defaults until you do |
| [`aura-model-roster`](skills/aura-model-roster/SKILL.md) | A dated catalog of the models behind your agents: tier, strengths and weaknesses, price, limits, privacy, browser access. The lead uses it to decide who gets each task. | 🔄 **Keep updated.** Models change monthly. Refresh it yourself, or reinstall to get ours. The lead warns you when it's more than 30 days old |
| [`.aura/project.md`](templates/project.md) | Optional project profile: your test commands, where specs go, shared files, product rules, your agents — and **a record of how each model actually behaved on your project.** | 📝 **Optional.** Created with `--profile`. Without it, agents read your `AGENTS.md`, README and package scripts |

**Why split by role?** The builder doesn't load the reviewer's rules, so a cheaper model that only
builds spends its context on your code, not on process.

## Adapt the git policy (once)

Open the **installed** copy of `aura-git-isolation/SKILL.md` and fill the **"Your git policy"**
table at the top. Where it is:

| Installed for | Claude Code | Codex and OpenCode |
|---|---|---|
| One project | `.claude/skills/aura-git-isolation/` | `.agents/skills/aura-git-isolation/` |
| All your projects (`--user`) | `~/.claude/skills/aura-git-isolation/` | `~/.agents/skills/aura-git-isolation/` |

If you use Claude Code and another tool, there are two copies: edit one and copy it over the
other.

Empty values fall back to the defaults: a branch per task from your default branch, builders push their
own branches, the reviewer merges after asking you, Conventional Commits.

| If your team uses… | Set |
|---|---|
| GitHub flow / trunk-based | base and target `main`, integration `pull-request` |
| Git flow | base and target `develop`; releases cut by a human |
| A staging branch | base `main`, target `staging` |
| Just you and one agent | integration `solo`: nothing is pushed or merged unless you ask |

Install it with `--user` and every repository you work on follows the same policy. The installer
**never overwrites a skill you changed**, so your edits survive updates. To take a newer version of
this skill later, reinstall with `--force` and copy your policy table back from the backup it
prints.

**Also protect your target branch** in GitHub/GitLab. "The builder never merges" is an
instruction to a model. A protected branch is a guarantee.

## Keep the model roster fresh

The roster carries a **"Last reviewed"** date. When it's more than 30 days old, the lead tells you
before assigning work and offers to refresh it. To refresh:

- **Get ours:** `git pull` in `aura-skills`, then run `install.sh` again. Skills you never edited
  update themselves; the installer keeps a fingerprint of what it installed and can tell.
- **Do it yourself:** ask your lead agent to refresh it. Every number in the roster links to the
  vendor's own page, and §6 explains how to refresh it.

How models behaved **on your project** goes in the record of `.aura/project.md`, not in the roster.
That record outranks any benchmark, and updating the roster never erases it.

## Installer options

```bash
./install.sh [--project <dir> | --user] [--tool claude|codex|opencode]... [--profile] [--force] [--dry-run]
```

| Option | What it does |
|---|---|
| `--project <dir>` | Install into that repository (default: the current folder) |
| `--user` | Install for all your projects |
| `--tool <name>` | Only for that tool. Repeatable. Default: the ones found on your `PATH` — if yours isn't detected (e.g. installed through nvm), pass it |
| `--profile` | Also create `.aura/project.md` from the template, marked **DRAFT** until you fill it in |
| `--force` | Replace skills you modified. Your copy goes to `~/.aura/skills-backup/` |
| `--dry-run` | Show what would change; touch nothing |

### Where each tool looks for skills

Measured on 2026-10-08 on Linux, by placing a probe skill in each folder and asking each tool
which ones it sees.

| Tool (version) | Project | User | `install.sh` uses |
|---|---|---|---|
| Claude Code 2.1.294 | `.claude/skills` | `~/.claude/skills` | `.claude/skills` |
| Codex CLI 0.161.0 | `.agents/skills`, `.codex/skills` | `~/.agents/skills`, `~/.codex/skills` | `.agents/skills` |
| OpenCode 1.18.35 | `.opencode/skills`, `.claude/skills`, `.agents/skills` | `~/.config/opencode/skills`, `~/.claude/skills`, `~/.agents/skills` | `.agents/skills` |

Two folders (`.claude/skills` and `.agents/skills`) cover all three. OpenCode reads both and lists
each skill once.

**Windows, or by hand:** copy each folder from `skills/` into your tool's skills folder, following
the table. **Antigravity:** not verified yet.

## Do I need Aura?

No. Without Aura, the skills work the same: one agent alone, or several with you passing messages
between them.

With [Aura Desktop](https://app.aura-ai.dev/install), every Claude Code, Codex or OpenCode agent you
open in one of its terminals gets the `aura-mailbox` MCP server, and the skills teach it to:
report what it's doing (`set_status`), read the rules you pinned for the session (`list_peers`),
ask for and deliver work (`send_message` with `kind: request` / `handoff`), and track tasks on the
session board (`update_task`). Requires Aura Runtime 0.1.0-beta.6 or later.

## Write your own skills

For what's yours — what your repo is, your design system — there are templates:

- [`templates/project-context/`](templates/project-context/SKILL.md): what the repo is, glossary,
  boundaries, decisions that aren't reopened.
- [`templates/design-system/`](templates/design-system/SKILL.md): tokens, surfaces, typography,
  components, anti-patterns.

A skill is a folder with a `SKILL.md`. Its `description` is what the agent reads to decide when to
load it: write it as "when" + "what". Keep it short — past ~170 lines, nobody reads it all.

## What they don't do (yet)

So nobody assumes otherwise:

- **They don't guarantee exclusivity.** Two agents could take the same task. That's why nothing is
  assigned until the other agent confirms. The Aura mailbox board shows; it doesn't assign.
- **They don't enforce permissions.** Protect your branches in your git provider.
- **They don't know which model sits behind each agent** unless you write it in the profile.
- **Aura doesn't install them for you yet:** use `npx skills add`, `install.sh`, or copy them by
  hand.

## License

[MIT](LICENSE)
