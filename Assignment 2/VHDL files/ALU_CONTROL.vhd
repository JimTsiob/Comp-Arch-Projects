-- Dimitrios Tsiompikas 3180223
-- Antonis Detsis 3190054
-- Petros Tsotsi 3180193


LIBRARY ieee;
use ieee.STD_Logic_1164.all;
ENTITY Alu_Control is 
port (opCode : in std_logic_vector(3 downto 0);
		func : in std_logic_vector(2 downto 0);
		output: out std_logic_vector(3 downto 0)
);
END Alu_Control;

Architecture behavioral of Alu_Control is
BEGIN 
process(opCode,func) begin
    case opCode is 
        when "0000" =>
            output(3)<='0';
            output(2 downto 0)<= func(2 downto 0);
        when others=> output <= opCode;
    end case;
end process;

END behavioral;