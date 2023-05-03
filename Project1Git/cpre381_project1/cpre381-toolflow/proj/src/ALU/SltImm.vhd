library IEEE;
use IEEE.std_logic_1164.all;

entity SltImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end SltImm;


architecture mixed of SltImm is 

	component NBitAdder_Sub is 
		generic(N : integer := 32);
		port(i_DA           : in std_logic_vector(N-1 downto 0);
       			i_DB           : in std_logic_vector(N-1 downto 0);
      			 i_Control      : in std_logic;
      			 o_Sum          : out std_logic_vector(N-1 downto 0);
     			 o_Overflow     : out std_logic);
	end component;

	signal s_LessThen : std_logic_vector(31 downto 0);
	signal s_signBit : std_logic;
begin 

	Adder : NBitAdder_Sub port map(

		i_DA => i_rs,
		i_DB => i_imm,
		i_Control => '1',
		o_Sum => s_LessThen);
	
		s_signBit <= s_LessThen(31);
	
	with s_signBit select
		   o_rt <= x"00000000" when '0',
			   x"00000001" when  others;

end mixed;