library IEEE;
use IEEE.std_logic_1164.all;
use work.TwoDArray.all;



entity RegisterFile32_32 is
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


end RegisterFile32_32;



architecture structural of RegisterFile32_32 is

signal s_writeDecoded : std_logic_vector(31 downto 0);
signal s_readFromReg : TwoDArray;



component bit5_32Decoder is 

  port(
       i_write        : in std_logic;
       i_reg          : in std_logic_vector(4 downto 0);     -- Data value input
       o_data         : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component nbit32_1Mux is 

  port(i_S          : in std_logic_vector(4 downto 0);
       iD0          : in TwoDArray;
       o_O          : out std_logic_vector(31 downto 0));

end component;


component NbitRegister is 

   port(
       i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value output

end component;

begin 

	Decoder: bit5_32Decoder port map(
		i_write => i_Enable,
		i_reg => i_writeEn,
		o_data => s_writeDecoded);

 G_RegisterFile32_32: for i in 1 to 31 generate



	Registers: nbitRegister port map(
		i_CLK => i_Clk,
		i_RST => i_Reset(i),
		i_WE => s_writeDecoded(i),
		i_D => i_writeData,
		o_Q => s_readFromReg(i));
  
end generate G_RegisterFile32_32;

	Mux1: nbit32_1Mux port map(
		i_S => i_read1,
       		iD0 => s_readFromReg,
       		o_O => o_readData1);    

	Mux2: nbit32_1Mux port map(
		i_S => i_read2,
       		iD0 => s_readFromReg,
       		o_O => o_readData2);  

	RegisterForZero: nbitRegister port map(
		i_CLK => i_Clk,
		i_RST => '1',
		i_WE => s_writeDecoded(0),
		i_D => i_writeData,
		o_Q => s_readFromReg(0));
	
end structural;