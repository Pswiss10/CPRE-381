library IEEE;
use IEEE.std_logic_1164.all;



entity controlDecoderRtype is
  port(
        i_write        : in std_logic;
	i_reg          : in std_logic_vector(5 downto 0);     -- Data value input
        o_data          : out std_logic_vector(15 downto 0));   -- Data value output

end controlDecoderRtype;


architecture dataflow of controlDecoderRtype is 
	signal s_sig : std_logic_vector(6 downto 0);  
	begin
	s_sig <= i_write & i_reg;
	with s_sig select 
			o_data <= "0000000110000000" when "1100000",
				  "0010000110000001" when "1100001",
				  "0000000110000010" when "1100100",
				  "0000000110000011" when "1011111",
				  "0000000110000100" when "1100111",
				  "0000000110000101" when "1100110",
				  "0000000110000110" when "1100101",
				  "0000000110000111" when "1101010",
 				  "0000000110001000" when "1000000",
				  "0000000110001001" when "1000010",
				  "0000000110001010" when "1000011",
				  "0000000110001011" when "1100010",
				  "1001000101001101" when "1001000",
				  "0000000110001101" when "1001011",
				  "0010000110011011" when "1100011",
				  "0000000110000000" when others;

end dataflow;
