library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;
use IEEE.numeric_std.all;

entity exmem is
  port (RegWrite  : in m32_1bit;
        memtoreg  : in m32_1bit;
        memwrite  : in m32_1bit; 
        memread   : in m32_1bit;
        branch    : in m32_1bit;
        addresult  : in m32_word;
        clock     : in m32_1bit;
        aluresult : in m32_word;
        aluzero   : in m32_1bit;
        muxoutput : in  m32_5bits;
        o_branch    : out m32_1bit;
        address     : out m32_word;
        o_memwrite  : out m32_1bit; 
        o_memread   : out m32_1bit;
        o_regwrite  : out m32_1bit;
        o_muxoutput : out m32_5bits;
        o_addresult : out m32_word;
        o_memtoreg  : out m32_1bit;
        o_zero      : out m32_1bit);

end exmem;


architecture behavior of exmem is

signal  s_regwrite, s_memtoreg, s_memwrite, s_branch, s_memread, s_zero : m32_1bit;
signal  s_address, s_addresult : m32_word;
signal  s_muxoutput : m32_5bits;
begin
  EXMEM: process(clock)
  begin
    if(rising_edge(clock)) then
      
      o_regwrite <= RegWrite;
      o_memtoreg <= memtoreg;
      o_memwrite <= memwrite;
      o_branch   <= branch;
      o_memread  <= memread;
      o_muxoutput <= muxoutput;
      address  <= aluresult;
      o_addresult <= addresult;
      o_zero <= aluzero;
      
 -- elsif(falling_edge(clock)) then
--   
--    o_branch    <= s_branch;
--    address     <= s_address;
--    o_memwrite  <= s_memwrite;
--    o_memread   <= s_memread;
--    o_regwrite  <= s_regwrite;
--    o_muxoutput <= s_muxoutput;
--    o_addresult <= s_addresult;
--    o_memtoreg  <= s_memtoreg;
--    o_zero      <= s_zero;
   end if;
    
 end process;
 end behavior;  