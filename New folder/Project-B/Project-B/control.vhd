-- control.vhd: CprE 381 F13 template file
-- 
-- The main control unit of MIPS
-- 
-- Note: This is a partial example, with nine control signals (no Jump
-- singal)

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mips32.all;


entity control is
  port (
        op_code     : in  m32_6bits;
        reg_dst     : out m32_1bit;
        alu_src     : out m32_1bit;
        mem_to_reg  : out m32_1bit;
        reg_write   : out m32_1bit;
        mem_read    : out m32_1bit;
        mem_write   : out m32_1bit;
        branch      : out m32_1bit;
        alu_op      : out m32_2bits;
        jump        : out m32_1bit);
end control;

architecture rom of control is
  subtype code_t is m32_vector(9 downto 0);
  type rom_t is array (0 to 63) of code_t;
 --
                 
                   


  -- The ROM content
  -- Format: reg_dst, alu_src, mem_to_reg, reg_write, mem_read, 
  -- mem_write, branch, alu_op(1), alu_op(0), jump
 
 
  signal rom : rom_t := (
    -- More code here
    
    0 => "1001000100", --rtype
   35 => "0111100000", --lw
   43 => "0100010000", --sw
    4 => "0000001010", -- beq
    2 => "0000000001", --jump
    
    
    others=>"0000000000");



begin
   (reg_dst, alu_src, mem_to_reg, reg_write, mem_read, 
   mem_write, branch, alu_op(1), alu_op(0), jump) 
     <= rom(to_integer(unsigned(op_code)));
     
     
     
     

      
 
end rom;

