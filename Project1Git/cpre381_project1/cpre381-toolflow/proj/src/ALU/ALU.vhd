library IEEE;
use IEEE.std_logic_1164.all;
use work.TwoDArrayForALU.all;

entity ALU is
  port(
	i_rs       : in std_logic_vector(31 downto 0);
	i_rt       : in std_logic_vector(31 downto 0);
	i_shiftImm    : in std_logic_vector(4 downto 0);
	i_AluOpcode : in std_logic_vector(4 downto 0);
	i_replImm   : in std_logic_vector(7 downto 0);
	i_PCJAL     : in std_logic_vector(31 downto 0);
        o_output        : out std_logic_vector(31 downto 0);   -- Data value output
	o_carryOut : out std_logic;
	o_overflow : out std_logic);

end ALU;


architecture structural of ALU is

component ALUMux is
  	port(i_S          : in std_logic_vector(4 downto 0);
      		 iD0         : in TwoDArrayForALU;
      		 o_O          : out std_logic_vector(31 downto 0));

end component;

component bit29_1Mux is
  port(i_S          : in std_logic_vector(4 downto 0);
       iD0         : in std_logic_vector(28 downto 0);
       o_O          : out std_logic);

end component;


component addIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end component;

component adduIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end component;

component andIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component notIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component norIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component xorIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component orIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

component Slt is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rd        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component shiftLeftLogical is
  port(i_In : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       o_Out : out std_logic_vector(31 downto 0));
end component;

component shiftRightLogical is
  port(i_In : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       o_Out : out std_logic_vector(31 downto 0));
end component;

component shiftRightArithmetic is
  port(i_In : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       o_Out : out std_logic_vector(31 downto 0));
end component;

component subIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end component;

component subuIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic;
       o_Overflow     : out std_logic);

end component;


component jumpRegister is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_outPut        : out std_logic_vector(31 downto 0));   -- Data value output

end component;


