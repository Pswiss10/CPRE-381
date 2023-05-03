library IEEE;
use IEEE.std_logic_1164.all;

entity move_N is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rd        : out std_logic_vector(31 downto 0));   -- Data value output

end move_N;


architecture dataflow of move_N is 

	signal s_equalTo : std_logic_vector(31 downto 0);

	begin

	s_equalTo <= x"00000000" or i_rt;
	
	with s_equalTo select 

		o_rd <= x"00000000"when x"00000000",
			i_rt when others;
	

end dataflow;
