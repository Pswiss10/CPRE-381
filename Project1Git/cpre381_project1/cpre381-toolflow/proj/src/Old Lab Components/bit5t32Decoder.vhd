library IEEE;
use IEEE.std_logic_1164.all;


entity bit5_32Decoder is
  port(
       i_write   : in std_logic;
       i_reg          : in std_logic_vector(4 downto 0);     -- Data value input
       o_data          : out std_logic_vector(31 downto 0));   -- Data value output

end bit5_32Decoder;


architecture dataflow of bit5_32Decoder is
	signal s_sig : std_logic_vector(5 downto 0);  
	begin
	s_sig <= i_write & i_reg;
	with s_sig select 
  			o_data <= X"00000001" when "100000",
				  X"00000002" when "100001",
				  X"00000004" when "100010",
				  X"00000008" when "100011",
				  X"00000010" when "100100",
				  X"00000020" when "100101",
				  X"00000040" when "100110",
				  X"00000080" when "100111",
 				  X"00000100" when "101000",
				  X"00000200" when "101001",
				  X"00000400" when "101010",
				  X"00000800" when "101011",
				  X"00001000" when "101100",
				  X"00002000" when "101101",
				  X"00004000" when "101110",
  				  X"00008000" when "101111",
				  X"00010000" when "110000",
				  X"00020000" when "110001",
				  X"00040000" when "110010",
				  X"00080000" when "110011",
				  X"00100000" when "110100",
				  X"00200000" when "110101",
				  X"00400000" when "110110",
				  X"00800000" when "110111",
 				  X"01000000" when "111000",
				  X"02000000" when "111001",
				  X"04000000" when "111010",
				  X"08000000" when "111011",
				  X"10000000" when "111100",
				  X"20000000" when "111101",
				  X"40000000" when "111110",
				  X"80000000" when "111111",
				  X"00000000" when others;


  
end dataflow;
