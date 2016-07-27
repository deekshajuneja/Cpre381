-------------------------------------------------------------------------
-- Joseph Zambreno
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- and2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input AND 
-- gate.
--
--
-- NOTES:
-- 8/27/08 by JAZ::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity and2 is

  port(i_A          : in m32_1bit;
       i_B          : in m32_1bit;
       o_F          : out m32_1bit);

end and2;

architecture dataflow of and2 is
begin

  o_F <= i_A and i_B;
  
end dataflow;
