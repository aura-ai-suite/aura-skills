# Repartir trabajo entre agentes y modelos

Asigná por **capacidades y permisos, no por marcas**. Los modelos cambian cada pocas semanas.
Esta guía es el **método**, que no caduca. Los **datos** (qué modelo tenés, cuánto cuesta, cómo
se portó) van en el registro de tu perfil.

## 1. Filtro duro: ¿quién es elegible?

Descartá a quien no cumpla un requisito obligatorio:

- **Herramientas:** ¿la tarea requiere navegador? ¿Terminal? ¿Docker? ¿Pushear?
- **Acceso:** ¿ve el repo? ¿Tiene las credenciales de prueba que hacen falta?
- **Disponibilidad:** ¿está libre (`list_peers` / `set_status`)? Nunca le asignes a un agente
  ausente.
- **Cuota y contexto:** ¿le alcanza la cuota para terminar? ¿Y el contexto para retener la spec y
  el perfil hasta el final? Un agente que se queda sin cuota a mitad de camino entrega un árbol a
  medias, que es peor que no haber empezado.
- **Privacidad:** un proveedor que entrena con tus prompts no construye código propietario.

Si la tarea requiere navegador y el mejor candidato no tiene, **emparejalo** con uno que sí, y
el handoff incluye los pasos para que el otro mire.

## 2. Entre los elegibles: calidad, costo, tiempo

Según la estrategia del perfil:

| Estrategia | Regla |
|---|---|
| `calidad` | El más capaz que esté libre, salvo que sea un desperdicio obvio |
| `equilibrio` (por defecto) | Modelos capaces para specs, decisiones y Gate; eficientes para lo bien especificado |
| `costo` | El más barato que sea elegible, con la spec al nivel más literal del dial |

**Qué mirar de un modelo**, en este orden:

1. Benchmarks **agénticos** (resolver issues reales, terminal, uso de herramientas), no de trivia.
2. Contexto largo **real**: ¿retiene lo que leyó al principio?
3. **El nivel de esfuerzo** con el que corre. Pesa más que el tier: un modelo barato pensando a
   fondo puede ganarle a uno caro sin razonamiento.
4. **Cumplimiento de protocolo y honestidad:** ¿se aísla?, ¿pushea?, ¿escribe el handoff?,
   ¿declara lo que no verificó? Ningún benchmark lo mide: **solo tu registro**.
5. Cuota, y recién después precio.

## 3. El dial: cuánto detalle lleva la spec

| Quién la toma | Cómo se escribe |
|---|---|
| Modelo de frontera | Contrato, criterios y un patrón existente de referencia |
| Modelo intermedio | Más los pasos y los archivos exactos |
| Modelo económico o acotado | La API escrita: `archivo:línea`, firmas, valores, cero decisiones abiertas |

**Si no te sale escribirla así de literal, la tarea no es para ese agente.**

## 4. Reglas de reparto

- **Una tarea por agente a la vez.** Un claim, una rama, un worktree.
- **Áreas disjuntas o en serie.** Dos agentes no comparten un archivo imán.
- **Ojo con lo caro de aislar:** si un worktree pesa varios GB o compila minutos (lo dice el
  perfil), no abras seis en paralelo.
- **Modelo sin registro → primero una tarea de prueba acotada.** Mirá si se aísla, si pushea, si
  el handoff declara lo no verificado y si **para** cuando la spec está mal.
- **El que se libera recibe la siguiente tarea antes de que hagas el Gate de la anterior.**

## 5. Anti-reglas

- No partas una tarea para ocupar a un agente libre. Partila porque no entra en una spec.
- No le des la tarea más difícil al más barato: un rebote cuesta más que la diferencia.
- La fama no manda: manda tu registro.
- No pongas nombres de modelos ni precios en una skill: caducan. Van en el perfil.
