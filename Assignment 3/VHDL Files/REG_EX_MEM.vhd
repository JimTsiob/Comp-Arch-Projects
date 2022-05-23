-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY REG_EX_MEM IS
GENERIC(
			n : INTEGER := 16;
			addressSize : INTEGER := 3
);
PORT(
		clock,isLW,WriteEnable , ReadDigit , PrintDigit : IN std_logic;
		R2Reg , Result : IN std_logic_vector(n-1 downto 0);
		RegAD : in std_logic_vector(addressSize - 1 downto 0);
		------------------------------------------------------------------
		isLW_EXMEM , WriteEnable_EXMEM , ReadDigit_EXMEM , PrintDigit_EXMEM : out std_logic;
		R2Reg_EXMEM , Result_EXMEM : out std_logic_vector(n-1 downto 0);
		RegAD_EXMEM : out std_logic_vector(addressSize - 1 downto 0)
);

END REG_EX_MEM;

ARCHITECTURE Behavior of REG_EX_MEM IS
begin

pc : process(clock)
begin
	if clock = '1' then
		RegAD_EXMEM <= RegAD;
		R2Reg_EXMEM <= R2Reg;
		Result_EXMEM <= Result;
		isLW_EXMEM <= isLW;
		WriteEnable_EXMEM <= WriteEnable;
		ReadDigit_EXMEM <= ReadDigit;
		PrintDigit_EXMEM <= PrintDigit;
	end if;
end process pc;

END architecture Behavior;