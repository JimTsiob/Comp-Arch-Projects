-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY ieee;
Use ieee.STD_Logic_1164.all;
use ieee.numeric_std.all;

ENTITY jump_AD IS
generic (
        n:integer:=16;
        k:integer:=12
    );
    Port(
        jumpADR : in std_logic_vector(k-1 downto 0);
        instrP2AD : in std_logic_vector(n-1 downto 0);
        EjumpAD : out std_logic_vector(n-1 downto 0)
    );
END jump_AD;

Architecture Logicfunc of jump_AD is 
    signal extended,multed: std_logic_vector(n-1 downto 0);
BEGIN
extended <= (n-1 downto k=> jumpADR(k-1))&(jumpADR);

process(instrP2AD)
BEGIN
    multed <= extended(n-2 downto 0)& '0';
    EjumpAD <= std_logic_vector(unsigned(multed)+unsigned(instrP2AD));
END PROCESS;
END Logicfunc;