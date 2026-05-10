library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ejercicio2 is
    port ( op1, op2 : in unsigned(7 downto 0);
           result   : out integer
    );
end ejercicio2;

architecture uno of ejercicio2 is
begin
    result <= conv_integer(op1 + op2);
end uno;