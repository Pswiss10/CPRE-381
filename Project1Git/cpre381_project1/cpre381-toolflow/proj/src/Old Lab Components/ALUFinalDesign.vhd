library IEEE;
use IEEE.std_logic_1164.all;


entity ALUFinalDesign is
  port(

        i_Clk         : in std_logic;
        i_Enable      : in std_logic;
	i_Reset	     : in std_logic_vector (31 downto 0);
        i_readA       : in std_logic_vector(4 downto 0);     -- Data value input
        i_readB       : in std_logic_vector(4 downto 0);     -- Data value input
        i_writeEn     : in std_logic_vector(4 downto 0);
	i_replImm     : in std_logic_vector(7 downto 0);
	i_shiftImm    : in std_logic_vector(4 downto 0);
        i_ALUOpCode      : in std_logic_vector(4 downto 0);
	i_immediate  : in std_logic_vector(31 downto 0);
	i_immSel     : in std_logic;
	o_Overflow  : out std_logic;
	o_carryOut   : out std_logic;
	o_Output  : out std_logic_vector(31 downto 0));


end ALUFinalDesign;

architecture structural of ALUFinalDesign is




component RegisterFile32_32 is
  port(
       i_Clk         : in std_logic;
       i_Enable      : in std_logic;
	i_Reset	     : in std_logic_vector (31 downto 0);
       i_read1       : in std_logic_vector(4 downto 0);     -- Data value input
       i_read2       : in std_logic_vector(4 downto 0);     -- Data value input
       i_writeEn     : in std_logic_vector(4 downto 0);
       i_writeData   : in std_logic_vector(31 downto 0);   -- Data value output
	o_readData1  : out std_logic_vector(31 downto 0);
	o_readData2  : out std_logic_vector(31 downto 0));

end component;

component ALU is 
  port(
	i_rs       : in std_logic_vector(31 downto 0);
	i_rt       : in std_logic_vector(31 downto 0);
	i_shiftImm    : in std_logic_vector(4 downto 0);
	i_AluOpcode : in std_logic_vector(4 downto 0);
	i_replImm   : in std_logic_vector(7 downto 0);
        o_output        : out std_logic_vector(31 downto 0);   -- Data value output
	o_carryOut : out std_logic;
	o_overflow : out std_logic);

end component;

component Mux32_1 is
  port(i_S : in std_logic;
       i_D0         : in std_logic_vector(31 downto 0);
       i_D1        : in std_logic_vector(31 downto 0);
       o_O    : out std_logic_vector(31 downto 0));

end component;

signal s_readA2 : std_logic_vector(31 downto 0);
signal s_readB2 : std_logic_vector(31 downto 0);
signal s_ALUOut : std_logic_vector(31 downto 0);
signal s_ImmOut : std_logic_vector(31 downto 0);


begin


	

	Registers: RegisterFile32_32 port map(

       i_Clk     => i_Clk,
       i_Enable   => i_Enable,
	i_Reset	   => i_Reset,
       i_read1    => i_readA,
       i_read2  => i_readB,
       i_writeEn => i_writeEn,
       i_writeData => s_ALUOut,
	o_readData1 => s_readA2,
	o_readData2 => s_readB2);


	ImmMux :  Mux32_1 port map(
	i_S    =>  i_immSel,
        i_D0   =>  s_readB2,
        i_D1   =>  i_immediate,
        o_O    =>  s_ImmOut);


	ALUForDatapath: ALU port map(
	i_rs       => s_readA2,
	i_rt       => s_ImmOut,
	i_shiftImm => i_shiftImm,
	i_AluOpcode => i_ALUOpCode,
	i_replImm  => i_replImm,
        o_output   => s_ALUOut, 
	o_carryOut => o_carryOut,
	o_overflow => o_overflow);

o_Output <= s_ALUOut;

end structural; 