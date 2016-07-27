library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity writeback is
  port( rdata  : in m32_word;
        address : in m32_word;
        regwrite: in m32_1bit;
        clock   : in m32_1bit;
        memtoreg: in m32_1bit;
        muxoutput :in  m32_5bits;
        o_rdata  : out m32_word;
        o_address : out m32_word;
        o_regwrite: out m32_1bit;
        o_memtoreg: out m32_1bit;
        o_muxoutput : out  m32_5bits);
        
      end writeback;
      
    architecture behavior of writeback is
    
    signal s_regwrite, s_memtoreg : m32_1bit;
    signal s_address, s_rdata : m32_word;
    signal s_muxoutput : m32_5bits;
    
    begin 
      WRITEBACK: process(clock)
  begin
    if(rising_edge(clock)) then
      
      s_regwrite <= regwrite;
      s_memtoreg <= memtoreg;
      s_address  <= address;
      s_rdata    <= rdata;
      s_muxoutput <= muxoutput;
      
    elsif(falling_edge(clock)) then
      
      o_regwrite <= s_regwrite;
      o_memtoreg <= s_memtoreg;
      o_address  <= s_address;
      o_rdata    <= s_rdata;
      o_muxoutput <= s_muxoutput;
      
   end if;
 end process;
end behavior;  