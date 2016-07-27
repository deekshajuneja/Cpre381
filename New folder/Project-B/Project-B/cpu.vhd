-- cpu.vhd: Single-cycle implementation of MIPS32 for CprE 381, fall 2013,
-- Iowa State University
--
-- Zhao Zhang, fall 2013

-- The CPU entity. It connects to 1) an instruction memory, 2) a data memory, and 
-- 3) an external clock source.
--
-- Note: This is a partical sample
--
--******************************* wmask and mem addr *********************************8
library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;
use IEEE.numeric_std.all;

entity cpu is
  port (imem_addr   : out m32_word;     -- Instruction memory address
        inst        : in  m32_word;     -- Instruction
        dmem_addr   : out m32_word;     -- Data memory address
        dmem_read   : out m32_1bit;     -- Data memory read?
        dmem_write  : out m32_1bit;     -- Data memory write?
        dmem_wmask  : out m32_4bits;    -- Data memory write mask
        dmem_rdata  : in  m32_word;     -- Data memory read data
        dmem_wdata  : out m32_word;     -- Data memory write data
        reset       : in  m32_1bit;     -- Reset signal
        clock       : in  m32_1bit);    -- System clock
end cpu;

-- This architecture of CPU must be dominantly structural, with no bahavior 
-- modeling, and only data flow statements to copy/split/merge signals or 
-- with a single level of basic logic gates.
architecture structure of cpu is
  

-- adder
component adder is
   port (src1    : in  m32_word;
        src2    : in  m32_word;
        result  : out m32_word);
      end component;
      
  -- alu    
component alu is   

 port (rdata1      : in  m32_word;
        rdata2      : in  m32_word;
        alu_code    : in  m32_4bits;
        result      : out m32_word;
        zero        : out m32_1bit);
end component;   

--component mem is 
--  generic(depth_exp_of_2 	: integer := 10;
--      mif_filename 	: string := "mem.mif");
--  port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
--      byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
--			clock			: IN STD_LOGIC := '1';
--			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
--			wren			: IN STD_LOGIC := '0';
--			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));   
--			end component;
--			

component SignExtender is
  
 generic   ( InputWidth  : integer := 16;
    OutputWidth : integer := 32);
  port ( in_Data  : in  std_logic_vector(InputWidth-1 downto 0);
    out_Data : out std_logic_vector(OutputWidth-1 downto 0) );
    
end component;

component reg is
   generic (M : integer := 32);                  -- Size of the register
  port (D      : in  m32_vector(M-1 downto 0);  -- Data input
        Q      : out m32_vector(M-1 downto 0);  -- Data output
        WE     : in  m32_1bit;                  -- Write enableenable
        reset  : in  m32_1bit;                  -- The clock signal
        clock  : in  m32_1bit);                 -- The reset signal
        
      end component;
			
  -- The register file
  component regfile is
     port(src1      : in  m32_5bits;
          src2      : in  m32_5bits;
          dst       : in  m32_5bits;
          wdata     : in  m32_word;
          rdata1    : out m32_word;
          rdata2    : out m32_word;
          WE        : in  m32_1bit;
          reset     : in  m32_1bit;
          clock     : in  m32_1bit);
  end component;  
  
  --main control unit
  
  component control is
    port (op_code     : in  m32_6bits;
        reg_dst     : out m32_1bit;
        alu_src     : out m32_1bit;
        mem_to_reg  : out m32_1bit;
        reg_write   : out m32_1bit;
        mem_read    : out m32_1bit;
        mem_write   : out m32_1bit;
        branch      : out m32_1bit;
        alu_op      : out m32_2bits;
        jump        : out m32_1bit );
end component;

