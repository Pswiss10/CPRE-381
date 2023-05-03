library IEEE;
use IEEE.std_logic_1164.all;

entity tb_ALU_dataflow is
  generic(gCLK_HPER   : time := 50 ns;
		DATA_WIDTH : natural := 32;
		ADDR_WIDTH : natural := 10); 
end tb_ALU_dataflow;

architecture structure of tb_ALU_dataflow is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


component ALU is
  port(
	i_rs       : in std_logic_vector(31 downto 0);
	i_rt       : in std_logic_vector(31 downto 0);
	i_shiftImm    : in std_logic_vector(4 downto 0);
	i_AluOpcode : in std_logic_vector(4 downto 0);
	i_replImm   : in std_logic_vector(7 downto 0);
	o_carryOut : out std_logic;
	o_overflow : out std_logic;
        o_output        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

signal s_carryOut, s_overflow : std_logic; 
signal s_rs, s_rt : std_logic_vector(31 downto 0);
signal s_output : std_logic_vector(31 downto 0);
signal s_shiftImm, s_AluOpcode : std_logic_vector(4 downto 0);
signal s_replImm : std_logic_vector(7 downto 0);

begin

  ALUmap: ALU
  port map(i_rs => s_rs, 
	   i_rt => s_rt,
           i_shiftImm => s_shiftImm,
	   i_AluOpcode => s_AluOpcode,	
           i_replImm  => s_replImm,
	   o_carryOut => s_carryOut,
	   o_overflow => s_overflow,
	   o_output => s_output);

  -- This process sets the clock value (low for gCLK_HPER, then high
  -- for gCLK_HPER). Absent a "wait" command, processes restart 
  -- at the beginning once they have reached the final statement.
  
  -- Testbench process  
  P_TB: process
  begin
-- test add

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00000";
    wait for cClk_PER/2;

-- test addu

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00001";
    wait for cClk_PER/2;

-- test sub

	s_rs <= x"00000002";
	s_rt <= x"00000001";
	s_AluOpcode <= "01011";
    wait for cClk_PER/2;

-- test subu

	s_rs <= x"00000002";
	s_rt <= x"FFFFFFFE";
	s_AluOpcode <= "11011";
    wait for cClk_PER/2;

-- test not --

	s_rs <= x"12345678";
	s_AluOpcode <= "00011";
    wait for cClk_PER/2;

-- test slt 

	s_rs <= x"FFFFFFFE";
	s_rt <= x"FFFFFFFF";
	s_AluOpcode <= "00111";
    wait for cClk_PER/2;


-- test and --

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00010";
    wait for cClk_PER/2;

-- test or --

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00110";
    wait for cClk_PER/2;

-- test xor --

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00101";
    wait for cClk_PER/2;

-- test nor --

	s_rs <= x"12345678";
	s_rt <= x"87654321";
	s_AluOpcode <= "00100";
    wait for cClk_PER/2;

-- test sll --

	s_rt <= x"12345678";
	s_shiftImm <= "10010";
	s_AluOpcode <= "01000";
    wait for cClk_PER/2;

-- test srl --

	s_rt <= x"F2345678";
	s_shiftImm <= "10010";
	s_AluOpcode <= "01001";
    wait for cClk_PER/2;

-- test sra 

	s_rt <= x"F2345678";
	s_shiftImm <= "10010";
	s_AluOpcode <= "01010";
    wait for cClk_PER/2;

-- test repl.qb 

	s_rs <= x"12345678";
	s_replImm <= "10011111";
	s_AluOpcode <= "10011";
    wait for cClk_PER/2;

    wait;
  end process;
  
end structure;