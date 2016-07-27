library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity slt is
  port( in_A : in std_logic;
        in_B : in std_logic;
        o_C  : out std_logic);
        
    end slt;
    
    architecture dataflow of slt is 
    begin
     
     o_c <= '1' when in_A < in_B else
           '0';
    end dataflow;