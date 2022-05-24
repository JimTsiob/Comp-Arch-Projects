-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE ieee.std_logic_1164.all;


ENTITY RISC_CPU IS
PORT(
		keyData,fromData,instr : IN std_logic_vector(15 DOWNTO 0); 
		clock,clock2 : IN std_logic;
		------------------------------------------------------------
		printEnable,keyEnable,dataWriteFlag : OUT std_logic;
		dataAD , toData , printCode , printData , instructionAD : OUT std_logic_vector(15 downto 0);
		regOut : OUT std_logic_vector(143 downto 0)
);
END RISC_CPU;


ARCHITECTURE Behavioral of RISC_CPU IS

-- Components 3hs ergasias

-- Forwarder component
COMPONENT FORWARDER IS
	GENERIC(addr_size : INTEGER := 3);
	PORT(
			R1AD , R2AD , RegAD_EXMEM, RegAD_MEMWB : IN std_logic_vector(addr_size - 1 DOWNTO 0);
			S1,S2 : OUT std_logic_vector(1 DOWNTO 0)
	);
END COMPONENT;

-- Selector component
COMPONENT SELECTOR IS
GENERIC ( 

		n : INTEGER := 16

);

PORT ( Reg, Memory, WriteBack : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		 operation : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)


);
END COMPONENT;

-- Control component
COMPONENT CONTROL IS
port(
		opcode : in std_logic_vector(3 downto 0);
		func : IN std_logic_vector(2 downto 0);
		flush : in std_logic;
		isMPFC,isJumpD,isReadDigit,isPrintDigit,isR,isLW,isSW,isBranch,isJR : out std_logic
);
END COMPONENT;

-- Hazard Unit component
COMPONENT HazardUnit IS
PORT(
		isJR,isJump,wasJump,mustBranch : in std_logic;
		flush,wasJumpOut : out std_logic;
		JRopcode : out std_logic_vector(1 DOWNTO 0)
);
END COMPONENT;

-- Trap Unit component
COMPONENT Trap_Unit IS
PORT(
		opcode : IN STD_logic_vector(3 DOWNTO 0);
		EOR : OUT STD_LOGIC
);
END COMPONENT;

-- REG_IF_ID component
COMPONENT REG_IF_ID IS
GENERIC(
		n : INTEGER := 16
);
PORT(
		inPC, inInstruction : IN STD_LOGIC_VECTOR(n-1 downto 0);
		clock,IF_Flush , IF_ID_Enable : IN STD_Logic;
		--------------------------------------------------------
		outPC,outInstruction : OUT STD_logic_vector(n-1 downto 0)
);
END COMPONENT;

-- REG_ID_EX component
COMPONENT REG_ID_EX IS
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
END COMPONENT;

-- REG_EX_MEM component

COMPONENT REG_EX_MEM IS
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
END COMPONENT;

-- REG_MEM_WB component

COMPONENT REG_MEM_WB IS
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
END COMPONENT;

-- JR_SELECTOR component

COMPONENT JRSelector IS
GENERIC(
			n : INTEGER := 16
);

PORT(
		jumpAD,branchAd, PCP2AD : in std_logic_vector(n-1 downto 0);
		jRopcode : in std_logic_vector(1 downto 0);
		result : out std_logic_vector(n-1 downto 0)
);
END COMPONENT;

-- REG_16B component (PC Register)

COMPONENT REG_16B IS
PORT(
		Input : in std_logic_vector(15 downto 0);
		enable,clock : in std_logic;
		output : out std_logic_vector(15 downto 0)
);
END COMPONENT;

-- Components 2hs ergasias

-- ALU component
COMPONENT ALU_16_BIT IS
PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(2 DOWNTO 0); -- ayto prepei na ginei 3 downto 0.
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);
END COMPONENT;

-- ALUControl component

COMPONENT ALUControl IS
PORT(
		opcode : IN std_logic_vector(3 DOWNTO 0);
		func : IN STD_logic_vector(2 DOWNTO 0);
		output : OUT std_logic_vector(3 DOWNTO 0)
);
END COMPONENT;

