library IEEE;
use IEEE.std_logic_1164.all;
use work.array_port.all;

entity mips is

port( data : in std_logic_vector(31 downto 0);
 R1_en, R2_en ,s5    : IN std_logic_vector(4 downto 0);
i_CLK, i_RST, i_WE: IN std_logic; 

 R1_data, R2_data  : OUT std_logic_vector(31 DOWNTO 0));

end mips;

architecture structure of mips is

component reg32

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(31 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(31 downto 0));   -- Data value output

end component;

component mux_32Bit 

port( sel : in std_logic_vector(4 downto 0);
i_D : in array32_bit(31 downto 0);
o_D : out std_logic_vector(31 downto 0));

end component;

component dec
  port(D_IN: in std_logic_vector(4 downto 0);
FOUT: out std_logic_vector(31 downto 0));
end component;

signal s6: std_logic_vector(31 downto 0);
signal v: std_logic_vector(31 downto 0);

signal s1, s8: work.array_port.array32_bit(31 downto 0);
begin

mips_0: reg32
  port map( i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => v(0),
            i_D => data,
            o_Q => s1(0));

G1: for i in 1 to 31 generate
  mips_i: reg32
  port map( i_CLK => i_CLK,
            i_RST => i_RST,
            i_WE => v(i),
            i_D => data,
            o_Q => s1(i));
end generate;


  
    
mips: dec
port map( D_IN => s5,
          FOUT => s6);
        G8: for i in 1 to 31 generate  
         v(i) <= s6(i) AND i_WE;
       end generate;
       


mips_j: mux_32Bit


  port map( sel => R1_en,
            i_D => s1,
            o_D => R1_data);
            
  mips_k: mux_32Bit


  port map( sel => R2_en,
            i_D => s1,
            o_D => R2_data);
            

 
 
 end structure;