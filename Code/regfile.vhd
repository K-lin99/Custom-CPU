library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is
port( d_reg_in : in std_logic_vector(31 downto 0);
reset : in std_logic;
clk : in std_logic;
write : in std_logic;
read_a : in std_logic_vector(4 downto 0);
read_b : in std_logic_vector(4 downto 0);
write_address : in std_logic_vector(4 downto 0);
out_a : out std_logic_vector(31 downto 0);
out_b : out std_logic_vector(31 downto 0));
end regfile ;

architecture rtl of regfile is
	type arr is array (0 to 31) of std_logic_vector(31 downto 0);
	signal R : arr := (others => (others => '0'));
	begin
		process(clk,reset) is
		begin
		if (clk'event and clk = '1') then
			if (write = '1') then 
				R(to_integer(unsigned(write_address))) <= d_reg_in;
			end if;
		end if;
		if (reset = '1') then
			R <= (others => (others => '0'));
		end if;
	end process;
	out_a <= R(to_integer(unsigned(read_a)));
	out_b <= R(to_integer(unsigned(read_b)));
end;
