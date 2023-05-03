library IEEE;
use IEEE.std_logic_1164.all;

entity loadWord is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
	o_Overflow : out std_logic;
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end loadWord;


architecture structural of loadWord is 

	component NBitAdder_Sub is 
		generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
 		 port(i_DA           : in std_logic_vector(N-1 downto 0);
   		    i_DB           : in std_logic_vector(N-1 downto 0);
   		    i_Control      : in std_logic;
   		    o_Sum          : out std_logic_vector(N-1 downto 0);
   		    o_Overflow     : out std_logic);

end component;
	begin

	StoreWord : NBitAdder_Sub port map(

		i_DA => i_rs,
		i_DB => i_imm,
		i_Control => i_imm(31),
		o_Sum => o_rt,
		o_Overflow => o_Overflow);


end structural;