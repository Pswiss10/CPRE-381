-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a MIPS_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.MIPS_types.all;

entity MIPS_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  signal s_regRst : std_logic_vector(31 downto 0); --Reset signal for the register file, each bit resets it's corresponding register file
  signal s_regRsOut : std_logic_vector(N-1 downto 0); --Register file output for RS register
  signal s_regRtOut : std_logic_vector(N-1 downto 0); --Register file output for RT register
  signal s_controlOut : std_logic_vector(15 downto 0); --Output from the Control unity
  signal s_immOutput : std_logic_vector(31 downto 0); --Output of the bit extender for the immediate values
  signal s_immMuxOut : std_logic_vector(31 downto 0); --Output of the Immediate value or register Mux before ALU
  signal s_carryOut  : std_logic; --ALU carryOut trigger
  signal s_ALUOut : std_logic_vector(N-1 downto 0); --ALU Output
  signal s_WRITEDST	:std_logic_vector(4 downto 0);
  signal s_JaloDataWrite   :std_logic_vector(31 downto 0);

  signal s_unsignSel : std_logic;      --Control Select bits
  signal s_ALUSrcSel  : std_logic;
  signal s_memToRegSel  : std_logic;
  signal s_memReadSel  : std_logic;
  signal s_regDstSel  : std_logic;
  signal s_jumpSel  : std_logic;
  signal s_branchSel  : std_logic;
  signal s_jumpRegSel : std_logic;
  signal s_jumpLnkSel : std_logic;
  signal s_ALUOpCode : std_logic_vector(4 downto 0);
  signal s_opCode : std_logic_vector(5 downto 0);
  signal s_functionCode : std_logic_vector(5 downto 0);
  signal s_regRsIn : std_logic_vector(4 downto 0);
  signal s_regRtIn : std_logic_vector(4 downto 0);
  signal s_regRdIn : std_logic_vector(4 downto 0);
  signal s_immOrLnkOut : std_logic_vector(31 downto 0);
  signal s_regDst : std_logic_vector(4 downto 0);
signal s_FirstPC		    : std_logic_vector(31 downto 0);

		signal s_HaltID          : std_logic;
		signal s_RegWrAddrID    : std_logic_vector(4 downto 0);
		signal s_InstID : std_logic_vector(31 downto 0);     -- Data value input
        	signal s_PCID   : std_logic_vector(31 downto 0);
		signal s_RegWrID : std_logic;
		signal s_DMemWrID : std_logic;
		signal s_branchAddrID : std_logic_vector(31 downto 0);

		signal s_PCEX2 : std_logic_vector(31 downto 0);
		signal s_overflowEX : std_logic;
        	signal s_ALUSrcSelEX	 : std_logic;
		signal s_ALUOpCodeEX     : std_logic_vector(4 downto 0);
        	signal s_regDstEX        : std_logic_vector(4 downto 0);
		signal s_MemWrEnEX	 : std_logic;
        	signal s_branchSelEX     : std_logic;
		signal s_memToRegSelEX   : std_logic;
		signal s_regRsInEX       : std_logic_vector(4 downto 0);
        	signal s_regRtInEX       : std_logic_vector(4 downto 0);
		signal s_RegWrAddrEX     : std_logic_vector(4 downto 0);
		signal s_JaloDataWriteEx : std_logic_vector(31 downto 0);
		signal s_regRsOutEX      : std_logic_vector(31 downto 0);
        	signal s_regRtOutEX      : std_logic_vector(31 downto 0);
		signal s_immMuxOutEX   	 : std_logic_vector(31 downto 0);
		signal s_jumpSelEX   	 : std_logic;
		signal s_jumpRegSelEX    : std_logic;
		signal s_jumpLnkSelEX    : std_logic;
		signal s_memReadSelEX    : std_logic;
		signal s_regWrEX         : std_logic;
		signal s_PCEX            : std_logic_vector(31 downto 0);
		signal s_branchAddrEX    : std_logic_vector(31 downto 0);
		signal s_jumpAddEX       : std_logic_vector(25 downto 0);
		signal s_HaltEX          : std_logic;
		signal s_BranchForHazard : std_logic;
		signal s_FetchFLushSel   : std_logic;
		signal s_stall           : std_logic_vector(4 downto 0);
		signal s_flushHaz	 : std_logic_vector(4 downto 0);
		signal s_flush           : std_logic_vector(4 downto 0);


	     signal s_readData2MEM	 	: std_logic_vector(31 downto 0);
	     signal s_aluOutMEM		 	: std_logic_vector(31 downto 0);

	     signal s_writeRegMEM	 	: std_logic_vector(4 downto 0);

	-- one bit inputs
	     signal s_overflowMEM			: std_logic;
	     signal s_MemtoRegMEM			: std_logic;
	     signal s_weMemMEM			: std_logic;
	     signal s_weRegMEM			: std_logic;
	     signal s_DMemReadMEM			: std_logic;
	     signal s_haltMEM			: std_logic;
		signal s_immMEM			: std_logic;

	    signal s_memReadDataWB 	: std_logic_vector(31 downto 0);
	    signal s_aluOutWB	 	: std_logic_vector(31 downto 0);
	    signal s_writeRegWB 	: std_logic_vector(4 downto 0);
	    signal s_overflowWB		: std_logic;
	    signal s_MemtoRegWB		: std_logic;
	    signal s_weRegWB		: std_logic;
	    signal s_haltWB		: std_logic;
		signal s_immWB		: std_logic;

	signal s_BranchSelMEM : std_logic;
	signal s_branchSelWB : std_logic;
	signal s_jumpSelMEM : std_logic;
	signal s_jumpSelWB : std_logic;

	signal s_instEX : std_logic_vector(31 downto 0);
	signal s_instMEM : std_logic_vector(31 downto 0);
	signal s_instWB : std_logic_vector(31 downto 0);

