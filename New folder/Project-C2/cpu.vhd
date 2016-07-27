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
  -- More code here

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
  
  component adder is
   port (src1    : in  m32_word;
        src2    : in  m32_word;
        result  : out m32_word);
      end component;
      
   
      
component alu is   
 port (rdata1      : in  m32_word;
        rdata2      : in  m32_word;
        alu_code    : in  m32_4bits;
        result      : out m32_word;
        zero        : out m32_1bit);
end component;   
      
 
 
  component SignExtender is
  
 generic   ( InputWidth  : integer := 16;
    OutputWidth : integer := 32);
  port ( in_Data  : in  std_logic_vector(InputWidth-1 downto 0);
    out_Data : out std_logic_vector(OutputWidth-1 downto 0) );
    
end component;


   component and2 is
      port(i_A          : in m32_1bit;
       i_B          : in m32_1bit;
       o_F          : out m32_1bit);
     end component;
  
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
        jump1       : out m32_1bit );
end component; 
 
  
  -- 2-to-1 MUX
  component mux2to1 is
    generic (M    : integer := 1);    -- Number of bits in the inputs and output
    port (input0  : in m32_vector(M-1 downto 0);
          input1  : in m32_vector(M-1 downto 0);
          sel     : in m32_1bit;
          output  : out m32_vector(M-1 downto 0));
  end component;
  
  -- ID/EX
  component instructiondecoder is
    port ( --PCplusfour  : in  m32_word;
         readdata1    : in m32_word;
         readdata2    : in m32_word;
         Iadd         : in m32_word;
         inst1        : in m32_5bits;
         rs          : in m32_5bits;
         rt          : in m32_5bits;
         inst2        : in m32_5bits;
         RegWrite     : in m32_1bit;
         AluSrc       : in m32_1bit;
         Aluop        : in m32_2bits;
         Regdst       : in m32_1bit;
         MemWrite     : in m32_1bit;
         branch       : in m32_1bit;
         memread      : in m32_1bit;
         memtoreg     : in m32_1bit;
         clock        : in  m32_1bit;
       -- o_PCplusfour  : out  m32_word;
        o_readdata1   : out m32_word;
        o_readdata2   : out m32_word;
         o_Iadd        :out m32_word;
         o_inst1        : out m32_5bits;
         o_inst2        : out m32_5bits;
         ex_rs        : out m32_5bits;
         ex_rt         : out m32_5bits;
         o_RegWrite     : out m32_1bit;
         o_AluSrc       : out m32_1bit;
         o_Aluop        : out m32_2bits;
         o_Regdst       : out m32_1bit;
         o_memtoreg     : out m32_1bit;
         o_MemWrite     : out m32_1bit;
         o_branch       : out m32_1bit;
         o_memread      : out m32_1bit);
         
         
  end component; 
  
  -- IF/ID
  component instructionfetch is
    port (inst        : in  m32_word;     -- Instruction
        PCplusfour  : in  m32_word;
        WE          : in  m32_1bit;
        clock       : in  m32_1bit;
        reset       : in  m32_1bit;
        flush       : in  m32_1bit;
        o_PCplusfour: out m32_word;
        opcode      : out m32_6bits; 
        rs          : out m32_5bits;
        rt          : out m32_5bits;
        inst1       : out m32_5bits;
        inst2       : out m32_5bits;
        Iadd        : out  m32_halfword);

end component;

-- EX/MEM
component exmem is
   port(RegWrite  : in m32_1bit;
        memtoreg  : in m32_1bit;
        memwrite  : in m32_1bit; 
        memread   : in m32_1bit;
        clock     : in m32_1bit;
        aluresult : in m32_word;
        muxoutput0 : in  m32_5bits;  -- forward_c
        muxoutput1  : in m32_word;
        address     : out m32_word;
        o_memwrite  : out m32_1bit; 
        o_memread   : out m32_1bit;
        o_regwrite  : out m32_1bit;
        o_muxoutput0 : out m32_5bits;
        o_muxoutput1 : out m32_word;
        o_memtoreg  : out m32_1bit);
        


end component;

