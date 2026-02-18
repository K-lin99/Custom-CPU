library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity alu1 is
port(x, y : in std_logic_vector(31 downto 0);
-- two input operands
add_sub : in std_logic ; -- 0 = add , 1 = sub
logic_func : in std_logic_vector(1 downto 0 ) ;
-- 00 = AND, 01 = OR , 10 = XOR , 11 = NOR
func : in std_logic_vector(1 downto 0 ) ;
-- 00 = lui, 01 = setless , 10 = arith , 11 = logic
alu_output : out std_logic_vector(31 downto 0) ;
overflow : out std_logic ;
zero : out std_logic);
end alu1 ;

architecture rtl of alu1 is
signal adder_substract_sig : signed(31 downto 0);
signal x_in : signed(31 downto 0);
signal y_in : signed(31 downto 0);
signal logic_unit_sig : signed(31 downto 0);
signal adder_substract_MSB : signed(31 downto 0);
signal zero_sig : signed(31 downto 0);
begin
    x_in <= signed(x);
    y_in <= signed(y);
    
    -- adder_subtract
    adder_substract_sig <= (x_in + y_in) when add_sub = '0' else
    (x_in - y_in) when add_sub = '1' ;
    
    -- logic unit
    logic_unit_sig  <= (x_in AND y_in) when logic_func = "00" else
    (x_in OR y_in) when logic_func = "01" else
    (x_in XOR y_in) when logic_func = "10" else
    (x_in NOR y_in) when logic_func = "11"; 
   
   -- MUX
    adder_substract_MSB <= (31 => adder_substract_sig(31), others => '0');
   
    with func select
        alu_output <= std_logic_vector(y_in) when "00",
        std_logic_vector(adder_substract_MSB) when "01",
        std_logic_vector(adder_substract_sig) when "10",
        std_logic_vector(logic_unit_sig) when others;
   
   -- zero
    zero_sig <= (others => '0');    
    zero <= '1' when adder_substract_sig = zero_sig else '0';
   
   -- overflow
    overflow <= '1' when (adder_substract_sig(31) = '1' and x_in(31) = '0' and y_in(31) = '0') or (adder_substract_sig(31) = '0' and x_in(31) = '1' and y_in(31) = '1') else '0';  
end;
