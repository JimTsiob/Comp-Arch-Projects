-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY FULLADDER_1 IS
PORT(
		in1,in2,cin : in std_logic;
		sum , cout : out std_logic
);
END FULLADDER_1;


ARCHITECTURE logic_structural OF FULLADDER_1 IS

COMPONENT AND_2
PORT ( IN1 , IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

COMPONENT OR_3
PORT ( IN1, IN2, IN3 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

COMPONENT XOR_3
PORT ( IN1, IN2, IN3 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

SIGNAL s1,s2,s3 : std_logic;

BEGIN
	V0 : XOR_3 port map (in1,in2,cin,sum);
	V1 : AND_2 port map (in1,in2,s1);
	V2 : AND_2 port map (in1,cin,s2);
	V3 : AND_2 port map (in2,cin,s3);
	V4 : OR_3 port map (s1,s2,s3,cout);

END logic_structural;
	