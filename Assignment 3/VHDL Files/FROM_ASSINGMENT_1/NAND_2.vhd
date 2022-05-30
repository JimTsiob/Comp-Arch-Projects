-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY NAND_2 IS
PORT(
		in1,in2 : in std_logic;
		out1 : out std_logic
);
END NAND_2;


ARCHITECTURE logic_structural OF NAND_2 IS

COMPONENT AND_2 IS
PORT ( IN1 , IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

COMPONENT NOT1 IS
PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL s1 : std_logic;

BEGIN
	v0 : AND_2 port map (in1,in2,s1);
	v1 : NOT1 port map (s1,out1);

END logic_structural;