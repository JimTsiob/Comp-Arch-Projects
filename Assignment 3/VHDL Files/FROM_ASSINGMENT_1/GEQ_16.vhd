-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY GEQ_16 IS
PORT(
		in1 : in std_logic_vector(15 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0)
);
END GEQ_16;


ARCHITECTURE logic_structural OF GEQ_16 IS

COMPONENT NOT1
PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL s1 : std_logic;
-- signal for zeroing all bits of output below
SIGNAL c : std_logic := '0';

BEGIN

	output(15 downto 1) <= (others => c);
	V0 : NOT1 port map (in1(15),s1);
	output(0) <= s1;
	
END logic_structural;
