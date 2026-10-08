# El Gate — verificar una entrega

El Gate separa **«está implementado»** de **«está listo para integrarse»**. Un Builder puede
decir que terminó, con los tests en verde, y el Gate igual lo rechaza si ve algo que va a afectar
al usuario.

## 0. ¿Hay entrega?

```bash
git fetch origin
git log --oneline <base>..origin/<rama>     # ¿hay commits en el remoto?
```

- ¿La rama existe **en el remoto**? En un equipo, un commit que solo está en el disco del Builder
  no existe. (En modo `solo` sin push autorizado, se revisa la rama local con el SHA del handoff.)
- ¿Hay handoff? Y si hay buzón, ¿llegó como `kind: handoff`?
- ¿El SHA del handoff coincide con el del remoto?

Si falta algo: pedilo. No vayas a buscarlo al disco de otro.

## 1. Leé el handoff empezando por abajo

1. **⚠️ Sin verificar.** Es lo primero que revisás.
2. **Chequeos con número.** Un ✅ suelto no es un chequeo.
3. **Desviaciones de la spec.** ¿Están justificadas?

## 2. Corré, no asumas

- [ ] Cada criterio de aceptación, uno por uno, contra el código real.
- [ ] Los comandos de verificación del perfil (`verify.gate`), **también lo que el Builder ya
      declaró verde**.
- [ ] El diff completo: ¿hay cosas fuera de alcance? ¿Dependencias nuevas sin justificar? ¿Código
      muerto? ¿Secretos?
- [ ] Las **reglas de producto** del perfil que apliquen (las «puertas»).

## 3. Verificá donde corre el usuario

- **Interfaz:** en el navegador, en los tamaños que diga la spec. Un build verde no prueba nada
  visual.
- **Algo que se distribuye empaquetado:** contra el paquete, no contra el modo de desarrollo.
- **Multiplataforma:** en cada plataforma que la spec nombra, o declarado como no verificado.
- **Si levantás un stack, que sea el de esa rama.** «Lo corregí pero no aparece» suele ser que
  estás mirando el stack de otro agente.

## 4. Según el nivel de verificación

| Nivel | Además |
|---|---|
| Normal | Lo de arriba |
| Elevado | Un caso de prueba nuevo que habría fallado antes del cambio |
| Crítico | Tests nuevos para el camino feliz **y** para el abuso (sin permiso, token vencido, entrada maliciosa). Revisión línea por línea. Sin excepciones por tamaño |

## 5. Decidí

- **Rechazo:** devolvé la rama con el defecto concreto: qué comando, qué salió, qué esperabas.
  No lo arregles vos: el Builder aprende y vos no te volvés el cuello de botella. La excepción es
  un arreglo trivial de última milla, que se anota.
- **Aprobado:** integrá según el perfil (merge directo o PR) con **la evidencia en el mensaje**:
  qué corriste y qué salió.

## 6. Cerrá

- Mové la tarea de «activa» a «historial» en el tablero del repo, si lo tiene.
- Liberá el worktree cuando ya nadie lo vaya a retomar.
- `CHANGELOG` si el perfil lo usa.
- **Registro del modelo** en el perfil: una línea. «2026-10-08 · codex·sol-6.1 · aprobado a la
  primera» o «rechazado: caché sin invalidar; handoff honesto».
