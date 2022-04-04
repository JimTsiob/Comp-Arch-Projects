-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY OR_HELPER_16 IS
PORT(in1 : in std_logic_vector(15 DOWNTO 0);
		output : out std_logic);
		
END OR_HELPER_16;

ARCHITECTURE logic_structural OF OR_HELPER_16 IS

COMPONENT OR_2
PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
END COMPONENT;

SIGNAL s1,s2,s3,s4,s5,s6,s7,s8,s21,s22,s23,s24,s31,s32 : std_logic;

BEGIN
	V0 : OR_2 port map (in1(0),in1(1),s1);
	V1 : OR_2 port map (in1(2),in1(3),s2);
	V2 : OR_2 port map (in1(4),in1(5),s3);
	V3 : OR_2 port map (in1(6),in1(7),s4);
	V4 : OR_2 port map (in1(8),in1(9),s5);
	V5 : OR_2 port map (in1(10),in1(11),s6);
	V6 : OR_2 port map (in1(12),in1(13),s7);
	V7 : OR_2 port map (in1(14),in1(15),s8);
	
	-- 2nd level
	V8 : OR_2 port map (s1,s2,s21);
	V9 : OR_2 port map (s3,s4,s22);
	V10 : OR_2 port map (s5,s6,s23);
	V11 : OR_2 port map (s7,s8,s24);
	
	-- 3rd level
	V12 : OR_2 port map (s21,s22,s31);
	V13 : OR_2 port map (s23,s24,s32);
	
	-- 4th level
	V14 : OR_2 port map (s31,s32,output);
	
	
END logic_structural;