library IEEE;
use IEEE.std_logic_1164.all;


entity bitExtender is
  port(

        i_input         : in std_logic_vector(15 downto 0);
	i_unsigned      : in std_logic;
	o_Output	: out std_logic_vector(31 downto 0));



end bitExtender;

architecture dataflow of bitExtender is

signal s_positive: std_logic_vector(31 downto 0);
signal s_negative: std_logic_vector(31 downto 0);
signal s_select: std_logic_vector(1 downto 0);

begin

	

	s_positive <= x"0000" & i_input;
	s_negative <= x"ffff" & i_input;
	s_select <= i_unsigned & i_input(15);
	with s_select select

		o_Output <= s_negative when "01",
			    s_positive when others;
			    




end dataflow;