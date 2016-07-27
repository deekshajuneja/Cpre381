library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_adder is

end tb_adder;

architecture behavior of tb_adder is

-- Declare the component we are going to instantiate
component nf_adder
  generic(N : integer := 32);
 port(i_A          : in std_logic_vector(N-1 downto 0);
      i_B          : in std_logic_vector(N-1 downto 0);
      i_C          : in std_logic_vector(N-1 downto 0);
     o_sum          : out std_logic_vector(N-1 downto 0);
     o_carry        : out std_logic_vector(N-1 downto 0));
end component;

component fa
  generic(N : integer := 32);
  port(
		 a : in STD_LOGIC_VECTOR(N-1 downto 0);
		 b : in STD_LOGIC_VECTOR(N-1 downto 0);
		 c : in STD_LOGIC_VECTOR(N-1 downto 0);
		 sum : out STD_LOGIC_VECTOR(N-1 downto 0);
		 carry : out STD_LOGIC_VECTOR(N-1 downto 0));
end component;
-- Signals to connect to the inv module

signal  s_A, s_B, s_C, s_F, s_E, s_G, s_H  : std_logic_vector(31 downto 0); 



begin

DUT: nf_adder 
  port map(i_A  => s_A,
            i_B => s_B,
            i_C => s_C,
            o_sum  => s_F,
            o_carry => s_G);
            

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= "11111111111111111111111111111111";
    s_B <= "00000000000000000000000000000000";
    s_C <= "11111000011111000001111111100000";
    wait for 100 ns;

    s_A <="11111100000000000000000000000000";
    s_B <="10101010101010101010101010101010";
    s_C <="11111111111111110000000000000000";
    wait for 100 ns;

    s_A <="00000000000000000000000111111111";
    s_B <="11111100000011001100101010001101";
    s_C <="11111000000000000000000000001111";
    wait for 100 ns;
    
    
    
    end process;
  
  DUT1: fa
  port map(a  => s_A,
            b => s_B,
            c => s_C,
            sum  => s_E,
            carry =>s_H);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    
    s_A <= "11111111111111111111111111111111";
    s_B <= "00000000000000000000000000000000";
    s_C <= "11111000011111000001111111100000";
    wait for 100 ns;

    s_A <="11111100000000000000000000000000";
    s_B <="10101010101010101010101010101010";
    s_C <="11111111111111110000000000000000";
    wait for 100 ns;

    s_A <="00000000000000000000000111111111";
    s_B <="11111100000011001100101010001101";
    s_C <="11111000000000000000000000001111";
    wait for 100 ns;
    
  end process;
  
end behavior;