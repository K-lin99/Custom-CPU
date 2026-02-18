library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity control_unit is 
port(
opcode      : in std_logic_vector(5 downto 0);
func_code   : in std_logic_vector(5 downto 0);
alu_src     : out std_logic;
load        : out std_logic;
reg_dst     : out std_logic;
write       : out std_logic;
add_sub     : out std_logic;
logic_func  : out std_logic_vector(1 downto 0);
func        : out std_logic_vector(1 downto 0);
branch_type : out std_logic_vector(1 downto 0);
pc_sel      : out std_logic_vector(1 downto 0);
data_write  : out std_logic);
end control_unit;

architecture rtl of control_unit is 
begin
	process(opcode, func_code)
	begin
		if opcode = "000000" then 
			if func_code = "100000" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '0';
				logic_func    <= "00";
				func          <= "10";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "100010" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '1';
				logic_func    <= "00";
				func          <= "10";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "101010" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '0';
				logic_func    <= "00";
				func          <= "01";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "100100" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '1';
				logic_func    <= "00";
				func          <= "11";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "100101" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '0';
				logic_func    <= "01";
				func          <= "11";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "100110" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '0';
				logic_func    <= "10";
				func          <= "11";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "100111" then
				alu_src       <= '0';
				load          <= '1';
				reg_dst       <= '1';
				write         <= '1';
				add_sub       <= '0';
				logic_func    <= "11";
				func          <= "11";
				branch_type   <= "00";
				pc_sel        <= "00";
				data_write    <= '0';
			elsif func_code = "001000" then
				alu_src       <= '0';
				load          <= '0';
				reg_dst       <= '0';
				write         <= '0';
				add_sub       <= '0';
				logic_func    <= "00";
				func          <= "00";
				branch_type   <= "00";
				pc_sel        <= "10";
				data_write    <= '0';
			end if;
		elsif opcode = "001111" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "001000" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "10";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "001010" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "01";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "001100" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '1';
			logic_func    <= "00";
			func          <= "11";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "001101" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "01";
			func          <= "11";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "001110" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "10";
			func          <= "11";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "100011" then
			alu_src       <= '1';
			load          <= '0';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "10";
			func          <= "10";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "101011" then
			alu_src       <= '1';
			load          <= '1';
			reg_dst       <= '0';
			write         <= '1';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "00";
			pc_sel        <= "00";
			data_write    <= '1';
		elsif opcode = "000010" then
			alu_src       <= '0';
			load          <= '0';
			reg_dst       <= '0';
			write         <= '0';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "00";
			pc_sel        <= "01";
			data_write    <= '0';
		elsif opcode = "000001" then
			alu_src       <= '0';
			load          <= '0';
			reg_dst       <= '0';
			write         <= '0';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "11";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "000100" then
			alu_src       <= '0';
			load          <= '0';
			reg_dst       <= '0';
			write         <= '0';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "01";
			pc_sel        <= "00";
			data_write    <= '0';
		elsif opcode = "000101" then
			alu_src       <= '0';
			load          <= '0';
			reg_dst       <= '0';
			write         <= '0';
			add_sub       <= '0';
			logic_func    <= "00";
			func          <= "00";
			branch_type   <= "10";
			pc_sel        <= "00";
			data_write    <= '0';
		end if;
	end process;
end;
