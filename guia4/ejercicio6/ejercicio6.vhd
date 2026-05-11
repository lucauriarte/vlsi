library ieee;
use ieee.std_logic_1164.all;

entity ejercicio6 is
    port ( updown : in  std_logic;
           clock  : in  std_logic;
           lsb    : out std_logic;
           msb    : out std_logic);
end ejercicio6;

architecture firstenumsmch of ejercicio6 is

    type count_state is (zero, one, two, three);
    signal present_state, next_state : count_state;

begin

    -- Proceso combinacional: lógica de próximo estado y salidas
    process (present_state, updown)
    begin
        case present_state is
            when zero =>
                if (updown = '0') then
                    next_state <= one;
                    lsb <= '0'; msb <= '0';
                else
                    next_state <= three;
                    lsb <= '1'; msb <= '1';
                end if;
            when one =>
                if (updown = '0') then
                    next_state <= two;
                    lsb <= '1'; msb <= '0';
                else
                    next_state <= zero;
                    lsb <= '0'; msb <= '0';
                end if;
            when two =>
                if (updown = '0') then
                    next_state <= three;
                    lsb <= '0'; msb <= '1';
                else
                    next_state <= one;
                    lsb <= '1'; msb <= '0';
                end if;
            when three =>
                if (updown = '0') then
                    next_state <= zero;
                    lsb <= '1'; msb <= '1';
                else
                    next_state <= two;
                    lsb <= '0'; msb <= '1';
                end if;
        end case;
    end process;

    -- Proceso secuencial: registro de estado
    process (clock)
    begin
        if rising_edge(clock) then
            present_state <= next_state;
        end if;
    end process;

end firstenumsmch;