-- alu control unit
  component alucontrol is
      port( instr : in m32_6bits;
            alu_op : in m32_2bits;
            alu_code : out m32_4bits);
    end component;
    
    
  component and2 is
      port(i_A          : in m32_1bit;
       i_B          : in m32_1bit;
       o_F          : out m32_1bit);
     end component;

  
  
  -- 2-to-1 MUX
  component mux2to1 is
    generic (M    : integer := 32);    -- Number of bits in the inputs and output
    port (input0  : in m32_vector(M-1 downto 0);
          input1  : in m32_vector(M-1 downto 0);
          sel     : in m32_1bit;
          output  : out m32_vector(M-1 downto 0));
  end component;
          
  
  
  -- signals for cpu --
  
  
  -- PC-related signals

  signal PC, PCoutput         : m32_word := x"00000000";     -- PC for the current inst
  signal output     : m32_word;     -- ouput signal for adder
 
  -- Instruction fields and derives
   signal Instruction : m32_26bits;
   signal shift_inst : m32_26bits;
   signal func : m32_halfword;
 
  -- Control signals
  signal opcode , funct    : m32_6bits;    -- 6-bit opcode
  signal  alusrc, memtoreg, regwrite, Sbranch, Jump    : m32_1bit;     
  signal aluop                                    : m32_2bits;
  signal  write_enable                            : m32_1bit;
  
  -- ALU signals
  
  signal InputA    : m32_word;
  signal InputB    : m32_word;
  signal ALUResult, AluResult1 : m32_word; 
  signal ZeroFlag  : m32_1bit;
  signal alucode    : m32_4bits;
  signal reg_dst    : m32_1bit;    -- Register destination

 --sign extender
 
 signal extendedaddress, extendedaddress1 : m32_word;
  
  -- Other non-control signals connected to regfile
  -- More code here
  
  signal rs, rt, rd, dst, shamt :  m32_5bits;
  signal Iadd : m32_halfword;
  signal JADD : m32_26bits;
  signal  r_data2 , rdata1, write_data     : m32_word;     -- Register write data
 
  -- More code here

--Program counter
  signal jumpAddress    : m32_word;
  signal BranchAddress  : m32_word;
  signal j_target    : m32_word;
  signal j_offset  : m32_26bits;
  signal mux3output : m32_word;
  signal signext :  m32_word;
  
  signal selectbit: m32_1bit;



constant offset : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";

begin
  -- More code here
   
  
  -- Jump target
  j_target <= output(31 downto 28) & instruction & "00";


  extendedaddress1 <= extendedaddress(29 downto 0) & "00";
    
  instruction <= inst(25 downto 0);
 --shift_inst <= instruction sll 2;
 --shift_inst <= instruction(23 downto 0) & "00";
  
  SPLIT : block                     -- Split the instructions into fields
  begin
    opcode <= inst(31 downto 26);
    rs     <= inst(25 downto 21);
    rt     <= inst(20 downto 16);
    rd     <= inst(15 downto 11);
    shamt  <= inst(10 downto 6);
    
    Iadd   <= inst(15 downto 0);
    funct  <= Iadd(5 downto 0);
    Jadd   <= inst(25 downto 0); 
    -- More code here
  end block;
  
 --cpu2 : adder
 
-- port map ( imem_addr, dmem_addr , j_target);
 dmem_wmask<="1111";
 
Reg1: reg
 port map(PC, PCoutput, '1', reset, clock);
 imem_addr <= PCoutput; 

 Cpu1 : Control
 
 port map (opcode, reg_dst, alusrc, memtoreg, regwrite, dmem_read, dmem_write, Sbranch, aluop, jump);
 
 
 Alucontrol1: alucontrol
    port map(funct, aluop, alucode);
      
      
 
   Cpu : Alu
    port map (rdata1, InputB, alucode, ALUResult, ZeroFlag);
    
    dmem_addr <= ALUResult;
 
 PC1 : adder
    port map (PCoutput, offset, output);
 
 
  
 
 
  cpu2 : SignExtender
    port map (Iadd,extendedaddress);
 
 PC2 : adder
  port map(output, extendedaddress1, AluResult1);

  
  
  DST_MUX : mux2to1 generic map (M => 5)       -- The mux connected to the dst port of regfile
    port map (rt, rd, reg_dst, dst);
  
  
  
  -- The register file
  REGFILE1 : regfile
    port map (rs, rt, dst, write_data,rdata1, r_data2, regwrite, reset, clock);

  dmem_wdata <= r_data2;
  

  DST_MUX1 : mux2to1 generic map (M => 32)       --connected to second input of alu
    port map (r_data2, extendedaddress, alusrc, InputB);
      

  DST_MUX2 : mux2to1 generic map (M => 32)       --
    port map (ALUResult, dmem_rdata , memtoreg,write_data);
 

 
    
 L_and: and2
    port map(Sbranch, ZeroFlag, selectbit);   
       
       
  DST_MUX3 : mux2to1 generic map (M => 32) 
  
   port map (output, AluResult1, selectbit, mux3output);
  
   

  DST_MUX4 : mux2to1 generic map (M => 32) 
  
  port map (mux3output,j_target,jump,PC);
 

    

end structure;














































   -- UpdatePC : process (clock, reset)
--  begin
--      
--    if in_Reset = '1' then
--      PC <= (others => '0');
--      
--    elsif rising_edge(clock) then
--      if Jump = '1' then
--        PC <= j_target;
--      elsif Branch = '1' and ZeroFlag = '1' then
--        PC <= BranchAddress;
--      else
--        PC <= jumpAddress;
--      end if;
--
--    end if;
--    
--  end process UpdatePC;
 
