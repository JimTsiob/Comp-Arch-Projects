-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY REG_MEM_WB IS
GENERIC(
			n : INTEGER := 16;
			addressSize : INTEGER := 3
);
PORT(
		Result : IN STD_LOGIC_VECTOR(n-1 downto 0);
		RegAD : in std_LOGIC_VECTOR(addressSize-1 downto 0);
		clk : in std_logic;
		writeData : out std_loGIC_VECTOR(n-1 downto 0);
		writeAD : out std_LOGIC_VECTOR(addressSize-1 downto 0)
);

END REG_MEM_WB;

ARCHITECTURE behavior of REG_MEM_WB IS
BEGIN

pc:process(clk)
begin
	if clk = '1' then -- rising edge
		writeData <= Result;
		writeAD <= RegAD;
	end if;
end process pc;

END ARCHITECTURE Behavior;