# Ejercicio 1 — Análisis

## Comportamiento del circuito

El circuito es un **contador de bits en '1'** (*popcount*). Recibe un vector de 3 bits (`d`) y cuenta cuántos de esos bits valen `'1'`, entregando el resultado en `q`.

| `d` | `q` |
|-----|-----|
| 000 | 0   |
| 001 | 1   |
| 010 | 1   |
| 011 | 2   |
| 100 | 1   |
| 101 | 2   |
| 110 | 2   |
| 111 | 3   |

El proceso es puramente combinacional: se activa ante cualquier cambio en `d`, recorre los tres bits con un bucle `for` e incrementa una variable local `num_bits` por cada `'1'` encontrado. Al finalizar el bucle, asigna el resultado a la salida `q`.

## ¿Por qué `integer range 0 to 3` y no `integer`?

1. **Síntesis:** Un `integer` sin restricción no es sintetizable directamente en Quartus, ya que el sintetizador necesita saber cuántos bits asignar en hardware. Al restringir el rango a 0–3, el sintetizador sabe que alcanza con **2 bits**, lo que resulta en un circuito más eficiente.

2. **Corrección semántica:** El máximo número de `'1'`s que puede tener un vector de 3 bits es exactamente 3, por lo que el rango `0 to 3` expresa con precisión los valores posibles. Usar `integer` sin rango implicaría reservar 32 bits para representar algo que nunca supera 3.

## Retardo del circuito

Obtenido mediante simulación en Quartus II 13.0sp1: **8.44 ns**.
