library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fa is
  --generic(N : integer := 32);
	 port(
		 a : in STD_LOGIC; --_VECTOR(N-1 downto 0);
		 b : in STD_LOGIC; --_VECTOR(N-1 downto 0);
		 c : in STD_LOGIC; --_VECTOR(N-1 downto 0);
		 sum : out STD_LOGIC; --_VECTOR(N-1 downto 0);
		 carry : out STD_LOGIC);--_VECTOR(N-1 downto 0));
end fa;

architecture dataflow of fa is
begin 
	sum <= a xor b xor c;
	carry <= (a and b) or (c and (a xor b));
	end dataflow;