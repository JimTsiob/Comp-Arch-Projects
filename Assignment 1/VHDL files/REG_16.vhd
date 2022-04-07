-- Dimitris Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG_16 IS

PORT(	
		input : in std_logic_vector(15 DOWNTO 0);
		clock,enable : in std_logic;
		output : out std_logic_vector(15 DOWNTO 0)
);

END REG_16;

ARCHITECTURE logic_structural OF REG_16 IS

COMPONENT REG_1 IS
PORT(
		Input,Clock,Enable : in std_logic;
		output : out std_logic
);
END COMPONENT;

BEGIN

	G0 : REG_1 port map (input(0),clock,enable,output(0));
	G1 : REG_1 port map (input(1),clock,enable,output(1));
	G2 : REG_1 port map (input(2),clock,enable,output(2));
	G3 : REG_1 port map (input(3),clock,enable,output(3));
	G4 : REG_1 port map (input(4),clock,enable,output(4));
	G5 : REG_1 port map (input(5),clock,enable,output(5));
	G6 : REG_1 port map (input(6),clock,enable,output(6));
	G7 : REG_1 port map (input(7),clock,enable,output(7));
	G8 : REG_1 port map (input(8),clock,enable,output(8));
	G9 : REG_1 port map (input(9),clock,enable,output(9));
	G10 : REG_1 port map (input(10),clock,enable,output(10));
	G11 : REG_1 port map (input(11),clock,enable,output(11));
	G12 : REG_1 port map (input(12),clock,enable,output(12));
	G13 : REG_1 port map (input(13),clock,enable,output(13));
	G14 : REG_1 port map (input(14),clock,enable,output(14));
	G15 : REG_1 port map (input(15),clock,enable,output(15));
	
END logic_structural;