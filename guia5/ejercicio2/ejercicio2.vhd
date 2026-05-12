library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ejercicio2 is
    port (
        a : in  std_logic_vector(11 downto 0);
        s : out std_logic_vector(6 downto 0)
    );
end ejercicio2;

architecture arq of ejercicio2 is
begin
    process(a)
    begin
        if    std_match(a, "0110110-----") then s <= "1000100";  -- fila 1
        elsif std_match(a, "1110110-----") then s <= "1001000";  -- fila 2
        elsif std_match(a, "----010-----") then s <= "0000001";  -- fila 3
        elsif std_match(a, "1100110-----") then s <= "0100000";  -- fila 4
        elsif std_match(a, "0100110-----") then s <= "0010000";  -- fila 5
        elsif std_match(a, "-1---10---11") then s <= "0000001";  -- fila 6
        elsif std_match(a, "1----10---11") then s <= "0000001";  -- fila 7
        elsif std_match(a, "-----100111-") then s <= "0000010";  -- fila 8
        elsif std_match(a, "--1--10---11") then s <= "0000001";  -- fila 9
        elsif std_match(a, "---1-10---11") then s <= "0000001";  -- fila 10
        else                                    s <= "0000000";
        end if;
    end process;
end arq;
