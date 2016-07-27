
library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity instructiondecoder is
  port ( PCplusfour  : in  m32_word;
         readdata1    : in m32_word;
         readdata2    : in m32_word;
         Iadd         : in m32_word;
         inst1        : in m32_5bits;
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
        o_PCplusfour  : out  m32_word;
        o_readdata1   : out m32_word;
        o_readdata2   : out m32_word;
         o_Iadd        :out m32_word;
         o_inst1        : out m32_5bits;
         o_inst2        : out m32_5bits;
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
  
  signal s_PCplusfour, s_readdata1, s_readdata2  :  m32_word;
           
  signal  s_inst1, s_inst2 : m32_5bits;
  signal  s_regwrite, s_regdst, s_alusrc, s_memwrite, s_branch, s_memread : m32_1bit;
  signal s_aluop : m32_2bits;

  begin
  INSTRUCTUIODECODER : process (clock)
  begin
    if (rising_edge(clock)) then
      -- if(reset = '1')
      o_PCplusfour <= PCplusfour;
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
      
   -- elsif(falling_edge(clock)) then
--      o_PCplusfour <= s_PCplusfour;
--      o_readdata1  <= s_readdata1;
--      o_readdata2  <= s_readdata2;
--      o_inst1      <= s_inst1;
--      o_inst2      <= s_inst2;
--      o_RegWrite     <=  s_regwrite;
--      o_Aluop        <=  s_aluop;
--      o_AluSrc       <=  s_alusrc;
--      o_regdst       <=  s_regdst;
--      o_MemWrite     <=  s_memwrite;
--      o_branch       <=  s_branch;
--      o_Memread     <=  s_memread;     
      
    end if;
    
 end process;
 end behavior;  