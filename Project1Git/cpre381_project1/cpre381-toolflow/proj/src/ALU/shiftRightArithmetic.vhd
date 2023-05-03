------------------------------------------------------------
-- Jack Sebahar
-- CPRE 381 Project 1
-- This file implements the sra op
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity shiftRightArithmetic is
  port(i_In : in std_logic_vector(31 downto 0);
       i_shamt : in std_logic_vector(4 downto 0);
       o_Out : out std_logic_vector(31 downto 0));
end shiftRightArithmetic;

architecture structural of shiftRightArithmetic is

  component mux2t1
    port(i_S: in std_logic;
         i_D0: in std_logic;
         i_D1: in std_logic;
         o_O: out std_logic);
  end component;

signal s_shift1 : std_logic_vector(31 downto 0);
signal s_shift2 : std_logic_vector(31 downto 0);
signal s_shift4 : std_logic_vector(31 downto 0);
signal s_shift8 : std_logic_vector(31 downto 0);

begin

-- 1 bit shift

  shift1ext:
    mux2t1 port map(i_S => i_shamt(0),
                    i_D0 => i_In(31),
                    i_D1 => i_In(31),
                    o_O => s_shift1(31));

  shift1: for i in 0 to 30 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(0),
                    i_D0 => i_In(i),
                    i_D1 => i_In(i+1),
                    o_O => s_shift1(i));
  end generate shift1;

-- 2 bit shift

  shift2ext: for i in 30 to 31 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(1),
                    i_D0 => s_shift1(i),
                    i_D1 => i_In(31),
                    o_O => s_shift2(i));
  end generate shift2ext;

  shift2: for i in 0 to 29 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(1),
                    i_D0 => s_shift1(i),
                    i_D1 => s_shift1(i+2),
                    o_O => s_shift2(i));
  end generate shift2;

-- 4 bit shift

  shift4ext: for i in 28 to 31 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(2),
                    i_D0 => s_shift2(i),
                    i_D1 => i_In(31),
                    o_O => s_shift4(i));
  end generate shift4ext;

  shift4: for i in 0 to 27 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(2),
                    i_D0 => s_shift2(i),
                    i_D1 => s_shift2(i+4),
                    o_O => s_shift4(i));
  end generate shift4;

-- 8 bit shift

  shift8ext: for i in 24 to 31 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(3),
                    i_D0 => s_shift4(i),
                    i_D1 => i_In(31),
                    o_O => s_shift8(i));
  end generate shift8ext;

  shift8: for i in 0 to 23 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(3),
                    i_D0 => s_shift4(i),
                    i_D1 => s_shift4(i+8),
                    o_O => s_shift8(i));
  end generate shift8;

-- 16 bit shift

  shift16ext: for i in 16 to 31 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(4),
                    i_D0 => s_shift8(i),
                    i_D1 => i_In(31),
                    o_O => o_Out(i));
  end generate shift16ext;

  shift16: for i in 0 to 15 generate shiftRightArithmetic:
    mux2t1 port map(i_S => i_shamt(4),
                    i_D0 => s_shift8(i),
                    i_D1 => s_shift8(i+16),
                    o_O => o_Out(i));
  end generate shift16;

end structural;