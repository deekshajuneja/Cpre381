library IEEE;
use IEEE.std_logic_1164.all;
use work.array_port.all;

entity reg is -- reg file

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in  array32_bit;     -- Data value input
       o_Q          : out  array32_bit);   -- Data value output

end reg;

architecture structure of reg is

--  component dff
--    port(i_CLK        : in std_logic;     -- Clock input
--       i_RST        : in std_logic;     -- Reset input
--       i_WE         : in std_logic;     -- Write enable input
--       i_D          : in  std_logic;     -- Data value input
--       o_Q          : out std_logic );   -- Data value output


component reg32
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out  std_logic_vector(31 downto 0));   -- Data value output
end component;

begin
  
G0: for i in 0 to 31 generate
  reg_i: reg32
  
  port map( i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => i_WE,
            i_D => i_D(i),
            o_Q => o_Q(i) );
end generate;
  
    

end structure;

