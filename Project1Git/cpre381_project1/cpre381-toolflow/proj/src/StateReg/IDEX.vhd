library IEEE;
use IEEE.std_logic_1164.all;

entity IDEX is
generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32

  port( i_Clk        	: in std_logic;     -- Clock input
        i_RST        	: in std_logic;     -- Reset input
	i_Stall         : in std_logic;

        i_ALUSrcSel	: in std_logic;
	i_ALUOpCode     : in std_logic_vector(4 downto 0);
        i_regDst        : in std_logic_vector(4 downto 0);
	i_MemWrEn	: in std_logic;
        i_branchSel     : in std_logic;
	i_memToRegSel   : in std_logic;
	i_regRsIn       : in std_logic_vector(4 downto 0);
        i_regRtIn       : in std_logic_vector(4 downto 0);
	i_RegWrAddr    	: in std_logic_vector(4 downto 0);
	i_JaloDataWrite : in std_logic_vector(31 downto 0);
	i_regRsOut      : in std_logic_vector(31 downto 0);
        i_regRtOut      : in std_logic_vector(31 downto 0);
	i_immMuxOut   	: in std_logic_vector(31 downto 0);
	i_jumpAddr      : in std_logic_vector(25 downto 0);
	i_branchAddr    : in std_logic_vector(31 downto 0);
	i_jumpSel     	: in std_logic;
	i_jumpRegSel    : in std_logic;
	i_jalSel    	: in std_logic;
	i_memReadSel    : in std_logic;
	i_regWr         : in std_logic;
	i_PC            : in std_logic_vector(31 downto 0);
	i_Halt          : in std_logic;
	i_inst		: in std_logic_vector(31 downto 0);
	o_inst		: out std_logic_vector(31 downto 0);

	i_opcode	: in std_logic_vector(5 downto 0);
	o_opcode	: out std_logic_vector(5 downto 0);

        o_ALUSrcSel	: out std_logic;
	o_ALUOpCode     : out std_logic_vector(4 downto 0);
        o_regDst        : out std_logic_vector(4 downto 0);
	o_MemWrEn	: out std_logic;
        o_branchSel     : out std_logic;
	o_memToRegSel   : out std_logic;
	o_regRsIn       : out std_logic_vector(4 downto 0);
        o_regRtIn       : out std_logic_vector(4 downto 0);
	o_RegWrAddr    	: out std_logic_vector(4 downto 0);
	o_JaloDataWrite : out std_logic_vector(31 downto 0);
	o_regRsOut      : out std_logic_vector(31 downto 0);
        o_regRtOut      : out std_logic_vector(31 downto 0);
	o_jumpAddr      : out std_logic_vector(25 downto 0);
	o_branchAddr    : out std_logic_vector(31 downto 0);
	o_immMuxOut   	: out std_logic_vector(31 downto 0);
	o_jumpSel     	: out std_logic;
	o_jumpRegSel    : out std_logic;
	o_jalSel    	: out std_logic;
	o_memReadSel    : out std_logic;
	o_regWr         : out std_logic;
	o_Halt          : out std_logic;
	o_PC            : out std_logic_vector(31 downto 0));

end IDEX;

architecture structure of IDEX is

component dffg32 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(31 downto 0);
       o_Q          : out std_logic_vector(31 downto 0));

end component;

component dffg5 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(4 downto 0);
       o_Q          : out std_logic_vector(4 downto 0));

end component;


component dffg26 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(25 downto 0);
       o_Q          : out std_logic_vector(25 downto 0));

end component;

component dffg is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic;
       o_Q          : out std_logic);

end component;

component dffg6 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(5 downto 0);
       o_Q          : out std_logic_vector(5 downto 0));

end component;

begin

alusrc: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_ALUSrcSel,
	o_Q   => o_ALUSrcSel);

aluop: dffg5 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_ALUOpCode,
	o_Q   => o_ALUOpCode);

regDst: dffg5 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regDst,
	o_Q   => o_regDst);

MemWrEn: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_MemWrEn,
	o_Q   => o_MemWrEn);

branchSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_branchSel,
	o_Q   => o_branchSel);

memToRegSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_memToRegSel,
	o_Q   => o_memToRegSel);

regRsIn: dffg5 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regRsIn,
	o_Q   => o_regRsIn);

regRtIn: dffg5 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regRtIn,
	o_Q   => o_regRtIn);


RegWrAddr: dffg5 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_RegWrAddr,
	o_Q   => o_RegWrAddr);

JaloDataWrite: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_JaloDataWrite,
	o_Q   => o_JaloDataWrite);

regRsOut: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regRsOut,
	o_Q   => o_regRsOut);

regRtOut: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regRtOut,
	o_Q   => o_regRtOut);

immMuxOut: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_immMuxOut,
	o_Q   => o_immMuxOut);

jumpAddr: dffg26 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_jumpAddr,
	o_Q   => o_jumpAddr);

branchAddr: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_branchAddr,
	o_Q   => o_branchAddr);

jumpSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_jumpSel,
	o_Q   => o_jumpSel);

jumpRegSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_jumpRegSel,
	o_Q   => o_jumpRegSel);

jalSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_jalSel,
	o_Q   => o_jalSel);

memReadSel: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_memReadSel,
	o_Q   => o_memReadSel);

regWr: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_regWr,
	o_Q   => o_regWr);

pc: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_PC,
	o_Q   => o_PC);

halt: dffg port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_Halt,
	o_Q   => o_Halt);

Inst: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_inst,
	o_Q   => o_inst);

opCode: dffg6 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_Stall,
	i_D   => i_opcode,
	o_Q   => o_opcode);


end structure;
