-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY ALUControl IS
PORT(
		opcode : IN std_logic_vector(3 DOWNTO 0);
		func : IN STD_logic_vector(2 DOWNTO 0);
		output : OUT std_logic_vector(3 DOWNTO 0)
);
END ALUControl;

ARCHITECTURE behavioral OF ALUControl IS

BEGIN
process(opcode,func) begin
	case opcode is
		when "0000" => 
			output(3) <= '0';
			output(2 downto 0) <= func(2 downto 0);
		when others => output <= opcode;
	end case;
end process;

END behavioral;