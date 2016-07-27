-- tb_regfile.vhd: Test bench for REGFILE
--
-- CprE 381 Sample code
--
-- Zhao Zhang, Fall 2013
--
library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

entity tb_regfile is
end tb_regfile;

architecture behavior of tb_regfile is
  -- The register file component
  component regfile is
    port( src1   : in  m32_5bits;    -- The 1st register source
          src2   : in  m32_5bits;    -- The 2nd register source
          dst    : in  m32_5bits;    -- The dest register
          wdata  : in  m32_word;     -- Register write data
          rdata1 : out m32_word;     -- The 1st register read data
          rdata2 : out m32_word;     -- The 2nd register read data
          WE     : in  m32_1bit;     -- Register write
          reset  : in  m32_1bit;
          clock  : in  m32_1bit);
  end component;
  
  signal clock  : m32_1bit;
  signal src1, src2, dst : m32_5bits;
  signal rdata1, rdata2, wdata : m32_word;
  signal WE     : m32_1bit;
  signal reset  : m32_1bit;
  
begin
  REGFILE1 : REGFILE
    port map(src1, src2, dst, wdata, rdata1, rdata2, WE, reset, clock);
  
  CLOCK_SIGNAL : process 
  begin
    clock <= '0';
    wait for HCT;
    clock <= '1';
    wait for HCT;
  end process;
  
  TEST : process
  begin
    -- Reset register file
    src1 <= "00000"; src2 <= "00000"; dst <= "00000";
    reset <= '1';
    wait for CCT;
    reset <= '0';
    report "Reset done";
  
    -- Read the register file, shall return zero for $0 and $1
    src1 <= "00000"; src2 <= "11111";
    WE <= '0';
    wait for CCT;
    report "src1 = " & hex(src1) & " src2 = " & hex(src2) 
      & " dst = " & hex(dst);
    report "rdata1 = " & hex(rdata1) & " rdata2 = " & hex(rdata2) 
      & " wdata = " & hex(wdata);
    assert (rdata1 = x"00000000") and (rdata2 = x"00000000");
    
    -- Write the register file, $2 = 0x12345678
    src1 <= "00001"; src2 <= "00010"; dst <= "00010";
    wdata <= x"12345678";
    WE <= '1';
    wait for CCT;
    report "src1 = " & hex(src1) & " src2 =  " & hex(src2) & " dst = " & hex(dst);
    report "rdata1 = " & hex(rdata1) & " rdata2 = " & hex(rdata2) & " wdata = " & hex(wdata);
    assert (rdata1 = x"00000000") and (rdata2 = x"00000000");
    
    -- Write 0x87654321 to $1
    src1 <= "00001"; src2 <= "00010"; dst <= "00001";
    wdata <= x"87654321";
    WE <= '1';
    wait for CCT;
    report "src1 = " & hex(src1) & " src2 =  " & hex(src2) & " dst = " & hex(dst);
    report "rdata1 = " & hex(rdata1) & " rdata2 = " & hex(rdata2) & " wdata = " & hex(wdata);
    assert (rdata1 = x"00000000") and (rdata2 = x"12345678");
    
    -- Read $1 and $2, no write
    src1 <= "00001"; src2 <= "00010"; dst <= "00001";
    wdata <= x"12345678";
    WE <= '0';
    wait for CCT;
    report "src1 = " & hex(src1) & " src2 =  " & hex(src2) & " dst = " & hex(dst);
    report "rdata1 = " & hex(rdata1) & " rdata2 = " & hex(rdata2) & " wdata = " & hex(wdata);
    assert (rdata1 = x"87654321") and (rdata2 = x"12345678");
    
    wait;
  end process;
end behavior;
 
