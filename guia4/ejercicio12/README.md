# Ejercicio 12 — Análisis

## Comportamiento del circuito

El circuito es un **multiplexor 4 a 1 de un bit**, descrito mediante **asignación concurrente con selección** (`with ... select`). Tiene cuatro entradas de datos (`d0`, `d1`, `d2`, `d3`), una entrada de selección `s` de tipo `integer range 0 to 3`, y una salida `salida`.

Según el valor de `s`, la salida toma el valor de una de las cuatro entradas de datos:

| `s` | `salida` |
|-----|----------|
| 0   | `d0`     |
| 1   | `d1`     |
| 2   | `d2`     |
| 3   | `d3`     |

## Asignación concurrente con selección (`with ... select`)

```vhdl
with s select
    salida <= d0 when 0,
              d1 when 1,
              d2 when 2,
              d3 when 3;
```

Es una sentencia **concurrente** (vive directamente en el cuerpo de la arquitectura, sin envolverse en un `process`). Diferencias clave con otras formas de descripción:

- A diferencia de `when ... else` (ejercicio 4), no hay prioridad entre las ramas: cada valor de `s` selecciona **exactamente una** entrada.
- A diferencia de un `case` dentro de un `process`, no hay lista de sensibilidad: el simulador y el sintetizador asumen sensibilidad a todas las señales del lado derecho (`s`, `d0`, `d1`, `d2`, `d3`).
- El conjunto de cláusulas `when` debe **cubrir todos los valores posibles** del tipo de `s`. Como `s` está acotado a `integer range 0 to 3`, basta con listar los cuatro casos. Si `s` fuera un tipo más amplio (p. ej. `integer` sin acotar), haría falta agregar `when others`.

## Tipo de circuito digital

Un **multiplexor 4 a 1** (selector de datos), construido como bloque combinacional puro. En síntesis, Quartus lo implementa típicamente con uno o dos LUTs según la arquitectura del FPGA.

## Notas sobre el tipo `integer range 0 to 3` para la selección

Acotar `s` al rango `0 to 3` cumple dos funciones:

1. **Síntesis eficiente:** sin el rango, `s` ocuparía 32 bits (como en el ejercicio 4). Con `range 0 to 3` el sintetizador reserva sólo 2 bits para el puerto.
2. **Exhaustividad de la `with ... select`:** acotar el tipo permite que las cuatro cláusulas `when 0..3` cubran todos los valores posibles sin necesidad de `when others`.

## Sobre la simulación

El `.vwf` que viene con el proyecto está armado para que cada entrada de datos se distinga visualmente cuando se selecciona:

- `d0` = `0` constante.
- `d1` = `1` constante.
- `d2` alterna 0/1 cada 100 ns.
- `d3` alterna 0/1 cada 50 ns (más rápido).
- `s` recorre los cuatro valores: 0 (0-250 ns), 1 (250-500 ns), 2 (500-750 ns), 3 (750-1000 ns).

En `salida` deberías ver: nivel bajo constante en el primer cuarto, alto constante en el segundo, la onda lenta de `d2` en el tercero, y la onda rápida de `d3` en el cuarto.
