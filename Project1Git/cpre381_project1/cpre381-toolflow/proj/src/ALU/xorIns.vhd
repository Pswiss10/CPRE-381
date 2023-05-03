library IEEE;
use IEEE.std_logic_1164.all;

entity xorIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end xorIns;

architecture dataflow of xorIns is

begin

xorAll: for i in 0 to 31 generate xorIns:

  o_F(i) <= i_A(i) xor i_B(i);

end generate xorAll;
  
end dataflow;