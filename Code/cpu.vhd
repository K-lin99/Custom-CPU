library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
entity cpu is
port(reset : in std_logic;
clk : in std_logic;
rs_out, rt_out : out std_logic_vector(3 downto 0);
-- output ports from register file
pc_out : out std_logic_vector(3 downto 0); -- pc reg
overflow, zero : out std_logic);
end cpu;

architecture rtl of cpu is 
-- Control signals
signal alu_src     : std_logic;
signal load        : std_logic;
signal reg_dst     : std_logic;
signal write       : std_logic;
signal add_sub     : std_logic;
signal logic_func  : std_logic_vector(1 downto 0);
signal func        : std_logic_vector(1 downto 0);
signal branch_type : std_logic_vector(1 downto 0);
signal pc_sel      : std_logic_vector(1 downto 0);
signal data_write  : std_logic;

-- Other signals 
signal opcode : std_logic_vector(5 downto 0);
signal func_code : std_logic_vector(5 downto 0);
signal alu_src_out : std_logic_vector(31 downto 0);
signal dest : std_logic_vector(4 downto 0);
signal reg_src_out : std_logic_vector(31 downto 0); 
signal instruct : std_logic_vector(31 downto 0);
signal rt : std_logic_vector(4 downto 0);
signal rd : std_logic_vector(4 downto 0);
signal rs : std_logic_vector(4 downto 0);
signal pc : std_logic_vector(31 downto 0);
signal target_address : std_logic_vector(25 downto 0);
signal next_pc : std_logic_vector(31 downto 0);
signal i_cache_address : std_logic_vector(4 downto 0);
signal data_out : std_logic_vector(31 downto 0);
signal d_reg_in : std_logic_vector(31 downto 0);
signal din : std_logic_vector(31 downto 0);
signal read_a : std_logic_vector(4 downto 0);
signal read_b : std_logic_vector(4 downto 0);
signal write_address : std_logic_vector(4 downto 0);
signal out_a : std_logic_vector(31 downto 0);
signal out_b : std_logic_vector(31 downto 0);
signal sign_in : std_logic_vector(15 downto 0);
signal sign_out : std_logic_vector(31 downto 0);
signal x, y : std_logic_vector(31 downto 0);
signal alu_output : std_logic_vector(31 downto 0);
signal d_cache_address :  std_logic_vector(4 downto 0);
signal dout : std_logic_vector(31 downto 0);

begin
rs <= instruct(25 downto 21);
rt <= instruct(20 downto 16);
rd <= instruct(15 downto 11);

rs_out <= out_a(3 downto 0); 
rt_out <= out_b(3 downto 0);
pc_out <= pc(3 downto 0); 

dest <= rt when reg_dst = '0' else rd; 
reg_src_out <= dout when load = '0' else alu_output;  
alu_src_out <= out_b when alu_src = '0' else sign_out;

        NEXT_ADDRESS : entity work.next_address(rtl)
        	port map (
        		rt => out_b,
        		rs => out_a,
        		pc => pc,
        		target_address => instruct(25 downto 0),
        		branch_type => branch_type,
        		pc_sel => pc_sel,
        		next_pc => next_pc
        	);
		
	PC_REG : entity work.pc_reg(rtl)
		port map (
			pc => next_pc,
			clk => clk,
			reset => reset,
			next_pc => pc
		);
		
	ICACHE : entity work.icache(rtl)
		port map (
			i_cache_address => pc(4 downto 0),
			data_out => instruct 
		);

		
	REGFILE : entity work.regfile(rtl)
		port map (
			d_reg_in => reg_src_out,
			reset => reset,
			clk => clk,
			write => write,
			read_a => rs,
			read_b => rt,
			write_address => dest,
			out_a => out_a,
			out_b => out_b
		);
		
	SIGN_EXTENSION : entity work.sign_extension(rtl)
		port map (
			sign_in => instruct(15 downto 0),
			func => func,
			sign_out => sign_out
		);
		
	ALU : entity work.alu1(rtl)
		port map (
			x => out_a,
			y => alu_src_out,
			add_sub => add_sub,
			logic_func => logic_func,
			func => func,
			alu_output => alu_output,
			overflow => overflow,
			zero => zero
		);
		
	DCACHE : entity work.d_cache(rtl)
		port map (
			din => out_b,
			reset => reset,
			clk => clk,
			data_write => data_write,
			d_cache_address => alu_output(4 downto 0),
			dout => dout
		);
		
	CTRL_UNIT : entity work.control_unit(rtl)
		port map (
			opcode => instruct(31 downto 26),
			func_code => instruct(5 downto 0),
			alu_src => alu_src,    
			load => load,      
			reg_dst => reg_dst,   
			write => write,     
			add_sub => add_sub,   
			logic_func => logic_func,
			func => func,      
			branch_type => branch_type,
			pc_sel => pc_sel,    
			data_write => data_write
		);

end;
