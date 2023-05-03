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

entity FullAdder is
  port(i_DA           : in std_logic;
       i_DB           : in std_logic;
       i_Carry        : in std_logic;
       o_Carry        : out std_logic;
       o_Sum          : out std_logic);

end FullAdder;

architecture structural of FullAdder is

  component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

  component xorg2 is   

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

  component org2 is 

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal i_AxorB : std_logic;
signal i_AandB : std_logic;
signal i_CandAxorB : std_logic;

begin

  -- Instantiate N mux instances.

    
    Part1: xorg2 port map(
              i_A => i_DA,
              i_B => i_DB,
	      o_F => i_AxorB);

    xor2: xorg2 port map(
	i_A => i_AxorB,
	i_B => i_Carry,
	o_F => o_Sum);

    and1: andg2 port map(

	i_A=> i_DA,
	i_B=> i_DB,
	o_F => i_AandB);

   and2: andg2 port map(

	i_A => i_Carry,
	i_B => i_AxorB,
	o_F => i_CandAxorB);

   or1: org2 port map(

	i_A => i_AandB,
	i_B => i_CandAxorB,
	o_F => o_Carry);



  
end structural;