-- MEM/WB
component writeback is
   port( rdata  : in m32_word;
        address : in m32_word;  -- also mux2 input
        regwrite: in m32_1bit;
        muxoutput1: in m32_word;
        clock   : in m32_1bit;
        --memtoreg: in m32_1bit;
        muxoutput :in  m32_5bits;
        o_muxoutput1: out m32_word;
        o_rdata  : out m32_word;
        o_address : out m32_word;
        o_regwrite: out m32_1bit;
        --o_memtoreg: out m32_1bit;
        o_muxoutput : out  m32_5bits);
        
  end component;
  
  
  component alucontrol is
  port(instr : in m32_6bits;
     alu_op : in m32_2bits;
    alu_code : out m32_4bits);
    end component;
    
    component hazard is
      port ( exmemread : in m32_1bit;
        if_rs : in m32_5bits;
        if_rt : in m32_5bits;
        ex_rt : in m32_5bits;
        ex_rs : in m32_5bits;
        --inst1 : in m32_5bits;
        stall : out m32_1bit);
        --o_exmemread : in m32_1bit);
        
      end component;
      
  component forwardingunit is
    port( inst1 : in m32_5bits;
  rs : in m32_5bits;
  rt :  in m32_5bits;
  exregwrite : in m32_1bit;
 wbregwrite : in m32_1bit;
    ForwardA : out m32_2bits;
   ForwardB : out m32_2bits;
     muxoutput2 : in m32_5bits;
    muxoutput1 : in m32_5bits);
   
 end component;
 
 component mux3to1 is
generic (M    : integer := 32);    -- Number of bits in the inputs and output
    port (input0  : in m32_vector(M-1 downto 0);
          input1  : in m32_vector(M-1 downto 0);
          input2  : in m32_vector(M-1 downto 0);
          sel     : in m32_2bits;
          output  : out m32_vector(M-1 downto 0));
end component;
    
  
          
 -- signals for cpu --
  
  
  -- PC-related signals

  signal PC, PCoutput         : m32_word := x"00000000";     -- PC for the current inst
  signal PCplusfour, o_PCplusfour, o_plusfour, addresult, addresult1     : m32_word;     -- ouput signal for adder
 
  -- Instruction fields and derives
   signal Instruction : m32_26bits;
   signal shift_inst : m32_26bits;
   signal func : m32_halfword;
 
  -- Control signals
  signal opcode , funct    : m32_6bits;    -- 6-bit opcode
  signal  alusrc, memtoreg, regwrite, Sbranch, reg_dst,  mem_read, mem_write, branch, o_RegWrite,o_AluSrc,o_Reg_dst,
  o_Mem_Write,o_branch, o_mem_read, branch1,mem_write1,mem_read1,exregwrite,memtoreg1,wbregwrite,memtoreg2, o_memtoreg   : m32_1bit;
  signal  alusrc_s, memtoreg_s, regwrite_s, Sbranch_s, reg_dst_s,  mem_read_s, mem_write_s, branch_s:m32_1bit;    
  signal aluop, o_Aluop, aluop_s                                    : m32_2bits;
  signal  write_enable,flush ,stall, flush_s                          : m32_1bit;

       
  -- ALU signals
  
  signal InputA    : m32_word;
  signal InputB, outputB    : m32_word;
  signal aluresult, address, address1 : m32_word; 
  signal ZeroFlag, zeroflag1  : m32_1bit;
  signal alucode    : m32_4bits;
  
 --sign extender
 
 signal extendedaddress, o_extendedaddress, extendedaddress1  : m32_word;
 signal extendedaddress2 : m32_6bits; 
  -- Other non-control signals connected to regfile
  -- More code here
  signal muxoutput, o_muxoutput, muxoutput_wb : m32_5bits; --- output of mux connected to ID/EX
  signal muxoutput1, muxoutput2 : m32_word; --- output of mux1, mux2 
  
  
  signal rs, rt, rd, dst, shamt,inst1,inst2,o_inst1,o_inst2, ex_rs, ex_rt :  m32_5bits;
  signal PCSrc : m32_1bit; -- and operation output
  signal Iadd : m32_halfword;
  signal JADD : m32_26bits;
  signal  readdata2 , readdata1, write_data, o_readdata1,o_readdata2, rdata : m32_word;     -- Register write data
 
  signal ForwardA, ForwardB : m32_2bits;  

constant offset : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";

