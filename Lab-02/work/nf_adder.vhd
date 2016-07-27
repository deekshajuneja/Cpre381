library IEEE;
use IEEE.std_logic_1164.all;

entity nf_adder is
generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
      i_B          : in std_logic_vector(N-1 downto 0);
      i_C          : in std_logic_vector(N-1 downto 0);
     o_sum          : out std_logic_vector(N-1 downto 0));
     o_carry        : out std_logic);

end nf_adder;

architecture structure of nf_adder is

component f_adder

 port (a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c: in std_logic;
		 sum : out STD_LOGIC;
		 carry : out STD_LOGIC);
end component;

begin

-- We loop through and instantiate and connect N not1 modules
G1: for i in 0 to N-1 generate
 
  nf_adder_i: f_adder
    port map(a  =>  i_A(i),
              b  => i_B(i),
              b  => i_C(i),
  	          sum  => o_sum(i)
  	          carry => o_carry);
end generate;

  
end structure;

