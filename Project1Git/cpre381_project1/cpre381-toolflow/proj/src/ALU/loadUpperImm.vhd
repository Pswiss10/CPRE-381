library IEEE;
use IEEE.std_logic_1164.all;

entity loadUpperImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end loadUpperImm;


architecture dataflow of loadUpperImm is 

	begin
		o_rt <= i_imm(15 downto 0) & x"0000";

end dataflow;