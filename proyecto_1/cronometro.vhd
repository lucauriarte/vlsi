-- Top level del cronometro.
-- Cuenta de 0:00.0 a 9:59.9 y vuelve a 0:00.0 automaticamente.
--
-- Entradas:
--   clk        : reloj de 50 MHz (oscilador de la placa DE2, CLOCK_50).
--   rst_n      : reset asincronico, activo-bajo. Se conecta a un pulsador
--                KEY de la DE2 (los KEY son activo-bajo de fabrica).
--   start_stop : '1' = cronometro corre, '0' = congelado. Se conecta a
--                un switch SW de la DE2 (activo-alto).
--
-- Salidas (7 bits, activo-bajo, van directo a los pines HEX de la DE2):
--   disp_minutos     -> HEX3
--   disp_decenas_seg -> HEX2
--   disp_unidad_seg  -> HEX1
--   disp_decimas     -> HEX0

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is
    generic (
        -- 50 MHz / 10 Hz = 5_000_000 ciclos entre ticks de 100 ms.
        -- El testbench sobreescribe este valor para simular rapido.
        PRESCALER_MAX : positive := 5_000_000
    );
    port (
        clk              : in  std_logic;
        rst_n            : in  std_logic;
        start_stop       : in  std_logic;
        disp_minutos     : out std_logic_vector(6 downto 0);
        disp_decenas_seg : out std_logic_vector(6 downto 0);
        disp_unidad_seg  : out std_logic_vector(6 downto 0);
        disp_decimas     : out std_logic_vector(6 downto 0)
    );
end entity cronometro;

architecture rtl of cronometro is

    component prescaler is
        generic (MAX_COUNT : positive);
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            en    : in  std_logic;
            ce    : out std_logic
        );
    end component;

    component contador_bcd is
        generic (MAX : positive);
        port (
            clk   : in  std_logic;
            rst_n : in  std_logic;
            ce    : in  std_logic;
            q     : out unsigned(3 downto 0);
            tc    : out std_logic
        );
    end component;

    component bcd_a_7seg is
        port (
            bcd : in  unsigned(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;

    signal tick_100ms : std_logic;
    signal tc_dec, tc_uni, tc_dds : std_logic;
    signal q_dec, q_uni, q_dds, q_min : unsigned(3 downto 0);

begin

    -- Prescaler: 50 MHz -> pulso de 100 ms
    u_prescaler : prescaler
        generic map (MAX_COUNT => PRESCALER_MAX)
        port map (
            clk   => clk,
            rst_n => rst_n,
            en    => start_stop,
            ce    => tick_100ms
        );

    -- Decimas de segundo: 0..9
    u_cnt_decimas : contador_bcd
        generic map (MAX => 10)
        port map (
            clk   => clk,
            rst_n => rst_n,
            ce    => tick_100ms,
            q     => q_dec,
            tc    => tc_dec
        );

    -- Unidad de segundos: 0..9 (avanza cuando decimas pasa de 9 -> 0)
    u_cnt_unidad_seg : contador_bcd
        generic map (MAX => 10)
        port map (
            clk   => clk,
            rst_n => rst_n,
            ce    => tc_dec,
            q     => q_uni,
            tc    => tc_uni
        );

    -- Decenas de segundos: 0..5 (para limitar segundos a 59)
    u_cnt_decenas_seg : contador_bcd
        generic map (MAX => 6)
        port map (
            clk   => clk,
            rst_n => rst_n,
            ce    => tc_uni,
            q     => q_dds,
            tc    => tc_dds
        );

    -- Minutos: 0..9 (al pasar de 9 vuelve a 0 -> rollover de 9:59.9 a 0:00.0)
    u_cnt_minutos : contador_bcd
        generic map (MAX => 10)
        port map (
            clk   => clk,
            rst_n => rst_n,
            ce    => tc_dds,
            q     => q_min,
            tc    => open
        );

    -- Decodificadores BCD -> 7 segmentos (salida ya invertida para los HEX)
    u_dec_decimas     : bcd_a_7seg port map (bcd => q_dec, seg => disp_decimas);
    u_dec_unidad_seg  : bcd_a_7seg port map (bcd => q_uni, seg => disp_unidad_seg);
    u_dec_decenas_seg : bcd_a_7seg port map (bcd => q_dds, seg => disp_decenas_seg);
    u_dec_minutos     : bcd_a_7seg port map (bcd => q_min, seg => disp_minutos);

end architecture rtl;
