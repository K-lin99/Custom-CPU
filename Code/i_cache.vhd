library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity icache is
port(   	i_cache_address	 : in  std_logic_vector(4 downto 0);
		data_out         : out std_logic_vector(31 downto 0));
end icache ;

architecture rtl of icache is
begin
    process(i_cache_address)
    begin
        case i_cache_address is
            -- Initializing counter to 1: addi $t0, $zero, 1
            when "00000" => data_out <= x"20080001"; -- opcode 001000, rs=0, rt=8, imm=1

            -- Initializing limit to 10: addi $t1, $zero, 10
            when "00001" => data_out <= x"2009000A"; 

            -- Loop: addi $t0, $t0, 1
            when "00010" => data_out <= x"21080001"; -- incrementing counter

            -- bne $t0, $t1, loop
            when "00011" => data_out <= x"1509FFFE"; -- branch back if counter is not equal to limit

            -- sw $t0, 0($zero)
            when "00100" => data_out <= x"AC080000"; -- storing content in $t0 into memory address 0

            -- lw $t2, 0($zero)
            when "00101" => data_out <= x"8C0A0000"; -- loads content in memory address to $t2

            -- and $t3, $t0, $t2
            when "00110" => data_out <= x"010A5824"; -- ands $t0 with $t2 and stores into $t3

            -- or $t4, $t0, $t2
            when "00111" => data_out <= x"010A6025"; -- ors $t0 with $t2 and stores into $t4

            -- xor $t5, $t0, $t2
            when "01000" => data_out <= x"010A6826"; -- xors $t0 with $t2 and stores into $t5

            when others  => data_out <= x"00000000";
        end case;
    end process;
end;

