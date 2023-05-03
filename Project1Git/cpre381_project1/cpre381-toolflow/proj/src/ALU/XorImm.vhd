library IEEE;
use IEEE.std_logic_1164.all;

entity XorImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end XorImm;


architecture dataflow of XorImm is 

	begin
		o_rt <= i_imm xor i_rs;

end dataflow;