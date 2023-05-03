library IEEE;
use IEEE.std_logic_1164.all;

entity addiIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Overflow     : out std_logic;
       o_Carry    : out std_logic);

end addiIns;

architecture structural of addiIns is

  component RippleAdder is
  generic(N : integer := 32);
  port(i_DA          : in std_logic_vector(N-1 downto 0);
       i_DB          : in std_logic_vector(N-1 downto 0);
       i_Carry       : in std_logic;
       o_Carry       : out std_logic;
       o_Overflow    : out std_logic;
       o_sum         : out std_logic_vector(N-1 downto 0));

  end component;

signal s_OCforB : std_logic_vector(N-1 downto 0);

begin

--s_CarryBits(0) <= i_Control;
--o_Overflow <= s_CarryBits(N);

  -- Instantiate N mux instances.
  --G_NBit_Adder: for i in 0 to N-1 generate

    RippleAdderTime: RippleAdder 
 generic map(N => N)
port map(
       i_DA => i_DA,   
       i_DB => i_DB,
       i_Carry => '0',
       o_Carry => o_Carry,
       o_sum => o_sum,
       o_Overflow => o_Overflow);
--  end generate G_NBit_Adder;


end structural;