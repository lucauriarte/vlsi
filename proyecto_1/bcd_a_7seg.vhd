-- Decodificador BCD a 7 segmentos, salida en formato activo-bajo
-- (compatible directo con los displays HEX0..HEX3 de la placa DE2).
-- Bit 0 = segmento 'a', bit 6 = segmento 'g'.
-- Para valores fuera de rango (10..15) se apaga el display.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_a_7seg is
    port (
        bcd : in  unsigned(3 downto 0);
        seg : out std_logic_vector(6 downto 0)
    );
end entity bcd_a_7seg;

architecture rtl of bcd_a_7seg is
begin
    with to_integer(bcd) select
        seg <= "1000000" when 0,   -- 0
               "1111001" when 1,   -- 1
               "0100100" when 2,   -- 2
               "0110000" when 3,   -- 3
               "0011001" when 4,   -- 4
               "0010010" when 5,   -- 5
               "0000010" when 6,   -- 6
               "1111000" when 7,   -- 7
               "0000000" when 8,   -- 8
               "0010000" when 9,   -- 9
               "1111111" when others;  -- apagado
end architecture rtl;
