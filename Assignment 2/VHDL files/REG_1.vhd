-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193



LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY REG_1 IS
PORT(
	Input, Clock , Enable : IN STD_LOGIC;
	Output : OUT STD_LOGIC
);
END REG_1;

ARCHITECTURE LogicFunc OF REG_1 IS
SIGNAL P1,P2,P3,P4,five,six,afterClock : std_logic;
BEGIN
	P3 <= P1 NAND P4;
	P1 <= afterClock NAND P3;
	P2 <= NOT(afterClock AND P1 AND P4);
	P4 <= Input NAND P2;
	five <= six NAND P1;
	six <= P2 NAND five;
	afterClock <= Clock AND Enable;
	output <= five;
END LogicFunc;