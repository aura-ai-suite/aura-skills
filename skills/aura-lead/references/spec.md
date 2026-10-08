# Cómo escribir una spec

La spec existe para que nadie construya lo equivocado. **Si no reduce riesgo, no la escribas.**

## Dónde va

La que diga el perfil (`.aura/project.md` → `specs:`). Por ejemplo:

- una carpeta `docs/specs/<slug>/` con `requirements.md` y `tasks.md`;
- una entrada en un tablero versionado (`docs/TAREAS.md`): la entrada **es** la spec;
- en modo Builder + Gate, el propio mensaje de pedido.

La skill no te impone el archivo; **te impone el contenido**.

## Plantilla

```markdown
## <slug> — <título corto>

**Objetivo:** <una frase. Qué cambia para el usuario.>

**Criterios de aceptación** (cada uno se puede correr o ver):
- [ ] `npm test -- login.test.ts` pasa, incluido el caso nuevo "token vencido → 401"
- [ ] En 390×844 el botón no se corta (captura en el handoff)

**Área:** src/auth/, tests/auth/
**Archivos imán:** src/lib/api.ts (lo tiene <otra tarea>, coordinar)
**Fuera de alcance:** <lo que alguien podría creer que entra y no entra>
**Depende de:** <otra spec o "nada">
**Requiere navegador:** sí / no
**Verificación:** normal / elevada / crítica
**Leer antes:** <docs o archivos que el Builder necesita>
**Preguntas abiertas:** <o "ninguna">
```

## Reglas

- **Criterios que se corren, no aspiraciones.** «Que funcione bien» no es un criterio. «El test
  X pasa» sí. «Que se vea bien» no. «En 1440×900 y 390×844, sin scroll horizontal», sí.
- **Una spec mediana entra en una página.** Si no entra, son dos tareas.
- **Sin secciones de relleno.** Si un campo no aplica, sacalo.
- **El dial:** para un modelo menos capaz, escribí la API: `archivo:línea`, firmas, payload y
  cero decisiones abiertas. Para uno más capaz, alcanza con el contrato y un patrón de referencia
  existente.
- **Lo que cambió después de escribirla** (otra rama se mergeó, un archivo se movió) va en el
  prompt de arranque como «delta», con archivo y línea, o actualizás la spec.
- **Las decisiones de arquitectura** que compararon alternativas van en un `design.md` aparte,
  **solo si existen**.
