library IEEE;
use IEEE.std_logic_1164.all;

entity orIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end orIns;

architecture dataflow of orIns is

begin

orAll: for i in 0 to 31 generate orIns:

  o_F(i) <= i_A(i) or i_B(i);

end generate orAll;
  
end dataflow;