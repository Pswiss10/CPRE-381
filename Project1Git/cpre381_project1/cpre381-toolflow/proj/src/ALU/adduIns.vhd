library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity adduIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end adduIns;

architecture structural of adduIns is

  component RippleAdder is
  generic(N : integer := 32);
  port(i_DA          : in std_logic_vector(N-1 downto 0);
       i_DB          : in std_logic_vector(N-1 downto 0);
       i_Carry       : in std_logic;
       o_Carry       : out std_logic;
       o_Overflow    : out std_logic; 
       o_sum         : out std_logic_vector(N-1 downto 0));

  end component;

begin

  -- Instantiate N mux instances.


    RippleAdderTime: RippleAdder 
 generic map(N => N)
port map(
       i_DA => i_DA,   
       i_DB => i_DB,
       i_Carry => '0',
       o_Carry => o_Carry,
       o_Overflow => o_Overflow, 
       o_sum => o_sum);


end structural;