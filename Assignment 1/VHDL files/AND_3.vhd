-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY AND_3 IS

PORT(
		in1,in2,in3 : in std_logic;
		out1 : out std_logic
);

END AND_3;


ARCHITECTURE logic_structural OF AND_3 IS

COMPONENT AND_2 IS

PORT(in1,in2 : in std_logic;
	  out1 : out std_logic
);


END COMPONENT;

SIGNAL s1 : std_logic;

BEGIN
	V0 : AND_2 port map (in1,in2,s1);
	V1 : AND_2 port map (s1,in3,out1);

END logic_structural;