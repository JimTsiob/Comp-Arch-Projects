-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY REG_ID_EX IS
GENERIC(
		n : INTEGER := 16;
		addressSize : INTEGER := 3
);
PORT(
		clock,isEOR,wasJumpOut , isJump,isJR,isBranch,isR,isMFPC,isLW,isSW,isReadDigit,isPrintDigit : in std_logic;
		ALUFunc : in std_logic_vector(3 DOWNTO 0);
		R1reg,R2Reg,immediate16 : IN std_logic_vector(n-1 downto 0);
		R2AD , R1AD : In std_logic_vector(addressSize - 1 downto 0);
		jumpShortAddr : In std_logic_vector(11 downto 0);
		-----------------------------------------------------------------
		isEOR_IDEX , wasJumpOut_IDEX , isJump_IDEX, isJR_IDEX,isBranch_IDEX,isR_IDEX,isMFPC_IDEX,isLW_IDEX,isSW_IDEX,isReadDigit_IDEX,isPrintDIgit_IDEX : out std_logic;
		ALUFunc_IDEX : out std_logic_vector(3 DOWNTO 0);
		R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX : out std_logic_vector(n-1 downto 0);
		R2AD_IDEX , R1AD_IDEX : out std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr_IDEX : out std_logic_vector(11 downto 0)
);
END REG_ID_EX;

ARCHITECTURE Behavior of REG_ID_EX IS
BEGIN

pc : process(clock)
begin
	if clock = '1' then
		isEOR_IDEX <= isEOR;
		wasJumpOut_IDEX <= wasJumpOut;
		isJUmp_IDEX <= isJump;
		isJR_IDEX <= isJR;
		isBranch_IDEX <= isbranch;
		isR_IDEX <= isR;
		isMFPC_IDEX <= isMFPC;
		ALUFunc_IDEX <= ALUFunc;
		R1Reg_IDEX <= R1Reg;
		R2Reg_IDEX <= R2Reg;
		immediate16_IDEX <= immediate16;
		R2AD_IDEX <= R2AD;
		R1AD_IDEX <= R1AD;
		jumpShortAddr_IDEX <= jumpShortAddr;
		isReadDigit_IDEX <= isReadDigit;
		isPrintDIgit_IDEX <= isprintDigit;
		isLW_IDEX <= isLW;
		isSW_IDEX <= isSW;
	end if;
end process pc;	
END ARCHITECTURE behavior;