library ieee;
use ieee.std_logic_1164.all;

entity reg12 is
    port ( d   : in  std_logic_vector(11 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(11 downto 0));
end reg12;

architecture a of reg12 is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            q <= d;
        end if;
    end process;
end a;

library ieee;
use ieee.std_logic_1164.all;

package reg24_package is
    component reg12
        port ( d   : in  std_logic_vector(11 downto 0);
               clk : in  std_logic;
               q   : out std_logic_vector(11 downto 0));
    end component;
end reg24_package;

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.reg24_package.all;

entity ejercicio9 is
    port ( d   : in  std_logic_vector(23 downto 0);
           clk : in  std_logic;
           q   : out std_logic_vector(23 downto 0));
end ejercicio9;

architecture a of ejercicio9 is
begin
    reg12a : reg12 port map (d => d(11 downto 0),  clk => clk, q => q(11 downto 0));
    reg12b : reg12 port map (d => d(23 downto 12), clk => clk, q => q(23 downto 12));
end a;
