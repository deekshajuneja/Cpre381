library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
      i_B          : in std_logic_vector(N-1 downto 0);
      i_S          : in std_logic;
     o_F          : out std_logic_vector(N-1 downto 0));

end mux;

architecture structure of mux is

component and_mux

  port(i_D         : in std_logic;
       i_E         : in std_logic;
       i_S         : in std_logic;
       o_Y         : out std_logic);

end component;

begin

-- We loop through and instantiate and connect N not1 modules
G1: for i in 0 to N-1 generate
 
  mux_i: and_mux
    port map(i_D  =>  i_A(i),
              i_E  => i_B(i),
              i_S  => i_S,
  	          o_Y  => o_F(i));
end generate;

  
end structure;

