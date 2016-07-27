
library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;
use IEEE.numeric_std.all;

entity instructionfetch is
  port (inst        : in  m32_word;     -- Instruction
        PCplusfour  : in  m32_word;
        WE          : in  m32_1bit;
        clock       : in  m32_1bit;
        reset       : in  m32_1bit;
        o_PCplusfour: out m32_word;
        opcode      : out m32_6bits; 
        rs          : out m32_5bits;
        rt          : out m32_5bits;
        inst1       : out m32_5bits;
        inst2       : out m32_5bits;
        Iadd        : out  m32_halfword);

end instructionfetch;






architecture behavior of instructionfetch is
signal s_opcode : m32_6bits;
signal s_plusfour : m32_word;
signal s_rs, s_rt, s_inst1, s_inst2 : m32_5bits;
signal s_iadd : m32_halfword;

begin
  INSTRUCTUIONFETCH : process (clock)
  begin
    if (rising_edge(clock)) then
        if (reset = '1') then
        -- Clear all bits of latch
        opcode <= std_logic_vector(to_unsigned(0, opcode'length));
        rs     <= std_logic_vector(to_unsigned(0, rs'length));
        rt     <= std_logic_vector(to_unsigned(0, rt'length));
        inst1  <= std_logic_vector(to_unsigned(0, inst1'length));
        inst2  <= std_logic_vector(to_unsigned(0, inst2'length));
        iadd   <= std_logic_vector(to_unsigned(0, Iadd'length));
       
        elsif (WE = '1') then
        
        opcode <= inst(31 downto 26);
        rs     <= inst(25 downto 21);
        rt     <= inst(20 downto 16);
        inst1  <= inst(15 downto 11);
        inst2  <= inst(20 downto 16);   
        Iadd   <= inst(15 downto 0);
        o_PCplusfour <= PCplusfour;
        
   --elsif(falling_edge(clock)) then
--     -- if(reset = '1')
--      
--      opcode <= s_opcode;
--      rs     <= s_rs;
--      rt     <= s_rt;
--      inst1  <= s_inst1;
--      inst2  <= s_inst2;
--      Iadd   <= s_iadd;
--      O_PCplusfour <= s_plusfour;
--      
      --opcode <= "000000";
--      rs     <= "00000";
--      rt     <= "00000";
--      inst1    <= "00000";
--      inst2    <= "00000";
--      Iadd <= "0000000000000000";
  --    
--    else
--      
--       opcode <= s_opcode;
--      rs     <= s_rs;
--      rt     <= s_rt;
--      inst1    <= s_inst1;
--      inst2    <= s_inst2;
--      Iadd <= s_iadd;
--      O_PCplusfour <= s_plusfour;
         
  end if;
    end if;
  end process;

end behavior;



















--architecture structure of  instructionfetch is
--
--
--signal rs, rt, inst1, inst2  :  m32_5bits;
--signal Iadd :  m32_halfword;
--signal Jadd :  m32_26bits;
--signal pcplusfour : m32_word;
--
--begin
--  
--   SPLIT : block                     -- Split the instructions into fields
--  begin
--    opcode <= inst(31 downto 26);
--    rs     <= inst(25 downto 21);
--    rt     <= inst(20 downto 16);
--    inst1  <= inst(15 downto 11);
--    inst2  <= inst(20 downto 16);   
--    Iadd   <= inst(15 downto 0);
--   
--    -- More code here
--  end block;
--  
  --end structure;