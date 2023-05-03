library IEEE;
use IEEE.std_logic_1164.all;

entity repl_qb is
  port(
	i_8bitIm        : in std_logic_vector(7 downto 0);
        o_replOutput         : out std_logic_vector(31 downto 0));   -- Data value output

end repl_qb;


architecture dataflow of repl_qb is 

	begin 

	o_replOutput <= i_8bitIm & i_8bitIm & i_8bitIm & i_8bitIm;

end dataflow;