library ieee;
use ieee.std_logic_1164.all;

entity ejercicio3 is
	port
	(
		-- Input ports
		A	: in std_logic_vector(7 downto 0);
		B	: in std_logic_vector(7 downto 0);
		SEL: in std_logic;
		-- Output ports
		Y : out std_logic_vector(7 downto 0)
	);
end ejercicio3;

architecture arq_if of ejercicio3 is
begin
	process(A,B,SEL) is
	begin
		if(SEL = '0') then
			Y <= A;
		else
			Y <= B;
		end if;
	end process;
end arq_if;

architecture arq_case of ejercicio3 is
begin
	process(A,B,SEL) is
	begin
		case SEL is
			when '0' =>
				Y <= A;
			when others =>
				Y <= B;
		end case;
	end process;
end arq_case;

architecture arq_whenelse of ejercicio3 is
begin
	Y <= 
	A when SEL = '0' else
	B;
end arq_whenelse;

architecture arq_withselect of ejercicio3 is
begin
	with SEL select
	Y <= A when '0',
		  B when others;
end arq_withselect;
