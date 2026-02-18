library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity d_cache is
port(  	din          	     : in std_logic_vector(31 downto 0);
	reset                : in  std_logic;
	clk                  : in  std_logic;
	data_write           : in  std_logic; 
	d_cache_address      : in  std_logic_vector(4 downto 0);
	dout                 : out std_logic_vector(31 downto 0));
end d_cache ;

architecture rtl of d_cache is
	type arr is array(0 to 31) of std_logic_vector(31 downto 0);
	signal R : arr := (others => (others => '0'));
begin
	process(clk, reset) is
	begin
		if(clk'event and clk = '1') then
			if(data_write = '1') then
				R(to_integer(unsigned(d_cache_address))) <= din;
			end if;
		end if;
		if(reset = '1') then
			R <= (others => (others => '0'));
		end if;
	end process;
	dout <= R(to_integer(unsigned(d_cache_address)));
end;
