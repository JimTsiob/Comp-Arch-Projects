-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


ENTITY CPU IS
PORT(
			-- CPU INPUTS
		
		keyData, fromData, instr : IN std_logic_vector(15 DOWNTO 0); 
		clock, clock2 : IN std_logic;
		------------------------------------------------------------
		
			--CPU OUTPUTS
				
		printEnable, keyEnable, dataWriteFlag : OUT std_logic;
		dataAD , toData , printCode , printData , instructionAD : OUT std_logic_vector(15 downto 0);
		regOut : OUT std_logic_vector(143 downto 0)
);
END CPU;





ARCHITECTURE Behavioral of CPU IS



------------------- COMPONENTS OF 3RD ASSIGNMENT

			
			
-- FORWARDER COMPONENT
-------------------------------------------------

COMPONENT FORWARDER IS

	GENERIC(addr_size : INTEGER := 3);
	
	PORT(
			R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB : IN std_logic_vector(addr_size - 1 DOWNTO 0);
			S1,S2 : OUT std_logic_vector(1 DOWNTO 0)
	);
END COMPONENT;
--------------------------------------------------




-- SELECTOR COMPONENT
-------------------------------------------------
COMPONENT SELECTOR IS
GENERIC ( 

		n : INTEGER := 16

);

PORT ( Reg, Memory, WriteBack : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		 operation : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)


);
END COMPONENT;
---------------------------------------------------






-- CONTROL COMPONENT
-------------------------------------------------
COMPONENT CONTROL IS
port(
		opcode : in std_logic_vector(3 downto 0);
		func : IN std_logic_vector(2 downto 0);
		flush : in std_logic;
		isMPFC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR : out std_logic
);
END COMPONENT;
-------------------------------------------------






-- HAZARD UNIT COMPONENT
-------------------------------------------------
COMPONENT HazardUnit IS
PORT(
		isJR, isJump, wasJump, mustBranch : in std_logic;
		flush, wasJumpOut : out std_logic;
		JRopcode : out std_logic_vector(1 DOWNTO 0)
);
END COMPONENT;
------------------------------------------------





-- TRAP UNIT COMPONENT
-------------------------------------------------
COMPONENT Trap_Unit IS
PORT(
		opcode : IN STD_logic_vector(3 DOWNTO 0);
		EOR : OUT STD_LOGIC
);
END COMPONENT;
------------------------------------------------






-- REG IF_ID COMPONENT
------------------------------------------------
COMPONENT REG_IF_ID IS

GENERIC(
		n : INTEGER := 16
);

PORT(
		inPC, inInstruction : IN STD_LOGIC_VECTOR(n-1 downto 0);
		clock, IF_Flush , IF_ID_Enable : IN STD_Logic;
		--------------------------------------------------------
		outPC, outInstruction : OUT STD_logic_vector(n-1 downto 0)
);
END COMPONENT;
----------------------------------------------




-- REG ID_EX COMPONENT
-------------------------------------------------
COMPONENT REG_ID_EX IS

GENERIC(
		n : INTEGER := 16;
		addressSize : INTEGER := 3
);

PORT(
		--INPUTS
		
		clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit : in std_logic;
		ALUFunc : in std_logic_vector(3 DOWNTO 0);
		R1reg, R2Reg, immediate16 : IN std_logic_vector(n-1 downto 0);
		R1AD, R2AD : IN std_logic_vector(addressSize - 1 downto 0);
		jumpShortAddr : IN std_logic_vector(11 downto 0);
		-----------------------------------------------------------------
		
		--OUTPUTS
		
		--clock_idex needed ???
		
		isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDIgit_IDEX : out std_logic;
		ALUFunc_IDEX : out std_logic_vector(3 DOWNTO 0);
		R1Reg_IDEX, R2Reg_IDEX , immediate16_IDEX : out std_logic_vector(n-1 downto 0);
		R1AD_IDEX, R2AD_IDEX : out std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr_IDEX : out std_logic_vector(11 downto 0)
);
END COMPONENT;
-----------------------------------------------







-- REG EX_MEM COMPONENT
-------------------------------------------------
COMPONENT REG_EX_MEM IS

GENERIC(
			n : INTEGER := 16;
			addressSize : INTEGER := 3
);

PORT(
		clock, isLW, WriteEnable, ReadDigit, PrintDigit : IN std_logic;
		R2Reg, Result : IN std_logic_vector(n-1 downto 0);
		RegAD : in std_logic_vector(addressSize - 1 downto 0);
		------------------------------------------------------------------
		isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM : out std_logic;
		R2Reg_EXMEM, Result_EXMEM : out std_logic_vector(n-1 downto 0);
		RegAD_EXMEM : out std_logic_vector(addressSize - 1 downto 0)
);
END COMPONENT;
-----------------------------------------------





-- REG MEM_WB COMPONENT
-------------------------------------------------
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
------------------------------------------------





-- JR SELECTOR COMPONENT
-------------------------------------------------
COMPONENT JR_SELECTOR IS
GENERIC(
			n : INTEGER := 16
);

