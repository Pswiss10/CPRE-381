library IEEE;
use IEEE.std_logic_1164.all;

entity bne is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_branchVal        : out std_logic_vector(31 downto 0));   -- Data value output

end bne;


architecture mixed of bne is

	component NBitAdder_Sub is 
		generic(N : integer := 32);
		port(i_DA           : in std_logic_vector(N-1 downto 0);
       			i_DB           : in std_logic_vector(N-1 downto 0);
      			 i_Control      : in std_logic;
      			 o_Sum          : out std_logic_vector(N-1 downto 0);
     			 o_Overflow     : out std_logic);
	end component;

	signal s_LessThen : std_logic_vector(31 downto 0);
begin 

	Adder : NBitAdder_Sub port map(

		i_DA => i_rt,
		i_DB => i_rs,
		i_Control => '1',
		o_Sum => s_LessThen);

	
	with s_LessThen select
		   o_branchVal <= x"00000000" when x"00000000",
			          x"00000001" when  others;

end mixed;