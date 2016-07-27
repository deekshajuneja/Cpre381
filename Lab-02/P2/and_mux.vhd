library IEEE;
use IEEE.std_logic_1164.all;

entity and_mux is

  port(i_D         : in std_logic;
       i_E         : in std_logic;
       i_S         : in std_logic;
       o_Y         : out std_logic);

end and_mux;

architecture structure of and_mux is

component and2 is
  port(i_A        : in std_logic;
      i_B         : in std_logic;
      o_F         : out std_logic);
end component;

component or2 is
   port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component inv is
   port(i_A          : in std_logic;
       o_F          : out std_logic);
end component;

signal and21, and22, inv1 : std_logic;


begin
    -- Just like the real circuit, there 
    -- are four components: G1 to G4
   G1: inv  port map(i_S, inv1);
   G2: and2  port map(inv1, i_D, and21);
   G3: and2  port map(i_S, i_E, and22);
   G4: or2   port map(and21, and22, o_Y); -- F
end structure;
 
  
