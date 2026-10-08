# Aura Skills

Skills para trabajar con uno o varios agentes de IA de programación —Claude Code, Codex,
OpenCode— **sin sobreingeniería**: el proceso se adapta a cada pedido. Un typo se arregla
directo. Una feature lleva criterios y una revisión. Un trabajo grande se reparte entre agentes,
cada uno en su rama, y alguien distinto verifica antes de integrar.

Salen de cómo trabajamos de verdad en [Aura](https://aura-ai.dev), con seis agentes de tres
proveedores en paralelo sobre tres repositorios. Funcionan **con o sin** Aura Desktop. Con Aura,
los agentes además se hablan por el buzón (`aura-mailbox`).

> **La metodología se adapta al trabajo. Nunca el trabajo a la metodología.**

## Las cuatro skills

| Skill | Quién la carga | Qué hace |
|---|---|---|
| [`aura-workflow`](skills/aura-workflow/SKILL.md) | Todos, siempre | Clasifica cada pedido en dos ejes —cuánto proceso (directo · Builder + Gate · equipo) y cuánta verificación (normal · elevada · crítica)— y elige el modo más liviano que alcanza. Cómo usar el buzón de Aura. Cómo retomar después de un corte. |
| [`aura-lead`](skills/aura-lead/SKILL.md) | Quien reparte y revisa | Del pedido a specs verificables, reparto por capacidades (no por marcas), y el **Gate**: verificar cada entrega y poder rechazarla aunque los tests pasen. Carga bajo demanda sus guías de [spec](skills/aura-lead/references/spec.md), [reparto](skills/aura-lead/references/assignment.md) y [Gate](skills/aura-lead/references/gate.md). |
| [`aura-builder`](skills/aura-builder/SKILL.md) | Quien construye | Una tarea, aislada en su worktree, verificada con números y entregada con un **handoff honesto** que dice lo que *no* se verificó. Nunca mergea. |
| [`aura-git-isolation`](skills/aura-git-isolation/SKILL.md) | Quien toca git | Una tarea = una rama = un worktree. Staging quirúrgico, commit → sincronizar → push, commits firmados por agente. Respeta la rama y la política de integración de **tu** proyecto. |

Están **cortadas por rol, no por fase**: el Builder no carga las reglas del Gate. Así un modelo
económico que solo construye gasta su contexto en la tarea, no en el proceso.

## Instalar

```bash
git clone https://github.com/aura-ai-suite/aura-skills.git
cd tu-proyecto
../aura-skills/install.sh --profile
```

Eso instala las cuatro skills en las carpetas de las herramientas que tengas instaladas y crea
`.aura/project.md` (el perfil) para que lo completes.

| Opción | Qué hace |
|---|---|
| `--project <dir>` | Instala en ese repo (por defecto, la carpeta actual) |
| `--user` | Instala para todos tus proyectos |
| `--tool claude\|codex\|opencode` | Solo para esa herramienta. Se puede repetir. Por defecto, las que estén en el `PATH`. Si no detecta la tuya (por ejemplo, instalada con nvm), pasá `--tool` |
| `--profile` | Crea `.aura/project.md` desde la plantilla, si no existe |
| `--force` | Reemplaza las skills que modificaste. La copia vieja va a `~/.aura/skills-backup/` |
| `--dry-run` | Muestra lo que haría, sin tocar nada |

**Nunca pisa una skill que modificaste** sin `--force`.

### Dónde las busca cada herramienta

Medido el 2026-10-08 en Linux, poniendo una skill de prueba en cada carpeta y preguntándole a
cada herramienta cuáles ve.

| Herramienta (versión) | Proyecto | Usuario | `install.sh` usa |
|---|---|---|---|
| Claude Code 2.1.294 | `.claude/skills` | `~/.claude/skills` | `.claude/skills` |
| Codex CLI 0.161.0 | `.agents/skills`, `.codex/skills` | `~/.agents/skills`, `~/.codex/skills` | `.agents/skills` |
| OpenCode 1.18.35 | `.opencode/skills`, `.claude/skills`, `.agents/skills` | `~/.config/opencode/skills`, `~/.claude/skills`, `~/.agents/skills` | `.agents/skills` |

Con **dos carpetas** (`.claude/skills` y `.agents/skills`) alcanza para las tres. Si usás Claude
Code y OpenCode a la vez, OpenCode lee las dos carpetas y lista cada skill **una sola vez** (medido
con OpenCode 1.18.35). Las dos copias son idénticas.

**A mano (Windows o cualquier sistema):** copiá cada carpeta de `skills/` a la carpeta de skills
de tu herramienta, según la tabla.

**Antigravity:** sin verificar todavía.

## El perfil del proyecto: `.aura/project.md`

Las skills son iguales en todos los proyectos. **Lo propio del tuyo va en un solo archivo**, que
las skills leen:

- rama base, adónde se integra y cómo (merge del Gate, pull request, o trabajando solo);
- qué está autorizado sin preguntar y qué se pregunta siempre;
- dónde van las specs y el tablero, si los usás;
- **qué verifica el Builder y qué el Gate** (los comandos de tu repo);
- áreas, archivos que muchas tareas tocan, reglas de producto, trampas conocidas;
- tus agentes y modelos, la estrategia de reparto (calidad · equilibrio · costo) y un registro
  de cómo se portó cada uno.

Plantilla: [`templates/project.md`](templates/project.md). Nace marcado como **BORRADOR**: hasta
que lo completes y borres esa línea, los agentes no lo usan y no autoriza nada. Borrá lo que no
uses: un perfil corto se lee entero.

El perfil **complementa** tu `AGENTS.md` o `CLAUDE.md`, no lo reemplaza. Si se contradicen, gana
lo que diga el usuario.

## ¿Necesito Aura?

No. Sin Aura, las skills funcionan igual: un agente solo, o varios con vos pasando los mensajes.
Con [Aura Desktop](https://app.aura-ai.dev/install), cada agente de Claude Code, Codex u OpenCode
que abrís en una de sus terminales tiene el servidor MCP `aura-mailbox`, y las skills le enseñan a usarlo: avisar en qué está
(`set_status`), leer las reglas que fijaste para la sesión (`list_peers`), pedir y entregar trabajo (`send_message` con `kind: request` / `handoff`) y
anotar tareas en el tablero de la sesión (`update_task`).

## Escribir tus propias skills

Para lo que es tuyo —qué es tu repo, tu design system— hay plantillas:

- [`templates/project-context/`](templates/project-context/SKILL.md): qué es el repo, glosario,
  fronteras, decisiones que no se reabren.
- [`templates/design-system/`](templates/design-system/SKILL.md): tokens, superficies,
  tipografía, componentes, anti-patterns.

Una skill es una carpeta con un `SKILL.md`. La `description` es lo que el agente lee para decidir
cuándo cargarla: escribila como «cuándo» + «qué». Mantenela corta: con más de ~170 líneas, nadie
la lee entera.

## Qué no hacen (todavía)

Lo decimos para que nadie lo suponga:

- **No garantizan exclusividad.** Dos agentes podrían tomar la misma tarea. Por eso un pedido no
  está asignado hasta que el otro confirma. El tablero del buzón es declarado: muestra, no
  asigna.
- **No hacen cumplir permisos.** «El Builder no mergea» es una instrucción. Si querés una
  garantía, protegé la rama en tu proveedor de git.
- **No saben qué modelo hay detrás de cada agente** si vos no lo escribís en el perfil.
- **Aura todavía no las instala sola**: por ahora, `install.sh` o a mano.

## Licencia

[MIT](LICENSE)
