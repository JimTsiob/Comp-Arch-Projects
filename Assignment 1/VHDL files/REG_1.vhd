-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

-- 1 bit register 

ENTITY REG_1 IS
PORT(
		Input,Clock,Enable : in std_logic;
		output : out std_logic
);

END REG_1;

ARCHITECTURE logic_structural OF REG_1 IS

COMPONENT NAND_2 IS
PORT(
		in1,in2 : in std_logic;
		out1 : out std_logic
);
END COMPONENT;

COMPONENT AND_3 IS
PORT(
		in1,in2,in3 : in std_logic;
		out1 : out std_logic
);
END COMPONENT;

COMPONENT AND_2 IS
PORT(
	  in1,in2 : in std_logic;
	  out1 : out std_logic
);
END COMPONENT;

COMPONENT NOT1 IS
PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL P1,P2,P3,P4,five,six,afterClock,temp,notClock : std_LOGIC;

BEGIN

-- negative trigger register 
	
			Vnot : NOT1 port map(clock,notClock); -- this enables the register when the clock is negative.
			V0 : NAND_2 port map (P1,P4,P3);
			V1 : NAND_2 port map (afterClock,P3,P1);
			V2 : AND_3 port map (afterClock,P1,P4,temp);
			V3 : NOT1 port map (temp,P2);
			V4 : NAND_2 port map (input,P2,P4);
			V5 : NAND_2 port map (P1,six,five);
			V6 : NAND_2 port map (five,P2,six);
			V7 : AND_2 port map (notClock,Enable,afterClock);
			output <= five;
		
END logic_structural;