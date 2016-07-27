library IEEE;
use IEEE.numeric_std.all;

use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ex32 is
 port( s8: in std_logic_vector(7 downto 0);
  s32: out std_logic_vector(31 downto 0));
end ex32;

architecture dataflow of ex32 is
    
begin
  s32 <= std_logic_vector(resize(signed(s8), s32'length));
end architecture;
