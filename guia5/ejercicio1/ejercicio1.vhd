library ieee;
use ieee.std_logic_1164.all;

entity ejercicio1 is
	port
	(
		-- Input ports
		a	: in  std_logic;
		b	: in  std_logic;
		cin	: in  std_logic;

		-- Output ports
		cout	: out std_logic;
		s	: out std_logic
	);
end ejercicio1;

architecture arq_if of ejercicio1 is
begin
	process(a, b, cin) is 
	begin 
		if(a = '0') then
			if(b = '0') then
				if(cin = '0') then
					(cout,s) <= std_logic_vector'("00");
				else
					(cout,s) <= std_logic_vector'("01");
				end if;
			else
				if(cin = '0') then
					(cout,s) <= std_logic_vector'("01");
				else
					(cout,s) <= std_logic_vector'("10");
				end if;
			end if;
		else
			if(b = '0') then
				if(cin = '0') then
					(cout,s) <= std_logic_vector'("01");
				else
					(cout,s) <= std_logic_vector'("10");
				end if;
			else
				if(cin = '0') then
					(cout,s) <= std_logic_vector'("10");
				else
					(cout,s) <= std_logic_vector'("11");
				end if;
			end if;
		end if;
	end process; 
end arq_if;

architecture arq_case of ejercicio1 is
begin
	process(a, b, cin) is 
	begin
		case std_logic_vector'(a,b,cin) is
			when "000" =>
				(cout,s) <= std_logic_vector'("00");
			when "001" =>
				(cout,s) <= std_logic_vector'("01");
			when "010" =>
				(cout,s) <= std_logic_vector'("01");
			when "011" =>
				(cout,s) <= std_logic_vector'("10");
			when "100" =>
				(cout,s) <= std_logic_vector'("01");
			when "101" =>
				(cout,s) <= std_logic_vector'("10");
			when "110" =>
				(cout,s) <= std_logic_vector'("10");
			when "111" =>
				(cout,s) <= std_logic_vector'("11");
			when others =>
				-- Sequential Statement(s)
		end case;
	end process; 
end arq_case;


architecture arq_whenelse of ejercicio1 is
begin
	(cout,s) <= 
	std_logic_vector'("00") when std_logic_vector'(a,b,cin)="000" else
	std_logic_vector'("01") when std_logic_vector'(a,b,cin)="001" else
	std_logic_vector'("01") when std_logic_vector'(a,b,cin)="010" else
	std_logic_vector'("10") when std_logic_vector'(a,b,cin)="011" else
	std_logic_vector'("01") when std_logic_vector'(a,b,cin)="100" else
	std_logic_vector'("10") when std_logic_vector'(a,b,cin)="101" else
	std_logic_vector'("10") when std_logic_vector'(a,b,cin)="110" else
	std_logic_vector'("11");
end arq_whenelse;

architecture arq_withselect of ejercicio1 is
begin
	 with std_logic_vector'(a,b,cin) select
	 (cout,s) <= std_logic_vector'("00") when "000",
					 std_logic_vector'("01") when "001",
					 std_logic_vector'("01") when "010",
					 std_logic_vector'("10") when "011",
					 std_logic_vector'("01") when "100",
					 std_logic_vector'("10") when "101",
					 std_logic_vector'("10") when "110",
					 std_logic_vector'("11") when others;
end arq_withselect;