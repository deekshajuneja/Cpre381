library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity tb_mux is

end tb_mux;

architecture behavior of tb_mux is

-- Declare the component we are going to instantiate
component mux
  generic(N : integer := 32);
    port(i_A          : in std_logic_vector(N-1 downto 0);
      i_B          : in std_logic_vector(N-1 downto 0);
      i_S          : in std_logic;
     o_F          : out std_logic_vector(N-1 downto 0));
end component;

component mux1
  generic(N : integer := 32);
   port(i_A         : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       i_S         : in std_logic;
       o_E         : out std_logic_vector(N-1 downto 0));
end component;
-- Signals to connect to the inv module

signal  s_A, s_B, s_F, s_E  : std_logic_vector(31 downto 0); 
signal s_S : std_logic;


begin

DUT: mux 
  port map(i_A  => s_A,
            i_B => s_B,
            i_S => s_S,
            o_F  => s_F);
            

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <= "11111111111111111111111111111111";
    s_B <= "00000000000000000000000000000000";
    wait for 200 ns;

    s_A <="11111100000000000000000000000000";
    s_B <="10101010101010101010101010101010
    wait for 200 ns;

    s_A <="00000000000000000000000111111111";
    s_B <="11111100000011001100101010001101";
    wait for 200 ns;
    
    
    
    end process;
  
  DUT1: mux1
  port map(i_A  => s_A,
            i_B => s_B,
            i_S => s_S,
            o_E  => s_E);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    
    s_A <= "11111111111111111111111111111111";
    s_B <= "00000000000000000000000000000000";
    wait for 200 ns;

    s_A <="11111100000000000000000000000000";
    s_B <="10101010101010101010101010101010
    wait for 200 ns;

    s_A <="00000000000000000000000111111111";
    s_B <="11111100000011001100101010001101";
    wait for 200 ns;
    
  end process;
  
end behavior;