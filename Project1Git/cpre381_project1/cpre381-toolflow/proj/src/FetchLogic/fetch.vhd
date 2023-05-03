library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fetch is
	generic(N : integer := 32);
	

  port( i_CLK                       : in std_logic;
        i_RST                       : in std_logic;
	i_EN                        : in std_logic;
	i_Branch		    : in std_logic;
	i_Jal			    : in std_logic;
	i_ZERO			    : in std_logic;
	i_Jr			    : in std_logic;
	i_J			    : in std_logic;
	i_WRITEDST		    : in std_logic_vector(4 downto 0);
	i_JAddr		            : in std_logic_vector(25 downto 0);
	i_BIAddr		    : in std_logic_vector(31 downto 0);
	i_WriteData		    : in std_logic_vector(31 downto 0);
	i_RS			    : in std_logic_vector(31 downto 0);
	i_BranchAddrEX		    : in std_logic_vector(31 downto 0);
	i_PCNextEX		    : in std_logic_vector(31 downto 0);
	i_JalAddr		    : in std_logic_vector(25 downto 0);
	i_PCID			    : in std_logic_vector(31 downto 0);
	
	o_FinalBranchSel            : out std_logic;
	o_RSTBegin                  : out std_logic;
	o_WRITEDST		    : out std_logic_vector(4 downto 0);
	o_JaloDataWrite		    : out std_logic_vector(31 downto 0);
	o_InsAddr		    : out std_logic_vector(31 downto 0);
	o_BranchAddrInEX	    : out std_logic_vector(31 downto 0);
	o_PCNextInEX		    : out std_logic_vector(31 downto 0));

end fetch;

architecture Mixed of fetch is

component AdderH_n is
 -- generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_X         	: in std_logic_vector(N-1 downto 0);
	i_Y		: in std_logic_vector(N-1 downto 0);
	i_C		: in std_logic;
	o_C	    	: out std_logic;
       	o_B          	: out std_logic_vector(N-1 downto 0));

end component;

component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component mux2t1_N is
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

end component;

component mux2t1_5 is
  	port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(4 downto 0);
             i_D1         : in std_logic_vector(4 downto 0);
             o_O          : out std_logic_vector(4 downto 0));

end component;

component invg is

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component PC is
  port(	i_CLK  :in std_logic;
	i_WE        : in std_logic;
	i_RST 	    : in std_logic;
       	i_WD         : in std_logic_vector(31 downto 0);	
       	o_InsAdd     : out std_logic_vector(31 downto 0));

end component;

signal S_InAddr, s_JAddr, s_BAddr, s_BIAddr, s_B1, s_B2, s_B3, s_PCin : std_logic_vector(31 downto 0);

signal s_oC, s_Ba0, s_N0, s_BNEANDNOTZERO : std_logic;

signal s_JalAdd : std_logic_vector(31 downto 0);	

  signal s_PCNext4, s_branchNew : std_logic_vector(31 downto 0);

signal s_possPCNext, s_FinalBrAddr : std_logic_vector(31 downto 0);


begin

o_RSTBegin <= '0';
o_FinalBranchSel    <= s_Ba0;
--Process(i_PCNextEX)

--begin
--	if (i_PCNextEX = x"00000000") then
--		o_RSTBegin <= '1';
--	else
--		o_RSTBegin <= '0';
--	end if;
--end process;

PC1: PC port map(
	i_CLK  => i_CLK,
	i_WE   => i_EN,
	i_RST  => i_RST,
       	i_WD   => s_PCin,	
       	o_InsAdd => s_InAddr);

o_InsAddr <= s_InAddr;

PCADD1: AdderH_N port map(
	i_X  => s_InAddr,
	i_Y  => x"00000004",
	i_C  => '0',
	o_C  => s_oC, 
       	o_B  =>  s_PCNext4);

o_PCNextInEX <= s_PCNext4;

JALADD1: AdderH_N port map(
	i_X  => s_InAddr,
	i_Y  => x"00000004",
	i_C  => '0',
	o_C  => s_oC, 
       	o_B  => s_JalAdd);

s_JAddr <= i_PCNextEX(31 downto 28) & i_JAddr & "00";

JALWRITEDATA: mux2t1_n port map(
 	i_S  => i_Jal,
       i_D0  => i_WriteData,
       i_D1  => s_JalAdd,
       o_O   => o_JaloDataWrite);


JALREGSEL: mux2t1_5 port map(
	i_S  => i_Jal,
       i_D0  => i_WRITEDST,
       i_D1  => "11111",
       o_O   => o_WRITEDST);

s_BIAddr <= i_BIAddr(29 downto 0) & "00";

BRANCHADDER: AdderH_n port map(
	i_X  => i_PCID,
	i_Y  => s_BIAddr,
	i_C  => '0',
	o_C  => s_oC, 
       	o_B  => s_branchNew);

o_BranchAddrInEX <= s_branchNew;

BRANCHANDZERO: andg2 port map(
	i_A  => i_Branch,
       i_B   => i_ZERO,
       o_F   => s_Ba0);
	
BRANCHMUX: mux2t1_N port map(i_S => s_Ba0,
       i_D0 => i_PCNextEX,
        i_D1 => i_BranchAddrEX,
       o_O  => s_B2);

--NOT0: invg port map(
--	i_A => i_ZERO,
--       o_F  => s_N0);

--ANDNOTZEROBNE: andg2 port map(
--	i_A  => i_BNE,
--       i_B   => s_N0,
--       o_F   => s_BNEANDNOTZERO);

--BNEMUX: mux2t1_N port map(i_S => s_BNEANDNOTZERO,
--       i_D0 => s_B1,
--       i_D1 => s_BAddr,
--       o_O  => s_B2);
	
JOBRANCHMUX: mux2t1_N port map(
	i_S => i_J,
       i_D0 => s_B2,
       i_D1 => s_JAddr,
       o_O  => s_B3);

JRMUX: mux2t1_N port map(
	i_S => i_Jr,
       i_D0 => s_B3,
       i_D1 => i_RS,
       o_O  => s_possPCNext);

	NextPCCorrect : Mux2t1_N port map(
		i_S => i_J,
		i_D0 => s_PCNext4,
		i_D1 => s_possPCNext,
		o_O => s_FinalBrAddr);


	NextPCCorrectForBranch : Mux2t1_N port map(
		i_S => s_Ba0,
		i_D0 => s_FinalBrAddr,
		i_D1 => s_possPCNext,
		o_O => s_PCin);

  end Mixed;