begin
  
  process(clock, reset) 
    begin
      if(rising_edge(clock)) then
      if(reset = '1') or (stall ='1') then 
        memtoreg_s<='0';
        regwrite_s<='0';
        mem_write_s<='0';
        mem_read_s<='0';
        branch_s<='0';
        reg_dst_s<='0';
        alusrc_s<='0';
        aluop_s<="00";
        flush_s<='0';
        
      else
         memtoreg_s<=memtoreg;
        regwrite_s<=regwrite;
        mem_write_s<=mem_write;
        mem_read_s<=mem_read;
        branch_s<=branch;
        reg_dst_s<=reg_dst;
        alusrc_s<=alusrc;
        aluop_s<=aluop;
        flush_s<=flush;
      end if;
    end if;
    end process;
  dmem_wmask<="1111";
  
  CPU4 : forwardingunit
    port map(o_inst1, ex_rs, ex_rt, exregwrite, wbregwrite, ForwardA, ForwardB, muxoutput_wb, o_muxoutput); 
  
  MUX0 : mux3to1
    port map(o_readdata1, muxoutput2, address, ForwardA, InputA);
    
  MUX1 : mux3to1
    port map(o_readdata2, muxoutput2, address, ForwardB, InputB);
    
    CPU5: hazard
    port map(o_mem_read, rs, rt, ex_rt, ex_rs, stall);
   
 
 Reg1: reg
    port map(PC, PCoutput, '1', reset, clock);
    imem_addr <= PCoutput;
 
 PC1 : adder
    port map (PCoutput, offset, PCplusfour);
 
 INSTFETCH_ID : instructionfetch
    port map(inst,PCplusfour,write_enable,clock,reset,flush_s,o_plusfour, opcode, rs, rt, inst1, inst2, Iadd);
    
 CONTROLLER: control
    port map(opcode, reg_dst, alusrc, memtoreg, regwrite, dmem_read, dmem_write, branch,aluop,flush);
 
 SIGNEX: SignExtender
    port map(Iadd, extendedaddress);   
    
 REGFILE1 : regfile
    port map (rs, rt, muxoutput, muxoutput2, readdata1, readdata2, wbregwrite, reset, clock);  
 
 --************ ???????same signal can be used for input and output??????????**************************************** 
 ID_EX : instructiondecoder
    port map(readdata1, readdata2, extendedaddress,inst1,rs,rt,inst2,regwrite_s,alusrc_s,aluop_s,reg_dst_s,mem_write_s,branch_s,mem_read_s,memtoreg_s,clock,o_readdata1,o_readdata2,o_extendedaddress,o_inst1,o_inst2,ex_rs,ex_rt,o_RegWrite,o_AluSrc,o_Aluop,o_Reg_dst,o_memtoreg,o_Mem_Write,o_branch, o_mem_read);
    
DST_MUX : mux2to1 generic map (M => 5)       -- The mux connected to the ID/EX
    port map (o_inst1, o_inst2, '1', muxoutput);
    
DST_MUX1 : mux2to1 generic map (M => 32)     -- The mux1 connected to the ID/EX
  port map(o_readdata2, o_extendedaddress, alusrc, muxoutput1);
  
 extendedaddress1 <= extendedaddress(29 downto 0) & "00"; -- shift left 2
 extendedaddress2 <= extendedaddress(31 downto 26); -- alucontrol input
 
  PC2 : adder
    port map (o_plusfour, extendedaddress1, addresult);
    
  CPU : alu
    port map(InputA, InputB, alucode, aluresult, ZeroFlag);   
    
  CPU2 : alucontrol
    
    port map(extendedaddress2,o_aluop,alucode);    
 
 EX_MEM : exmem
    port map(o_RegWrite,o_memtoreg,o_mem_write,o_mem_read,clock,aluresult,muxoutput,InputB,address,mem_write1,mem_read1,exregwrite,o_muxoutput,outputB,memtoreg1);
    
 CPU3 : and2
    port map(branch, ZeroFlag1, PCSrc);    
    
    dmem_addr <= address;
    rdata <= dmem_rdata;
 
 MEM_WB : writeback
   port map(dmem_rdata,address,exregwrite,o_muxoutput,clock,rdata,address1,wbregwrite,muxoutput_wb);
    
        
DST_MUX2 : mux2to1 generic map (M => 32)     -- The mux2 connected to the MEM/WB
  port map(rdata, address1, memtoreg2, muxoutput2);
  
DST_MUX0 : mux2to1 generic map (M => 32)     -- The mux0 connected to the PC
  port map(PCplusfour, addresult, PCSrc, PC);  
  
  
  -- More code here

  -- Jump target
 -- j_target <= PC(31 downto 28) & j_offset & "00";

  -- More code here
    
  -- Split the instructions into fields
 -- SPLIT : block
--  begin
--    opcode <= inst(31 downto 26);
    -- More code here
  --end block;
 
  -- More code here

--Program counter
  -- signal jumpAddress    : m32_word;
--  signal BranchAddress  : m32_word;
--  signal j_target    : m32_word;
--  signal j_offset  : m32_26bits;
--  signal mux3output : m32_word;
--  signal signext :  m32_word;
--  signal selectbit: m32_1bit;
  
    
     -- idex : mux2to1 
--    port map (rt, rd, reg_dst, dst);
--    
--      idex2 : mux2to1 
--    port map (, , , );
  
  -- The register file
  

  -- More code here
      
end structure;

