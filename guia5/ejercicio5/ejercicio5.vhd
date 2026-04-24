library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Codificador de prioridad 8 a 3
-- A(7 downto 0): entradas; S(2 downto 0): salida con el indice del bit de mayor
-- peso activo. Si ninguna entrada esta activa, S = "000".

entity ejercicio5 is
    port (
        A : in  std_logic_vector(7 downto 0);
        S : out std_logic_vector(2 downto 0)
    );
end ejercicio5;

-- -----------------------------------------------------------------------------
-- a) Arquitectura con sentencia when ... else
--    Prioridad decreciente: A(7) > A(6) > ... > A(0).
--    La primera condicion verdadera determina el valor de S.
-- -----------------------------------------------------------------------------
--architecture arq_when_else of ejercicio5 is
--begin
--    S <= "111" when A(7) = '1' else
--         "110" when A(6) = '1' else
--         "101" when A(5) = '1' else
--         "100" when A(4) = '1' else
--         "011" when A(3) = '1' else
--         "010" when A(2) = '1' else
--         "001" when A(1) = '1' else
--         "000";
--end arq_when_else;

-- -----------------------------------------------------------------------------
-- b) Arquitectura con sentencia if (dentro de un process)
--    Misma logica de prioridad que en (a), expresada de forma secuencial.
-- -----------------------------------------------------------------------------
architecture arq_if of ejercicio5 is
begin
    process (A)
    begin
        if    A(7) = '1' then S <= "111";
        elsif A(6) = '1' then S <= "110";
        elsif A(5) = '1' then S <= "101";
        elsif A(4) = '1' then S <= "100";
        elsif A(3) = '1' then S <= "011";
        elsif A(2) = '1' then S <= "010";
        elsif A(1) = '1' then S <= "001";
        elsif A(0) = '1' then S <= "000";
        end if;
    end process;
end arq_if;

-- -----------------------------------------------------------------------------
-- c) Arquitectura con sentencia for ... loop
--    El bucle recorre los indices de menor a mayor. En VHDL, la ultima
--    asignacion a una senal dentro de un process es la que prevalece, por lo
--    que el bit de mayor indice activo "sobreescribe" a los anteriores,
--    implementando la prioridad de mayor peso.
-- -----------------------------------------------------------------------------
--architecture arq_for_loop of ejercicio5 is
--begin
--    process (A)
--    begin
--        S <= "000";  -- valor por defecto (ninguna entrada activa)
--        for i in 0 to 7 loop
--            if A(i) = '1' then
--                S <= std_logic_vector(to_unsigned(i, 3));
--            end if;
--        end loop;
--    end process;
--end arq_for_loop;
