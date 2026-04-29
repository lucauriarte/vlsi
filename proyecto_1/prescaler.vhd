-- Prescaler: divide el reloj de 50 MHz para generar un pulso CE cada
-- MAX_COUNT ciclos (por defecto 5.000.000 -> 10 Hz, periodo de 100 ms).
-- CE dura exactamente 1 ciclo de clk.
-- 'en' habilita la cuenta (para stop/start: cuando en='0' el contador
-- queda congelado en el valor actual y no emite CE).

library ieee;
use ieee.std_logic_1164.all;

entity prescaler is
    generic (
        MAX_COUNT : positive := 5_000_000
    );
    port (
        clk   : in  std_logic;
        rst_n : in  std_logic;  -- reset asincronico, activo-bajo
        en    : in  std_logic;  -- habilitacion (stop/start)
        ce    : out std_logic   -- pulso de 1 ciclo cada MAX_COUNT ciclos
    );
end entity prescaler;

architecture rtl of prescaler is
    signal cnt : natural range 0 to MAX_COUNT-1;
begin
    ce <= '1' when (cnt = MAX_COUNT-1 and en = '1') else '0';

    process(clk, rst_n)
    begin
        if rst_n = '0' then
            cnt <= 0;
        elsif rising_edge(clk) then
            if en = '1' then
                if cnt = MAX_COUNT-1 then
                    cnt <= 0;
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;
end architecture rtl;
