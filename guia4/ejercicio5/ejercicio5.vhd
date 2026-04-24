library ieee;
use ieee.std_logic_1164.all;

entity counters is
    port ( d       : in  integer range 0 to 255;
           clk     : in  std_logic;
           clear   : in  std_logic;
           ld      : in  std_logic;
           enable  : in  std_logic;
           up_down : in  std_logic;
           qa      : out integer range 0 to 255;
           qb      : out integer range 0 to 255;
           qc      : out integer range 0 to 255;
           qd      : out integer range 0 to 255;
           qe      : out integer range 0 to 255;
           qf      : out integer range 0 to 255;
           qg      : out integer range 0 to 255;
           qh      : out integer range 0 to 255;
           qi      : out integer range 0 to 255;
           qj      : out integer range 0 to 255;
           qk      : out integer range 0 to 255;
           ql      : out integer range 0 to 255;
           qm      : out integer range 0 to 255;
           qn      : out integer range 0 to 255);
end counters;

architecture a of counters is
begin

    process ( clk )
        variable cnt : integer range 0 to 255;
    begin
        if ( rising_edge(clk)) then
            if enable = '1' then
                cnt := cnt + 1;
            end if;
        end if;
        qa <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
    begin
        if (rising_edge(clk) ) then
            if ld = '0' then
                cnt := d;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qb <= cnt;
    end process;

    process ( clk )
        variable cnt: integer range 0 to 255;
    begin
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qc <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction: integer;
    begin
        if ( up_down = '1' ) then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk)) then
            cnt := cnt + direction;
        end if;
        qd <= cnt;
    end process;

    process ( clk )
        variable cnt: integer range 0 to 255;
    begin
        if ( rising_edge(clk) ) then
            if ld = '0' then
                cnt := d;
            else
                if enable = '1' then
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qe <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction : integer;
    begin
        if ( up_down = '1' ) then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk) ) then
            if enable = '1' then
                cnt := cnt + direction;
            end if;
        end if;
        qf <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
    begin
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                if enable = '1' then
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qg <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
    begin
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                if ld = '0' then
                    cnt := d;
                else
                    cnt := cnt + 1;
                end if;
            end if;
        end if;
        qh <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk) ) then
            if ld = '0' then
                cnt := d;
            else
                cnt := cnt + direction;
            end if;
        end if;
        qi <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction : integer;
    begin
        if ( up_down = '1' ) then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk) ) then
            if ld = '0' then
                cnt := d;
            else
                if enable = '1' then
                    cnt := cnt + direction;
                end if;
            end if;
        end if;
        qj <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
    begin
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                if ld = '0' then
                    cnt := d;
                else
                    if enable = '1' then
                        cnt := cnt + 1;
                    end if;
                end if;
            end if;
        end if;
        qk <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction : integer;
    begin
        if ( up_down = '1' ) then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                cnt := cnt + direction;
            end if;
        end if;
        ql <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        variable direction : integer;
    begin
        if (up_down = '1') then
            direction := 1;
        else
            direction := -1;
        end if;
        if ( rising_edge(clk) ) then
            if clear = '0' then
                cnt := 0;
            else
                if enable = '1' then
                    cnt := cnt + direction;
                end if;
            end if;
        end if;
        qm <= cnt;
    end process;

    process ( clk )
        variable cnt : integer range 0 to 255;
        constant modulus : integer := 200;
    begin
        if ( rising_edge(clk) ) then
            if cnt = modulus then
                cnt := 0;
            else
                cnt := cnt + 1;
            end if;
        end if;
        qn <= cnt;
    end process;

end a;