PORT(
		jumpAD, branchAd, PCP2AD : in std_logic_vector(n-1 downto 0);
		JRopcode : in std_logic_vector(1 downto 0);
		result : out std_logic_vector(n-1 downto 0)
);
END COMPONENT;
-------------------------------------------------






-- PC REGISTER COMPONENT
-------------------------------------------------
COMPONENT REG_16B IS
PORT(
		Input : in std_logic_vector(15 downto 0);
		enable, clock : in std_logic;
		output : out std_logic_vector(15 downto 0)
);
END COMPONENT;
-------------------------------------------------





--2ND ASSIGNMENT COMPONENTS





-- ALU CONTROL COMPONENT
-------------------------------------------------
COMPONENT ALU_Control IS
PORT(
		opcode : IN std_logic_vector(3 DOWNTO 0);
		func : IN STD_logic_vector(2 DOWNTO 0);
		output : OUT std_logic_vector(3 DOWNTO 0)
);
END COMPONENT;
-------------------------------------------------




-- REGISTER FILE COMPONENT
-------------------------------------------------
COMPONENT REG_FILE IS

generic(n:integer:=16;
		k:integer:=3;
		regNum:integer:=8
		);
port (

	Clock :in std_logic;
	Write1 : in std_logic_vector(n-1 downto 0);
	Write1AD, Read1AD, Read2AD : in std_logic_vector(k-1 downto 0);
	Read1, Read2 : out std_logic_vector(n-1 downto 0);
	OUTall: out std_logic_vector(n*regNum-1 downto 0)
);
END COMPONENT;
-------------------------------------------------





-- SIGN EXTENDER COMPONENT
-------------------------------------------------
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
-------------------------------------------------




-- JUMP AD COMPONENT
-------------------------------------------------
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
-----------------------------------------------






-- ALU COMPONENT
-------------------------------------------------
COMPONENT ALU IS
PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(3 DOWNTO 0);				--CHANGED OPCODES 
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);
END COMPONENT;
-------------------------------------------------



-----------------------END OF COMPONENTS---------





-------------------------------- SIGNALS ------------------------------------




-- FORWARDER SIGNAL OUTPUTS

SIGNAL forwardS1, forwardS2 : std_LOGIC_vector(1 downto 0);



-- SELECTOR SIGNAL OUTPUTS

SIGNAL SelOut1, SelOut2 : std_LOGIC_vector(15 downto 0);


 
-- CONTROL SIGNAL OUTPUTS

SIGNAL isMFPC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR : std_logic;



-- HAZARD UNIT SIGNAL OUTPUTS

SIGNAL flush, wasJumpOut : std_logic;
SIGNAL JRopcode : std_logic_vector(1 DOWNTO 0);



-- ALU_Control SIGNAL OUTPUTS

SIGNAL ALUFunc : std_logic_vector(3 DOWNTO 0);		--RENAMED



-- TRAP UNIT SIGNAL OUTPUTS

SIGNAL isEOR : std_logic;



-- ALU SIGNAL OUTPUTS

SIGNAL ALUout : std_logic_vector(15 DOWNTO 0);
SIGNAL addcout,subcout : std_logic;



-- ALU INPUT SIGNALS (PROCESS OUTPUTS)
SIGNAL ALUinput1, ALUinput2 : std_loGIC_VECTOR(15 downto 0);



-- REG_FILE SIGNAL OUTPUTS

SIGNAL R1Reg,R2Reg : std_logic_vector(15 downto 0);
SIGNAL OUTall		 : std_logic_vector(127 downto 0);


		 
-- SIGN EXTENDER SIGNAL OUTPUTS

SIGNAL immediate16 : std_logic_vector(15 downto 0);		--RENAMED



-- JUMP AD SIGNAL OUTPUTS  

SIGNAL jumpADOut : std_logic_vector(15 downto 0);



-- REG_IF_ID SIGNAL OUTPUTS

SIGNAL outPC, outInstruction : STD_logic_vector(15 downto 0);



-- REG_ID_EX SIGNAL OUTPUTS

--clock_idex signal ??

SIGNAL isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDIgit_IDEX : std_logic;
SIGNAL ALUFunc_IDEX : std_logic_vector(3 DOWNTO 0);
SIGNAL R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX : std_logic_vector(15 downto 0);
SIGNAL R1AD_IDEX, R2AD_IDEX : std_logic_vector(2 downto 0);
SIGNAL jumpShortAddr_IDEX : std_logic_vector(11 downto 0);

-- REG_ID_EX input signals for R1AD and R2AD.

SIGNAL R1AD,R2AD : std_loGIC_VECTOR(2 downto 0);


-- REG_EX_MEM SIGNAL OUTPUTS

-- (PrintDigit_EXMEM --> PrintEnable  , WriteEnable_EXMEM --> DataWriteFlag)

SIGNAL isLW_EXMEM, isReadDigit_EXMEM: std_logic;   
SIGNAL R2Reg_EXMEM , Result_EXMEM : std_logic_vector(15 downto 0);
SIGNAL RegAD_EXMEM : std_logic_vector(2 downto 0);


-- REG_MEM_WB SIGNAL OUTPUTS

