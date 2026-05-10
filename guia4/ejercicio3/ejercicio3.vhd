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