library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;



entity mux2to1 is

--generic (M    : integer := 1);    -- Number of bits in the inputs and output
    port (input0  : in m32_word;
          input1  : in m32_word;
          sel     : in m32_1bit;
          output  : out m32_word);
end mux2to1;


architecture dataflow of mux2to1 is

begin
  
  with sel select

output <= input0 when '0',
          input1 when others;
          
end dataflow;