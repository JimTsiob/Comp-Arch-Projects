-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG_16B IS
PORT(
		Input : in std_logic_vector(15 downto 0);
		enable,clock : in std_logic;
		output : out std_logic_vector(15 downto 0)
);
END REG_16B;

ARCHITECTURE Behavior OF REG_16B IS
BEGIN
	process(clock)
	begin
		if clock ' EVENT AND Clock = '1' THEN
			IF ENABLE = '1' THEN
				Output <= Input;
			END IF;
		END IF;
	END PROCESS;
END Behavior;