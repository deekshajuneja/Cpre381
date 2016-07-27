library IEEE;
use IEEE.std_logic_1164.all;

entity mux1 is
generic(N : integer := 32);
  port(i_A         : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       i_S         : in std_logic;
       o_E         : out std_logic_vector(N-1 downto 0));

end mux1;


architecture dataflow of mux1 is


begin
    
    process(i_A, i_B, i_S)
      begin
        
        if(i_S='0') then
           o_E <= i_A;
           
         else
           o_E <= i_B;
         end if;
       end process;
      

end dataflow;