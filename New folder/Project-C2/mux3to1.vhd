library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;



entity mux3to1 is

generic (M    : integer := 32);    -- Number of bits in the inputs and output
    port (input0  : in m32_vector(M-1 downto 0);
          input1  : in m32_vector(M-1 downto 0);
          input2  : in m32_vector(M-1 downto 0);
          sel     : in m32_2bits;
          output  : out m32_vector(M-1 downto 0));
end mux3to1;


architecture dataflow of mux3to1 is

begin
  
  with sel select

output <= input0 when "00",
          input1 when "01",
          input2 when others;
          
end dataflow;