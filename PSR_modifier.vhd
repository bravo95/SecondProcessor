
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;



entity PSR_modifier is
    Port ( ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           RESULT : in  STD_LOGIC_VECTOR (31 downto 0);
           RS1 : in  STD_LOGIC_VECTOR (31 downto 0);
           RS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0) := "0000");
end PSR_modifier;

architecture Behavioral of PSR_modifier is

begin

process(ALUOP)
	begin
		
		IF(ALUOP = "100001" OR ALUOP = "100010") then -- para  addcc y addxcc
			NZVC(3) <= RESULT(31);
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
			NZVC(1) <= (RS1(31) AND RS2(31) AND (NOT RESULT(31))) OR ((NOT RS1(31)) AND ( NOT RS2(31)) AND RESULT(31));
			NZVC(0) <= (RS1(31) AND RS2(31)) OR ((NOT RESULT(31)) AND (RS1(31) OR RS2(31)));
		END IF;
		
		IF( ALUOP = "100100" OR ALUOP = "100101") THEN -- para subcc y subxcc
			NZVC(3) <= RESULT(31);
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
			NZVC(1) <= (RS1(31) AND (NOT RS2(31)) AND (NOT RESULT(31))) OR ((NOT RS1(31)) AND RS2(31) AND RESULT(31));
			NZVC(0) <= ((not RS1(31)) and RS2(31)) or (RESULT(31) and ((not RS1(31)) or RS2(31)));
		END IF;
		
		if(ALUOP = "100111" OR ALUOP = "101000" OR ALUOP = "101001" OR ALUOP = "101010" OR ALUOP = "101011" OR ALUOP = "101100") THEN --PARA LAS OPERACIONES LOGICAS ANDCC, ANDNCC, ORCC, ORNCC, XORCC, XNORCC
			
			NZVC(3) <= RESULT(31);
			IF RESULT = "00000000000000000000000000000000" THEN
				NZVC(2) <= '1';
			ELSE 
				NZVC(2) <= '0';
			END IF;
			NZVC(1) <= '0';
			NZVC(0) <= '0';
			
		END IF;
	end process;

end Behavioral;
