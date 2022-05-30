-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MUX8_1_16BIT IS

PORT (ADD_RES,SUB_RES,AND_RES,OR_RES,GEQ_RES,NOT_RES: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		SEL : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		OUT1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
		
		
END MUX8_1_16BIT;


ARCHITECTURE logic_structural OF MUX8_1_16BIT IS



--ADD - 0010
--SUB - 0011
--AND - 0000
--OR  - 0001
--GEQ - 0101
--NOT - 0110



BEGIN

	WITH SEL SELECT
		OUT1 <=   		ADD_RES when "0010",	
							SUB_RES WHEN "0011",
							AND_RES when "0000",
							OR_RES  when "0001",
							GEQ_RES when "0101",
							NOT_RES when "0110",
							"0000000000000000" WHEN others;
							


	
END logic_structural;