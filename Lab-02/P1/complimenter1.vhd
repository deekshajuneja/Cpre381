library IEEE;
use IEEE.std_logic_1164.all;

entity complimenter1 is
generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
     o_E          : out std_logic_vector(N-1 downto 0));

end complimenter1;

architecture dataflow of complimenter1 is
begin

  o_E <= not i_A;
  
  
end dataflow;