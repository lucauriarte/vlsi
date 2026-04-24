entity ejercicio is
    port ( d : in  bit_vector(2 downto 0);
           q : out integer range 0 to 3
    );
end ejercicio;

architecture uno of ejercicio is
begin
    process (d)
        variable num_bits : integer;
    begin
        num_bits := 0;
        for i in d'range loop
            if d(i) = '1' then
                num_bits := num_bits + 1;
            end if;
        end loop;
        q <= num_bits;
    end process;
end uno;
