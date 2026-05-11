library ieee;
use ieee.std_logic_1164.all;

entity ejercicio13 is
    port ( clk     : in  std_logic;
           entrada : in  std_logic;
           reset   : in  std_logic;
           salida  : out std_logic);
end ejercicio13;

architecture a of ejercicio13 is

    type state_type is (s0, s1);
    signal state : state_type;

begin

    process (clk)
    begin
        if reset = '1' then
            state <= s0;
        elsif rising_edge(clk) then
            case state is
                when s0 =>
                    state <= s1;
                when s1 =>
                    if entrada = '1' then
                        state <= s0;
                    else
                        state <= s1;
                    end if;
            end case;
        end if;
    end process;

    salida <= '1' when state = s1 else '0';

end a;
