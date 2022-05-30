-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY ieee;
Use ieee.STD_Logic_1164.all;
ENTITY sign_Extender IS 
    generic (
        n:integer:=16;
        k:integer:=6
    );
    port (
        immediate : in std_logic_vector(k-1 downto 0);
        extended : out std_logic_vector(n-1 downto 0)
    );
END sign_Extender;

Architecture Logicfunc of sign_Extender IS 
BEGIN 
    extended <= (n-1 downto k=> immediate(k-1)) & (immediate);
END Logicfunc;	 
