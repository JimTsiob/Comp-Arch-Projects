LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY OR_2 IS 

PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END OR_2;


ARCHITECTURE LOGICFUNC OF OR_2 IS

BEGIN 

	OUT1 <= IN1 OR IN2;
	
END LOGICFUNC;