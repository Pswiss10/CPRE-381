library IEEE;
use IEEE.std_logic_1164.all;

entity jumpAndLink is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_outPut        : out std_logic_vector(31 downto 0));   -- Data value output

end jumpAndLink;


architecture dataflow of jumpAndLink is

begin

	o_outPut <= i_rs;

end dataflow;