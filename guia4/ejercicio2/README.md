# Ejercicio 2 — Análisis

## Comportamiento del circuito

El circuito es un **sumador binario de 8 bits sin signo**. Recibe dos operandos `op1` y `op2` (ambos `unsigned(7 downto 0)`) y entrega en `result` la suma aritmética de ambos.

| `op1` (dec) | `op2` (dec) | `result` (dec) |
|-------------|-------------|----------------|
| 0           | 0           | 0              |
| 15          | 1           | 16             |
| 200         | 55          | 255            |
| 200         | 56          | 256            |
| 255         | 255         | 510            |

La salida puede tomar valores entre 0 y 510, ya que `op1 + op2` con dos operandos de 8 bits sin signo produce un resultado de 9 bits. Como `result` es de tipo `integer`, no se trunca y representa el valor completo de la suma.

## Función de `conv_integer()` y tipo de conversión

`conv_integer()` está definida en el paquete `ieee.std_logic_arith` y realiza una **conversión de tipo** desde un vector de bits con interpretación numérica (`unsigned`, `signed`, `std_logic_vector`) hacia el tipo escalar `integer` de VHDL.

En este ejercicio se aplica sobre el resultado de `op1 + op2`, que es un valor `unsigned`. La función lo interpreta como un número binario natural (sin signo) y devuelve el `integer` equivalente, que luego se asigna al puerto de salida `result`.

En síntesis:

- **Entrada de la función:** `unsigned` (vector binario sin signo).
- **Salida de la función:** `integer` (escalar entero de VHDL).
- **Sentido de la conversión:** representación vectorial → representación escalar.

La conversión es necesaria porque el operador `+` sobre `unsigned` devuelve `unsigned`, pero `result` está declarado como `integer`, y VHDL es fuertemente tipado: no permite la asignación directa entre tipos distintos.

## Operación aritmética implementada

La operación es una **suma binaria sin signo de 8 + 8 bits** con resultado de 9 bits. Al sintetizar, Quartus implementa el circuito como una cadena de sumadores completos (full adders) con propagación de acarreo.

## Retardos del circuito

Obtenidos del análisis de tiempos (TimeQuest) en Quartus II 13.0sp1:

| Métrica                          | Valor      | Camino                  |
|----------------------------------|------------|-------------------------|
| Retardo mínimo (mejor caso)      | 6.177 ns   | `op2[0]` → `result[0]`  |
| Retardo máximo (peor caso)       | 11.220 ns  | `op2[1]` → `result[2]`  |

El retardo crece con la posición del bit de salida porque el acarreo debe propagarse por la cadena de sumadores: los bits más significativos de `result` tardan más que los menos significativos.
