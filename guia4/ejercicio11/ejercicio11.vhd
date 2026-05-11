library ieee;
use ieee.std_logic_1164.all;

entity ejercicio11 is
    port ( d, clk, clr, pre, load, data : in  std_logic;
           q1, q2, q3, q4, q5, q6, q7  : out std_logic);
end ejercicio11;

architecture maxpld of ejercicio11 is
begin

    process (clk)
    begin
        if rising_edge(clk) then
            q1 <= d;
        end if;
    end process;

    process (clk)
    begin
        if falling_edge(clk) then
            q2 <= d;
        end if;
    end process;

    process (clk, clr)
    begin
        if clr = '1' then
            q3 <= '0';
        elsif rising_edge(clk) then
            q3 <= d;
        end if;
    end process;

    process (clk, clr)
    begin
        if clr = '0' then
            q4 <= '0';
        elsif falling_edge(clk) then
            q4 <= d;
        end if;
    end process;

    process (clk, pre)
    begin
        if pre = '1' then
            q5 <= '1';
        elsif rising_edge(clk) then
            q5 <= d;
        end if;
    end process;

    process (clk, load, data)
    begin
        if load = '1' then
            q6 <= data;
        elsif rising_edge(clk) then
            q6 <= d;
        end if;
    end process;

    process (clk, clr, pre)
    begin
        if clr = '1' then
            q7 <= '0';
        elsif pre = '1' then
            q7 <= '1';
        elsif rising_edge(clk) then
            q7 <= d;
        end if;
    end process;

end maxpld;
