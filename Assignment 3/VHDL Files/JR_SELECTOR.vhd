-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY JR_SELECTOR IS
GENERIC(
			n : INTEGER := 16
);

PORT(
		jumpAD,branchAd, PCP2AD : in std_logic_vector(n-1 downto 0);
		jRopcode : in std_logic_vector(1 downto 0);
		result : out std_logic_vector(n-1 downto 0)
);
END JR_SELECTOR;

ARCHITECTURE behavior of JR_SELECTOR IS
BEGIN
	-- opcode:
	-- 00 : +2 from outPC of IF_ID
	-- 01 : JumpAD
	-- 10 : branchAd
	process(JRopcode)
	BEGIN
		case JRopcode IS
			WHEN "00" =>
				result <= PCP2AD;
			WHEN "01" =>
				result <= jumpAD;
			WHEN "10" =>
				result <= branchAd;
			WHEN OTHERS => result <= PCP2AD;
		end case;
	end process;
	
END Behavior;