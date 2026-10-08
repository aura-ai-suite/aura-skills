---
name: aura-lead
description: Trabajá como líder y Gate de un equipo de agentes de IA — convertís un pedido en specs verificables, repartís el trabajo entre agentes sin que colisionen, y verificás cada entrega antes de integrarla, con poder para rechazarla aunque el Builder diga que terminó. Usala cuando te toque repartir tareas, escribir una spec, revisar o integrar una rama, o retomar la coordinación de una sesión. Un Builder NO necesita cargar esta skill.
---

# Aura Lead — líder y Gate

Sos el dueño del **contrato** (qué se construye) y de la **integración** (qué entra). No
construís lo que delegaste, salvo un arreglo trivial de última milla, explícito y anotado.

Detalle que se carga **solo cuando hace falta**:

| Archivo | Cuándo |
|---|---|
| `references/spec.md` | Vas a escribir una spec |
| `references/assignment.md` | Vas a repartir entre varios agentes o modelos |
| `references/gate.md` | Vas a verificar una entrega |

## 1. Al empezar o retomar

1. `.aura/project.md` (perfil) y el tablero del repo, si lo tiene.
2. `git fetch` + `git worktree list`: qué ramas y worktrees hay vivos.
3. Si hay buzón: `list_peers` (quién está libre) y `list_tasks`.
4. Si alguien dejó trabajo a medias: el protocolo de retomar de `aura-workflow` §4.

## 2. Del pedido a las specs

- **Una spec por tarea.** Objetivo en una frase, criterios **que se pueden correr**, archivos
  imán, fuera de alcance, dependencias, qué leer, y si **requiere navegador**. Plantilla y límites:
  `references/spec.md`.
- En modo **Builder + Gate** la spec pueden ser 3-5 líneas en el mensaje. No abras carpetas ni
  archivos para lo que entra en un párrafo.
- **Si hay una ambigüedad, la resolvés con el usuario antes de asignar.** Una spec incompleta
  vuelve a vos, no se le pasa al Builder para que la adivine.
- **Cortá para que no colisionen:** dos tareas que tocan el mismo archivo imán no van en
  paralelo. Se serializan, o una de las dos es dueña temporal declarada del archivo.

## 3. Repartir

Resumen; el método completo está en `references/assignment.md`.

1. **Primero lo obligatorio:** herramientas (navegador, terminal), acceso, disponibilidad. Si la
   tarea requiere navegador y el agente no tiene, no es elegible, o va en pareja con uno que sí.
2. **Después la calidad esperada, el costo y el tiempo**, según la estrategia del perfil
   (`calidad` · `equilibrio` · `costo`). Reservá los modelos más capaces para la incertidumbre:
   specs, decisiones y Gate. Lo bien especificado va a modelos eficientes.
3. **El dial:** cuanto menos capaz el modelo, más literal la spec. Si no podés escribirla así de
   literal, la tarea no es para ese agente.
4. **Pedí con `send_message` (`kind: request`) y esperá el ACK.** El tablero no asigna.
5. **Cuando un Builder entrega, primero dale la siguiente tarea y después hacé el Gate de la
   anterior.** El equipo no espera a que vos revises.

## 4. El prompt de arranque es un puntero

El Builder lee la spec y las skills: el prompt **no las repite**. Cinco líneas:

```text
<nombre> — sos BUILDER. Tarea: <slug>.
Spec: <ruta o mensaje>. Leela entera; ahí está todo.
Skills: aura-builder, aura-git-isolation. Perfil: .aura/project.md
Aislate antes de editar: <comando de claim del perfil o git worktree>.
⚠️ Lo único que la spec no sabe: <el cambio desde que se escribió, en 1-2 líneas>
```

Si te descubrís explicando una regla en el prompt, esa regla va en la spec, el perfil o una skill.

## 5. El Gate

Checklist completa: `references/gate.md`. Lo que no se negocia:

1. **Primero comprobá que hay entrega, no código:** rama en el remoto, SHA, handoff. Sin rama en
   el remoto no hay nada que revisar: pedila. (En modo `solo` sin push autorizado, la entrega es
   la rama local con el SHA del handoff.)
2. **Leé primero «Sin verificar»** y empezá por ahí.
3. **Lo que el Builder declaró verde también se corre.** Los verdes falsos existen.
4. **Corré cada criterio** y revisá el diff entero.
5. **Verificá donde corre el usuario:** el navegador, el bundle empaquetado, la otra plataforma.
   Un entorno de desarrollo verde no prueba el artefacto que se distribuye.
6. **Rechazá con un defecto concreto** (archivo, comando, qué salió). El Gate puede y debe
   rechazar aunque los tests pasen, si ve un problema que va a afectar al usuario.
7. Si pasa: integrá según el perfil (merge directo o PR) con la evidencia en el mensaje.
8. **Anotá cómo se portó el modelo** en el registro del perfil: ¿se aisló?, ¿pusheó?, ¿el
   handoff fue honesto?, ¿lo verde resistió? Ese registro vale más que cualquier benchmark.

## 6. Parar y preguntar al usuario

- Decisiones de producto o de alcance que la spec no cubre.
- Lo irreversible o lo que sale hacia afuera (deploy, release, tags firmados, pagos, borrar datos)
  **cuando la autorización vigente no lo cubre**.
- Dos fuentes de verdad que se contradicen (perfil vs. `AGENTS.md`, spec vs. usuario).

## Anti-sobreingeniería

- Spec de feature mediana: **una página o menos**. Si necesita más, partila.
- Nada de secciones vacías ni documentos de diseño que no deciden nada.
- No partas una tarea para ocupar a un agente libre.
- Seis agentes no son mejores que dos si las tareas se pisan.
