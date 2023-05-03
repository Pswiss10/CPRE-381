library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
--library std;
--use std.env.all;                -- For hierarchical/external signals
--use std.textio.all;             -- For basic I/O
use work.TwoDArray.all;

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_dp_1 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_dp_1;

architecture mixed of tb_dp_1 is

  constant cCLK_PER  : time := gCLK_HPER * 2;

-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component ALUFinalDesign is

  port(

        i_Clk         : in std_logic;
        i_Enable      : in std_logic;
	i_Reset	     : in std_logic_vector (31 downto 0);
        i_readA       : in std_logic_vector(4 downto 0);     -- Data value input
        i_readB       : in std_logic_vector(4 downto 0);     -- Data value input
        i_writeEn     : in std_logic_vector(4 downto 0);
	i_replImm     : in std_logic_vector(7 downto 0);
	i_shiftImm    : in std_logic_vector(4 downto 0);
        i_ALUOpCode      : in std_logic_vector(4 downto 0);
	i_immediate  : in std_logic_vector(31 downto 0);
	i_immSel     : in std_logic;
	o_Overflow  : out std_logic;
	o_carryOut   : out std_logic;
	o_Output  : out std_logic_vector(31 downto 0));



end component;


        signal i_Clk         : std_logic;
        signal i_Enable      : std_logic;
	signal i_Reset	     : std_logic_vector (31 downto 0);
        signal i_readA       : std_logic_vector(4 downto 0);     -- Data value input
        signal i_readB       : std_logic_vector(4 downto 0);     -- Data value input
        signal i_writeEn     : std_logic_vector(4 downto 0);
	signal i_replImm     : std_logic_vector(7 downto 0);
	signal i_shiftImm    : std_logic_vector(4 downto 0);
        signal i_ALUOpCode   : std_logic_vector(4 downto 0);
	signal i_immediate   : std_logic_vector(31 downto 0);
	signal i_immSel      : std_logic;
	signal o_Overflow    : std_logic;
	signal o_carryOut    : std_logic;
	signal o_Output      : std_logic_vector(31 downto 0);


begin

  DUT0: ALUFinalDesign
  port map(

        i_Clk     => i_Clk,
        i_Enable    => i_Enable,
	i_Reset	   => i_Reset,
        i_readA   => i_readA,
        i_readB    => i_readB,
        i_writeEn    => i_writeEn,
	i_ALUOpCode  => i_ALUOpCode,
        i_shiftImm   =>  i_shiftImm,
	i_replImm   => i_replImm,
	i_immediate => i_immediate,
	i_immSel    => i_immSel,
	o_carryOut  => o_carryOut,
	o_Overflow  => o_Overflow,
	o_Output  => o_Output);


  P_CLK: process
  begin
    i_Clk <= '1';
    wait for gCLK_HPER;
    i_Clk <= '0';
    wait for gCLK_HPER;
  end process;

  P_TEST_CASES: process
  begin

wait for cCLK_PER;

  i_Enable <= '1';
  i_Reset <= x"00000000";
  i_writeEn <= "00001";
  i_immediate <= X"00000001";
  i_immSel <= '1';
  i_ALUOpCode <= "00000";
  i_readA <= "00000";
  i_readB <= "00000";
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_Reset <= x"00000000";
  i_immediate <= X"00000000";
  i_immSel <= '0';
  i_ALUOpCode <= "00011";
  i_writeEn <= "00010";
  i_readA <= "00001";
  i_readB <= "00000";
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00111";  --opcode
  i_writeEn <= "00011";  --rd
  i_readA <= "00001";   --rs
  i_readB <= "00010";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00000";  --opcode
  i_writeEn <= "00011";  --rd
  i_readA <= "00011";   --rs
  i_readB <= "00001";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01000";  --opcode
  i_writeEn <= "00100";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "00011";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00100";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01010";  --opcode
  i_writeEn <= "00100";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "00100";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00010";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00101";  --opcode
  i_writeEn <= "00101";  --rd
  i_readA <= "00100";   --rs
  i_readB <= "00011";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01011";  --opcode
  i_writeEn <= "00110";  --rd
  i_readA <= "00100";   --rs
  i_readB <= "00101";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01010";  --opcode
  i_writeEn <= "00110";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "00110";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "01100";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00010";  --opcode
  i_writeEn <= "00111";  --rd
  i_readA <= "00110";   --rs
  i_readB <= "00000";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00000";  --opcode
  i_writeEn <= "01000";  --rd
  i_readA <= "00111";   --rs
  i_readB <= "00101";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;


  i_Enable <= '1';
  i_ALUOpCode <= "00000";  --opcode
  i_writeEn <= "01000";  --rd
  i_readA <= "01000";   --rs
  i_readB <= "00011";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01001";  --opcode
  i_writeEn <= "01001";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "01000";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00001";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00100";  --opcode
  i_writeEn <= "01010";  --rd
  i_readA <= "01001";   --rs
  i_readB <= "01000";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "00110";  --opcode
  i_writeEn <= "01011";  --rd
  i_readA <= "01010";   --rs
  i_readB <= "00110";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00000";

wait for cCLK_PER;

  i_Enable <= '1';
  i_ALUOpCode <= "01000";  --opcode
  i_writeEn <= "01011";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "01011";   --rt
  i_replImm  <= x"00";
  i_shiftImm  <= "00011";

wait for cCLK_PER;


  i_Enable <= '1';
  i_ALUOpCode <= "10011";  --opcode
  i_writeEn <= "01000";  --rd
  i_readA <= "00000";   --rs
  i_readB <= "00000";   --rt
  i_replImm  <= x"80";
  i_shiftImm  <= "00000";

wait for cCLK_PER;


wait for 100 ns;

end process;

end mixed;