# Guía 4 — Análisis VHDL

## Objetivos

- Comprender la estructura de un diseño VHDL, identificando las unidades básicas (`entity`, `architecture`, `package`, `configuration`) y su función en la definición del hardware.
- Reconocer y analizar sentencias secuenciales y concurrentes, entendiendo cómo se ejecutan dentro de procesos o en paralelo y cómo afectan el comportamiento del diseño.
- Desarrollar habilidades de análisis crítico de código VHDL, interpretando resultados, identificando errores y relacionando la estructura del código con la síntesis y ejecución en hardware.

---

## Ejercicio 1

Determinar el comportamiento del siguiente circuito y simularlo. Explique por qué la señal de salida se define con un rango entre 0 y 3 en lugar de utilizar un entero sin restricción. A partir de la simulación, determine el retardo del circuito.

```vhdl
entity ejercicio is
    port ( d : in bit_vector(2 downto 0);
           q : out integer range 0 to 3
    );
end ejercicio;

architecture uno of ejercicio is
begin
    process (d)
        variable num_bits : integer;
    begin
        num_bits := 0;
        for i in d'range loop
            if d(i) = '1' then
                num_bits := num_bits + 1;
            end if;
        end loop;
        q <= num_bits;
    end process;
end uno;
```

---

## Ejercicio 2

Determinar el comportamiento del siguiente circuito y simularlo. Explique qué función realiza `conv_integer()` y qué tipo de conversión se está llevando a cabo. Determine mediante simulación los retardos del circuito e indique qué operación aritmética implementa.

```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity adder is
    port ( op1, op2 : in unsigned(7 downto 0);
           result   : out integer
    );
end adder;

architecture uno of adder is
begin
    result <= conv_integer(op1 + op2);
end uno;
```

---

## Ejercicio 3

Determinar el comportamiento del siguiente circuito y simularlo. Obtener las ecuaciones lógicas de síntesis de la salida e identificar qué tipo de circuito digital se implementa.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ejercicio3 is
    port ( A, B, sel : in  std_logic;
           salida    : out std_logic);
end ejercicio3;

architecture tres of ejercicio3 is
begin
    salida <= A when sel = '0' else B;
end tres;
```

---

## Ejercicio 4

Determinar el comportamiento del siguiente circuito y simularlo (observe el empleo de la asignación concurrente condicional). ¿Qué ocurre cuando más de una entrada toma el valor 1? ¿Cuántos terminales se reservan para la señal `q` y por qué?

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ejercicio4 is
    port ( alto, medio, bajo : in  std_logic;
           q                 : out integer);
end ejercicio4;

architecture uno of ejercicio4 is
begin
    q <= 3 when alto  = '1' else
         2 when medio = '1' else
         1 when bajo  = '1' else 0;
end uno;
```

---

## Ejercicio 5

Determinar el comportamiento de cada uno de los siguientes contadores y simularlos. Especifique las diferencias entre ellos.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity counters is
    port ( d       : in  integer range 0 to 255;
           clk     : in  std_logic;
           clear   : in  std_logic;
           ld      : in  std_logic;
           enable  : in  std_logic;
           up_down : in  std_logic;
           qa      : out integer range 0 to 255;
           qb      : out integer range 0 to 255;
           qc      : out integer range 0 to 255;
           qd      : out integer range 0 to 255;
           qe      : out integer range 0 to 255;
           qf      : out integer range 0 to 255;
           qg      : out integer range 0 to 255;
           qh      : out integer range 0 to 255;
           qi      : out integer range 0 to 255;
           qj      : out integer range 0 to 255;
           qk      : out integer range 0 to 255;
           ql      : out integer range 0 to 255;
           qm      : out integer range 0 to 255;
           qn      : out integer range 0 to 255);
end counters;

