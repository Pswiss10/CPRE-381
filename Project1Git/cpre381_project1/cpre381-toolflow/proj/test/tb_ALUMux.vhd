library IEEE;
use IEEE.std_logic_1164.all;
use work.TwoDArrayForALU.all;

entity tb_ALUMux is

end tb_ALUMux;



architecture behavior of tb_ALUMux is
  
  -- Calculate the clock period as twice the half-period



  component ALUMux 
  port(i_S          : in std_logic_vector(4 downto 0);
       iD0         : in TwoDArrayForALU;
       o_O          : out std_logic_vector(31 downto 0));
  end component;


signal iD0:  TwoDArrayForALU;
signal i_S  :  std_logic_vector(4 downto 0);
signal o_O :  std_logic_vector(31 downto 0);

begin

  DUT: ALUMux 
  port map(
       i_S     => i_S,
       iD0     => iD0,
       o_O     => o_O);

P_TB: process
  begin
wait for 10 ns;
	iD0(0) <= x"22221111";
	i_S <= "00000";
	
wait for 100 ns;

iD0(0) <= X"ffff8888";
	i_S <= "00001";
	
wait for 100 ns;

iD0(28) <= X"8888ffff";
	i_S <= "11100";
	
wait for 100 ns;

iD0(4) <= X"1111aaaa";
	i_S <= "00100";

wait for 100 ns;

iD0(23) <= X"1111aaaa";
	i_S <= "10111";



wait for 200 ns;
	



end process;

end behavior;