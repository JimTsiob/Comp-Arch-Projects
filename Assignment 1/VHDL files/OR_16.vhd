-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY OR_16 IS
PORT( in1 ,in2 : in std_logic_vector (15 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0)
);
END OR_16;


ARCHITECTURE logic_structural OF OR_16 IS

COMPONENT OR_2
PORT(
		in1,in2 : in std_logic;
		out1 : out std_logic
);
END COMPONENT;


BEGIN 
	OR0: OR_2 port map (in1(0),in2(0),output(0));
	OR1: OR_2 port map (in1(1),in2(1),output(1));
	OR2: OR_2 port map (in1(2),in2(2),output(2));
	OR3: OR_2 port map (in1(3),in2(3),output(3));
	OR4: OR_2 port map (in1(4),in2(4),output(4));
	OR5: OR_2 port map (in1(5),in2(5),output(5));
	OR6: OR_2 port map (in1(6),in2(6),output(6));
	OR7: OR_2 port map (in1(7),in2(7),output(7));
	OR8: OR_2 port map (in1(8),in2(8),output(8));
	OR9: OR_2 port map (in1(9),in2(9),output(9));
	OR10: OR_2 port map (in1(10),in2(10),output(10));
	OR11: OR_2 port map (in1(11),in2(11),output(11));
	OR12: OR_2 port map (in1(12),in2(12),output(12));
	OR13: OR_2 port map (in1(13),in2(13),output(13));
	OR14: OR_2 port map (in1(14),in2(14),output(14));
	OR15: OR_2 port map (in1(15),in2(15),output(15));

END logic_structural;