component move_N is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rd        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component jump is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_outPut        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component jumpAndLink is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_outPut        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component beq is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_branchVal        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component bne is
  port(
	i_rt       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_branchVal        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component addiIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end component;

component repl_qb is
  port(
	i_8bitIm        : in std_logic_vector(7 downto 0);
        o_replOutput         : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component addiuIns is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_DA           : in std_logic_vector(N-1 downto 0);
       i_DB           : in std_logic_vector(N-1 downto 0);
       o_Sum          : out std_logic_vector(N-1 downto 0);
       o_Carry        : out std_logic; 
       o_Overflow     : out std_logic);

end component;

component SltImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component orImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component XorImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component loadUpperImm is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component loadWord is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
	o_Overflow : out std_logic;
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component storeWord is
  port(
	i_imm       : in std_logic_vector(31 downto 0);
	i_rs       : in std_logic_vector(31 downto 0);
	o_Overflow : out std_logic;
        o_rt        : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component andImmIns is
generic(N : integer := 32); 
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_Imm          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end component;

signal s_insOut : TwoDArrayForALU;
signal s_overflow : std_logic_vector(28 downto 0):= "00000000000000000000000000000";
signal s_carryOut : std_logic_vector(28 downto 0):= "00000000000000000000000000000";
signal s_unusedOverflow : std_logic_vector(28 downto 0):= "00000000000000000000000000000";

begin

add: addIns port map(
	i_DA   =>   i_rs,
       i_DB   =>    i_rt,
       o_Sum       => s_insOut(0),
       o_Carry       => s_carryOut(0),
       o_Overflow   => s_overflow(0));

	
addu: adduIns port map(
	i_DA        => i_rs,
       i_DB        => i_rt,
       o_Sum       => s_insOut(1),
       o_Carry       => s_carryOut(1),
       o_Overflow  => s_unusedOverflow(1));

andInst: andIns port map(
	i_A    => i_rs,
       i_B     => i_rt,
       o_F      => s_insOut(2));

notInst: notIns port map(
	i_A    => i_rs,
       o_F    => s_insOut(3));

norInst: norIns port map(
	i_A    => i_rs,
       i_B     => i_rt,
       o_F     => s_insOut(4));

xorInst: xorIns port map(
	i_A       => i_rs,
       i_B     => i_rt,
       o_F     => s_insOut(5));

orInst: orIns port map(
	i_A      => i_rs,
       i_B     	 => i_rt,
       o_F       => s_insOut(6));

Sltins: Slt port map(
	i_rt   => i_rt,
	i_rs    => i_rs,
        o_rd   => s_insOut(7));

ShiftLL: shiftLeftLogical port map(
	i_In => i_rt,
       i_shamt => i_shiftImm,
       o_Out => s_insOut(8));

ShiftRL : shiftRightLogical port map(
	i_In  => i_rt,
       i_shamt => i_shiftImm,
       o_Out => s_insOut(9));

ShiftRA : shiftRightArithmetic port map(
	i_In  => i_rt,
       i_shamt => i_shiftImm,
       o_Out => s_insOut(10));

sub: subIns port map(
	i_DA        => i_rs,
       i_DB         => i_rt,
       o_Sum        => s_insOut(11),
       o_Carry       => s_carryOut(11),
       o_Overflow   => s_overflow(11));

jumpReg:  jumpRegister port map(
	i_rt     => i_rs,
	i_rs     => i_rt,
        o_outPut    => s_insOut(12));

movn:  move_N port map(
	i_rt   => i_rs,
	i_rs   => i_rt,
        o_rd   => s_insOut(13));

jumpIns: jump port map(
	i_rt   =>  i_rs,
	i_rs   =>  i_rt,
        o_outPut   => s_insOut(14));

jumpAndLinkIns: jumpAndLink port map(
	i_rt    => i_rs,
	i_rs    => i_PCJAL,
        o_outPut   => s_insOut(15));

beqIns: beq port map(
	i_rt   => i_rs,
	i_rs   =>  i_rt,
        o_branchVal    => s_insOut(16));

bneIns: bne port map(
	i_rt  => i_rs,
	i_rs  => i_rt,
        o_branchVal  => s_insOut(17)); 

addi: addiIns port map(
	i_DA        => i_rs,
       i_DB         => i_rt,
       o_Sum        => s_insOut(18),
       o_Carry       => s_carryOut(18),
       o_Overflow   => s_overflow(18));

replQB: repl_qb port map(
	i_8bitIm       => i_replImm,
        o_replOutput   => s_insOut(19));

addiu: addiuIns port map(
	i_DA    =>    i_rs,
       i_DB     => i_rt, 
       o_Sum    => s_insOut(20),
       o_Carry       => s_carryOut(20),
       o_Overflow     => s_unusedOverflow(20));

Slti: SltImm port map(
	i_imm     => i_rt,
	i_rs      => i_rs,
        o_rt      => s_insOut(21));

ori: orImm port map(
	i_imm     => i_rt,
	i_rs      => i_rs,
        o_rt      => s_insOut(22));

Xori: XorImm port map(
	i_imm     => i_rt,
	i_rs      => i_rs,
        o_rt      => s_insOut(23));

lui: loadUpperImm port map(
	i_imm     => i_rt,
	i_rs      => i_rs,
        o_rt      => s_insOut(24));

lw: loadWord port map(
	i_imm  => i_rt,
	i_rs   => i_rs,
	o_Overflow => s_overflow(25),
        o_rt       => s_insOut(25));

sw: storeWord port map(
	i_imm    => i_rt,
	i_rs     => i_rs,
	o_Overflow => s_overflow(26),
        o_rt       => s_insOut(26));

subuInst: subuIns port map(
	i_DA         => i_rs,
       i_DB          => i_rt,
       o_Sum         => s_insOut(27),
       o_Carry       => s_carryOut(27),
       o_Overflow    => s_unusedOverflow(27));

andImmInst : andImmIns port map(
	i_A    => i_rs,
       i_Imm   => i_rt,
       o_F     => s_insOut(28));



ALUMulti: ALUMux port map(
	i_S   => i_AluOpcode,
        iD0 =>   s_insOut,
      	o_O    => o_output);

CarryMux: bit29_1Mux port map(
	i_S   => i_AluOpcode,
        iD0 =>   s_carryOut,
      	o_O    => o_carryOut);

OverflowMux: bit29_1Mux port map(
	i_S   => i_AluOpcode,
        iD0 =>   s_overflow,
      	o_O    => o_overflow);



end structural;