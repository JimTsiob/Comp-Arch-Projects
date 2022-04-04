LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY XOR_2 IS

PORT ( A ,B : IN STD_LOGIC ;
		 Z : OUT STD_LOGIC);
		 
END XOR_2;


ARCHITECTURE STRUCTURAL OF XOR_2 IS


-----------------------------------------------

COMPONENT AND_2

PORT ( IN1 , IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END COMPONENT;
-----------------------------------------------

------------------------------------------------
COMPONENT OR_2

PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END COMPONENT;

-------------------------------------------------

-------------------------------------------------

COMPONENT NOT1

PORT ( A : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
		 
END COMPONENT;

-------------------------------------------------
SIGNAL NOTA, NOTB , X , Y : STD_LOGIC;


BEGIN 

V0: NOT1 PORT MAP (A, NOTA);
V1: NOT1 PORT MAP (B, NOTB);
V2: AND_2 PORT MAP (A, NOTB , X);
V3: AND_2 PORT MAP (B, NOTA , Y);
V4: OR_2 PORT MAP (X,Y,Z);


END STRUCTURAL;