package ram_constants is
    constant addr_width : integer := 8;
    constant data_width : integer := 8;
end ram_constants;

library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
library work;
use work.ram_constants.all;

entity ejercicio7 is
    port ( data     : in  std_logic_vector(data_width - 1 downto 0);
           address  : in  std_logic_vector(addr_width - 1 downto 0);
           we       : in  std_logic;
           inclock  : in  std_logic;
           outclock : in  std_logic;
           q        : out std_logic_vector(data_width - 1 downto 0));
end ejercicio7;

architecture example of ejercicio7 is
begin
    inst_1 : lpm_ram_dq
        generic map (lpm_widthad => addr_width, lpm_width => data_width)
        port map (data => data, address => address, we => we,
                  inclock => inclock, outclock => outclock, q => q);
end example;
