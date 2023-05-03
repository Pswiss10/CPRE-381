library IEEE;
use IEEE.std_logic_1164.all;

entity tb_fetch is
  generic(gCLK	   : time := 50 ns;
	N : integer := 32;
	DATA_WIDTH : natural := 32;
	ADDRW_WIDTH : natural := 10);
end tb_fetch;


architecture behavior of tb_fetch is

	constant cClk  : time := gCLK * 2;
	
	component fetch is 
	port( i_CLK                 : in std_logic;
              i_RST                 : in std_logic;
	      i_Branch		    : in std_logic;
	      i_BNE		    : in std_logic;
	      i_Jal		    : in std_logic;
	      i_ZERO		    : in std_logic;
	      i_Jr	  	    : in std_logic;
	      i_J	  	    : in std_logic;
	      i_WRITEDST	    : in std_logic_vector(4 downto 0);
	      i_JAddr	            : in std_logic_vector(25 downto 0);
	      i_BIAddr		    : in std_logic_vector(31 downto 0);
	      i_WriteData	    : in std_logic_vector(31 downto 0);
	      i_RS		    : in std_logic_vector(31 downto 0);
	      o_WRITEDST	    : out std_logic_vector(4 downto 0);
	      o_JaloDataWrite       : out std_logic_vector(31 downto 0);	      
	      o_InsAddr		    : out std_logic_vector(31 downto 0));
end component;

	component mem is 
	port( clk		    : in std_logic;
	      addr		    : in std_logic_vector(9 downto 0);
	      data		    : in std_logic_vector(31 downto 0);
	      we		    : in std_logic := '1';
	      q		   	    : out std_logic_vector(31 downto 0));

end component;

-- Temporary signals to connect to the dff component.

signal s_Branch : std_logic;

  signal s_CLK, s_IMWE, s_RST, s_BNE, s_Jal, s_ZERO, s_Jr, s_J : std_logic;
  signal s_BranchImmAddr, s_WriteData, s_RS, s_JaloDataWrite : std_logic_vector(31 downto 0);
signal s_JumpAddr : std_logic_vector(25 downto 0);
  signal s_oWriteDST, s_iWriteDST : std_logic_vector(4 downto 0);
  signal s_INSTR, s_INSTRADDR   : std_logic_vector((DATA_WIDTH-1) downto 0);

begin

	FETCH1: fetch
	port map(    
		i_CLK => s_CLK,        	
           	i_RST  => s_RST,
		i_Branch => s_Branch,
		i_BNE	=> s_BNE,
		i_Jal	=> s_Jal,
		i_ZERO	=> s_ZERO,
		i_Jr	=> s_Jr,
		i_J  	=> s_J,
		i_WRITEDST => s_iWriteDST,
		i_JAddr => s_JumpAddr,
		i_BIAddr	=> s_BranchImmAddr,
		i_WriteData => s_WriteData,
		i_RS	=> s_RS,
		o_WRITEDST => s_oWriteDST,
		o_JaloDataWrite	 => s_JaloDataWrite,
           	o_InsAddr   => s_INSTRADDR);

	INSTMEM: mem 
	port map( clk => s_CLK,
		  addr => s_INSTRADDR(11 downto 2),
		  data => x"00000000",
		  we => s_IMWE,
		  q => s_INSTR);

	P_CLK: process 
	begin
	  s_CLK <= '0';
	  wait for gCLK;
	  s_CLK <= '1';
	  wait for gCLK;
	end process;

	P_TB: process
	begin
	  s_RST <= '1';
	  wait for gCLK;
	  s_RST <= '0';
	  s_IMWE <= '0';

	  s_Branch <= '0';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '0';
	  s_Jr <= '0';
	  s_J <= '0';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000000";
	  s_BranchImmAddr <= x"00000008";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

       	  wait for gCLK*2;
	
	  s_Branch <= '0';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '0';
	  s_Jr <= '0';
	  s_J <= '0';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000000";
	  s_BranchImmAddr <= x"00000008";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

    	  wait for gCLK*2;

	  s_Branch <= '1';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '1';
	  s_Jr <= '0';
	  s_J <= '0';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000000";
	  s_BranchImmAddr <= x"00000002";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

	  wait for gCLK*2;

	  s_Branch <= '1';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '1';
	  s_Jr <= '0';
	  s_J <= '0';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000000";
	  s_BranchImmAddr <= x"00000001";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

 	  wait for gCLK*2;

	  s_Branch <= '0';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '1';
	  s_Jr <= '0';
	  s_J <= '1';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000000";
	  s_BranchImmAddr <= x"00000004";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

	  wait for gCLK*2;

	  s_Branch <= '0';
	  s_BNE <= '0';
	  s_Jal <= '1';
	  s_ZERO <= '1';
	  s_Jr <= '0';
	  s_J <= '1';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000000011";
	  s_BranchImmAddr <= x"00400004";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00000000";

	  wait for gCLK*2;

	  s_Branch <= '0';
	  s_BNE <= '0';
	  s_Jal <= '0';
	  s_ZERO <= '0';
	  s_Jr <= '1';
	  s_J <= '0';
	  s_iWriteDST <= "00001";
	  s_JumpAddr <= "00000000000000000000001100";
	  s_BranchImmAddr <= x"00000004";
	  s_WriteData <= x"00000000";
	  s_RS <= x"00400004";

	  wait for gCLK*2;

	   wait;
  end process;
  
end behavior;


