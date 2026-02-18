library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity next_address is
    port(   rt, rs : in std_logic_vector(31 downto 0);
        -- two register inputs
        pc : in std_logic_vector(31 downto 0);
        target_address : in std_logic_vector(25 downto 0);
        branch_type : in std_logic_vector(1 downto 0);
        pc_sel : in std_logic_vector(1 downto 0);
        next_pc : out std_logic_vector(31 downto 0)   );
end next_address ;

architecture rtl of next_address is
signal branch_res : signed(31 downto 0);
begin
    branch_res <= resize(signed(target_address), 32) + 1 when (branch_type = "01" and rs = rt)  or 
                                        (branch_type = "10" and rs /= rt) or 
                                        (branch_type = "11" and rs(31) = '1') else
              to_signed(1, 32);

    with pc_sel select
    next_pc <= std_logic_vector(branch_res + signed(pc)) when "00",
           "000000" & target_address    when "01",
               rs                           when "10",
               pc                           when others;

end;
