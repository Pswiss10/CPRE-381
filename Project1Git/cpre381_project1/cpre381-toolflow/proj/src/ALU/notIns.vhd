library IEEE;
use IEEE.std_logic_1164.all;

entity notIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end notIns;

architecture dataflow of notIns is

begin

notAll: for i in 0 to 31 generate notIns:

  o_F(i) <= not i_A(i);

end generate notAll;
  
end dataflow;