-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE ieee.std_logic_1164.all;



ENTITY SELECTOR IS 

GENERIC ( 

		n : INTEGER := 16

);

PORT ( Reg, Memory, WriteBack : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		 operation : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)


);


END SELECTOR;


ARCHITECTURE Behavior OF SELECTOR IS


BEGIN

		with operation select 
		
				output <= Reg 		when "00", 
						  WriteBack when "01",
						  Memory 	when "10",
						  "0000000000000000" when "11";


END Behavior;