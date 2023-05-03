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

entity RippleAdder is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       i_Carry        : in std_logic;
       o_Carry        : out std_logic;
       o_Overflow     : out std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0));

end RippleAdder;

architecture structural of RippleAdder is

  component FullAdder is

  port(i_DA          : in std_logic;
       i_DB          : in std_logic;
       i_Carry       : in std_logic;
       o_Carry       : out std_logic;
       o_sum         : out std_logic);

end component;

component xorg2 is
	port(i_A		: in std_logic;
	     i_B		: in std_logic;
	     o_F		: out std_logic);
end component;



signal i_CarryNext : std_logic_vector(N downto 0);

begin

i_CarryNext(0) <= i_Carry;
o_Carry <= i_CarryNext(N);

  -- Instantiate N mux instances.
  G_NBit_Adder_1: for i in 0 to N-1 generate
    
    AddingfirstAdder: FullAdder port map(
              i_DA => i_DA(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_DB => i_DB(i),  -- ith instance's data output hooked up to ith data output.
	      i_Carry => i_Carrynext(i),
	      o_Carry => i_CarryNext(i+1),
	      o_sum => o_sum(i));


  end generate G_NBit_Adder_1;

xor1 : xorg2
     port map(i_A		=> i_CarryNext(N),
	      i_B		=> i_CarryNext(N-1),
	      o_F		=> o_Overflow);

end structural;