-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1.vhd
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

entity mux2t1 is
  port(i_S : in std_logic;
       i_D0         : in std_logic;
       i_D1        : in std_logic;
       o_O    : out std_logic);

end mux2t1;

architecture structural of mux2t1 is


  component invg is

  port(i_A          : in std_logic;
       o_F          : out std_logic);


  end component;

  component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

  end component;


  component org2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

  end component;


	signal i_si : std_logic;
	signal i_and1 : std_logic;
	signal i_and2 : std_logic;

begin

  ---------------------------------------------------------------------------
  -- Level 0: inverse the switch
  ---------------------------------------------------------------------------
 
  g_Switch: invg
    port MAP(i_A        => i_S,
             o_F            => i_si);


  ---------------------------------------------------------------------------
  -- Level 1: Both And gates
  ---------------------------------------------------------------------------
  g_And1: andg2
    port MAP(i_A           => i_S,
             i_B               => i_D1,
             o_F               => i_and1);
  
  g_And2: andg2
    port MAP(i_A             => i_si,
             i_B               => i_D0,
             o_F               => i_and2);

    
  ---------------------------------------------------------------------------
  -- Level 2: Or gate
  ---------------------------------------------------------------------------
  g_or3: org2
    port MAP(i_A             => i_and1,
             i_B             => i_and2,
             o_F             => o_O);

  
end structural;