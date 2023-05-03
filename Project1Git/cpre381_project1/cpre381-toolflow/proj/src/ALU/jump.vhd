library IEEE;
use IEEE.std_logic_1164.all;

entity jump is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_outPut        : out std_logic_vector(31 downto 0));   -- Data value output

end jump;


architecture dataflow of jump is

begin

	o_outPut <= i_rs;

end dataflow;