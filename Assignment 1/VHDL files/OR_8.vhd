-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY OR_8 IS 

PORT ( IN1, IN2, IN3, IN4 , IN5 , IN6 , IN7, IN8 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END OR_8;


ARCHITECTURE LOGICFUNC OF OR_8 IS


COMPONENT OR_2 IS 

PORT ( IN1, IN2 : IN STD_LOGIC;
		 OUT1 : OUT STD_LOGIC);
		 
END COMPONENT;


SIGNAL S1,S2,S3,S4, F1, F2: STD_LOGIC;


BEGIN 

V0: OR_2 PORT MAP (IN1, IN2, S1);
V1: OR_2 PORT MAP (IN3, IN4, S2);
V2: OR_2 PORT MAP (IN5, IN6, S3);
V3: OR_2 PORT MAP (IN7, IN8, S4);

V4: OR_2 PORT MAP (S1, S2, F1);
V5: OR_2 PORT MAP (S3, S4, F2);

V6: OR_2 PORT MAP (F1, F2, OUT1);


	
END LOGICFUNC;