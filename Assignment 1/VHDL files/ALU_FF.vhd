-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


--Παρατηρώντας το simulation του τελικού κυκλώματος(ALU_FF_func) βλέπουμε μια καθυστέρηση 
--ενός κύκλου μεταξύ του υπολογισμού του αποτελέσματος των inputs (από την ALU με βάση
--το operation) και της προώθησης αυτού του αποτελέσματος στο output του τελικού Register.
--Αυτό είναι αναμενόμενο να συμβεί και οφείλεται στον χρονισμό των Registers από ένα κοινό clock.
--Συγκεκριμένα , την 1η φορά που το Clock θα μεταβεί από τιμή 1 σε 0 , τα inputs των αρχικών Registers
--θα προωθηθούν στην ALU και θα προκύψει το αποτέλεσμα του operation στην έξοδο της ALU. Ωστόσο ο 3ος register
--θα προωθήσει αυτό το αποτέλεσμα στην έξοδο στο επόμενο clock , όταν η ALU θα εκτελέσει την επόμενη πράξη.
--Συνεπώς ο υπολογισμός της ALU καθυστερεί έναν κύκλο μέχρι να προωθηθεί στο output του τελικού Register


ENTITY ALU_FF IS

PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(2 DOWNTO 0);
		clock,enable : in std_logic;
		ALUout : out std_logic_vector(15 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);

END ALU_FF;

ARCHITECTURE logic_structural OF ALU_FF IS


-- Flip Flop component

COMPONENT REG_16 IS
PORT(	
		input : in std_logic_vector(15 DOWNTO 0);
		clock,enable : in std_logic;
		output : out std_logic_vector(15 DOWNTO 0)
);
END COMPONENT;

-- ALU component
COMPONENT ALU_16_BIT IS
PORT(
		input1,input2 : in std_logic_vector(15 DOWNTO 0);
		operation : in std_logic_vector(2 DOWNTO 0);
		output : out std_logic_vector(15 DOWNTO 0);
		addcout : out std_logic;
		subcout : out std_logic
);
END COMPONENT;

SIGNAL ffs1,ffs2,alusignal : std_logic_vector(15 DOWNTO 0);

BEGIN

	FF1 : REG_16 port map(input1,clock,enable,ffs1);
	FF2 : REG_16 port map(input2,clock,enable,ffs2);
	ALU :	ALU_16_BIT port map(ffs1,ffs2,operation,alusignal,addcout,subcout);
	aluout <= alusignal;
	FF3 : REG_16 port map (alusignal,clock,enable,output);


END logic_structural;