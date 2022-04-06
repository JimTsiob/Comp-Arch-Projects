-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity FULL_SUB_1 is 

port( A, B, C : in std_logic; 
DIFF, Borrow : out std_logic);

-- diff = apotelesma afaireshs
-- borrow = kratoumeno afaireshs

end FULL_SUB_1;


ARCHITECTURE logic_structural OF FULL_SUB_1 IS

COMPONENT XOR_3 IS

PORT ( IN1, IN2, IN3 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);

END COMPONENT;

COMPONENT OR_2 IS

PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		
END COMPONENT;

COMPONENT AND_2 IS

PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END COMPONENT;

COMPONENT NOT1 IS

PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);

END COMPONENT;
SIGNAL s1,s2,s3,s4 : std_LOGIC;

BEGIN

	xorPort : XOR_3 port map (a,b,c,DIFF);
	notA : NOT1 port map (a,s1);
	BOrC : OR_2 port map (b,c,s2);
	and_notA_borc : AND_2 port map (s1,s2,s3);
	b_and_c : AND_2 port map (b,c,s4);
	s3_or_s4 : OR_2 port map (s3,s4,borrow);

END logic_structural;
