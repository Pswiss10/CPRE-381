library IEEE;
use IEEE.std_logic_1164.all;

entity tb_stateRegTest is
  generic(
	  gCLK	   : time := 50 ns;
	  DATA_WIDTH : natural := 32;
	  ADDR_WIDTH : natural := 10); 
end tb_stateRegTest;

architecture structure of tb_stateRegTest is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK : time := gCLK * 2;


component stateRegTest is
  port(i_Clk        	: in std_logic;     -- Clock input
        i_FlushIFID       : in std_logic;     -- Reset input
	i_StallIFID         : in std_logic;
	i_FlushIDEX       : in std_logic;     -- Reset input
	i_StallIDEX         : in std_logic;
	i_FlushEXMEM       : in std_logic;     -- Reset input
	i_StallEXMEM         : in std_logic;
	i_FlushMEMWB       : in std_logic;     -- Reset input
	i_StallMEMWB         : in std_logic;
	i_inst            : in std_logic_vector(31 downto 0);
	o_inst            : out std_logic_vector(31 downto 0));

end component;

signal s_inst, s_instOut : std_logic_vector(31 downto 0);
signal s_CLK, s_FlushIFID, s_StallIFID, s_FlushIDEX, s_StallIDEX, s_FlushEXMEM, s_StallEXMEM, s_FlushMEMWB, s_StallMEMWB : std_logic;
begin

  regTest: stateRegTest
  port map(i_CLK => s_CLK,
	   i_FlushIFID => s_FlushIFID, 
	   i_StallIFID => s_StallIFID,
	   i_FlushIDEX => s_FlushIDEX, 
	   i_StallIDEX => s_StallIDEX,
           i_FlushEXMEM => s_FlushEXMEM, 
	   i_StallEXMEM => s_StallEXMEM,
	   i_FlushMEMWB => s_FlushMEMWB, 
	   i_StallMEMWB => s_StallMEMWB,
	   i_inst => s_inst,	
           o_inst => s_instOut);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  
  -- Testbench process  

P_CLK: process 
	begin
	  s_CLK <= '0';
	  wait for gCLK;
	  s_CLK <= '1';
	  wait for gCLK;
	end process;

  P_TB: process
  begin

s_inst <= x"12345678";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';

    wait for cClk;

		s_inst <= x"87654321";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';

    wait for cClk;

	s_inst <= x"0F0F0F0F";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';

    wait for cClk;

	s_inst <= x"12345678";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

        s_inst <= x"FFFFFFFF";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

	 s_inst <= x"87654321";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';

 wait for cClk;

s_inst <= x"00000000";
	s_StallIFID <= '1';
	s_FlushIFID <= '1';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

s_inst <= x"57375838";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

s_inst <= x"99999999";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

s_inst <= x"12345678";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;

s_inst <= x"88888888";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;


s_inst <= x"FFFFFFFF";
	s_StallIFID <= '0';
	s_FlushIFID <= '0';
	s_StallIDEX <= '0';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '0';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '0';
	s_FlushMEMWB <= '0';
	
  wait for cClk;


s_inst <= x"00000000";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;


s_inst <= x"11111111";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;


s_inst <= x"34858383";
	s_StallIFID <= '1';
	s_FlushIFID <= '0';
	s_StallIDEX <= '1';
	s_FlushIDEX <= '0';
        s_StallEXMEM <= '1';
	s_FlushEXMEM <= '0';
	s_StallMEMWB <= '1';
	s_FlushMEMWB <= '0';
	
  wait for cClk;


    wait;
  end process;
  
end structure;