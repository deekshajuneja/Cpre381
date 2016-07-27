
library IEEE;
use IEEE.std_logic_1164.all;

-- This is an empty entity so we don't need to declare ports
entity testbench is

end testbench;

architecture behavior of testbench is

-- Declare the component we are going to instantiate
component complimenter
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(31 downto 0);
       o_F  : out std_logic_vector(31 downto 0));
end component;

component complimenter1
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(31 downto 0);
       o_E  : out std_logic_vector(31 downto 0));
end component;
-- Signals to connect to the inv module

signal  s_A, s_F, s_E  : std_logic_vector(31 downto 0); 


begin

DUT: complimenter 
  port map(i_A  => s_A,
  	        o_F  => s_F);
  	        

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <="00000000000000000000000100000000";
    wait for 200 ns;

    s_A <="00000000000000000000000000000000";
    wait for 200 ns;

    s_A <="00000000000000000000000000000001";
    wait for 200 ns;
    
  end process;
  
  DUT1: complimenter1 
  port map(i_A  => s_A,
  	        o_E  => s_E);

  -- Remember, a process executes sequentially
  -- and then if not told to 'wait' loops back
  -- around
  process
  begin

    s_A <="00000000000000000000000100000000";
    wait for 200 ns;

    s_A <="00000000000000000000000000000000";
    wait for 200 ns;

    s_A <="00000000000000000000000000000001";
    wait for 200 ns;
    
  end process;
  
end behavior;