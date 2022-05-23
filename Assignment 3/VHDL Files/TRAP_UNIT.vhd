-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY TRAP_UNIT IS
PORT(
		opcode : IN STD_logic_vector(3 DOWNTO 0);
		EOR : OUT STD_LOGIC
);
END TRAP_UNIT;

ARCHITECTURE Behavior OF TRAP_UNIT IS
BEGIN
	PROCESS(opcode)
	BEGIN
		IF opcode = "1110" THEN
			EOR <= '1';
		ELSE
			EOR <= '0';
		END IF;
	END PROCESS;
END ARCHITECTURE Behavior;