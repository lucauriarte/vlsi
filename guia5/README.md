# Guía 5 — Síntesis VHDL

## Objetivos

- Comprender el proceso de síntesis en VHDL, identificando cómo las descripciones de comportamiento se traducen en estructuras de hardware como lógica combinacional, registros y máquinas de estado.
- Analizar el uso de sentencias condicionales en descripciones sintetizables, reconociendo su impacto en la generación de multiplexores, lógica combinacional y secuencial.
- Diseñar e interpretar máquinas de estados en VHDL, relacionando diagramas de estados con su implementación mediante procesos secuenciales y señales, y evaluando su correcta síntesis en hardware.

---

## Ejercicio 1

Sintetizar la siguiente tabla de verdad, correspondiente a un sumador completo:

| A | B | Cin | Cout | S |
|---|---|-----|------|---|
| 0 | 0 |  0  |  0   | 0 |
| 0 | 0 |  1  |  0   | 1 |
| 0 | 1 |  0  |  0   | 1 |
| 0 | 1 |  1  |  1   | 0 |
| 1 | 0 |  0  |  0   | 1 |
| 1 | 0 |  1  |  1   | 0 |
| 1 | 1 |  0  |  1   | 0 |
| 1 | 1 |  1  |  1   | 1 |

- a) mediante la sentencia `if`
- b) mediante `case`
- c) mediante `when ... else`
- d) mediante `with ... select`
- e) mediante la función suma descrita en el paquete `TablaDeVerdadPaquete.vhd`

> En VHDL se puede realizar la **asignación**: `(cout,s) <= std_logic_vector'("11");` o la **agrupación**: `std_logic_vector'(a,b,cin)="101"`, a fin de hacer más legible la descripción del sistema.

---

## Ejercicio 2

Sintetizar la siguiente tabla de verdad. Emplear la función `std_match()` (paquete `numeric_std`) para facilitar la descripción de la tabla de verdad contemplando los términos redundantes.

| A(11) | A(10) | A(9) | A(8) | A(7) | A(6) | A(5) | A(4) | A(3) | A(2) | A(1) | A(0) | S(6) | S(5) | S(4) | S(3) | S(2) | S(1) | S(0) |
|-------|-------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|------|
|   0   |   1   |  1   |  0   |  1   |  1   |  0   |  *   |  *   |  *   |  *   |  *   |  1   |  0   |  0   |  0   |  1   |  0   |  0   |
|   1   |   1   |  1   |  0   |  1   |  1   |  0   |  *   |  *   |  *   |  *   |  *   |  1   |  0   |  0   |  1   |  0   |  0   |  0   |
|   *   |   *   |  *   |  *   |  0   |  1   |  0   |  *   |  *   |  *   |  *   |  *   |  0   |  0   |  0   |  0   |  0   |  0   |  1   |
|   1   |   1   |  0   |  0   |  1   |  1   |  0   |  *   |  *   |  *   |  *   |  *   |  0   |  1   |  0   |  0   |  0   |  0   |  0   |
|   0   |   1   |  0   |  0   |  1   |  1   |  0   |  *   |  *   |  *   |  *   |  *   |  0   |  0   |  1   |  0   |  0   |  0   |  0   |
|   *   |   1   |  *   |  *   |  *   |  1   |  0   |  *   |  *   |  *   |  1   |  1   |  0   |  0   |  0   |  0   |  0   |  0   |  1   |
|   1   |   *   |  *   |  *   |  *   |  1   |  0   |  *   |  *   |  *   |  1   |  1   |  0   |  0   |  0   |  0   |  0   |  0   |  1   |
|   *   |   *   |  *   |  *   |  *   |  1   |  0   |  0   |  1   |  1   |  1   |  *   |  0   |  0   |  0   |  0   |  0   |  1   |  0   |
|   *   |   *   |  1   |  *   |  *   |  1   |  0   |  *   |  *   |  *   |  1   |  1   |  0   |  0   |  0   |  0   |  0   |  0   |  1   |
|   *   |   *   |  *   |  1   |  *   |  1   |  0   |  *   |  *   |  *   |  1   |  1   |  0   |  0   |  0   |  0   |  0   |  0   |  1   |

