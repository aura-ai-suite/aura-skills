---
name: aura-git-isolation
description: Cómo trabajan varios agentes de IA en el mismo repositorio git sin pisarse — una tarea, una rama, un worktree; staging quirúrgico; el orden commit → sincronizar → push; commits que dicen qué agente los hizo; y quién integra. Respeta la rama destino y la política de merge del proyecto en vez de imponer main. Usala antes de crear una rama o un worktree, de hacer stage, commitear, pushear o integrar.
---

# Aura Git Isolation

Varios agentes pueden estar trabajando **a la vez sobre el mismo repositorio**. Todo lo que sigue
existe para que uno no le rompa el trabajo a otro.

## 1. La regla que más cuesta romper

> **Nunca cambies de rama en un directorio que comparten otros agentes.**
> Un `git checkout` o `git switch` ahí le cambia la rama a **todos** los que trabajan en esa
> carpeta, y les corrompe lo que estaban haciendo.

Si tu tarea necesita una rama, creá un **worktree** aparte.

## 2. Una tarea = una rama = un worktree

```bash
git fetch origin
git worktree add ../<repo>--<agente>--<tarea> -b feature/<tarea> origin/<base>
cd ../<repo>--<agente>--<tarea>
```

- `origin` es tu remoto. Si se llama distinto, usá ese nombre.
- `<base>` es la rama de la que salen las tareas, según el perfil (`.aura/project.md` →
  «Rama base»). **No asumas `main`.** El **destino** es adónde se integra. Casi siempre es la
  misma rama, pero el perfil puede decir otra (por ejemplo, `staging`).
- Si el repo tiene un helper para reclamar tareas (`bin/agente start`, un script, un comando),
  **el perfil lo nombra y lo usás.** Si no lo nombra, no asumas que existe: usá `git worktree`.
- Las dependencias no se heredan entre worktrees: instalalas adentro, si la tarea las necesita.
- **Un worktree puede ser caro** (dependencias compiladas, varios GB). El perfil lo declara.
  Antes de abrir otro, fijate si hace falta.

## 3. Antes de commitear

- **Staging quirúrgico:** `git add <rutas concretas>`. **Nunca** `git add .` ni `git add -A`:
  arrastran archivos de prueba, `.env`, basura de build o el trabajo de otro.
- `git diff --staged` antes de cada commit. Si ves algo que no hiciste vos, no lo commitees.
- **Nunca commitees secretos.** Ni tokens, ni `.env`, ni credenciales «de prueba» reales.
- Si aparece basura sin trackear que debería ignorarse, arreglá el `.gitignore` en vez de
  esquivarla cada vez.

## 4. Mensaje de commit

[Conventional Commits](https://www.conventionalcommits.org/), y al final, en **un solo bloque
sin líneas en blanco en el medio**, los trailers que dicen quién lo hizo:

```
feat(auth): reject expired tokens with 401

Agent: <herramienta·modelo>
Task: <tarea>
```

Comprobalo después de commitear, porque un trailer mal formado no se ve a simple vista:

```bash
git log -1 --format='%(trailers:key=Agent,valueonly)'   # vacío = está roto, corregilo antes del push
```

El idioma de los commits lo fija el perfil.

## 5. Orden al entregar: commit → sincronizar → push

```bash
git add <rutas> && git commit
git fetch origin && git rebase origin/<base>   # o el helper de sync del perfil
# conflictos → resolvelos y volvé a correr los chequeos
git push -u origin feature/<tarea>
```

Se sincroniza **después** de commitear porque el rebase exige un árbol limpio.

## 6. Quién integra

| Política del perfil | Qué pasa |
|---|---|
| `gate-merges` | El Builder pushea su rama. El Gate verifica y mergea al destino. |
| `pull-request` | El Builder (o el Gate) abre un PR contra el destino. Se integra por el proveedor de git, con sus revisiones. |
| `solo` | Trabajás solo con el usuario: **no pusheás ni mergeás sin que lo pida** o sin que lo autorice el perfil. La entrega es el commit local + el handoff. |

**El Builder nunca mergea su propio trabajo** cuando hay Gate. El destino se mantiene siempre
verde: nada se integra en rojo.

Recomendado: proteger la rama destino en el proveedor de git. Que solo se pueda integrar con
revisión es una garantía real. «La skill dice que no» es solo una instrucción.

## 7. Archivos imán

Son archivos que muchas tareas quieren tocar: `CHANGELOG.md`, el tablero, los tipos compartidos,
las rutas, los lockfiles. El perfil los lista.

- **Dos tareas que tocan el mismo imán no van en paralelo**, salvo que una sea dueña temporal
  declarada.
- `CHANGELOG.md` y el tablero los suele cerrar el Gate al integrar, no el Builder.

## 8. Soltar, retomar y limpiar

- **Soltar una tarea no es borrar su worktree.** Si otro la va a retomar, liberá el reclamo y
  dejá el worktree, con el handoff diciendo dónde está.
- **Retomar:** trabajá sobre la rama del remoto. Si alguien ya rescató la rama, no la reescribas.
- **Limpiar** solo lo integrado o abandonado: `git worktree remove <ruta>` y borrar la rama local.
  Nunca borres un worktree con cambios sin pushear sin preguntar.
- Nunca `git push --force` sobre una rama que no es tuya. Sobre la tuya, `--force-with-lease`.