architecture a of counters is
begin

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if enable = '1' then
                cnt := cnt + 1;
            end if;
        end if;
        qa <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if ld = '0' then
                cnt := d;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qb <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qc <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            cnt := cnt + direction;
        end if;
        qd <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if ld = '0' then
                cnt := d;
            else
                if enable = '1' then
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qe <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            if enable = '1' then
                cnt := cnt + direction;
            end if;
        end if;
        qf <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                if enable = '1' then
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qg <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                if ld = '0' then
                    cnt := d;
                else
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qh <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            if ld = '0' then
                cnt := d;
            else
                cnt := cnt + direction;
            end if;
        end if;
        qi <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            if ld = '0' then
                cnt := d;
            else
                if enable = '1' then
                    cnt := cnt + direction;
                end if;
            end if;
        end if;
        qj <= cnt;
    end process;

    process (clk)
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                if ld = '0' then
                    cnt := d;
                else
                    if enable = '1' then
                        cnt := cnt + 1;
                    end if;
                end if;
            end if;
        end if;
        qk <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                cnt := cnt + direction;
            end if;
        end if;
        ql <= cnt;
    end process;

    process (clk)
        variable cnt       : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if (rising_edge(clk)) then
            if clear = '0' then
                cnt := 0;
            else
                if enable = '1' then
                    cnt := cnt + direction;
                end if;
            end if;
        end if;
        qm <= cnt;
    end process;

    process (clk)
        variable cnt     : integer range 0 to 255;
        constant modulus : integer := 200;
    begin
        if (rising_edge(clk)) then
            if cnt = modulus then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qn <= cnt;
    end process;

end a;
```

---

## Ejercicio 6

Determinar el diagrama de estados del circuito, simular su funcionamiento y verificar que las transiciones y salidas coincidan con el modelo teórico mediante simulación en Quartus.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity enumsmch is
    port ( updown : in  std_logic;
           clock  : in  std_logic;
           lsb    : out std_logic;
           msb    : out std_logic);
end enumsmch;

architecture firstenumsmch of enumsmch is

    type count_state is (zero, one, two, three);
    signal present_state, next_state : count_state;

begin

    -- Proceso combinacional: lógica de próximo estado y salidas
    process (present_state, updown)
    begin
        case present_state is
            when zero =>
                if (updown = '0') then
                    next_state <= one;
                    lsb <= '0'; msb <= '0';
                else
                    next_state <= three;
                    lsb <= '1'; msb <= '1';
                end if;
            when one =>
                if (updown = '0') then
                    next_state <= two;
                    lsb <= '1'; msb <= '0';
                else
                    next_state <= zero;
                    lsb <= '0'; msb <= '0';
                end if;
            when two =>
                if (updown = '0') then
                    next_state <= three;
                    lsb <= '0'; msb <= '1';
                else
                    next_state <= one;
                    lsb <= '1'; msb <= '0';
                end if;
            when three =>
                if (updown = '0') then
                    next_state <= zero;
                    lsb <= '1'; msb <= '1';
                else
                    next_state <= two;
                    lsb <= '0'; msb <= '1';
                end if;
        end case;
    end process;

    -- Proceso secuencial: registro de estado
    process (clock)
    begin
        if rising_edge(clock) then
            present_state <= next_state;
        end if;
    end process;

end firstenumsmch;
```

---

## Ejercicio 7

Determinar el comportamiento del siguiente circuito y simularlo. Interprete cada uno de los terminales de la RAM que se desea implementar.

- **a)** Desde el simulador (menú *Initialize*) inicialice algunos lugares de memoria y léalos mediante una simulación.
- **b)** Mediante el editor de ondas y el simulador escriba un lugar de memoria y luego léalo.

> Nota: Si se colocan las constantes en el lugar deseado, la parte del *Initialize menu* es opcional.

Interprete el contenido de los archivos `*.hex` y `*.mif`.

```vhdl
package ram_constants is
    constant addr_width : integer := 8;
    constant data_width : integer := 8;
end ram_constants;

library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
library work;
use work.ram_constants.all;

entity ram256x8 is
    port ( data     : in  std_logic_vector(data_width - 1 downto 0);
           address  : in  std_logic_vector(addr_width - 1 downto 0);
           we       : in  std_logic;
           inclock  : in  std_logic;
           outclock : in  std_logic;
           q        : out std_logic_vector(data_width - 1 downto 0));
end ram256x8;

architecture example of ram256x8 is
begin
    inst_1 : lpm_ram_dq
        generic map (lpm_widthad => addr_width, lpm_width => data_width)
        port map (data => data, address => address, we => we,
                  inclock => inclock, outclock => outclock, q => q);
end example;
```

> El archivo de inicialización se puede crear con un editor de texto ASCII o desde la ventana de inicialización, también se lo puede llamar desde aquí o especificar con el parámetro `lpm_file`.

---

## Ejercicio 8

