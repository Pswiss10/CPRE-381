library IEEE;
use IEEE.std_logic_1164.all;

entity andIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end andIns;

architecture dataflow of andIns is

begin

andAll: for i in 0 to 31 generate andIns:

  o_F(i) <= i_A(i) and i_B(i);

end generate andAll;
  
end dataflow;