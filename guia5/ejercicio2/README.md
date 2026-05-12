# Ejercicio 2 — Análisis

## Objetivo

Sintetizar una tabla de verdad con **términos redundantes** (don't cares) de 12 entradas a 7 salidas, usando la función `std_match()` del paquete `ieee.numeric_std` para comparar contra patrones que contienen `'-'` como bit indiferente.

## Por qué `std_match()` y no `=`

El operador `=` de `std_logic_vector` compara bit a bit, pero un `'-'` (don't care) en VHDL **es un valor literal**, no un comodín. Esto significa que `a = "----010-----"` sólo es verdadero si `a` contiene literalmente nueve `'-'` (cosa que en un puerto físico nunca ocurre — los bits valen `'0'` o `'1'`).

`std_match` cambia la semántica: trata los `'-'` del segundo operando como **bits que matchean cualquier valor**. Es la herramienta canónica para describir tablas de verdad con términos redundantes.

```vhdl
use ieee.numeric_std.all;
...
if std_match(a, "----010-----") then ...
```

## Estructura de la arquitectura

```vhdl
process(a)
begin
    if    std_match(a, "0110110-----") then s <= "1000100";  -- fila 1
    elsif std_match(a, "1110110-----") then s <= "1001000";  -- fila 2
    elsif std_match(a, "----010-----") then s <= "0000001";  -- fila 3
    elsif std_match(a, "1100110-----") then s <= "0100000";  -- fila 4
    elsif std_match(a, "0100110-----") then s <= "0010000";  -- fila 5
    elsif std_match(a, "-1---10---11") then s <= "0000001";  -- fila 6
    elsif std_match(a, "1----10---11") then s <= "0000001";  -- fila 7
    elsif std_match(a, "-----100111-") then s <= "0000010";  -- fila 8
    elsif std_match(a, "--1--10---11") then s <= "0000001";  -- fila 9
    elsif std_match(a, "---1-10---11") then s <= "0000001";  -- fila 10
    else                                    s <= "0000000";
    end if;
end process;
```

Las filas se evalúan en el orden de la tabla del enunciado, lo que implementa una **prioridad por orden**: si varios patrones matchean simultáneamente, gana el que aparece primero en el `if/elsif`.

## Caveat: solapamiento entre filas

Algunas filas de la tabla matchean entradas comunes. Por ejemplo:

- Fila 3 (`----010-----`) → `S = "0000001"`
- Fila 8 (`-----100111-`) → `S = "0000010"`

Si `A(7,6,5) = 010` y `A(6,5,4,3,2,1) = 100111`, ambas matchean (compatible cuando `A(7)=0`, `A(6)=1`, `A(5)=0`, `A(4)=0`, `A(3)=1`, `A(2)=1`, `A(1)=1`). Con la prioridad por orden, gana fila 3 y la fila 8 nunca se activa en ese caso.

Si la intención original fuera que **fila 8 tenga prioridad** (más específica, dispara una salida distinta), habría que reordenar:

```vhdl
elsif std_match(a, "-----100111-") then s <= "0000010";  -- fila 8 ANTES de fila 3
elsif std_match(a, "----010-----") then s <= "0000001";  -- fila 3
```

Como el enunciado no aclara la prioridad, dejé el orden tal cual aparece en la tabla. Si la cátedra espera lo contrario, basta con mover la línea de la fila 8.

## Test del `.vwf`

El `.vwf` provisto ejercita cinco filas con distinto patrón en `A(11..5)`:

| t (ns)    | `a` (hex) | Fila que matchea | `s` esperado (hex) |
|-----------|-----------|------------------|---------------------|
| 0 – 200   | `0x6C0`   | Fila 1           | `0x44`              |
| 200 – 400 | `0xEC0`   | Fila 2           | `0x48`              |
| 400 – 600 | `0x040`   | Fila 3           | `0x01`              |
| 600 – 800 | `0xCC0`   | Fila 4           | `0x20`              |
| 800 – 1000| `0x4C0`   | Fila 5           | `0x10`              |

Los buses `a` y `s` se muestran en radix hexadecimal para que sea fácil comparar contra los valores esperados. Si querés probar las filas 6–10 (todas producen `0x01` salvo la 8), agregás más slots de tiempo en el editor de ondas.
