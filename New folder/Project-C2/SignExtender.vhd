library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SignExtender is
  generic (
    InputWidth  : integer := 16;
    OutputWidth : integer := 32
    );
  port (
    in_Data  : in  std_logic_vector(InputWidth-1 downto 0);
    out_Data : out std_logic_vector(OutputWidth-1 downto 0)
    );
end SignExtender;

architecture behavioral of SignExtender is
begin

  UpdateOutput: process (in_Data)
  begin
    out_Data(InputWidth-1 downto 0) <= in_Data(InputWidth-1 downto 0);
    out_Data(OutputWidth-1 downto InputWidth) <= (others => in_Data(InputWidth-1));
  end process UpdateOutput;

end behavioral;