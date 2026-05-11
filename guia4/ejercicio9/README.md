# Ejercicio 9 — Análisis

## Comportamiento del circuito

El circuito es un **registro paralelo de 24 bits** construido por instanciación de **dos registros de 12 bits** (`reg12`, el componente del ejercicio 8). En cada flanco ascendente de `clk` los 24 bits de `d` se transfieren a `q` y se mantienen hasta el próximo flanco.

Funcionalmente es idéntico a un único `reg24` de 24 flip-flops D, pero está descrito por composición jerárquica en lugar de hacerlo todo en un solo proceso.

## Estructura jerárquica

```
ejercicio9 (reg24)
├── reg12a : reg12   →   d[11..0]  → q[11..0]
└── reg12b : reg12   →   d[23..12] → q[23..12]
```

Ambas instancias comparten el reloj `clk`. La entidad de nivel superior sólo se encarga de **enrutar** los bits a cada sub-registro: no agrega lógica adicional.

## Mecanismo de invocación de componentes en VHDL

Para que la arquitectura del nivel superior pueda usar `reg12`, hace falta:

1. **La entidad y arquitectura de `reg12`** disponibles en la librería de trabajo (`work`). En este proyecto se incluyen en el mismo archivo `ejercicio9.vhd`.
2. **Una declaración de componente** que describa la interfaz de `reg12` desde la perspectiva del usuario. Esta declaración se encapsula en el paquete `reg24_package`:

   ```vhdl
   package reg24_package is
       component reg12
           port ( d   : in  std_logic_vector(11 downto 0);
                  clk : in  std_logic;
                  q   : out std_logic_vector(11 downto 0));
       end component;
   end reg24_package;
   ```

3. **Importar el paquete** en la unidad que lo va a usar:

   ```vhdl
   library work;
   use work.reg24_package.all;
   ```

4. **Instanciar** el componente con `port map`, conectando cada puerto formal del componente con la señal real del nivel superior:

   ```vhdl
   reg12a : reg12 port map (d => d(11 downto 0),  clk => clk, q => q(11 downto 0));
   reg12b : reg12 port map (d => d(23 downto 12), clk => clk, q => q(23 downto 12));
   ```

El paquete es opcional —`component` también puede declararse directamente dentro del `architecture`—, pero usarlo así permite reutilizar la declaración en varios diseños sin repetir código.

## Rol dentro de la guía

Este ejercicio muestra el patrón básico de **diseño jerárquico**: encapsular un bloque (el `reg12` del ejercicio 8) y reusarlo varias veces en un diseño de mayor tamaño. La misma técnica se aplica al instanciar megafunciones de la librería `lpm` (ejercicios 7 y 10) o cualquier IP de terceros.
