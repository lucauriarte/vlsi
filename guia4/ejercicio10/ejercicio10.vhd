library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity ejercicio10 is
    port ( d   : in  std_logic_vector(23 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(23 downto 0));
end ejercicio10;

architecture a of ejercicio10 is
begin
    reg12a : lpm_ff
        generic map (lpm_width => 12)
        port map (data => d(11 downto 0),  clock => clk, q => q(11 downto 0));

    reg12b : lpm_ff
        generic map (lpm_width => 12)
        port map (data => d(23 downto 12), clock => clk, q => q(23 downto 12));
end a;
