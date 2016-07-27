-- reg.vhd
--
-- A generic register component used in CprE 381 fall. It may be used for PC,
-- pineline registers and so on.
-- 
-- Zhao Zhang, fall 2013
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mips32.all;

entity reg is
  generic (M : integer := 32);                  -- Size of the register
  port (D      : in  m32_vector(M-1 downto 0);  -- Data input
        Q      : out m32_vector(M-1 downto 0);  -- Data output
        WE     : in  m32_1bit;                  -- Write enableenable
        reset  : in  m32_1bit;                  -- The clock signal
        clock  : in  m32_1bit);                 -- The reset signal
end reg;

architecture behavior of reg is
begin
  REG : process (clock)
  begin
    if (rising_edge(clock)) then
      if (reset = '1') then
        -- Clear all bits of latch
        Q <= std_logic_vector(to_unsigned(0, Q'length));
      elsif (WE = '1') then
        Q <= D;
      end if;
    end if;
  end process;

end behavior;
