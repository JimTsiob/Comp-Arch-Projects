-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FULLADDER_16 IS
PORT( in1,in2 : in std_logic_vector(15 DOWNTO 0);
		cin : in std_logic;
		sum : out std_logic_vector(15 DOWNTO 0);
		cout , overflow : out std_logic
);

END FULLADDER_16;

ARCHITECTURE logic_structural OF FULLADDER_16 IS

-- full adder 1 bit component

COMPONENT FULLADDER_1
PORT(
		in1,in2,cin : in std_logic;
		sum , cout : out std_logic
);
END COMPONENT;

COMPONENT XOR_2
PORT ( A ,B : IN STD_LOGIC;
		 Z : OUT STD_LOGIC);
END COMPONENT;

SIGNAL C : std_logic_vector(16 DOWNTO 1);

BEGIN
	FA0 : FULLADDER_1 port map (in1(0),in2(0),cin,sum(0),C(1));
	FA1 : FULLADDER_1 port map (in1(1),in2(1),C(1),sum(1),C(2));
	FA2 : FULLADDER_1 port map (in1(2),in2(2),C(2),sum(2),C(3));
	FA3 : FULLADDER_1 port map (in1(3),in2(3),C(3),sum(3),C(4));
	FA4 : FULLADDER_1 port map (in1(4),in2(4),C(4),sum(4),C(5));
	FA5 : FULLADDER_1 port map (in1(5),in2(5),C(5),sum(5),C(6));
	FA6 : FULLADDER_1 port map (in1(6),in2(6),C(6),sum(6),C(7));
	FA7 : FULLADDER_1 port map (in1(7),in2(7),C(7),sum(7),C(8));
	FA8 : FULLADDER_1 port map (in1(8),in2(8),C(8),sum(8),C(9));
	FA9 : FULLADDER_1 port map (in1(9),in2(9),C(9),sum(9),C(10));
	FA10 : FULLADDER_1 port map (in1(10),in2(10),C(10),sum(10),C(11));
	FA11 : FULLADDER_1 port map (in1(11),in2(11),C(11),sum(11),C(12));
	FA12 : FUlLADDER_1 port map (in1(12),in2(12),C(12),sum(12),C(13));
	FA13 : FULLADDER_1 port map (in1(13),in2(13),C(13),sum(13),C(14));
	FA14 : FULLADDER_1 port map (in1(14),in2(14),C(14),sum(14),C(15));
	FA15 : FULLADDER_1 port map (in1(15),in2(15),C(15),sum(15),C(16));
	-- Overflow 
	OFlow : XOR_2 port map (C(15),C(16),overflow);
	
	cout <= C(16);
END logic_structural;