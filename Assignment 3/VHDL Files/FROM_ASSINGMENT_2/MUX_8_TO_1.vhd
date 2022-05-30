-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY MUX_8_TO_1 IS
GENERIC(
			n : INTEGER := 16
);
PORT(
		Input0,Input1,Input2,Input3,Input4,Input5,Input6,Input7 : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);

END MUX_8_TO_1;

ARCHITECTURE LogicFunc of MUX_8_TO_1 IS
BEGIN
	WITH opcode SELECT
	Output <= Input0 when "000",
				Input1 when "001",
				Input2 when "010",
				Input3 when "011",
				Input4 when "100",
				Input5 when "101",
				Input6 when "110",
				Input7 when "111",
				"0000000000000000" WHEN OTHERS;


END LogicFunc;