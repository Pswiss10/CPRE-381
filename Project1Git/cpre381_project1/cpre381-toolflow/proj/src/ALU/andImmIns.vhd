library IEEE;
use IEEE.std_logic_1164.all;

entity andImmIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_Imm          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end andImmIns;

architecture dataflow of andImmIns is

begin

andAll: for i in 0 to 31 generate andImmIns:

  o_F(i) <= i_A(i) and i_Imm(i);

end generate andAll;
  
end dataflow;