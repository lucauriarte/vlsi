# Ejercicio 8 — Análisis

## Comportamiento del circuito

El circuito es un **registro paralelo de 12 bits con disparo por flanco ascendente**.

En cada flanco ascendente de `clk`, el valor presente en la entrada `d` (de 12 bits) se transfiere a la salida `q` y se mantiene allí hasta el siguiente flanco. Entre flancos, los cambios en `d` no afectan a `q`.

En términos prácticos, equivale a 12 flip-flops tipo D operando en paralelo, todos compartiendo la misma señal de reloj.

## Detalle de la descripción VHDL

```vhdl
process (clk)
begin
    if rising_edge(clk) then
        q <= d;
    end if;
end process;
```

- El proceso es sensible únicamente a `clk`, por lo que sólo se reevalúa cuando `clk` cambia.
- La condición `rising_edge(clk)` filtra ese cambio para que la asignación a `q` ocurra exclusivamente en la transición `0 → 1`.
- Al no haber rama `else`, fuera del flanco `q` conserva su valor anterior — esa es justamente la inferencia de memoria que sintetiza los flip-flops.

## Rol dentro de la guía

Este bloque está pensado como **componente reutilizable**: en el ejercicio 9 se lo invoca dos veces para construir un registro de 24 bits (`reg24`), demostrando cómo encapsular un diseño y referenciarlo desde un paquete.
