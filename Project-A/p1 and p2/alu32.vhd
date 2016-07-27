library IEEE;
use IEEE.std_logic_1164.all;
use work.array_port.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;
--use IEEE.NUMERIC_BIT.ALL;


entity ALU32 is
  
  port(A : in std_logic_vector(31 downto 0);
      B : in std_logic_vector(31 downto 0);
      C : in std_logic;
      add_sub     : in std_logic;
      sel: in std_logic_vector(2 downto 0);
      carry : out STD_LOGIC;
      overflow: out std_logic;
      zero : out std_logic;
      Result : buffer std_logic_vector(31 downto 0));
end ALU32;

architecture mixed of ALU32 is


component inv2 is
  
    port(i_A          : in std_logic;
       o_F          : out std_logic);

end component;



component ALU is
  
   port(A : in std_logic;
      B : in std_logic;
      C : in std_logic;
      add_sub     : in std_logic;
      sel: in std_logic_vector(2 downto 0);
      carry : out STD_LOGIC;
      Result : out std_logic);
     
end component;
signal temp_c  :std_logic_vector(32 downto 0);
signal s2,s3,s4, s5 : std_logic_vector(31 downto 0);
signal less : std_logic;
signal r1,r2 : std_logic_vector(31 downto 0);

begin
  
  temp_c(0) <= c;
carry <= temp_c(32);


 
        
-- control bit for addition or subtraction
      with add_sub select
          s4 <= B when '0',
                s2 when others;

-- one's complement of input B
 G12: for i in 0 to 31 generate
 Alu8:inv2
  port map( i_A => B(i),
              o_F => s3(i));
 end generate;

-- 2's comlement
 s2 <= s3 + "00000000000000000000000000000001";



-- mapping 32 bit alu with one bit alu
   G1: for i in 0 to 31 generate
  
  Alu32:Alu
    
  port map(
    
    A => A(i),
    B => s4(i),
    C => temp_c(i),
    add_sub => add_sub,
    sel => sel,
    carry => temp_c(i+1),
  Result => r1(i));

    
  end generate;         
  
   -- checking overflow
  overflow <= temp_c(32) XOR temp_c(31);



L_P: process(sel, r1)
--L_P: process
  begin
  -- if(r1<0) and  (sel = 011) then 
  if( r1(31) = '1' and sel = "011") then
          Result <="00000000000000000000000000000001";
  elsif (sel = "011") then
          Result <= "00000000000000000000000000000000";
  else
    Result <= r1;
  
end if;

end process L_P;

with Result select

  zero <= '1' when "00000000000000000000000000000000",
          '0' when others;
  

 
end mixed;



    

 
    