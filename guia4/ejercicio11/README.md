# Ejercicio 11 — Análisis

## Comportamiento del circuito

El circuito implementa **siete variantes de flip-flop tipo D** en paralelo, todas compartiendo las mismas entradas comunes (`d`, `clk`, `clr`, `pre`, `load`, `data`) pero cada una con su propia lógica de control. Sirve como catálogo de las formas más comunes de describir un FF en VHDL: distintos tipos de flanco y distintas combinaciones de borrado, preset y carga asíncronas.

Cada salida `q1..q7` corresponde a un proceso independiente y, por lo tanto, a un flip-flop separado en el FPGA.

## Detalle de cada flip-flop

### `q1` — D-FF disparado por flanco ascendente

```vhdl
if rising_edge(clk) then
    q1 <= d;
end if;
```

D flip-flop básico. La lista de sensibilidad sólo contiene `clk`, por lo que el proceso únicamente se ejecuta cuando hay un evento en el reloj; `rising_edge` filtra el evento al flanco `0 → 1`.

### `q2` — D-FF disparado por flanco descendente

```vhdl
if falling_edge(clk) then
    q2 <= d;
end if;
```

Idéntico al anterior pero el muestreo de `d` ocurre en el flanco `1 → 0`.

### `q3` — D-FF con clear asíncrono activo en alto, flanco ascendente

```vhdl
if clr = '1' then
    q3 <= '0';
elsif rising_edge(clk) then
    q3 <= d;
end if;
```

`clr` aparece en la lista de sensibilidad. Si `clr = '1'`, la salida pasa a `'0'` **sin esperar al reloj** (clear asíncrono). Si no está activo, el flip-flop funciona normalmente capturando `d` en el flanco ascendente.

### `q4` — D-FF con clear asíncrono activo en bajo, flanco descendente

```vhdl
if clr = '0' then
    q4 <= '0';
elsif falling_edge(clk) then
    q4 <= d;
end if;
```

Variante del anterior con dos diferencias: el clear es **activo en bajo** (`clr = '0'` borra) y la captura ocurre en flanco descendente. Quartus infiere un flip-flop con clear asíncrono cuya señal de borrado se conecta a través de un inversor implícito.

### `q5` — D-FF con preset asíncrono activo en alto, flanco ascendente

```vhdl
if pre = '1' then
    q5 <= '1';
elsif rising_edge(clk) then
    q5 <= d;
end if;
```

Análogo a `q3` pero con preset: cuando `pre = '1'`, la salida pasa a `'1'` de forma asíncrona.

### `q6` — D-FF con carga asíncrona desde `data`, flanco ascendente

```vhdl
if load = '1' then
    q6 <= data;
elsif rising_edge(clk) then
    q6 <= d;
end if;
```

A diferencia del clear/preset, acá la salida no se fuerza a un valor fijo sino que se carga **el valor de la señal `data`** mientras `load = '1'`. Es esencialmente un latch transparente cuando `load` está activo, y un D-FF disparado por flanco cuando `load` está bajo.

### `q7` — D-FF con clear y preset asíncronos (clear con mayor prioridad)

```vhdl
if clr = '1' then
    q7 <= '0';
elsif pre = '1' then
    q7 <= '1';
elsif rising_edge(clk) then
    q7 <= d;
end if;
```

Combina las dos entradas asíncronas. El orden de los `elsif` define la **prioridad**: si `clr` y `pre` están ambos activos al mismo tiempo, gana `clr` y la salida queda en `'0'`. Recién cuando ambas están inactivas se evalúa el flanco de reloj.

## Resumen comparativo

| Salida | Flanco       | Clear (async) | Preset (async) | Carga (async)        |
|--------|--------------|---------------|----------------|----------------------|
| `q1`   | Ascendente   | —             | —              | —                    |
| `q2`   | Descendente  | —             | —              | —                    |
| `q3`   | Ascendente   | `clr = '1'`   | —              | —                    |
| `q4`   | Descendente  | `clr = '0'`   | —              | —                    |
| `q5`   | Ascendente   | —             | `pre = '1'`    | —                    |
| `q6`   | Ascendente   | —             | —              | `load = '1' → data`  |
| `q7`   | Ascendente   | `clr = '1'`   | `pre = '1'`    | —                    |

## Idiomas de inferencia importantes

- **Sin `else` ni `default`** después del flanco → el sintetizador infiere memoria (flip-flop). Si se agregara un `else`, se obtendría lógica combinacional o un latch.
- **La lista de sensibilidad determina qué señales son asíncronas.** En `q3`, incluir `clr` en `(clk, clr)` es lo que hace que el clear sea asíncrono. Si `clr` no estuviera en la lista, el sintetizador inferiría un clear síncrono (evaluado sólo en el flanco).
- **El orden de los `elsif` define prioridades** entre entradas asíncronas (caso de `q7`).
