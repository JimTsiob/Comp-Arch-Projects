-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;


ENTITY REG_IF_ID IS
GENERIC(
		n : INTEGER := 16
);
PORT(
		inPC, inInstruction : IN STD_LOGIC_VECTOR(n-1 downto 0);
		clock,IF_Flush , IF_ID_Enable : IN STD_Logic;
		--------------------------------------------------------
		outPC,outInstruction : OUT STD_logic_vector(n-1 downto 0)
);
END REG_IF_ID;

ARCHITECTURE Behavior of REG_IF_ID IS
BEGIN
	pc : PROCESS(clock,IF_Flush,IF_ID_Enable)
	begin
		IF clock = '1' AND IF_ID_Enable = '1' THEN
			outPC <= std_logic_vector(unsigned(inPC) + 2);
			outInstruction <= inInstruction;
		elsif clock = '1' AND IF_Flush = '1' THEN
			outPC <= (OTHERS => '0');
			outInstruction <= (OTHERS => '0');
		END IF;
	END PROCESS PC;
END ARCHITECTURE Behavior;