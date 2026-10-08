# Perfil del proyecto — <nombre del repo>

> ⚠️ **BORRADOR — todavía no completado.** Mientras esta línea exista, los agentes tratan el
> perfil como vacío: no autoriza nada y sus comandos no se corren. Completalo y borrá esta línea.

<!--
Copiá este archivo a `.aura/project.md` en la raíz de tu repo y completalo.
Las skills de Aura lo leen para saber lo que es propio de TU proyecto. El método va en las
skills; los datos, acá.

- Borrá las secciones que no apliquen. Un perfil corto se lee entero; uno largo, no.
- Complementa a AGENTS.md / CLAUDE.md, no los reemplaza. Si ya tenés esto escrito ahí,
  poné un enlace en vez de copiarlo.
- Aura no lee este archivo: lo leen tus agentes. Es texto para un modelo, no configuración.
-->

## 🔴 Cambios que derogan lo anterior
<!-- Lo más reciente arriba, con fecha. Así un agente sabe qué regla vieja ya no vale. -->
- AAAA-MM-DD: <qué cambió>

## Cómo trabajamos

- **Modo por defecto:** <adaptativo>   <!-- adaptativo · directo · builder-gate · equipo -->
- **Rama base:** <main>                <!-- de dónde salen las ramas de tarea -->
- **Integración:** <gate-merges>       <!-- gate-merges · pull-request · solo -->
- **Destino:** <main>                  <!-- adónde se integra; casi siempre = la base (o p. ej. staging) -->
- **Remoto:** <origin>
- **Idioma de commits y specs:** <inglés>
- **Autorizado sin preguntar:** <p. ej. pushear ramas de tarea>   <!-- vacío = nada; se pregunta todo -->
- **Siempre preguntar:** <p. ej. deploy, release, migraciones en producción, borrar datos>

## Tareas y specs

- **Specs:** <docs/specs/<slug>/>      <!-- o: una entrada en docs/TAREAS.md · o: en el mensaje -->
- **Tablero:** <docs/progress/current.md>   <!-- o: "solo el buzón de Aura" -->
- **Historial:** <docs/progress/history.md>
- **Reclamar una tarea:** <git worktree add ../<repo>--<agente>--<slug> -b feature/<slug> <remoto>/<base>>
  <!-- o el helper del repo, p. ej. bin/agente start <tool> <slug> "<área>" -->

## Verificación

**verify.builder** — lo que corre quien construye:
```bash
<p. ej. npm run build && npm test>
```

**verify.gate** — lo que además corre quien revisa:
```bash
<p. ej. npm run e2e>
```
<!-- y lo que no es un comando: "probar en el navegador en 1440×900 y 390×844",
     "probar contra el paquete instalable, no contra el modo dev" -->

**Aislamiento del stack** (si el Builder levanta servicios):
<!-- p. ej. "puertos = 3000 + slot; proyecto de compose = <repo>-<slot>" -->

**Costo de un worktree:** <!-- p. ej. "~5 GB y 2 min de compilación: no más de 2 en paralelo" -->

## Áreas y archivos imán

| Área | Directorios |
|---|---|
| API | src/api/ |
| UI | src/ui/ |

**Imanes** (una tarea a la vez): CHANGELOG.md, src/lib/types.ts, package-lock.json

## Reglas de producto (el Gate no integra sin esto)

- <p. ej. "nada de dangerouslySetInnerHTML con texto que viene del servidor">
- <p. ej. "toda ruta nueva lleva test de autorización">

## Trampas vivas

- <lo que ya le costó a alguien, p. ej. "/usr/bin/node es v18 y rompe vite: usar v24">

## Agentes y modelos

**Estrategia de reparto:** equilibrio   <!-- calidad · equilibrio · costo -->

| Agente | Herramienta · modelo | Navegador | Notas (cuota, privacidad) |
|---|---|---|---|
| claude-1 | Claude Code · <modelo> | sí | |
| codex-1 | Codex · <modelo> | no | |

**Registro medido** (lo anota el Gate al cerrar cada tarea; lo más reciente arriba):
- AAAA-MM-DD · <herramienta·modelo> · <tarea> · <aprobado a la primera / rechazado: motivo> · <¿handoff honesto?>
