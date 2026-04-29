-- Contador BCD generico de 0 a MAX-1.
-- Todos los contadores del cronometro se clockean con el mismo clk de 50 MHz
-- y solo avanzan cuando 'ce' esta en alto. 'tc' (terminal count) se pulsea
-- cuando el contador esta en su valor maximo y ce='1', y se usa como ce
-- de la etapa siguiente para construir la cascada sincronica.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador_bcd is
    generic (
        MAX : positive := 10   -- numero de estados: cuenta 0..MAX-1
    );
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;                     -- reset asincronico, activo-bajo
        ce    : in  std_logic;                     -- clock enable
        q     : out unsigned(3 downto 0);          -- valor BCD actual
        tc    : out std_logic                      -- terminal count
    );
end entity contador_bcd;

architecture rtl of contador_bcd is
    signal cnt : unsigned(3 downto 0);
begin
    q  <= cnt;
    tc <= '1' when (cnt = to_unsigned(MAX-1, 4) and ce = '1') else '0';

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            cnt <= (others => '0');
        elsif rising_edge(clk) then
            if ce = '1' then
                if cnt = to_unsigned(MAX-1, 4) then
                    cnt <= (others => '0');
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;
end architecture rtl;
