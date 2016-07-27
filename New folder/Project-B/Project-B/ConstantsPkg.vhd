library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

package ConstantsPkg is

  type T_MemoryArray is array(0 to (2**10)-1) of std_logic_vector (7 downto 0);

    constant cadd : m32_6bits := "100000";
    constant csub : m32_6bits := "100010";
    constant cand : m32_6bits := "100100";
    constant cor : m32_6bits := "100101";
    constant cslt : m32_6bits := "101010";
    constant cnor : m32_6bits := "100111";

end ConstantsPkg;

package body ConstantsPkg is



end ConstantsPkg;