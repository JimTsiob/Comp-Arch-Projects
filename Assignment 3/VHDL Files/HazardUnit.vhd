-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


Library ieee;
use ieee.std_logic_1164.all;

ENTITY HazardUnit IS
PORT(
		isJR,isJump,wasJump,mustBranch : in std_logic;
		flush,wasJumpOut : out std_logic;
		JRopcode : out std_logic_vector(1 DOWNTO 0)
);
END HazardUnit;


ARCHITECTURE Behavior OF HazardUnit IS
BEGIN
	PROCESS (isJR,isJump,wasJump,mustBranch)
	BEGIN
		flush <= '0';
		
		IF isJR = '1' OR isJump = '1' OR wasJump = '1' OR mustBranch = '1' THEN
			flush <= '1';
		END IF;
		IF isJump = '1' THEN
			JRopcode <= "01";
		ELSIF mustBranch = '1' THEN
			JRopcode <= "10";
		ELSE
			JRopcode <= "00";
		END IF;
	END PROCESS;
	
		wasJumpOut <= isJump;
		
END ARCHITECTURE Behavior;