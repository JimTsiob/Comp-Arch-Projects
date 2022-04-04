-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY AND_16 IS
PORT (in1,in2 : in std_logic_vector(15 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0)
);
END AND_16;



ARCHITECTURE logic_structural OF AND_16 IS

COMPONENT AND_2
PORT ( IN1 , IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

BEGIN
	AND0: AND_2 port map (in1(0),in2(0),output(0));
	AND1: AND_2 port map (in1(1),in2(1),output(1));
	AND2: AND_2 port map (in1(2),in2(2),output(2));
	AND3: AND_2 port map (in1(3),in2(3),output(3));
	AND4: AND_2 port map (in1(4),in2(4),output(4));
	AND5: AND_2 port map (in1(5),in2(5),output(5));
	AND6: AND_2 port map (in1(6),in2(6),output(6));
	AND7: AND_2 port map (in1(7),in2(7),output(7));
	AND8: AND_2 port map (in1(8),in2(8),output(8));
	AND9: AND_2 port map (in1(9),in2(9),output(9));
	AND10: AND_2 port map (in1(10),in2(10),output(10));
	AND11: AND_2 port map (in1(11),in2(11),output(11));
	AND12: AND_2 port map (in1(12),in2(12),output(12));
	AND13: AND_2 port map (in1(13),in2(13),output(13));
	AND14: AND_2 port map (in1(14),in2(14),output(14));
	AND15: AND_2 port map (in1(15),in2(15),output(15));
	
END logic_structural;
