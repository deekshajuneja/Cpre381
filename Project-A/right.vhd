library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity right is
  port(i_a:in std_logic_vector(31 downto 0);
  c_in: std_logic;
  result: out std_logic_vector(32 downto 0));
end right;

architecture behaviour of right is

begin
  
  result(30 downto 0)<=i_a(31 downto 1);
  result(31)<=c_in;
  result(32)<=i_a(0);
  
end behaviour;