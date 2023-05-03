library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity EXMEM is
	port(i_CLK		: in std_logic;
	     i_RST		: in std_logic; -- (1 sets reg to 0)
		i_EN  : in std_logic;

	 --    i_PC_4		: in std_logic_vector(31 downto 0);
	 --    i_finalJumpAddr	: in std_logic_vector(31 downto 0);
	 --    i_branchAddr	: in std_logic_vector(31 downto 0);
	     i_readData2 	: in std_logic_vector(31 downto 0);
	     i_aluOut	 	: in std_logic_vector(31 downto 0);

	     i_writeReg 	: in std_logic_vector(4 downto 0);

	-- one bit inputs
	--     i_zero		: in std_logic;
	     i_overflow		: in std_logic;
	--     i_jal		: in std_logic;
	     i_MemtoReg		: in std_logic;
	     i_weMem		: in std_logic;
	     i_weReg		: in std_logic;
	     i_DMemRead		: in std_logic;
	--     i_j		: in std_logic;
	     i_halt		: in std_logic;
		i_imm	:in std_logic;
	i_inst		: in std_logic_vector(31 downto 0);
	o_inst		: out std_logic_vector(31 downto 0);

		i_branch	: in std_logic;
		o_branch	: out std_logic;

		i_jump		: in std_logic;
		o_jump		: out std_logic;

	i_opcode	: in std_logic_vector(5 downto 0);
o_opcode	: out std_logic_vector(5 downto 0);
	--     o_PC_4		: out std_logic_vector(31 downto 0);
	 --    o_finalJumpAddr	: out std_logic_vector(31 downto 0);
	--     o_branchAddr	: out std_logic_vector(31 downto 0);
	     o_readData2 	: out std_logic_vector(31 downto 0);
	     o_aluOut	 	: out std_logic_vector(31 downto 0);

	     o_writeReg 	: out std_logic_vector(4 downto 0);

	-- one bit outputs
	--     o_zero		: out std_logic;
	     o_overflow		: out std_logic;
	 --    o_jal		: out std_logic;
	     o_MemtoReg		: out std_logic;
	     o_weMem		: out std_logic;
	     o_weReg		: out std_logic;
	     o_DMemRead		: out std_logic;
	--     o_j		: out std_logic;
	     o_halt		: out std_logic;
		o_imm	:out std_logic);

end EXMEM;

-- architecture
architecture structural of EXMEM is

  component dffg is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
  end component;

component dffg5 is
  --generic(N : integer := 5); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(4 downto 0);
       o_Q          : out std_logic_vector(4 downto 0));

end component;

  component dffg32 is
  --generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value output
  end component;


component dffg6 is
  port(i_Clk        : in std_logic;
       i_RST        : in std_logic;
       i_WE         : in std_logic;	
       i_D	    : in std_logic_vector(5 downto 0);
       o_Q          : out std_logic_vector(5 downto 0));

end component;

begin

 -- x1_1: dffg_N
	--generic map(N => 32)
	--port map(i_CLK 	=> i_CLK,
	--	 i_RST 	=> i_RST,
	--	 i_WE	=> '1',
	--	 i_D	=> i_PC_4,
	--	 o_Q	=> o_PC_4);

  --x1_2: dffg_N
	--generic map(N => 32)
	--port map(i_CLK 	=> i_CLK,
		-- i_RST 	=> i_RST,
	--	 i_WE	=> '1',
	--	 i_D	=> i_finalJumpAddr,
--		 o_Q	=> o_finalJumpAddr);

  x1_3: dffg32
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_readData2,
		 o_Q	=> o_readData2);

  --x1_4: dffg_N
	--generic map(N => 32)
	--port map(i_CLK 	=> i_CLK,
	--	 i_RST 	=> i_RST,
	--	 i_WE	=> '1',
	--	 i_D	=> i_branchAddr,
	--	 o_Q	=> o_branchAddr);

  x1_5: dffg32
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_aluOut,
		 o_Q	=> o_aluOut);

  x2_1: dffg5
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_writeReg,
		 o_Q	=> o_writeReg);

--  x3_1: dffg
	--port map(i_CLK 	=> i_CLK,
	--	 i_RST 	=> i_RST,
		-- i_WE	=> '1',
		-- i_D	=> i_zero,
		-- o_Q	=> o_zero);

  x3_2: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_overflow,
		 o_Q	=> o_overflow);

  --x3_3: dffg
	--port map(i_CLK 	=> i_CLK,
	--	 i_RST 	=> i_RST,
	--	 i_WE	=> '1',
		-- i_D	=> i_jal,
	--	 o_Q	=> o_jal);

  x3_4: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_MemtoReg,
		 o_Q	=> o_MemtoReg);

  x3_5: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_weMem,
		 o_Q	=> o_weMem);

  x3_6: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_weReg,
		 o_Q	=> o_weReg);

  x3_7: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_DMemRead,
		 o_Q	=> o_DMemRead);

 -- x3_8: dffg
	--port map(i_CLK 	=> i_CLK,
	--	 i_RST 	=> i_RST,
	----	 i_WE	=> '1',
	--	 i_D	=> i_j,
	--	 o_Q	=> o_j);

  x3_9: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_halt,
		 o_Q	=> o_halt);

  x3_10: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_imm,
		 o_Q	=> o_imm);

  x3_11: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_branch,
		 o_Q	=> o_branch);

  x3_12: dffg
	port map(i_CLK 	=> i_CLK,
		 i_RST 	=> i_RST,
		 i_WE	=> i_EN,
		 i_D	=> i_jump,
		 o_Q	=> o_jump);

Inst: dffg32 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_EN,
	i_D   => i_inst,
	o_Q   => o_inst);

opCode: dffg6 port map(
	i_Clk => i_Clk,
	i_RST => i_RST,
	i_WE  => i_EN,
	i_D   => i_opcode,
	o_Q   => o_opcode);




end structural;

