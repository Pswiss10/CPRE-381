library IEEE;
use IEEE.std_logic_1164.all;
use work.TwoDArray.all;

entity nbit32_1Mux is
  port(i_S          : in std_logic_vector(4 downto 0);
       iD0         : in TwoDArray;
       o_O          : out std_logic_vector(31 downto 0));

end nbit32_1Mux;

architecture dataflow of nbit32_1Mux is

begin
	with i_S select 
		o_O <=  iD0(0) when "00000",
			iD0(1) when "00001",
			iD0(2) when "00010",
			iD0(3) when "00011",
			iD0(4) when "00100",
			iD0(5) when "00101",
			iD0(6) when "00110",
			iD0(7) when "00111",
			iD0(8) when "01000",
			iD0(9) when "01001",
			iD0(10) when "01010",
			iD0(11) when "01011",
			iD0(12) when "01100",
			iD0(13) when "01101",
			iD0(14) when "01110",
			iD0(15) when "01111",
			iD0(16) when "10000",
			iD0(17) when "10001",
			iD0(18) when "10010",
			iD0(19) when "10011",
			iD0(20) when "10100",
			iD0(21) when "10101",
			iD0(22) when "10110",
			iD0(23) when "10111",
			iD0(24) when "11000",
			iD0(25) when "11001",
			iD0(26) when "11010",
			iD0(27) when "11011",
			iD0(28) when "11100",
			iD0(29) when "11101",
			iD0(30) when "11110",
			iD0(31) when "11111",
			x"00000000" when others;


  
end dataflow;

