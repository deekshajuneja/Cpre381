library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.mips32.all;
--use work.ConstantsPkg.all;

entity alucontrol is
  port(instr : in m32_6bits;
     alu_op : in m32_2bits;
    alu_code : out m32_4bits);
    end alucontrol;
    
  architecture behavior of alucontrol is
      
     
      


 constant cadd : m32_6bits := "100000";
    constant csub : m32_6bits := "100010";
    constant cand : m32_6bits := "100100";
    constant cor : m32_6bits := "100101";
    constant cslt : m32_6bits := "101010";
    constant cnor : m32_6bits := "100111";
 
 begin
 
 
 
  alu_control : process(instr, alu_op)
    
    begin
    
  
    
    case alu_op is
      
    when "00" => alu_code <= "0010"; --add
    when "01" => alu_code <= "0110";  --sub
    when "10" =>                     --operation depends on function field
      
      case instr is
      when cadd => alu_code <="0010"; --add
      when csub => alu_code <= "0110"; --sub
      when cand => alu_code <= "0000";
      when cor => alu_code <= "0001";
      when cslt => alu_code <= "0111";
      when cnor => alu_code <= "1100";
      when others => alu_code <= "0010";
      end case;
    when others => alu_code <= "0010";                  -- *****change
    end case;
    
  end process;
  
end behavior;