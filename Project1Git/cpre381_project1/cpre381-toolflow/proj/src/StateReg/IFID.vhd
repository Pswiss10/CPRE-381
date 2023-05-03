library IEEE;
use IEEE.std_logic_1164.all;

entity IFID is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32

  port( i_Clk        	: in std_logic;     -- Clock input
        i_Flush        	: in std_logic;     -- Reset input
	i_Stall         : in std_logic;
        i_Inst	    	: in std_logic_vector(31 downto 0);
	i_PC      	: in std_logic_vector(31 downto 0);
        o_Inst		: out std_logic_vector(31 downto 0);     -- Data value input
        o_PC       : out std_logic_vector(31 downto 0));   -- Data value output

end IFID;

architecture structure of IFID is

component dffg32 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(31 downto 0);
       o_Q          : out std_logic_vector(31 downto 0));

end component;

begin

inst_dffg: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_Flush,
	i_WE  => i_Stall,
	i_D   => i_Inst,
	o_Q   => o_Inst);

pc_dffg: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_Flush,
	i_WE  => i_Stall,
	i_D   => i_PC,
	o_Q   => o_PC);
 
end structure;