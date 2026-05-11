library ieee;
use ieee.std_logic_1164.all;

entity ejercicio8 is
    port ( d   : in  std_logic_vector(11 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(11 downto 0));
end ejercicio8;

architecture a of ejercicio8 is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end a;