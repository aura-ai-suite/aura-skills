# aura-skills

Skills de [aura-ai-suite/aura-skills](https://github.com/aura-ai-suite/aura-skills) (commit `52861a8`) listas para varios agentes de programación.

| Agente | Carpeta que lee |
|---|---|
| Claude Code | `.claude/skills/` |
| Codex CLI | `.agents/skills/` |
| OpenCode | `.agents/skills/` (también `.claude/skills/`) |
| Antigravity (`agy`) | `.agents/skills/` |
| Pi | `.agents/skills/` (también `.pi/skills/`) |

Skills incluidas: aura-workflow, aura-lead, aura-builder, aura-swarm, aura-git-isolation, aura-model-roster.

## Uso

- **En un proyecto:** copiá `.claude/` y `.agents/` a la raíz del proyecto.
- **Para todos tus proyectos:** `cp -r .claude/skills/* ~/.claude/skills/` y `cp -r .agents/skills/* ~/.agents/skills/`
  (Antigravity global usa `~/.gemini/config/skills/`; Pi global también `~/.pi/agent/skills/`).

Antes de usar, completá la tabla "Your git policy" en `aura-git-isolation/SKILL.md` (en las dos copias).

## Actualizar

```bash
git clone --depth 1 https://github.com/aura-ai-suite/aura-skills /tmp/aura-up
cp -r /tmp/aura-up/skills/. .claude/skills/ && cp -r /tmp/aura-up/skills/. .agents/skills/
```