---

## Ejercicio 3

Sintetizar un multiplexor de 2 a 1 de 8 bits con los siguientes puertos:

- Entradas de datos: `A, B: in std_logic_vector(7 downto 0)`
- Entrada de selección: `SEL: in std_logic`
- Salida: `Y: out std_logic_vector(7 downto 0)`

Sintetizar mediante:

- a) sentencia `if`
- b) sentencia `case`
- c) sentencia `when ... else`
- d) sentencia `with ... select`

---

## Ejercicio 4

Sintetizar un decodificador de 3 a 8, con arquitecturas basadas en:

- a) la sentencia `with ... select`
- b) la sentencia `case`
- c) la sentencia `for ... in ... loop`

Entrada: `A(2 downto 0)` — Salida: `Y(7 downto 0)`

---

## Ejercicio 5

Sintetizar un codificador de 8 a 3 con prioridad, mediante arquitecturas basadas en:

- a) la sentencia `when ... else`
- b) la sentencia `if`
- c) la sentencia `for ... loop`

Entradas: `A(7 downto 0)`. La salida `S(2 downto 0)` indica cuál de los 8 bits de entrada tiene un 1 lógico. Si dos o más entradas se encuentran en 1, la salida reflejará la de mayor peso.

---

## Ejercicio 6

Sintetizar los siguientes contadores:

- a) Un contador de 4 bits. Entradas: `CLK` (reloj) y `RST` (reset asincrónico).
- b) Al contador realizado agregarle una entrada de habilitación de reloj (`CE`) y otra (`L`) de entrada de carga en paralelo para llevar la cuenta (entrada `Cuenta`) a un valor determinado. Estas entradas son sincrónicas.
- c) El contador del punto b) debe ser ahora paramétrico.

---

## Ejercicio 7

HDLC es un protocolo de transmisión de datos. En este, el inicio o el final de una trama se señaliza mediante la secuencia `"01111110"`, a este patrón se lo denomina *flag*. Realizar un circuito que detecte esta cadena, momento en el cual, coincidente con el último 0, se pondrá en 1 la señal `F` durante un pulso de reloj.

Sintetizar:

1. Mediante una máquina de Moore sin asignación de estados, empleando la construcción:

```vhdl
type e is (eReset, Primer0, Primer1, Segundo1, Tercer1,
           Cuarto1, Quinto1, Sexto1, Inicio);
```

2. Con asignación de estados binaria, empleando la construcción:

```vhdl
type e is (eReset, Primer0, Primer1, Segundo1, Tercer1,
           Cuarto1, Quinto1, Sexto1, Inicio);
attribute syn_encoding : string;
attribute syn_encoding of e : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000";
```

3. Con asignación de estados en código Gray, empleando la construcción:

```vhdl
type e is (eReset, Primer0, Primer1, Segundo1, Tercer1,
           Cuarto1, Quinto1, Sexto1, Inicio);
attribute syn_encoding : string;
attribute syn_encoding of e : type is "0000 0001 0011 0010 0110 0111 0101 0100 1100";
```

4. Con asignación de estados, empleando la construcción:

```vhdl
subtype e is unsigned (3 downto 0);
constant eReset   : e := "0000";
constant Primer0  : e := "0001";
constant Primer1  : e := "0010";
constant Segundo1 : e := "0011";
constant Tercer1  : e := "0100";
constant Cuarto1  : e := "0101";
constant Quinto1  : e := "0110";
constant Sexto1   : e := "0111";
constant Inicio   : e := "1000";
```

5. Sintetizar ahora con una arquitectura que almacene los 8 últimos bits y detecte la combinación que indica el principio de trama.

> Para todos los casos indicar el número de celdas lógicas empleadas y la codificación que emplea el sintetizador.
