library IEEE;
use IEEE.numeric_std.all;

use IEEE.std_logic_1164.all;
--use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ex16 is
 port( s16: in std_logic_vector(15 downto 0);
  s32: out std_logic_vector(31 downto 0);
  control: in std_logic);
end ex16;

architecture behaviour of ex16 is

begin
  
with control select

  
  s32 <= std_logic_vector(resize(signed(s16), s32'length)) when '1',
        std_logic_vector(resize(unsigned(s16), s32'length)) when others;


end;

