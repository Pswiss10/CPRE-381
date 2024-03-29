library IEEE;
use IEEE.std_logic_1164.all;



entity controlUnit is
  port(
	i_opCode        : in std_logic_vector(5 downto 0);
	i_funCode          : in std_logic_vector(5 downto 0);     -- Data value input
	o_Halt             : out std_logic;
        o_controlOutput          : out std_logic_vector(15 downto 0));   -- Data value output

end controlUnit;


architecture structural of controlUnit is 

	component ControlDecoderRtype is 
		port(
			i_write        : in std_logic;
			i_reg          : in std_logic_vector(5 downto 0);     -- Data value input
        		o_data          : out std_logic_vector(15 downto 0));   -- Data value output
	end component;

	component ControlDecoderOG is 
		port(
			i_reg          : in std_logic_vector(5 downto 0);     -- Data value input
        		o_data          : out std_logic_vector(16 downto 0));   -- Data value output
	end component;

	
	component mux2t1_16 is 
		port(
			i_S          : in std_logic;
       			i_D0         : in std_logic_vector(15 downto 0);
      			i_D1         : in std_logic_vector(15 downto 0);
       			o_O          : out std_logic_vector(15 downto 0));

	end component;


	component invg is 
		port(
			i_A          : in std_logic;
      			o_F          : out std_logic);
	end component;


signal s_OGOutput : std_logic_vector(16 downto 0);
signal s_RtypeOutput : std_logic_vector(15 downto 0);
signal s_RtypeEn : std_logic;

begin

	OGPortMap : ControlDecoderOG port map(

		i_reg => i_opCode,
		o_data => s_OGOutput);

	RtypePortMap : ControlDecoderRtype port map(

		i_write   => s_OGOutput(16),   
		i_reg     => i_funCode,
        	o_data    => s_RtypeOutput);

	MuxEnable : invg port map(
	
		i_A => s_OGOutput(16),
		o_F => s_RtypeEn);


	MuxOutput : mux2t1_16 port map(

		i_S => s_RtypeEn,
		i_D0 => s_RtypeOutput,
		i_D1 => s_OGOutput(15 downto 0),
		o_O => o_controlOutput);

	with i_opCode select	
		o_Halt <= '1' when "010100",
			  '0' when others;


end structural;