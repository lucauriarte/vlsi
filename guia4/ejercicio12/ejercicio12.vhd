library ieee;
use ieee.std_logic_1164.all;

entity ejercicio12 is
    port ( d0, d1, d2, d3 : in  std_logic;
           s               : in  integer range 0 to 3;
           salida          : out std_logic);
end ejercicio12;

architecture maxpld of ejercicio12 is
begin
    with s select
        salida <= d0 when 0,
                  d1 when 1,
                  d2 when 2,
                  d3 when 3;
end maxpld;
