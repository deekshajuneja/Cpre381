library IEEE;
use IEEE.std_logic_1164.all;

package array_port is
type array32_bit is array(natural range <>) of std_logic_vector(31 downto 0);
end array_port;