-- REG_FILE component

COMPONENT REG_FILE IS
generic(n:integer:=16;
		k:integer:=3;
		regNum:integer:=8
		);
port (
	Clock :in std_logic;
	Write1 : in std_logic_vector(n-1 downto 0);
	Write1AD,Read1AD,Read2AD : in std_logic_vector(k-1 downto 0);
	Read1,Read2 : out std_logic_vector(n-1 downto 0);
	OUTall: out std_logic_vector(n*regNum-1 downto 0)
);
END COMPONENT;

-- REG_16 component

COMPONENT REG_16 IS
GENERIC(
			n : INTEGER := 16
);
PORT(
		Input : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Enable , Clock : IN STD_LOGIC;
		Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END COMPONENT;

-- REG_16_PSEUDO component

COMPONENT REG_16_PSEUDO IS
GENERIC(
		n : INTEGER := 16
);
PORT(
		Input : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Enable , Clock : IN STD_LOGIC;
		Output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END COMPONENT;

-- SIGN_EXTENDER component

COMPONENT SIGN_EXTENDER IS
 generic (
	  n:integer:=16;
	  k:integer:=6
 );
 port (
	  immediate : in std_logic_vector(k-1 downto 0);
	  extended : out std_logic_vector(n-1 downto 0)
 );
END COMPONENT;

-- jumpAD component

COMPONENT jump_AD IS
generic (
        n:integer:=16;
        k:integer:=12
    );
    Port(
        jumpADR : in std_logic_vector(k-1 downto 0);
        instrP2AD : in std_logic_vector(n-1 downto 0);
        EjumpAD : out std_logic_vector(n-1 downto 0)
    );
END COMPONENT;

-- end of components

-------------------------------- SIGNALS ------------------------------------
-- Forwarder signal outputs

SIGNAL forwardS1,forwardS2 : std_LOGIC_vector(1 downto 0);

-- Selector signal outputs

SIGNAL SelOut1,SelOut2 : std_LOGIC_vector(15 downto 0);
 
-- Control signal outputs

SIGNAL isMPFC,isJumpD,isReadDigit,isPrintDigit,isR,isLW,isSW,isBranch,isJR : std_logic;

-- Hazard Unit signal outputs

SIGNAL flush,wasJumpOut : std_logic;
SIGNAL JRopcode : std_logic_vector(1 DOWNTO 0);

-- ALU Control signal outputs

SIGNAL ALUControlOut : std_logic_vector(3 DOWNTO 0);

-- Trap Unit signal outputs

SIGNAL isEOR : std_logic;

-- ALU signal outputs

SIGNAL ALUout : std_logic_vector(15 DOWNTO 0);
SIGNAL addcout,subcout : std_logic;

-- ALU input signals (process outputs)
SIGNAL ALUinput1, ALUinput2 : std_loGIC_VECTOR(15 downto 0);


-- REG_FILE signal outputs

SIGNAL Read1,Read2 : std_logic_vector(15 downto 0);
SIGNAL OUTall		 : std_logic_vector(127 downto 0);
		 
-- SIGN_EXTENDER signal outputs

SIGNAL extended : std_logic_vector(15 downto 0);

-- jumpAD signal outputs  

SIGNAL jumpADOut : std_logic_vector(15 downto 0);

-- REG_IF_ID signal outputs

SIGNAL outPC,outInstruction : STD_logic_vector(15 downto 0);

-- REG_ID_EX signal outputs

SIGNAL isEOR_IDEX , wasJumpOut_IDEX , isJump_IDEX, isJR_IDEX,isBranch_IDEX,isR_IDEX,isMFPC_IDEX,isLW_IDEX,isSW_IDEX,isReadDigit_IDEX,isPrintDIgit_IDEX : std_logic;
SIGNAL ALUFunc_IDEX : std_logic_vector(3 DOWNTO 0);
SIGNAL R1Reg_IDEX , R2Reg_IDEX , immediate16_IDEX : std_logic_vector(15 downto 0);
SIGNAL R2AD_IDEX , R1AD_IDEX : std_logic_vector(2 downto 0);
SIGNAL jumpShortAddr_IDEX : std_logic_vector(11 downto 0);

-- REG_EX_MEM signal outputs

SIGNAL isLW_EXMEM , WriteEnable_EXMEM , isReadDigit_EXMEM , PrintDigit_EXMEM : std_logic;
SIGNAL R2Reg_EXMEM , Result_EXMEM : std_logic_vector(15 downto 0);
SIGNAL RegAD_EXMEM : std_logic_vector(2 downto 0);

-- REG_MEM_WB signal outputs

SIGNAL writeData_WB : std_loGIC_VECTOR(15 downto 0);
SIGNAL writeAD_WB : std_LOGIC_VECTOR(2 downto 0);
SIGNAL MEM_WB_Out : std_logic_vector(15 downto 0); -- special signal for multiplexers.

-- JR_SELECTOR signal outputs

SIGNAL JRresult : std_logic_vector(15 downto 0);

-- PC Register signal outputs

SIGNAL PCReg_output : std_logic_vector(15 downto 0);

BEGIN
	Trap : Trap_Unit port map (OutInstruction(15 downto 12),isEOR); -- Trap unit
	
	PCREG : REG_16B port map (JRresult,(isEOR NOR isEOR_IDEX),clock,PCReg_output); -- PC Register
	
	IFIDREG : REG_IF_ID port map (PCReg_output,instr,clock,'0','1',outPC,outInstruction); -- IF ID Register 
	
	SignExtend : SIGN_EXTENDER port map (outInstruction(5 downto 0),extended); -- Sign Extender
		
	jumpAD : jump_AD port map(jumpShortAddr_IDEX,outInstruction,jumpADOut); -- Jump Address
	
	JR : JRSelector port map(jumpADOut,immediate16_IDEX,outPC,JRopcode,JRResult); -- JR Selector
	
	ForwardUnit : FORWARDER port map(R1AD_IDEX,R2AD_IDEX,regAD_EXMEM,writeAD_WB,forwardS1,forwardS2); -- Forwarder
	
	-- MEM_WB multiplexer
        MUX2_1_MEM_WB: process(isLW_EXMEM, isReadDigit_EXMEM)
        begin
            if (isLW_EXMEM = '1') then
                MEM_WB_Out <= fromData;
            elsif (isReadDigit_EXMEM = '1') then
                MEM_WB_Out <= keyData;
            else
                MEM_WB_Out <= Result_EXMEM;
            end if;
        end process;
	
	MEMWBREG : REG_MEM_WB port map(MEM_WB_Out,RegAD_EXMEM,clock,writeData_WB,writeAD_WB); -- REG_MEM_WB register
	
	Selector1 : SELECTOR port map(R1Reg_IDEX,MEM_WB_Out,writeData_WB,forwardS1,SelOut1); -- Selector 1
	
	Selector2 : SELECTOR port map(R2Reg_IDEX,MEM_WB_Out,writeData_WB,forwardS2,SelOut2); -- Selector 1
	
	ALUController : ALUControl port map(outInstruction(15 downto 12),outInstruction(2 downto 0),ALUControlOut); -- ALU Controller unit
	
	-- ALU input 1 multiplexer
        MUX2_1_ALU_1: process(isMFPC_IDEX)
        begin
            if (isMFPC_IDEX = '1') then
                ALUinput1 <= outPC;
            else
                ALUinput1 <= SelOut1;
            end if;
        end process;
	
	-- ALU input 2 multiplexer
        MUX2_1_ALU_2: process(isR_IDEX)
        begin
            if (isR_IDEX = '1') then
                ALUinput2 <= SelOut2;
            else
                ALUinput2 <= immediate16_IDEX;
            end if;
        end process;
		  
	ALU : ALU_16_BIT port map(aluinput1,aluinput2,ALUFunc_IDEX,aluout,addcout,subcout);	-- ALU 
	
	
END Behavioral;