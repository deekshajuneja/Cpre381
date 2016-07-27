library IEEE;
use IEEE.std_logic_1164.all;
use work.array_port.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
  
  port(A : in std_logic;
      B : in std_logic;
      C : in std_logic;
      add_sub     : in std_logic;
      sel: in std_logic_vector(2 downto 0);
      carry : out STD_LOGIC;
      Result : out std_logic);
     -- Result1: out std_logic;
    --  zero : out std_logic);
      
end ALU;

architecture structure of ALU is



component fadder

port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry : out STD_LOGIC);


end component;


component slt
  
 port( in_A : in std_logic;
        in_B : in std_logic;
        o_C  : out std_logic);

end component;

component and2
  
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component inv2
  
    port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;

component or2
  
   port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component xor2
  
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component mux
  
  port( sel : in std_logic_vector(2 downto 0);
i_D : in array_bit;
o_D : out std_logic);

end component;
-- signal array
signal s1 : work.array_port.array_bit;
signal s2,s3,s4, zero1 : std_logic;


begin
 
 s2 <= s3 xor '1';

with add_sub select
s4 <= B when '0',
      s2 when others;
 
 Alu8:inv2
  port map( i_A => B,
              o_F => s3);
 
 
 Alu:and2
 
 port map(i_A => A,
          i_B => B,
          o_F => s1(0));
          
          
Alu1:or2

port map(i_A => A,
        i_B => B,
        o_F => s1(1));
        
Alu2:xor2

port map(i_A => A,
          i_B => B,
          o_F => s1(2));
          
 -- Alu3:slt
--  
--  port map(in_A => A,
--            in_B => B,
--            o_C => s1(3));
 
 Alu4:inv2 
   port map( i_A => s1(0),
              o_F => s1(4));
 Alu5:inv2
     port map( i_A => s1(1),
              o_F => s1(5));
              
 Alu7:fadder
  port map( a => A,
            b => s4,
            c => C,
            sum => s1(6),
            carry => carry );             
              
              
          
          Alu9:fadder
  port map( a => A,
            b => s4,
            c => C,
            sum => s1(3),
            carry => carry ); 
          
          
              
  Alu6: mux
  port map( sel => sel,
            i_D => s1,
            o_D => Result);
  
  


--process
--  begin
--
--if (zero1='0') then
--    zero <= '1';
--  wait(100);
--else
--    zero <= '0';
--    wait(100);
--end if;
--end process;
  
  
end structure;
              
 