SIGNAL writeData_WB : std_LOGIC_VECTOR(15 downto 0);
SIGNAL writeAD_WB : std_LOGIC_VECTOR(2 downto 0);
SIGNAL MEM_WB_Out : std_logic_vector(15 downto 0); -- special signal for multiplexers.


-- JR SELECTOR SIGNAL OUTPUTS

SIGNAL JR_result : std_logic_vector(15 downto 0);


-- PC REGISTER SIGNAL OUTPUTS

SIGNAL PCReg_output : std_logic_vector(15 downto 0);





-- BEGIN CPU IMPLEMENTATION


BEGIN


	-- Trap unit

	Trap : Trap_Unit port map (OutInstruction(15 downto 12), isEOR); 
	
	-- PC Register
	
	PC_Register : REG_16B port map (JR_result, (isEOR NOR isEOR_IDEX), clock, PCReg_output); 
	
	-- Jump Address
	
	jumpAD : jump_AD port map (jumpShortAddr_IDEX, outInstruction, jumpADOut); 
	
	-- JR Selector
	
	JR : JR_SELECTOR port map (jumpADOut, immediate16_IDEX, outPC, JRopcode, JR_result); 
	
	
	IFIDREG : REG_IF_ID port map (PCReg_output, instr, clock, '0', '1', outPC, outInstruction); -- IF ID Register 
	
	
		
	
	--FORWARDER
	
	
	ForwardUnit : FORWARDER port map(R1AD_IDEX, R2AD_IDEX, RegAD_EXMEM, writeAD_WB, forwardS1, forwardS2); 
	
	-- SELECTORS
	
	Selector1 : SELECTOR port map(R1Reg_IDEX, MEM_WB_Out, writeData_WB, forwardS1, SelOut1); 
	
	Selector2 : SELECTOR port map(R2Reg_IDEX, MEM_WB_Out, writeData_WB, forwardS2, SelOut2); 
	
	
	-- SIGN EXTENDER
	
	SignExtend : SIGN_EXTENDER port map (outInstruction(5 downto 0), immediate16); 
	
	
	Hazard : HazardUnit port map (isJR, isJumpD, '0', (addcout AND isBranch_IDEX), flush, wasJumpOut, JRopcode);
	
	
	Controller: CONTROL port map (outInstruction(15 downto 12), outInstruction(2 downto 0), (flush OR isEOR_IDEX), isMFPC, isJumpD, isReadDigit, isPrintDigit, isR, isLW, isSW, isBranch, isJR);
	
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
	
	MEMWBREG : REG_MEM_WB port map(MEM_WB_Out, RegAD_EXMEM, clock, writeData_WB, writeAD_WB); -- REG_MEM_WB register
	
	-- ALU Controller 
	
	ALUController : ALU_Control port map(outInstruction(15 downto 12), outInstruction(2 downto 0), ALUFunc); 
	
	
	
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
		  
		  
	-- ALU
		  
	ALU_16 : ALU port map(ALUinput1, ALUinput2, ALUFunc_IDEX, ALUout, addcout, subcout);
	
	
	-- Register ID_EX
	
	R1AD <= outInstruction(8 downto 6);
	
	-- R2AD process
	
		MUX2_1_R2 : process(isR)
		begin
			case isR is
				when '0' =>
					R2AD <= outInstruction(11 downto 9);
				when '1' =>
					R2AD <= outInstruction(5 downto 3);
				when OTHERS =>
					R2AD <= outInstruction(11 downto 9); -- if command is not R type
			end case;
		end process;	
			
	IDEXREG : REG_ID_EX port map(clock, isEOR, wasJumpOut, isJumpD, isJR,  isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit, ALUFunc, R1reg, R2Reg, immediate16, R1AD, R2AD , outInstruction(11 downto 0),
	isEOR_IDEX, wasJumpOut_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDIgit_IDEX, ALUFunc_IDEX, R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX, R1AD_IDEX, R2AD_IDEX , jumpShortAddr_IDEX);
	
	-- Register File
	
	RegisterFile : REG_FILE port map(clock2,writeData_WB,writeAD_WB,R1AD,R2AD,R1Reg,R2Reg,outall);
	
	
	-- Register EX_MEM
	
	EXMEMREG : REG_EX_MEM port map(clock,isLW_IDEX,isSW_IDEX,isReadDigit_IDEX,isPrintDIgit_IDEX,R2Reg_IDEX,ALUout,R2AD_IDEX, -- exmem inputs
	isLW_EXMEM,DataWriteFlag,isReadDigit_EXMEM,PrintEnable,R2Reg_EXMEM,Result_EXMEM,RegAD_EXMEM); -- exmem outputs
	
	-- CPU Outputs
	-- printEnable , DataWriteFlag have been computed above (in EXMEM Register).
		
	DataAD <= R2Reg_EXMEM;
	toData <= result_EXMEM;
	printData <= result_EXMEM;
	keyEnable <= isReadDigit_EXMEM;
	printCode <= R2Reg_EXMEM;
	instructionAD <= PCReg_output;
	regOut <= PCReg_output & outall;
	
END Behavioral;