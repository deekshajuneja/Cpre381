-- cpu.vhd: Single-cycle implementation of MIPS32 for CprE 381, fall 2013,
-- Iowa State University
--
-- Zhao Zhang, fall 2013

-- The CPU entity. It connects to 1) an instruction memory, 2) a data memory, and 
-- 3) an external clock source.
--
-- Note: This is a partical sample
--

library IEEE;
use IEEE.std_logic_1164.all;
use work.mips32.all;

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

component mem is 
  generic(depth_exp_of_2 	: integer := 10;
      mif_filename 	: string := "mem.mif");
  port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
      byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			clock			: IN STD_LOGIC := '1';
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			wren			: IN STD_LOGIC := '0';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));   
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
        alu_op      : out m32_2bits);
end component;

  
  -- 2-to-1 MUX
  component mux2to1 is
    generic (M    : integer := 32);    -- Number of bits in the inputs and output
    port (input0  : in m32_vector(M-1 downto 0);
          input1  : in m32_vector(M-1 downto 0);
          sel     : in m32_1bit;
          output  : out m32_vector(M-1 downto 0));
  end component;
          
  --
  -- Signals in the CPU
  --
  
  -- PC-related signals

  signal PC         : m32_word;     -- PC for the current inst

 
  -- Instruction fields and derives
   signal Instruction : m32_word;

  -- Control signals
  signal opcode     : m32_6bits;    -- 6-bit opcode
  signal  alusrc, memtoreg, regwrite, Sbranch    : m32_1bit;     
  signal aluop                                    : m32_2bits;
  signal  write_enable                            : m32_1bit;
  
  -- ALU signals
  
  signal InputA    : m32_word;
  signal InputB    : m32_word;
  signal ALUResult : m32_word; 
  signal ZeroFlag  : m32_1bit;

  signal reg_dst    : m32_1bit;    -- Register destination

 
  
  -- Other non-control signals connected to regfile
  -- More code here
  
  signal rs, rt, rd, dst :  m32_5bits;
  
  signal  rdata2 , rdata1, write_data     : m32_word;     -- Register write data
 
  -- More code here

--Program counter
  signal NextAddress    : m32_word;
  signal BranchAddress  : m32_word;
  signal j_target    : m32_word;



signal ExtendedAddress : std_logic_vector(31 downto 0);


begin
  -- More code here
   
  
  -- Jump target
  j_target <= PC(31 downto 28) & j_offset & "00";
  NextAddress   <= std_logic_vector(unsigned(PC) + 4);
  BranchAddress <= std_logic_vector(unsigned(NextAddress) + unsigned(ExtendedAddress));

  -- More code here
    
  
  SPLIT : block                     -- Split the instructions into fields
  begin
    opcode <= inst(31 downto 26);
    -- More code here
  end block;
  
 --cpu2 : adder
 
-- port map ( imem_addr, dmem_addr , j_target);
 
 Cpu1 : Controller
 
 port map (opcode, reg_dst, alusrc, memtoreg, regwrite, dmem_read, dmem_write, Sbranch, aluop);
      
 
 Cpu : Alu
 port map (InputA, InputB, aluop, ALUResult, ZeroFlag);
  

 
  DST_MUX : mux2to1 generic map (M => 5)       -- The mux connected to the dst port of regfile
    port map (rt, rd, reg_dst, dst);
  
  -- The register file
  REGFILE1 : regfile
    port map (rs, rt, dst, write_data,rdata1, rdata2, write_enable, reset, clock);

  -- More code here
      
end structure;

