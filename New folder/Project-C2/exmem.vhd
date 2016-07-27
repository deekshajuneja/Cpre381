library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;


entity exmem is
  port(RegWrite  : in m32_1bit;
        memtoreg  : in m32_1bit;
        memwrite  : in m32_1bit; 
        memread   : in m32_1bit;
        clock     : in m32_1bit;
        aluresult : in m32_word;
        muxoutput0 : in  m32_5bits;  -- forward_c
        muxoutput1  : in m32_word;
        address     : out m32_word;
        o_memwrite  : out m32_1bit; 
        o_memread   : out m32_1bit;
        o_regwrite  : out m32_1bit;
        o_muxoutput0 : out m32_5bits;
        o_muxoutput1 : out m32_word;
        o_memtoreg  : out m32_1bit);
        

end exmem;


architecture behavior of exmem is

begin
  EXMEM: process(clock)
  begin
    if(rising_edge(clock)) then
      
      o_regwrite <= RegWrite;
      o_memtoreg <= memtoreg;
      o_memwrite <= memwrite;
      --o_branch   <= branch;
      o_memread  <= memread;
      o_muxoutput0 <= muxoutput0;
      address  <= aluresult;
     -- o_addresult <= addresult;
      o_muxoutput1 <= muxoutput1;
      --o_zero <= aluzero;

   end if;
    
 end process;
 end behavior;  