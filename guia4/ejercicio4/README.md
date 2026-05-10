# Ejercicio 4 — Análisis

## Comportamiento del circuito

El circuito implementa un **codificador con prioridad de 3 entradas**. Recibe tres señales (`alto`, `medio`, `bajo`) y entrega en `q` un código numérico que indica cuál de ellas está activa, con un orden de prioridad fijo:

1. `alto` (mayor prioridad)
2. `medio`
3. `bajo` (menor prioridad)

La asignación condicional concurrente (`when ... else`) se evalúa en cascada de arriba hacia abajo: cada cláusula sólo se considera si todas las anteriores son falsas. La primera entrada activa fija el valor de salida; las demás son ignoradas.

### Tabla de comportamiento

| `alto` | `medio` | `bajo` | `q` |
|--------|---------|--------|-----|
| 0      | 0       | 0      | 0   |
| 0      | 0       | 1      | 1   |
| 0      | 1       | 0      | 2   |
| 0      | 1       | 1      | 2   |
| 1      | 0       | 0      | 3   |
| 1      | 0       | 1      | 3   |
| 1      | 1       | 0      | 3   |
| 1      | 1       | 1      | 3   |

## ¿Qué ocurre cuando más de una entrada toma el valor 1?

**Gana siempre la entrada de mayor prioridad** y se ignoran las restantes. Esto es consecuencia directa de la asignación condicional concurrente con `when ... else` encadenados: la primera condición verdadera que aparece en el código fija el valor de la salida.

Por ejemplo, si `alto = '1'` y `medio = '1'` simultáneamente, la salida es `q = 3` (porque `alto` se evalúa primero), y el valor de `medio` no influye.

## ¿Cuántos terminales se reservan para `q` y por qué?

El compilador reserva **32 terminales** para `q` (`q[31..0]`). El motivo es que `q` está declarado como `integer` sin acotar:

```vhdl
q : out integer;
```

El estándar IEEE 1076 establece que el tipo `integer` por defecto se representa con la palabra natural de la máquina, que en la mayoría de las herramientas (Quartus incluido) es de **32 bits**. Sin un `range`, el sintetizador no tiene información sobre el rango real de valores y debe asumir el peor caso.

Como en este diseño los únicos valores posibles son 0, 1, 2 y 3, sólo los bits `q[0]` y `q[1]` reciben lógica útil. Los 30 bits restantes (`q[2]` a `q[31]`) quedan **fijados a GND**, tal como advierte Quartus en el reporte de mapeo (`output_files/ejercicio4.map.rpt`, líneas 244–273):

```
Warning (13410): Pin "q[2]" is stuck at GND
Warning (13410): Pin "q[3]" is stuck at GND
...
Warning (13410): Pin "q[31]" is stuck at GND
```

Esto desperdicia pines del FPGA y vuelve menos legible el diseño. La forma correcta es restringir el rango:

```vhdl
q : out integer range 0 to 3;
```

Con esto el sintetizador asigna sólo **2 bits** a `q`, eliminando los 30 pines fantasma.

### Recursos sintetizados

El reporte indica que el diseño usa **2 funciones combinacionales** (un LUT de 3 entradas para `q[1]` y un LUT de 2 entradas para `q[0]`, ver `.map.rpt` líneas 174–177), una por cada bit útil de la salida.

## Retardos del circuito

Obtenidos del análisis de tiempos (TimeQuest) en Quartus II 13.0sp1, sección *Propagation Delay* en `output_files/ejercicio4.sta.rpt`:

| Camino           | Retardo máximo | Retardo mínimo |
|------------------|----------------|----------------|
| `alto`  → `q[0]` | 5.420 ns       | 2.822 ns       |
| `alto`  → `q[1]` | 5.145 ns       | 2.705 ns       |
| `bajo`  → `q[0]` | 5.140 ns       | 2.700 ns       |
| `medio` → `q[0]` | 9.287 ns       | 5.203 ns       |
| `medio` → `q[1]` | 9.431 ns       | 5.268 ns       |

El retardo desde `medio` es el peor (≈9.4 ns) porque su pad de entrada tiene mayor retardo de IO y porque participa en la lógica de ambos bits de salida.
