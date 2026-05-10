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