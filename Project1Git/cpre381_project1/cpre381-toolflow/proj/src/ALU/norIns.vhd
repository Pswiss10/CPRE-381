library IEEE;
use IEEE.std_logic_1164.all;

entity norIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end norIns;

architecture dataflow of norIns is

begin

norAll: for i in 0 to 31 generate norIns:

  o_F(i) <= i_A(i) nor i_B(i);

end generate norAll;
  
end dataflow;