library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fadder is
  -- generic(N : integer := 32);
	 port(
		 a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 c : in STD_LOGIC;
		 sum : out STD_LOGIC;
		 carry : out STD_LOGIC);
		 
end fadder;

architecture dataflow of fadder is begin 
	sum <= a xor b xor c;
	carry <= (a and b) or (c and (a xor b));
	end dataflow;