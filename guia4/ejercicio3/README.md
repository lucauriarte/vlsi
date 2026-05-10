# Ejercicio 3 — Análisis

## Comportamiento del circuito

El circuito implementa un **multiplexor 2 a 1 (MUX 2:1)** de un bit. Tiene dos entradas de datos (`A` y `B`), una entrada de selección (`sel`) y una salida (`salida`). Según el valor de `sel`, la salida toma el valor de una u otra entrada:

- Si `sel = '0'` → `salida = A`
- Si `sel = '1'` → `salida = B`

### Tabla de verdad

| `sel` | `A` | `B` | `salida` |
|-------|-----|-----|----------|
| 0     | 0   | 0   | 0        |
| 0     | 0   | 1   | 0        |
| 0     | 1   | 0   | 1        |
| 0     | 1   | 1   | 1        |
| 1     | 0   | 0   | 0        |
| 1     | 0   | 1   | 1        |
| 1     | 1   | 0   | 0        |
| 1     | 1   | 1   | 1        |

Cuando `sel = '0'` la salida sólo depende de `A` (ignora `B`); cuando `sel = '1'` ocurre lo contrario.

## Ecuación lógica de síntesis

A partir de la tabla de verdad (suma de productos sobre los mintérminos donde `salida = 1`):

$$\text{salida} = \overline{sel}\cdot A + sel\cdot B$$

Esta es la forma canónica del multiplexor 2:1 y coincide con lo que sintetiza Quartus. El reporte de mapeo confirma que el diseño se implementa con **una única función combinacional de 3 entradas** (un LUT de 3 entradas, ver `output_files/ejercicio3.map.rpt`, línea 176), exactamente lo que requiere la ecuación anterior.

## Tipo de circuito digital

Es un **multiplexor 2:1** (selector de datos), un bloque combinacional básico que permite enrutar una de varias entradas hacia una única salida según una señal de control.

## Retardos del circuito

Obtenidos del análisis de tiempos (TimeQuest) en Quartus II 13.0sp1, sección *Propagation Delay* en `output_files/ejercicio3.sta.rpt`:

| Camino           | Retardo máximo | Retardo mínimo |
|------------------|----------------|----------------|
| `A`   → `salida` | 5.133 ns       | 2.695 ns       |
| `B`   → `salida` | 5.407 ns       | 2.814 ns       |
| `sel` → `salida` | 9.453 ns       | 5.271 ns       |

El retardo desde `sel` es notablemente mayor que desde los datos porque `sel` controla el camino de selección dentro del LUT y, además, tiene un retardo de pad de entrada más alto (≈2.5 ns frente a ≈0.17 ns de `A` y `B`, ver `.fit.rpt` líneas 1071–1073).
