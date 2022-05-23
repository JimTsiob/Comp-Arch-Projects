-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY FORWARDER IS
	GENERIC(addr_size : INTEGER := 3);
	PORT(
			R1AD , R2AD , RegAD_EXMEM, RegAD_MEMWB : IN std_logic_vector(addr_size - 1 DOWNTO 0);
			S1,S2 : OUT std_logic_vector(1 DOWNTO 0)
	);
END ENTITY FORWARDER;


ARCHITECTURE Behave OF FORWARDER IS
BEGIN
	PROCESS (RegAD_EXMEM, RegAD_MEMWB , R1AD , R2AD)
	BEGIN
		S1 <= "00"; -- select R1AD
 		S2 <= "00"; -- select R2AD
		
		if (R1AD = RegAD_EXMEM) then
			S1 <= "10"; -- select RegAD_EXMEM
		elsif (R1AD = RegAD_MEMWB) then
			S1 <= "01"; -- select RegAD_MEMWB
		end if;
		if (R2AD = RegAD_EXMEM) then
			S2 <= "10"; -- select RegAD_EXMEM
		elsif(R2AD = RegAD_MEMWB) then
			S2 <= "01"; -- select RegAD_MEMWB
		end if;
		
	END PROCESS;
END ARCHITECTURE behave;