signal s_opcodeEX	:  std_logic_vector(5 downto 0);
signal s_opcodeMEM	: std_logic_vector(5 downto 0);
signal s_opcodeWB	: std_logic_vector(5 downto 0);

signal s_RegWr4WB : std_logic;
signal s_RegWrMEM : std_logic;



  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment

	component ALU is
  	port(
		i_rs       : in std_logic_vector(31 downto 0);
		i_rt       : in std_logic_vector(31 downto 0);
		i_shiftImm  : in std_logic_vector(4 downto 0);
		i_AluOpcode : in std_logic_vector(4 downto 0);
		i_replImm   : in std_logic_vector(7 downto 0);
		i_PCJAL     : in std_logic_vector(31 downto 0);
        	o_output   : out std_logic_vector(31 downto 0);   -- Data value output
		o_carryOut : out std_logic;
		o_overflow : out std_logic);

	end component;

	component controlUnit is
  	port(
		i_opCode        : in std_logic_vector(5 downto 0);
		i_funCode          : in std_logic_vector(5 downto 0);     -- Data value input
		o_Halt 			: out std_logic;
        	o_controlOutput          : out std_logic_vector(15 downto 0));   -- Data value output

	end component;

	component RegisterFile32_32 is
  	port(
        	i_Clk         : in std_logic;
        	i_Enable      : in std_logic;
		i_Reset	     : in std_logic_vector (31 downto 0);
        	i_read1       : in std_logic_vector(4 downto 0);     -- Data value input
        	i_read2       : in std_logic_vector(4 downto 0);     -- Data value input
        	i_writeEn     : in std_logic_vector(4 downto 0);
        	i_writeData   : in std_logic_vector(31 downto 0);   -- Data value output
		o_readData1  : out std_logic_vector(31 downto 0);
		o_readData2  : out std_logic_vector(31 downto 0));


	end component;

	component bitExtender is
  	port(
        	i_input         : in std_logic_vector(15 downto 0);
		i_unsigned      : in std_logic;
		o_Output	: out std_logic_vector(31 downto 0));

	end component;

	component Mux32_1 is     --normal 1 bit select line with 2-32bit inputs
 	port(
		i_S        : in std_logic;
        	i_D0       : in std_logic_vector(31 downto 0);
        	i_D1       : in std_logic_vector(31 downto 0);
        	o_O        : out std_logic_vector(31 downto 0));

	end component;

	component mux2t1_5 is
	port(
		i_S        : in std_logic;
        	i_D0       : in std_logic_vector(4 downto 0);
        	i_D1       : in std_logic_vector(4 downto 0);
        	o_O        : out std_logic_vector(4 downto 0));

	end component;

	component andg2 is
	port(
		i_A          : in std_logic;
       		i_B          : in std_logic;
        	o_F          : out std_logic);

	end component;

	component fetch is
		port(   i_CLK		    	    : in std_logic;
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
	end component;

	component IDEX is

  		port( 
	i_Clk        	: in std_logic;     -- Clock input
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
	o_PC            : out std_logic_vector(31 downto 0);
	o_Halt          : out std_logic);

	end component;

component IFID is

  port( i_Clk        	: in std_logic;     -- Clock input
        i_Flush        	: in std_logic;     -- Reset input
	i_Stall         : in std_logic;
        i_Inst	    	: in std_logic_vector(31 downto 0);
	i_PC      	: in std_logic_vector(31 downto 0);
        o_Inst		: out std_logic_vector(31 downto 0);     -- Data value input
        o_PC       : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component EXMEM is
	port(
	     i_CLK		: in std_logic;
	     i_RST		: in std_logic; -- (1 sets reg to 0)
	     i_EN  : in std_logic;

	  --   i_PC_4		: in std_logic_vector(31 downto 0);
	  --   i_finalJumpAddr	: in std_logic_vector(31 downto 0);
	 --    i_branchAddr	: in std_logic_vector(31 downto 0);
	     i_readData2 	: in std_logic_vector(31 downto 0);
	     i_aluOut	 	: in std_logic_vector(31 downto 0);

	     i_writeReg 	: in std_logic_vector(4 downto 0);

	-- one bit inputs
	--     i_zero		: in std_logic;
	     i_overflow		: in std_logic;
	 --    i_jal		: in std_logic;
	     i_MemtoReg		: in std_logic;
	     i_weMem		: in std_logic;
	     i_weReg		: in std_logic;
	     i_DMemRead		: in std_logic;
	 --    i_j		: in std_logic;
	     i_halt		: in std_logic;
		i_imm	:in std_logic;


		i_branch	: in std_logic;
		o_branch	: out std_logic;

		i_jump		: in std_logic;
		o_jump		: out std_logic;

	i_inst		: in std_logic_vector(31 downto 0);
	o_inst		: out std_logic_vector(31 downto 0);

i_opcode	: in std_logic_vector(5 downto 0);
o_opcode	: out std_logic_vector(5 downto 0);
	  --   o_PC_4		: out std_logic_vector(31 downto 0);
	 --    o_finalJumpAddr	: out std_logic_vector(31 downto 0);
	  --   o_branchAddr	: out std_logic_vector(31 downto 0);
	     o_readData2 	: out std_logic_vector(31 downto 0);
	     o_aluOut	 	: out std_logic_vector(31 downto 0);

	     o_writeReg 	: out std_logic_vector(4 downto 0);

	-- one bit outputs
	  --   o_zero		: out std_logic;
	     o_overflow		: out std_logic;
	 --    o_jal		: out std_logic;
	     o_MemtoReg		: out std_logic;
	     o_weMem		: out std_logic;
	     o_weReg		: out std_logic;
	     o_DMemRead		: out std_logic;
	  --   o_j		: out std_logic;
	     o_halt		: out std_logic;
		o_imm	:out std_logic);

end component;

component MEMWB is
	port(i_CLK		: in std_logic;
	     i_RST		: in std_logic; -- (1 sets reg to 0)
	     i_EN  : in std_logic;

	     i_memReadData 	: in std_logic_vector(31 downto 0);
	     i_aluOut	 	: in std_logic_vector(31 downto 0);
	     i_writeReg 	: in std_logic_vector(4 downto 0);
	     i_overflow		: in std_logic;
	     i_MemtoReg		: in std_logic;
	     i_weReg		: in std_logic;
	     i_halt		: in std_logic;
		i_imm	:in std_logic;

		i_branch	: in std_logic;
		o_branch	: out std_logic;

		i_jump		: in std_logic;
		o_jump		: out std_logic;

	i_inst		: in std_logic_vector(31 downto 0);
	o_inst		: out std_logic_vector(31 downto 0);


		i_opcode	: in std_logic_vector(5 downto 0);
		o_opcode	: out std_logic_vector(5 downto 0);
	     o_memReadData 	: out std_logic_vector(31 downto 0);
	     o_aluOut	 	: out std_logic_vector(31 downto 0);
	     o_writeReg 	: out std_logic_vector(4 downto 0);
	     o_overflow		: out std_logic;
	     o_MemtoReg		: out std_logic;
	     o_weReg		: out std_logic;
	     o_halt		: out std_logic;
		o_imm	:out std_logic);


end component;


component HazardController is
  port(
       i_ReadRegRSID          : in std_logic_vector(4 downto 0);     -- Next RS read dstination
	i_ReadRegRTID          : in std_logic_vector(4 downto 0);     -- Next RT read dstination
	i_ReadRegDSTID          : in std_logic_vector(4 downto 0);     -- Next RT read dstination
	i_dstRegEX 	:in std_logic_vector(4 downto 0);     -- Destination for Execution Stage
	i_dstRegMEM 	:in std_logic_vector(4 downto 0);     -- Destination for Mem stage
	i_dstRegWB 	:in std_logic_vector(4 downto 0);     -- Destination for write Back stage
	i_DMEMwr	: in std_logic;	
	i_branchEx	: in std_logic;
	i_branchMEM	: in std_logic;
	i_branchWB	: in std_logic;
	i_JumpEX       : in std_logic;
	i_JumpMEM       : in std_logic;
	i_JumpWB       : in std_logic;
	i_immEX		: in std_logic;
	i_immMEM	: in std_logic;
	i_immWB		: in std_logic;
	i_opcodeMEM	: in std_logic_vector(5 downto 0);
	i_instEX : in std_logic_vector(31 downto 0);
	i_instMEM : in std_logic_vector(31 downto 0);
	i_instWB : in std_logic_vector(31 downto 0);
	i_FirstPC		    : in std_logic_vector(31 downto 0);
	i_RegWr4WB	: in std_logic;
	i_RegWrMEM	: in std_logic;
	o_RegWrMEM	: out std_logic;
	i_opcodeWB	: in std_logic_vector(5 downto 0);
	o_RegWr4WB	: out std_logic;
	o_stall		: out std_logic_vector(4 downto 0);
        o_flush          : out std_logic_vector(4 downto 0));

end component;

begin


s_regRst <= iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST & iRST; --sets all bits of regRST to the iRST input
s_unsignSel <= s_controlOut(13);
s_ALUSrcSel <= s_controlOut(12);
s_memToRegSel <= s_controlOut(11);
s_DMemWrID <= s_controlOut(10);
s_memReadSel <= s_controlOut(9);
s_RegWrID  <= s_controlOut(8);
s_regDstSel <= s_controlOut(7);
s_jumpSel <= s_controlOut(6);
s_branchSel <= s_controlOut(5);
s_ALUOpCode <= s_controlOut(4 downto 0);
s_jumpRegSel <= s_controlOut(15);
s_jumpLnkSel <= s_controlOut(14);
s_opCode <= s_InstID(31 downto 26); 
s_functionCode <= s_InstID(5 downto 0);
s_regRsIn <= s_InstID(25 downto 21);
s_regRtIn <= s_InstID(20 downto 16);
s_regRdIn <= s_InstID(15 downto 11);
s_DMemAddr <= s_aluOutMEM;
s_RegWr <= s_weRegWB;


oALUOut <= s_aluOutWB;
s_halt <= s_HaltWB;
s_Ovfl <= s_overflowWB;
s_RegWrAddr <= s_writeRegWB;
s_DMemWr <= s_weMemMEM;
s_PCEX2 <= s_PCEX;
s_DMemData <= s_readData2MEM;



  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

  Fetch1: fetch
   port map(  i_CLK		=> iCLK, --
              i_RST		=> s_flush(4), --
	      i_EN              => s_stall(4),
 	      i_Branch		=> s_branchSelEX, --
 	      i_Jal		=> s_jumpLnkSelEX, --
 	      i_ZERO		=> s_ALUOut(0), --
 	      i_Jr		=> s_jumpRegSelEX, --
	      i_J		=> s_jumpSelEX, --
	      i_WRITEDST	=> s_RegWrAddrID, --
	      i_JAddr		=> s_jumpAddEX, --rs reg
 	      i_BIAddr		=> s_immOutput, --
	      i_WriteData	=> s_RegWrData, --
	      i_RS		=> s_regRsOutEX, --
	      i_BranchAddrEX	=> s_branchAddrEX,
	      i_PCNextEX	=> s_PCEX,
		i_JalAddr	=> s_jumpAddEX,
		i_PCID		=> s_PCID,
		o_FinalBranchSel    => s_BranchForHazard,
		o_RSTBegin     => s_FetchFLushSel,
	      o_WRITEDST	=> s_WRITEDST, --
	      o_JaloDataWrite   => s_JaloDataWrite, --
		o_BranchAddrInEX => s_branchAddrID,
	      o_insAddr		=> s_NextInstAddr,
		o_PCNextInEX => s_FirstPC); --
     

  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_aluOutMEM(11 downto 2),
             data => s_DMemData,
             we   => s_weMemMEM,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 

	RegFile :  RegisterFile32_32 port map(
        	i_Clk     => iCLK,
        	i_Enable  => s_weRegWB,
		i_Reset	  => s_regRst,
        	i_read1   => s_regRsIn,      --rs register
        	i_read2   => s_regRtIn,   --rt register
        	i_writeEn   => s_RegWrAddr,
        	i_writeData  => s_RegWrData, 
		o_readData1  => s_regRsOut,
		o_readData2  => s_regRtOut);

	FullControlunit: controlUnit port map(
		i_opCode   => s_opCode,
		i_funCode   => s_functionCode, 
		o_Halt      => s_HaltID, 
        	o_controlOutput    => s_controlOut);   -- Data value output

	RegWriteDest : mux2t1_5 port map(
		i_S       =>  s_regDstSel,
        	i_D0      =>  s_regRtIn,
        	i_D1      =>  s_regRdIn,
        	o_O       =>  s_regDst);


	RegJALDest : mux2t1_5 port map(
		i_S 	=> s_jumpLnkSel,
		i_D0  	=> s_regDst,
		i_D1 	=> "11111",
		o_O	=> s_RegWrAddrID);

	FLushSelMux : mux2t1_5 port map(
		i_S 	=> iRST,
		i_D0  	=> s_flushHaz,
		i_D1 	=> "11111",
		o_O	=> s_flush);
		

	signExt : bitExtender port map(
        	i_input    => s_InstID(15 downto 0),
		i_unsigned  => s_unsignSel,
		o_Output     => s_immOutput);

	JALOrImmed : Mux32_1 port map(
		i_S    =>  s_jumpLnkSel,
        	i_D0   =>  s_immOutput,
        	i_D1   =>  s_PCID,
        	o_O    =>  s_immOrLnkOut);

	ImmMux : Mux32_1 port map(
		i_S    =>  s_ALUSrcSelEX,
        	i_D0   =>  s_regRtOutEX,
        	i_D1   =>  s_immMuxOutEX,
        	o_O    =>  s_immMuxOut);

	ALUDesign : ALU port map(
		i_rs     => s_regRsOutEX,
		i_rt     => s_immMuxOut,
		i_shiftImm  => s_jumpAddEX(10 downto 6),
		i_AluOpcode => s_ALUOpCodeEX,
		i_replImm   => s_jumpAddEX(23 downto 16),
		i_PCJAL => s_immMuxOut,
        	o_output    => s_ALUOut,  -- ALU output signal
		o_carryOut  => s_carryOut,
		o_overflow => s_overflowEX);

	DmemOutMux: Mux32_1 port map(
		i_S    =>  s_MemtoRegWB,
        	i_D0   =>  s_aluOutWB, --ALU OutPut signal
        	i_D1   =>  s_memReadDataWB,
        	o_O    =>  s_RegWrData);

	IDEXRegisters: IDEX port map( 

		i_Clk      =>  iCLK,
       		i_RST      =>  s_flush(2),
		i_Stall    =>  s_stall(2), --Don't know what to put here

        	i_ALUSrcSel	=>  s_ALUSrcSel,
		i_ALUOpCode     =>  s_ALUOpCode,
        	i_regDst        =>  s_regDst,
		i_MemWrEn	=>  s_DMemWrID,
        	i_branchSel     =>  s_branchSel,
		i_memToRegSel   =>  s_memToRegSel,
		i_regRsIn       =>  s_regRsIn,
        	i_regRtIn       =>  s_regRtIn,
		i_RegWrAddr    	=>  s_RegWrAddrID,
		i_JaloDataWrite =>  s_JaloDataWrite,
		i_regRsOut      => s_regRsOut,
        	i_regRtOut      => s_regRtOut,
		i_immMuxOut   	=> s_immOrLnkOut,
		i_jumpAddr      => s_InstID(25 downto 0),
		i_branchAddr    => s_branchAddrID,
		i_jumpSel     	=> s_jumpSel,
		i_jumpRegSel    => s_jumpRegSel,
		i_jalSel    	=> s_jumpLnkSel,
		i_memReadSel    => s_memReadSel,
		i_regWr         => s_RegWrID,
		i_PC            => s_PCID,
		i_Halt          => s_HaltID,
	i_inst		=> s_instID,
	o_inst		=> s_instEX,

	i_opcode	=> s_opcode,
	o_opcode	=> s_opcodeEX,

        	o_ALUSrcSel	=> s_ALUSrcSelEX,
		o_ALUOpCode     => s_ALUOpCodeEX,
        	o_regDst        => s_regDstEX,
		o_MemWrEn	=> s_MemWrEnEX,
        	o_branchSel     => s_branchSelEX,
		o_memToRegSel   => s_memToRegSelEX,
		o_regRsIn       => s_regRsInEX,
        	o_regRtIn       => s_regRtInEX,
		o_RegWrAddr    	=> s_regWrAddrEX,
		o_JaloDataWrite => s_JaloDataWriteEX,
		o_regRsOut      => s_regRsOutEX,
        	o_regRtOut      => s_regRtOutEX,
		o_immMuxOut   	=> s_immMuxOutEX,
		o_jumpAddr      => s_jumpAddEX,
		o_branchAddr    => s_branchAddrEX,
		o_jumpSel     	=> s_jumpSelEX,
		o_jumpRegSel    => s_jumpRegSelEX,
		o_jalSel    	=> s_jumpLnkSelEX,
		o_memReadSel    => s_memReadSelEX,
		o_regWr         => s_regWrEX,
		o_PC            => s_PCEX,
		o_Halt          => s_HaltEX);

	IFIDRegisters : IFID port map( 
		i_Clk        => iCLK,
        	i_Flush      => s_flush(3),
		i_Stall      => s_stall(3), --ADD STALL
        	i_Inst	     => s_Inst,
		i_PC         => s_FirstPC,
        	o_Inst	     => s_InstID,     -- Data value input
        	o_PC         => s_PCID);   -- Data value output
EXMEMRegisters : EXMEM	port map(
	     i_CLK		=> iCLK,
	     i_RST		=> s_flush(1),
	     i_EN               => s_stall(1),

	     i_readData2 	=> s_regRtOutEX,
	     i_aluOut	 	=> s_ALUOut,

	     i_writeReg 	=> s_regWrAddrEX,

	-- one bit inputs

	     i_overflow		=> s_overflowEX,
	     i_MemtoReg		=> s_memToRegSelEX,
	     i_weMem		=> s_MemWrEnEX,
	     i_weReg		=> s_RegWr4WB,
	     i_DMemRead 	=> s_memReadSelEX,

	     i_halt		=> s_HaltEX,
		i_imm		=> s_ALUSrcSelEX,

		i_branch	=> s_BranchForHazard,
		o_branch	=> s_branchSelMEM,

		i_jump		=> s_jumpSelEX,
		o_jump		=> s_jumpSelMEM,
		

	i_inst		=> s_instEX,
	o_inst		=> 	s_instMEM,

	i_opcode	=> s_opcodeEX,
	o_opcode	=> s_opcodeMEM,
	     o_readData2 	=> s_readData2MEM,
	     o_aluOut	 	=> s_aluOutMEM,

	     o_writeReg 	=> s_writeRegMEM,

	-- one bit outputs

	     o_overflow		=> s_overflowMEM,
	     o_MemtoReg		=> s_MemtoRegMEM,
	     o_weMem		=> s_weMemMEM,
	     o_weReg		=> s_weRegMEM,
	     o_DMemRead		=> s_DMemReadMEM,

	     o_halt		=> s_HaltMEM,
		o_imm		=> s_immMEM);

MEMWBRegisters : MEMWB port map(
	     i_CLK		=> iCLK,
	     i_RST		=> s_flush(0),
	     i_EN               => s_stall(0),

	     i_memReadData 	=> s_DMemOut,
	     i_aluOut	 	=> s_aluOutMEM,
	     i_writeReg 	=> s_writeRegMEM,
	     i_overflow		=> s_overflowMEM,
	     i_MemtoReg		=> s_MemtoRegMEM,
	     i_weReg		=> s_RegWrMEM,
	     i_halt		=> s_HaltMEM,
		i_imm		=> s_immMEM,

		i_branch	=> s_BranchSelMEM,
		o_branch	=> s_branchSelWB,

		i_jump		=> s_jumpSelMEM,
		o_jump		=> s_jumpSelWB,


	i_inst		=> s_instMEM,
	o_inst		=> s_instWB,

	i_opcode 	=> s_opcodeMEM,
	o_opcode	=> s_opcodeWB,

	     o_memReadData 	=> s_memReadDataWB,
	     o_aluOut	 	=> s_aluOutWB,
	     o_writeReg 	=> s_writeRegWB,
	     o_overflow		=> s_overflowWB,
	     o_MemtoReg		=> s_MemtoRegWB,
	     o_weReg		=> s_weRegWB,
	     o_halt		=> s_HaltWB,
		o_imm 		=> s_immWB);


HazardUnitNew: HazardController port map(
        i_ReadRegRSID  => s_regRsIn,
	i_ReadRegRTID  => s_regRtIn,
	i_ReadRegDSTID => s_RegWrAddrID,
	i_dstRegEX     => s_RegWrAddrEX,
	i_dstRegMEM    => s_writeRegMEM,
	i_dstRegWB     => s_writeRegWB,
	i_DMEMwr	=> s_weMemMEM,
	i_branchEX    => s_BranchForHazard,
	i_branchMEM	=> s_BranchSelMEM,
	i_branchWB	=> s_branchSelWB,
	i_JumpEX       => s_jumpSelEX,
	i_JumpMEM      => s_jumpSelMEM,
	i_JumpWB       => s_jumpSelWB,
	i_immEX	       => s_ALUSrcSelEX,
	i_immMEM	=> s_immMem,
	i_immWB		=> s_immWB,
	i_instEX 	=> s_instEX,
	i_instMEM => s_instMEM,
	i_instWB 	=> s_instWB,
	i_FirstPC	=> s_FirstPC,
	i_RegWr4WB	=> s_regWrEX,
	i_RegWrMEM	=> s_weRegMEM,
	o_RegWrMEM	=> s_RegWrMEM,
	i_opcodeMEM	=> s_opcodeMEM,	
	i_opcodeWB	=> s_opcodeWB,
	o_RegWr4WB	=> s_RegWr4WB,
	o_stall	       => s_stall,
        o_flush        => s_flushHaz); 



end structure;
