library IEEE;
use IEEE.std_logic_1164.all;



entity HazardController is
  port(
       i_ReadRegRSID          : in std_logic_vector(4 downto 0);     -- Next RS read dstination
	i_ReadRegRTID          : in std_logic_vector(4 downto 0);     -- Next RT read dstination
	i_ReadRegDSTID          : in std_logic_vector(4 downto 0);     -- Next RT read dstination
	i_dstRegEX 	:in std_logic_vector(4 downto 0);     -- Destination for Execution Stage
	i_dstRegMEM 	:in std_logic_vector(4 downto 0);     -- Destination for Mem stage
	i_dstRegWB 	:in std_logic_vector(4 downto 0);     -- Destination for write Back stage
	i_branchID	: in std_logic;	
	i_branchEx	: in std_logic;
	i_branchMEM	: in std_logic;
	i_branchWB	: in std_logic;
	i_JumpEX       : in std_logic;
	i_JumpMEM       : in std_logic;
	i_JumpWB       : in std_logic;
	i_immEX		: in std_logic;
	i_immMEM	: in std_logic;
	i_immWB		: in std_logic;
	i_instEX : in std_logic_vector(31 downto 0);
	i_instMEM : in std_logic_vector(31 downto 0);
	i_instWB : in std_logic_vector(31 downto 0);
	i_FirstPC		    : in std_logic_vector(31 downto 0);
	i_RegWr4WB	: in std_logic;
	o_RegWr4WB	: out std_logic;
	o_stall		: out std_logic_vector(4 downto 0);
        o_flush          : out std_logic_vector(4 downto 0));   

end HazardController;



architecture dataflow of HazardController is 

signal s1 : std_logic_vector(7 downto 0);
	begin 

Process(i_ReadRegRSID, i_ReadRegRTID, i_ReadRegDSTID, i_dstRegEX, i_dstRegMEM , i_dstRegWB, i_branchEX, i_branchMEM, i_branchWB, i_jumpEX, i_jumpMEM, i_jumpWB, i_immEX, i_immMEM, i_immWB, i_instEX , i_instMEM , i_instWB, i_RegWr4WB)

begin
--if (not (i_FirstPC = x"00400004" or i_FirstPC = x"00400008")) then
	if ((i_branchWB = '1')) then
			o_stall <= "11001";
			o_flush <= "00110";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"00";	

	elsif ((i_branchMEM = '1')) then
			o_stall <= "11001";
			o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"01";
	elsif ((i_branchEX = '1')) then
			o_stall <= "10011";
			o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"02";
	elsif (( i_jumpWB = '1')) then
			o_stall <= "00001";
			o_flush <= "01110";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"10";	

	elsif (( i_jumpMEM = '1')) then
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"11";
	elsif (( i_jumpEX = '1')) then
			o_stall <= "10111";
			o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"12";

	


	elsif (i_immex = '1' and i_ReadRegRSID = i_dstRegEX and not (i_dstRegEX = i_dstRegMEM)) then
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"05";
		elsif (i_immMEM = '1' and i_ReadRegRSID = i_dstRegMEM and (not (i_dstRegMEM = i_dstRegWB)) and ((i_instMEM = i_instEX) or i_instEX = x"00000000")) then
			o_stall <= "00001";
			o_flush <= "00100";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"04";
		elsif (i_immMEM = '1' and i_ReadRegRSID = i_dstRegMEM and (not (i_dstRegMEM = i_dstRegWB)) and (not (i_instMEM = i_instEX))) then
		
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= '0';
			s1 <= x"14";
	
		elsif ( i_immWB = '1'  and (i_ReadRegRSID = i_dstRegWB) and (not (i_dstRegMEM = i_dstRegWB)) and ((i_instMEM = i_instWB) or i_instMEM = x"00000000")) then
			o_stall <= "00001";
			o_flush <= "00010";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"03";
		elsif (i_immWB = '1'  and (i_ReadRegRSID = i_dstRegWB) and (not (i_dstRegMEM = i_dstRegWB)) and (not (i_instMEM = i_instWB))) then
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= '0';
			s1 <= x"13";
		
		elsif (((i_ReadRegRSID = i_dstRegWB) or (i_ReadRegRTID = i_dstRegWB))and ((not (i_ReadRegRSID = "00000")) or (not (i_ReadRegRTID = "00000")))  and (not (i_dstRegWB = "00000")) and ((i_instMEM = i_instWB) or i_instMEM = x"00000000")) then 
			o_stall <= "00001";
			o_flush <= "00010";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"07";
		elsif (((i_ReadRegRSID = i_dstRegWB) or (i_ReadRegRTID = i_dstRegWB))and ((not (i_ReadRegRSID = "00000")) or (not (i_ReadRegRTID = "00000")))  and (not (i_dstRegWB = "00000")) and (not (i_instMEM = i_instWB))) then 
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= '0';
			s1 <= x"17";
		
		elsif (((i_ReadRegRSID = i_dstRegMEM) or (i_ReadRegRTID = i_dstRegMEM))and ((not (i_ReadRegRSID = "00000")) or (not (i_ReadRegRTID = "00000")))  and (not (i_dstRegMEM = "00000")) and ((i_instMEM = i_instEX) or i_instEX = x"00000000")) then 
			o_stall <= "00001";
			o_flush <=  "00100";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"08";

		elsif (((i_ReadRegRSID = i_dstRegMEM) or (i_ReadRegRTID = i_dstRegMEM))and ((not (i_ReadRegRSID = "00000")) or (not (i_ReadRegRTID = "00000")))  and (not (i_dstRegMEM = "00000")) and (not (i_instMEM = i_instEX))) then 
			o_stall <= "00011";
			o_flush <= "00000";
			o_RegWr4WB <= '0';
			s1 <= x"18";
		

	elsif (((i_ReadRegRSID = i_dstRegEX) or (i_ReadRegRTID = i_dstRegEX)) and ( (not (i_ReadRegRSID = "00000")) or (not (i_ReadRegRTID = "00000"))) and (not (i_dstRegEX = "00000"))) then 
			o_stall <= "00011";
		  	o_flush <= "00000";
			o_RegWr4WB <= i_RegWr4WB;
			s1 <= x"09";
	
	
	else 
		  o_stall <= "11111";
		 o_flush <= "00000";
		o_RegWr4WB <= i_RegWr4WB;
		s1 <= x"0A";
		
	end if;	
--end if;

End Process;

end dataflow;
