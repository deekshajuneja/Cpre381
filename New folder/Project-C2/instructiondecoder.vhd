
library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity instructiondecoder is
  port ( --PCplusfour  : in  m32_word;
         readdata1    : in m32_word;
         readdata2    : in m32_word;
         Iadd         : in m32_word;
         inst1        : in m32_5bits;
         rs          : in m32_5bits;
         rt          : in m32_5bits;
         inst2        : in m32_5bits;
         RegWrite     : in m32_1bit;
         AluSrc       : in m32_1bit;
         Aluop        : in m32_2bits;
         Regdst       : in m32_1bit;
         MemWrite     : in m32_1bit;
         branch       : in m32_1bit;
         memread      : in m32_1bit;
         memtoreg     : in m32_1bit;
         clock        : in  m32_1bit;
       -- o_PCplusfour  : out  m32_word;
        o_readdata1   : out m32_word;
        o_readdata2   : out m32_word;
         o_Iadd        :out m32_word;
         o_inst1        : out m32_5bits;
         o_inst2        : out m32_5bits;
         ex_rs        : out m32_5bits;
         ex_rt         : out m32_5bits;
         o_RegWrite     : out m32_1bit;
         o_AluSrc       : out m32_1bit;
         o_Aluop        : out m32_2bits;
         o_Regdst       : out m32_1bit;
         o_memtoreg     : out m32_1bit;
         o_MemWrite     : out m32_1bit;
         o_branch       : out m32_1bit;
         o_memread      : out m32_1bit);
         
  end instructiondecoder; 
  
  
  
  architecture behavior of instructiondecoder is
  

  begin
  INSTRUCTUIODECODER : process (clock)
  begin
    if (rising_edge(clock)) then
      -- if(reset = '1')
      --o_PCplusfour <= PCplusfour;
      o_readdata1  <= readdata1;
      o_readdata2  <= readdata2;
      o_inst1  <= inst1;
      o_inst2  <= inst2;
      o_regwrite     <=  RegWrite;
      o_aluop        <=  Aluop;
      o_alusrc       <=  Alusrc;
      o_regdst       <=  Regdst;
      o_memwrite     <=  Memwrite;
      o_branch       <=  branch;
      o_memread     <=  memread;    
      o_memtoreg    <=  memtoreg;
      ex_rs         <= rs;
      ex_rt         <= rt;
  
      
    end if;
    
 end process;
 end behavior;  