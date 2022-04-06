-- Dimitris Tsiompikas 3180223
-- Antwnhs Detshs 3190054
-- Petros Tsotsi 3180193

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;


ENTITY FULL_SUB_16 IS

PORT(
		A,B : in signed(15 DOWNTO 0);
		C : in std_logic;
		diff : out signed(15 DOWNTO 0);
		bout : out std_logic
);

END FULL_SUB_16;


ARCHITECTURE logic_structural OF FULL_SUB_16 IS

COMPONENT FULL_SUB_1 IS

port( A, B, C : in std_logic; 
DIFF, Borrow : out std_logic);

END COMPONENT;

COMPONENT XOR_2 IS

PORT ( A ,B : IN STD_LOGIC ;
		 Z : OUT STD_LOGIC);

END COMPONENT;

SIGNAL borrow : std_logic_vector(16 DOWNTO 1); -- in between borrows of each bit
SIGNAL index : integer; -- constant for the for loop.
SIGNAL tempbout : std_logic; -- temp variable for bout
SIGNAL tempdiff : signed (15 DOWNTO 0); -- temporary variable for diff

-- function to find first one bit in vector.
	-- used for negative number representation
	function find_first_one(signal a : signed(15 DOWNTO 0)) return integer IS
		BEGIN
		for i in 0 to 15 loop
			if (a(i) = '1') then
				return i;
			end if;
		end loop;
		return -1; -- if the number is full of zeros return -1.
	end function;


BEGIN

	--V0 : FULL_SUB_1 port map (A(0),B(0),C,tempdiff(0),borrow(1));
	--V1 : FULL_SUB_1 port map (A(1),B(1),borrow(1),tempdiff(1),borrow(2));
	--V2 : FULL_SUB_1 port map (A(2),B(2),borrow(2),tempdiff(2),borrow(3));
	--V3 : FULL_SUB_1 port map (A(3),B(3),borrow(3),tempdiff(3),borrow(4));
	--V4 : FULL_SUB_1 port map (A(4),B(4),borrow(4),tempdiff(4),borrow(5));
	--V5 : FULL_SUB_1 port map (A(5),B(5),borrow(5),tempdiff(5),borrow(6));
	--V6 : FULL_SUB_1 port map (A(6),B(6),borrow(6),tempdiff(6),borrow(7));
	--V7 : FULL_SUB_1 port map (A(7),B(7),borrow(7),tempdiff(7),borrow(8));
	--V8 : FULL_SUB_1 port map (A(8),B(8),borrow(8),tempdiff(8),borrow(9));
	--V9 : FULL_SUB_1 port map (A(9),B(9),borrow(9),tempdiff(9),borrow(10));
	--V10 : FULL_SUB_1 port map (A(10),B(10),borrow(10),tempdiff(10),borrow(11));
	--V11 : FULL_SUB_1 port map (A(11),B(11),borrow(11),tempdiff(11),borrow(12));
	--V12 : FULL_SUB_1 port map (A(12),B(12),borrow(12),tempdiff(12),borrow(13));
	--V13 : FULL_SUB_1 port map (A(13),B(13),borrow(13),tempdiff(13),borrow(14));
	--V14 : FULL_SUB_1 port map (A(14),B(14),borrow(14),tempdiff(14),borrow(15));
	--V15 : FULL_SUB_1 port map (A(15),B(15),borrow(15),tempdiff(15),borrow(16));

	V0 : FULL_SUB_1 port map (A(0),B(0),C,diff(0),borrow(1));
	V1 : FULL_SUB_1 port map (A(1),B(1),borrow(1),diff(1),borrow(2));
	V2 : FULL_SUB_1 port map (A(2),B(2),borrow(2),diff(2),borrow(3));
	V3 : FULL_SUB_1 port map (A(3),B(3),borrow(3),diff(3),borrow(4));
	V4 : FULL_SUB_1 port map (A(4),B(4),borrow(4),diff(4),borrow(5));
	V5 : FULL_SUB_1 port map (A(5),B(5),borrow(5),diff(5),borrow(6));
	V6 : FULL_SUB_1 port map (A(6),B(6),borrow(6),diff(6),borrow(7));
	V7 : FULL_SUB_1 port map (A(7),B(7),borrow(7),diff(7),borrow(8));
	V8 : FULL_SUB_1 port map (A(8),B(8),borrow(8),diff(8),borrow(9));
	V9 : FULL_SUB_1 port map (A(9),B(9),borrow(9),diff(9),borrow(10));
	V10 : FULL_SUB_1 port map (A(10),B(10),borrow(10),diff(10),borrow(11));
	V11 : FULL_SUB_1 port map (A(11),B(11),borrow(11),diff(11),borrow(12));
	V12 : FULL_SUB_1 port map (A(12),B(12),borrow(12),diff(12),borrow(13));
	V13 : FULL_SUB_1 port map (A(13),B(13),borrow(13),diff(13),borrow(14));
	V14 : FULL_SUB_1 port map (A(14),B(14),borrow(14),diff(14),borrow(15));
	V15 : FULL_SUB_1 port map (A(15),B(15),borrow(15),diff(15),borrow(16));
	
	
	--tempbout <= borrow(16);
	
	bout <= borrow(16);
	
	-- function call
	--process
	--begin
		
		--if (tempbout = '1') then
			--index <= find_first_one(tempdiff);
			
			-- conversion to 2's complement for proper output
			
			--for i in index + 1 to 15 loop
				--if (tempdiff(i) = '0') then
					--tempdiff(i) <= '1';
				--elsif (tempdiff(i) = '1') then
					--tempdiff(i) <= '0';
				--end if;
			--end loop;
		--end if;
	--end process;
	
	--diff <= tempdiff;
	--bout <= borrow(16);
	
END logic_structural;