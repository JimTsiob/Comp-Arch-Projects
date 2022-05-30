-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY ieee;
Use ieee.STD_Logic_1164.all;

ENTITY reg_File IS 
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
END reg_File;

ARCHITECTURE LogicFunc of reg_File is

		component REG_16_PSEUDO is 
				PORT(Input: in STD_LOGIC_VECTOR(n-1 downto 0);
				Enable,Clock :in std_logic;
				Output : out std_logic_vector(n-1 downto 0)
				);
		end component;
		
		component reg_16 is 
				PORT(Input: in STD_LOGIC_VECTOR(n-1 downto 0);
				Enable,Clock :in std_logic;
				Output : out std_logic_vector(n-1 downto 0)
				);
		end component;
		
		component dec_3_to_8 is 
			Port (Input:in std_logic_vector(k-1 downto 0);
			Output : out std_logic_vector(regNum-1 downto 0)
			);
		end component;
		
		component mux_8_to_1 is 
				Port(Input0,Input1,Input2,Input3,Input4,Input5,Input6,Input7: in std_logic_vector(n-1 downto 0);
				opcode :in std_logic_vector(k-1 downto 0);
				Output : out std_logic_vector(n-1 downto 0)
				);
		end component;
		
		signal enableSigs: std_logic_vector(regNum-1 downto 0);
		signal re0,re1,re2,re3,re4,re5,re6,re7 : std_logic_vector(n-1 downto 0);
BEGIN 

		G0 :dec_3_to_8 port map (Write1AD, enableSigs);
		G1 :reg_16_PSEUDO port map (Write1,enableSigs(0),Clock,re0);
		G2 :reg_16 port map (Write1,enableSigs(1),Clock,re1);
		G3 :reg_16 port map (Write1,enableSigs(2),Clock,re2);
		G4 :reg_16 port map (Write1,enableSigs(3),Clock,re3);
		G5 :reg_16 port map (Write1,enableSigs(4),Clock,re4);
		G6 :reg_16 port map (Write1,enableSigs(5),Clock,re5);
		G7 :reg_16 port map (Write1,enableSigs(6),Clock,re6);
		G8 :reg_16 port map (Write1,enableSigs(7),Clock,re7);

		G9 : mux_8_to_1 port map (re0,re1,re2,re3,re4,re5,re6,re7,Read1AD,Read1);		
		G10 : mux_8_to_1 port map (re0,re1,re2,re3,re4,re5,re6,re7,Read2AD,Read2);		

		OUTall<= re7 & re6 & re5 & re4 & re3 & re2 & re1 & re0;
END LogicFunc;