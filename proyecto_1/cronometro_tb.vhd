-- Testbench del cronometro.
-- Usa PRESCALER_MAX muy chico (5) para poder observar rollovers en
-- tiempo de simulacion razonable:
--   * 1 tick de decimas cada 5 ciclos de clk (100 ns @ 50 MHz simulado)
--   * 1 segundo logico   = 10 ticks   = 50 ciclos
--   * 1 minuto logico    = 600 ticks  = 3000 ciclos
--   * 9:59.9             = 5999 ticks = 29995 ciclos
--   * 10 minutos (rollover a 0:00.0) = 6000 ticks = 30000 ciclos
--
-- La secuencia del estimulo cubre:
--   1) reset inicial asincronico
--   2) corrida completa hasta el rollover de 9:59.9 -> 0:00.0
--   3) stop / resume (verifica que la cuenta quede congelada y continue)
--   4) reset asincronico en medio de la cuenta

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro_tb is
end entity cronometro_tb;

architecture sim of cronometro_tb is

    constant CLK_PERIOD : time     := 20 ns;   -- 50 MHz
    constant PRESC_MAX  : positive := 5;       -- prescaler reducido para simular

    signal clk              : std_logic := '0';
    signal rst_n            : std_logic := '0';
    signal start_stop       : std_logic := '0';
    signal disp_minutos     : std_logic_vector(6 downto 0);
    signal disp_decenas_seg : std_logic_vector(6 downto 0);
    signal disp_unidad_seg  : std_logic_vector(6 downto 0);
    signal disp_decimas     : std_logic_vector(6 downto 0);

    signal sim_done : boolean := false;

begin

    dut : entity work.cronometro
        generic map (
            PRESCALER_MAX => PRESC_MAX
        )
        port map (
            clk              => clk,
            rst_n            => rst_n,
            start_stop       => start_stop,
            disp_minutos     => disp_minutos,
            disp_decenas_seg => disp_decenas_seg,
            disp_unidad_seg  => disp_unidad_seg,
            disp_decimas     => disp_decimas
        );

    -- Generador de reloj
    clk_gen : process
    begin
        while not sim_done loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Estimulo
    stim : process
    begin
        -- 1) Reset inicial asincronico
        rst_n      <= '0';
        start_stop <= '0';
        wait for 5 * CLK_PERIOD;
        rst_n      <= '1';
        wait for 2 * CLK_PERIOD;

        -- 2) Corrida completa: 10 minutos (30000 ciclos de clk)
        --    deberiamos ver al menos un rollover 9:59.9 -> 0:00.0
        start_stop <= '1';
        wait for 30500 * CLK_PERIOD;

        -- 3) Stop/start: congelar ~20 ticks (200 ns reales en sim) y reanudar
        start_stop <= '0';
        wait for 200 * CLK_PERIOD;
        start_stop <= '1';
        wait for 200 * CLK_PERIOD;

        -- 4) Reset asincronico en medio de la cuenta
        rst_n <= '0';
        wait for 3 * CLK_PERIOD;
        rst_n <= '1';
        wait for 200 * CLK_PERIOD;

        sim_done <= true;
        wait;
    end process;

end architecture sim;
