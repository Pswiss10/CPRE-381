library IEEE;
use IEEE.std_logic_1164.all;



entity controlDecoderOG is
  port(
       i_reg          : in std_logic_vector(5 downto 0);     -- Data value input
       o_data          : out std_logic_vector(16 downto 0));   -- Data value output

end controlDecoderOG;


architecture dataflow of controlDecoderOG is 
	begin 
		with i_reg select
			o_data <= "10000000000000000" when "000000",
				  "00001000001001110" when "000010",
				  "00101000111001111" when "000011",
				  "00000000000110000" when "000100",
				  "00001000100010010" when "001000",
				  "00001000110010011" when "011111",
				  "00001000100010100" when "001001",
				  "00001000100010101" when "001010",
 				  "00000000000110001" when "000101",
				  "00011000100010110" when "001101",
				  "00001000100010111" when "001110",
				  "00001001100011000" when "001111",
				  "00001101100011001" when "100011",
				  "00001110000011010" when "101011",
				  "00011000100011100" when "001100",
			  	  "00000000000000000" when "010100",
				  "10000000000000000" when others;

end dataflow;