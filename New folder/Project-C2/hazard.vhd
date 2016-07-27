library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity hazard is 
port ( exmemread : in m32_1bit;
        if_rs : in m32_5bits;
        if_rt : in m32_5bits;
        ex_rt : in m32_5bits;
        ex_rs : in m32_5bits;
        --inst1 : in m32_5bits;
        stall : out m32_1bit);
       -- o_exmemread : in m32_1bit);
      end hazard;
      
      architecture behavior of hazard is
      begin
        process(exmemread, if_rs, if_rt, ex_rs, ex_rt)
          begin
            if((exmemread = '1') and ((ex_rt = if_rs) or (ex_rt = if_rt))) then
              
              stall<='1';
            else
                  stall<='0';
                  
                end if;
               end process;
               
             end behavior;
               
      --process(clock, reset, stall)
--      begin
--      if(rising_edge(clock)) then
--      if(reset = '1') or (stall ='1')    then
           