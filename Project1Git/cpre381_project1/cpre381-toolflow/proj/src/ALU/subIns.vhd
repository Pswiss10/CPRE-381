library IEEE;
use IEEE.std_logic_1164.all;

entity subIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic;
       o_Overflow     : out std_logic);

end subIns;

architecture structural of subIns is

  component RippleAdder is
  generic(N : integer := 32);
  port(i_DA          : in std_logic_vector(N-1 downto 0);
       i_DB          : in std_logic_vector(N-1 downto 0);
       i_Carry       : in std_logic;
       o_Carry       : out std_logic;
       o_Overflow    : out std_logic; 
       o_sum         : out std_logic_vector(N-1 downto 0));

  end component;


  component OnesComp is 
  generic(N : integer := 32);
       port(
	i_D0         : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));

  end component;


signal s_OCforB : std_logic_vector(N-1 downto 0);
--signal s_CarryBits : std_logic_vector(N downto 0);

begin

--s_CarryBits(0) <= i_Control;
--o_Overflow <= s_CarryBits(N);

  -- Instantiate N mux instances.
    
    InvertingBits1: OnesComp 
 generic map(N => N)
port map(
        i_D0 => i_DB,
	o_O => s_OCforB);


    RippleAdderTime: RippleAdder 
 generic map(N => N)
port map(
       i_DA => i_DA,   
       i_DB => s_OCforB,
       i_Carry => '1',
       o_Carry => o_Carry,
       o_Overflow => o_Overflow,
       o_sum => o_sum);


end structural;