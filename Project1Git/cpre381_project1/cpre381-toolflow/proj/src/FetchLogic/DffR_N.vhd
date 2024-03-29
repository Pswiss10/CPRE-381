library IEEE;
use IEEE.std_logic_1164.all;

entity DffR_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(N-1 downto 0);
       o_Q          : out std_logic_vector(N-1 downto 0));

end DffR_N;

architecture structural of DffR_N is

  component dffg is
    port(i_Clk                  : in std_logic;
         i_RST                 : in std_logic;
         i_WE                 : in std_logic;
 	 i_D                 : in std_logic;
         o_Q                  : out std_logic);
  end component;

begin

  G_NBit_DFFR: for i in 0 to N-1 generate
    DFFR: dffg port map(
        i_Clk      => i_Clk,      -- All instances share the same select input.
        i_RST     => i_RST,  -- ith instance's data 0 input hooked up to ith data 0 input.
        i_WE     => i_WE,  -- ith instance's data 1 input hooked up to ith data 1 input.
        i_D      => i_D(i),    
	o_Q      => o_Q(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_DFFR;
  
end structural;
