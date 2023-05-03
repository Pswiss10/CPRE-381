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

entity Adder is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       i_Carry        : in std_logic;
       o_Carry        : out std_logic;
       o_Sum          : out std_logic_vector(N-1 downto 0));

end Adder;

architecture structural of Adder is

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
  G_NBit_Adder: for i in 0 to N-1 generate

   carryBit: process is 
	begin 
	  if (i /= 0 and i /= N - 1) then
		wait for 5 ns;
	    o_Carry <= i_Carry;
	    
	end if;
	wait for 10 ns;
   end process;
    
    xor1: xorg2 port map(
              i_A => i_DA(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              i_B => i_DB(i),  -- ith instance's data output hooked up to ith data output.
	      o_F => i_AxorB);

    xor2: xorg2 port map(
	i_A => i_AxorB,
	i_B => i_Carry,
	o_F => o_Sum(i));


   and1: andg2 port map(

	i_A=> i_DA(i),
	i_B=> i_DB(i),
	o_F => i_AandB);

   and2: andg2 port map(

	i_A => i_Carry,
	i_B => i_AxorB,
	o_F => i_CandAxorB);

   or1: org2 port map(

	i_A => i_AandB,
	i_B => i_CandAxorB,
	o_F => o_Carry);



  end generate G_NBit_Adder;

  
end structural;