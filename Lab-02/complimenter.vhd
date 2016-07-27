library IEEE;
use IEEE.std_logic_1164.all;

entity complimenter is
generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
     o_F          : out std_logic_vector(N-1 downto 0));

end complimenter;

architecture structure of complimenter is

component inv
  port(i_A  : in std_logic;
       o_F  : out std_logic);
end component;

begin

-- We loop through and instantiate and connect N not1 modules
G1: for i in 0 to N-1 generate
  o_F(i) <= not i_A(i);
  inv_i: inv
    port map(i_A  =>  i_A(i),
  	          o_F  => o_F(i));
end generate;

  
end structure;

