-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- mux using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 1/6/20 by H3::Created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity NBitAdder_Sub is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       i_Control      : in std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Overflow     : out std_logic);

end NBitAdder_Sub;

architecture structural of NBitAdder_Sub is

  component RippleAdder is
  generic(N : integer := 32);
  port(i_DA          : in std_logic_vector(N-1 downto 0);
       i_DB          : in std_logic_vector(N-1 downto 0);
       i_Carry       : in std_logic;
       o_Carry       : out std_logic;
       o_sum         : out std_logic_vector(N-1 downto 0));

  end component;

  component mux2t1_N is 
  generic(N : integer := 32);
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

  end component;

  component OnesComp is 
  generic(N : integer := 32);
       port(
	i_D0         : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));

  end component;


signal s_OCforB : std_logic_vector(N-1 downto 0);
signal s_muxOutput : std_logic_vector(N-1 downto 0);
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


    Multiplexer: mux2t1_N 
 generic map(N => N)
port map(

	i_S => i_Control,
	i_D0 => i_DB,
	i_D1 => s_OCforB,
	o_O => s_muxOutput);

    RippleAdderTime: RippleAdder 
 generic map(N => N)
port map(
       i_DA => i_DA,   
       i_DB => s_muxOutput,
       i_Carry => i_Control,
       o_Carry => o_Overflow,
       o_sum => o_sum);

end structural;