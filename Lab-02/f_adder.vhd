library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity f_adder is
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c: in std_logic;
		 sum : out STD_LOGIC;
		 carry : out STD_LOGIC
	     );
end f_adder;

architecture structure of f_adder is 

component xor2

	  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);


end component;

component and2

 port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);	

end component;

component or2
	
	port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

--for G1 : xor2 use entity work.xor2(xor2);
	
--for G3: and2 use entity	work.and2(and2);
		
--for G5: or2 use entity work.or2(or2);


signal a1,a2,a3: std_logic;

begin

	G1: xor2 port map(a,b,a1);
	G2:	xor2 port map ( a1,c,sum);
G3: and2 port map (a,b,a2);
	G4: and2 port map (a1,c,a3);
	G5: or2 port map (a3,a2,carry);
	
end structure;