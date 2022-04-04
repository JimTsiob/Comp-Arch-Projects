-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY NOT_16 IS
PORT(in1 : in std_logic_vector(15 DOWNTO 0);
	  output : out std_logic_vector(15 DOWNTO 0)	
);
END NOT_16;


ARCHITECTURE logic_structural OF NOT_16 IS

COMPONENT OR_HELPER_16 
PORT( in1 : in std_logic_vector (15 DOWNTO 0);
		output : out std_logic
);
END COMPONENT;

COMPONENT NOT1
PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END COMPONENT;

SIGNAL s1 : std_logic;
signal c : std_logic := '0';

BEGIN
	-- this bit will determine if our number is comprised only of 0s (s1 = 0)
	-- or if there is at least one bit that is equal to 1 (s1 = 1)
	 output(15 downto 1) <= (others => c);
	 
	 V0 : OR_HELPER_16 port map (in1,s1); 
	
	
	 V1 : NOT1 port map (s1,output(0));
	 
	
END logic_structural;