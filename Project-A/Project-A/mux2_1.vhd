library IEEE;
use IEEE.std_logic_1164.all;



entity mux2_1 is

port( 
         in0    : in  std_logic_vector (31 downto 0);
         in1    : in  std_logic_vector (31 downto 0);          
         ctl    : in  std_logic;
         result : out std_logic_vector (31 downto 0));

end mux2_1;


architecture dataflow of mux2_1 is

begin
  
  with ctl select
  
result <= in0 when '0',
          in1 when others;
          
end dataflow;