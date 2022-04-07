-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

-- Parathrhsame oti to output tou teleytaiou Flip Flop kathysterei
-- ston ypologismo tou opote tha kathysterei kai ta ypoloipa kommatia
-- tou epexergasth.


ENTITY ALU_FF IS

PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(2 DOWNTO 0);
		clock,enable : in std_logic;
		ALUout : out std_logic_vector(15 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);

END ALU_FF;

ARCHITECTURE logic_structural OF ALU_FF IS


-- Flip Flop component

COMPONENT REG_16 IS
PORT(	
		input : in std_logic_vector(15 DOWNTO 0);
		clock,enable : in std_logic;
		output : out std_logic_vector(15 DOWNTO 0)
);
END COMPONENT;

-- ALU component
COMPONENT ALU_16_BIT IS
PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(2 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);
END COMPONENT;

SIGNAL ffs1,ffs2,alusignal : std_logic_vector(15 DOWNTO 0);

BEGIN

	FF1 : REG_16 port map(input1,clock,enable,ffs1);
	FF2 : REG_16 port map(input2,clock,enable,ffs2);
	ALU :	ALU_16_BIT port map(ffs1,ffs2,operation,alusignal,addcout,subcout);
	aluout <= alusignal;
	FF3 : REG_16 port map (alusignal,clock,enable,output);


END logic_structural;