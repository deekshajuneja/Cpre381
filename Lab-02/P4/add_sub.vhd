library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
 use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity add_sub is
generic(N : integer := 32);
  port(i_P          : in std_logic_vector(N-1 downto 0);
       i_Q          : in std_logic_vector(N-1 downto 0);
       i_carry      : in std_logic_vector(N-1 downto 0);
       nadd_sub     : in std_logic;  --control bit
       i_s          : in std_logic;
       o_result     : out std_logic_vector(N-1 downto 0);
       o_carry      : out std_logic_vector(N-1 downto 0));
end add_sub;

architecture structure of add_sub is

 component inv is

  port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component and_mux is

  port(i_D         : in std_logic;
       i_E         : in std_logic;
       i_S         : in std_logic;
       o_Y         : out std_logic);

 end component;
 
component fa is

  port(
		 a : in STD_LOGIC; 
		 b : in STD_LOGIC; 		 
		 c : in STD_LOGIC; 
		 sum : out STD_LOGIC; 
		 carry : out STD_LOGIC);
		
end component;

signal a1,a2,a3: std_logic_vector(31 downto 0);
begin

-- We loop through and instantiate and connect N not1 modules

G1: for i in 0 to N-1 generate

  add_sub_i: and_mux
    port map(i_D  =>  i_P(i),
              i_E  => i_Q(i),
              i_S  => i_S,
  	          o_Y  => a2(i));
end generate;



G2: for i in 0 to N-1 generate
--1's compliment of i_B 
  add_sub_i: inv
   port map(i_A => i_Q(i),
            o_F => a1(i));
   end generate;  
 
 
 
 process(nadd_sub)
  begin

if(nadd_sub='0')then
  a3<=a1 + "00000000000000000000000000000001";
  
else
a3<=i_Q;

end if;
end process;



  G3: for i in 0 to N-1 generate
 
  add_sub_i: fa
    port map(a  =>  a2(i),
              b  => a3(i),
               c  => i_carry(i),
  	          sum  => o_result(i),
  	          carry => o_carry(i));
  	          
end generate;

  
end structure;

