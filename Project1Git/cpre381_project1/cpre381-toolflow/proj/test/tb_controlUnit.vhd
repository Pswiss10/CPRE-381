
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
--library std;
--use std.env.all;                -- For hierarchical/external signals
--use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_controlUnit is

end tb_controlUnit;

architecture mixed of tb_controlUnit is


-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component controlUnit is

port(
	i_opCode        : in std_logic_vector(5 downto 0);
	i_funCode          : in std_logic_vector(5 downto 0);     -- Data value input
        o_controlOutput          : out std_logic_vector(13 downto 0));   -- Data value output




end component;

	signal i_opCode        : std_logic_vector(5 downto 0);
	signal i_funCode          : std_logic_vector(5 downto 0);     -- Data value input
        signal o_controlOutput          : std_logic_vector(13 downto 0);   -- Data value output




begin
ControlUnitTest  : controlUnit
  port map(

        i_opCode  => i_opCode,
	i_funCode => i_funCode,
	o_controlOutput => o_controlOutput);


--mem load -infile dmem.hex -format hex /tb_dmem/dmem/ram

  P_TEST_CASES: process
  begin

	i_opCode <= "000000";
	i_funCode <= "000000";  --Output Should be "0000110000000"

	wait for 50 ns;

	i_opCode <= "000000";
	i_funCode <= "000101";  --Output Should be "0000110000101"

	wait for 50 ns;

	i_opCode <= "000000";
	i_funCode <= "001100";  --Output Should be "1000100001101"

	wait for 50 ns;

	i_opCode <= "000000";
	i_funCode <= "001001";  --Output Should be "0000110001001"

	wait for 50 ns;

	i_opCode <= "000001";
	i_funCode <= "000000";  --Output Should be "1000001001110"

	wait for 50 ns;

	i_opCode <= "000100";
	i_funCode <= "010010";  --Output Should be "0000000110001"

	wait for 50 ns;

	i_opCode <= "001010";
	i_funCode <= "111111";  --Output Should be "1000100010111"

	wait for 50 ns;

	i_opCode <= "000110";
	i_funCode <= "000000"; --Output Should be "1000110010011"

	wait for 50 ns;
	

end process;



end mixed;


