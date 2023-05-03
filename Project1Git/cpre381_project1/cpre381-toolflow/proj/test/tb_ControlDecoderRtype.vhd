library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
--library std;
--use std.env.all;                -- For hierarchical/external signals
--use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_ControlDecoderRtype is

end tb_ControlDecoderRtype;

architecture mixed of tb_ControlDecoderRtype is


-- We will be instantiating our design under test (DUT), so we need to specify its
-- component interface.
-- TODO: change component declaration as needed.
component ControlDecoderRtype is

port(
	i_write : in std_logic;
        i_reg   : in std_logic_vector(5 downto 0);
	o_data  : out std_logic_vector(12 downto 0));


end component;
	
	signal i_write : std_logic;
	signal i_reg   : std_logic_vector(5 downto 0);
	signal o_data  : std_logic_vector(12 downto 0);


begin
ControlTestRtype  : ControlDecoderRtype
  port map(

	i_write => i_write,
        i_reg  => i_reg,
	o_data => o_data);


--mem load -infile dmem.hex -format hex /tb_dmem/dmem/ram

  P_TEST_CASES: process
  begin

	i_write <= '1';

	i_reg <= "000000";
	
	wait for 50 ns;

	i_reg <= "000001";
	
	wait for 50 ns;

	i_reg <= "000010";
	
	wait for 50 ns;

	i_reg <= "000011";
	
	wait for 50 ns;

	i_reg <= "000100";
	
	wait for 50 ns;

	i_reg <= "000101";
	
	wait for 50 ns;

	i_reg <= "000110";
	
	wait for 50 ns;

	i_reg <= "000111";
	
	wait for 50 ns;

	i_reg <= "001000";
	
	wait for 50 ns;

	i_reg <= "001001";
	
	wait for 50 ns;

	i_reg <= "001010";
	
	wait for 50 ns;

	i_reg <= "001011";
	
	wait for 50 ns;

	i_reg <= "001100";
	
	wait for 50 ns;

	i_reg <= "001101";
	
	wait for 50 ns;

	i_reg <= "001110";
	
	wait for 50 ns;

	i_reg <= "001111";
	
	wait for 50 ns;

	i_write <= '0';

	i_reg <= "000000";
	
	wait for 50 ns;

	i_reg <= "000001";
	
	wait for 50 ns;

	i_reg <= "000010";
	
	wait for 50 ns;

	i_reg <= "000011";
	
	wait for 50 ns;

end process;



end mixed;