Determinar el comportamiento del siguiente circuito y simularlo. Este circuito será invocado por el circuito del ejercicio 9.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity reg12 is
    port ( d   : in  std_logic_vector(11 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(11 downto 0));
end reg12;

architecture a of reg12 is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end a;
```

---

## Ejercicio 9

Determinar el comportamiento del siguiente programa y simularlo. Para llamar un componente ya definido se crea primero un paquete dentro del archivo de menor jerarquía o en un archivo aparte, y luego se lo invoca como un componente.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

package reg24_package is
    component reg12
        port ( d   : in  std_logic_vector(11 downto 0);
               clk : in  std_logic;
               q   : out std_logic_vector(11 downto 0));
    end component;
end reg24_package;

library work;
use work.reg24_package.all;

entity reg24 is
    port ( d   : in  std_logic_vector(23 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(23 downto 0));
end reg24;

architecture a of reg24 is
begin
    reg12a : reg12 port map (d => d(11 downto 0),  clk => clk, q => q(11 downto 0));
    reg12b : reg12 port map (d => d(23 downto 12), clk => clk, q => q(23 downto 12));
end a;
```

---

## Ejercicio 10

Determinar el comportamiento del siguiente programa y simularlo. Determinar las características del componente `lpm_ff`.

```vhdl
library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity reg24lpm is
    port ( d   : in  std_logic_vector(23 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(23 downto 0));
end reg24lpm;

architecture a of reg24lpm is
begin
    reg12a : lpm_ff
        generic map (lpm_width => 12)
        port map (data => d(11 downto 0),  clock => clk, q => q(11 downto 0));

    reg12b : lpm_ff
        generic map (lpm_width => 12)
        port map (data => d(23 downto 12), clock => clk, q => q(23 downto 12));
end a;
```

---

## Ejercicio 11

Determinar el comportamiento del siguiente programa y simularlo.

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity reginf is
    port ( d, clk, clr, pre, load, data : in  std_logic;
           q1, q2, q3, q4, q5, q6, q7  : out std_logic);
end reginf;

architecture maxpld of reginf is
begin

    process (clk)
    begin
        if rising_edge(clk) then
            q1 <= d;
        end if;
    end process;

    process (clk)
    begin
        if falling_edge(clk) then
            q2 <= d;
        end if;
    end process;

    process (clk, clr)
    begin
        if clr = '1' then
            q3 <= '0';
        elsif rising_edge(clk) then
            q3 <= d;
        end if;
    end process;

    process (clk, clr)
    begin
        if clr = '0' then
            q4 <= '0';
        elsif falling_edge(clk) then
            q4 <= d;
        end if;
    end process;

    process (clk, pre)
    begin
        if pre = '1' then
            q5 <= '1';
        elsif rising_edge(clk) then
            q5 <= d;
        end if;
    end process;

    process (clk, load, data)
    begin
        if load = '1' then
            q6 <= data;
        elsif rising_edge(clk) then
            q6 <= d;
        end if;
    end process;

    process (clk, clr, pre)
    begin
        if clr = '1' then
            q7 <= '0';
        elsif pre = '1' then
            q7 <= '1';
        elsif rising_edge(clk) then
            q7 <= d;
        end if;
    end process;

end maxpld;
```

---

## Ejercicio 12

Determinar el comportamiento del siguiente programa y simularlo (asignación concurrente con selección).

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity selsig is
    port ( d0, d1, d2, d3 : in  std_logic;
           s               : in  integer range 0 to 3;
           salida          : out std_logic);
end selsig;

architecture maxpld of selsig is
begin
    with s select
        salida <= d0 when 0,
                  d1 when 1,
                  d2 when 2,
                  d3 when 3;
end maxpld;
```

---

## Ejercicio 13

Determinar el comportamiento del siguiente circuito y simularlo. Realizar el diagrama de estados. ¿El reset es sincrónico o asincrónico?

```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity statmach is
    port ( clk     : in  std_logic;
           entrada : in  std_logic;
           reset   : in  std_logic;
           salida  : out std_logic);
end statmach;

architecture a of statmach is

    type state_type is (s0, s1);
    signal state : state_type;

begin

    process (clk)
    begin
        if reset = '1' then
            state <= s0;
        elsif rising_edge(clk) then
            case state is
                when s0 =>
                    state <= s1;
                when s1 =>
                    if entrada = '1' then
                        state <= s0;
                    else
                        state <= s1;
                    end if;
            end case;
        end if;
    end process;

    salida <= '1' when state = s1 else '0';

end a;
```
