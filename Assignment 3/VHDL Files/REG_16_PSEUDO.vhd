-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG_16_PSEUDO IS
GENERIC(
		n : INTEGER := 16
);
PORT(
		Input : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Enable , Clock : IN STD_LOGIC;
		Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END REG_16_PSEUDO;

ARCHITECTURE Behavior OF REG_16_PSEUDO IS
BEGIN
	Output <= (OTHERS => '0');

END Behavior;