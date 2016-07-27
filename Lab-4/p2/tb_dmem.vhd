library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

use work.array_port.all;
use std.textio.all;


-- This is an empty entity so we don't need to declare ports
entity tb_dmem is
 

end tb_dmem;

architecture behaviour of tb_dmem is

component mem 
	generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "dmem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
			byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			clock			: IN STD_LOGIC;
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			wren			: IN STD_LOGIC;
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));         
end component;

signal s_address : STD_LOGIC_VECTOR (9 DOWNTO 0) := (OTHERS => '0');
signal s_byteena : STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
signal s_data : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
signal s_q : STD_LOGIC_VECTOR (31 DOWNTO 0);
signal s_CLK, s5  : std_logic;
signal s_WE  : std_logic:='0';
signal array1 :  array32_bit(9 downto 0);

begin
  
  DUT: mem 
  port map(address => s_address,
           clock => s_CLK, 
           byteena => s_byteena,
           data   => s_data,
           wren => s_WE,
           q   => s_q);
           
  process
    variable x: integer:=0;
    variable y: integer:=0;
    variable z: integer:=0;
    begin
      wait for 100 ns;
      
    s_address<="0000000000";
    
    while(s_address<"0000001001") loop ---read
      array1(x)<=s_q;
      x:=x+1;
      s_address<=std_logic_vector(unsigned(s_address)+1);
      wait for 100 ns;
      
    end loop;
    array1(9) <= s_q;
    
    s_address<="0100000000";
    s_WE<='1';
   
    
    while(y<10) loop  ---write
      s_data<=array1(y);
          wait for 100 ns;
      
      s_address<=std_logic_vector(unsigned(s_address)+1);
     y:=y+1;
      
      end loop;
    
    
     
     s_address<="0100000000";
   s_WE<='0';
    while(s_address<"0100001001") loop  --read again
     
      array1(z)<=s_q;
      z:=z+1;
      s_address<=std_logic_vector(unsigned(s_address)+1);
      
      wait for 100 ns;
      
    end loop;        
     array1(9) <= s_q;
end process;
   

           
           
          
           
           
end behaviour;