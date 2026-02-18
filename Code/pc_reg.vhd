library IEEE;
use IEEE.std_logic_1164.all;

entity pc_reg is
	port(	pc 		: in std_logic_vector(31 downto 0);
		clk, reset	: in std_logic;
		next_pc 	: out std_logic_vector(31 downto 0));
end pc_reg ;

architecture rtl of pc_reg is
begin
	process(clk, reset) is
	begin
		if(clk'event and clk = '1') then
			next_pc <= pc;
		end if;
		if(reset = '1') then
			next_pc <= (others => '0');
		end if;
	end process;
end;
