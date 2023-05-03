library IEEE;
use IEEE.std_logic_1164.all;

entity dffg6 is
  --generic(N : integer := 5); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(5 downto 0);
       o_Q          : out std_logic_vector(5 downto 0));

end dffg6;

architecture structural of dffg6 is

  component dffg is
    port(i_Clk               : in std_logic;
         i_RST               : in std_logic;
         i_WE                : in std_logic;
 	 i_D                 : in std_logic;
         o_Q                 : out std_logic);
  end component;

begin

  G_5bit_DFFG: for i in 0 to 5 generate
    DFFR: dffg port map(
        i_Clk      => i_Clk,      
        i_RST     => i_RST,  
        i_WE     => i_WE,  
        i_D      => i_D(i),    
	o_Q      => o_Q(i)); 
  end generate G_5bit_DFFG;
  
end structural;