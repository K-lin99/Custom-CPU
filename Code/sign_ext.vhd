library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extension is
    port( 	sign_in : in std_logic_vector(15 downto 0);
    		func : in std_logic_vector(1 downto 0);
    		sign_out : out std_logic_vector(31 downto 0)
    );
    end sign_extension;
    
architecture rtl of sign_extension is 
signal signed_in : signed(15 downto 0);
begin
	signed_in <= signed(sign_in);
	with func select
    		  sign_out <= sign_in & x"0000"               when "00",
                  std_logic_vector(resize(signed_in, 32))         when "01",
                  std_logic_vector(resize(signed_in, 32))         when "10",
                  x"0000" & sign_in                             when others;
end;		              
