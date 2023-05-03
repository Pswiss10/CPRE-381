library IEEE;
use IEEE.std_logic_1164.all;

entity Mux32_1 is
  port(i_S : in std_logic;
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1        : in std_logic_vector(31 downto 0);
       o_O    : out std_logic_vector(31 downto 0));

end Mux32_1;

architecture dataflow of Mux32_1 is

begin
	with i_S select 
		o_O <=  i_D0 when '0',
			i_D1 when '1',
			i_D0 when others;
  
end dataflow;