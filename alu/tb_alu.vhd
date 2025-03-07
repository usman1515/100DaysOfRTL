library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.uniform;


entity tb_alu is
end entity tb_alu;

architecture behaviour of tb_alu is
    -- constants
    constant T : time := 5 ns;
    constant DATA_WIDTH : integer := 8;

    -- declare IO signals for DUT
    signal i_data_a : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal i_data_b : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
    signal i_mode : std_logic_vector(3 downto 0) := (others => '0');
    signal o_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal o_carry : std_logic;

begin

    -- instantiate DUT and map ports
    INST_alu : entity work.alu
    generic map (
        DATA_WIDTH => DATA_WIDTH
    )
    port map (
        i_data_a => i_data_a,
        i_data_b => i_data_b,
        i_mode => i_mode,
        o_data => o_data,
        o_carry => o_carry
    );

    main_loop : process
        -- generate random numbers
        variable seed_min, seed_max : positive := 1;
        variable rand_num : real;
        variable rand_int : integer;

    begin

        report "begin simulation" severity note;

        for i in 0 to 31 loop
            uniform(seed_min, seed_max, rand_num);
            i_data_a <= std_logic_vector(to_unsigned(integer(rand_num * 255.0), DATA_WIDTH));
            uniform(seed_min, seed_max, rand_num);
            i_data_b <= std_logic_vector(to_unsigned(integer(rand_num * 255.0), DATA_WIDTH));
            uniform(seed_min, seed_max, rand_num);
            i_mode <= std_logic_vector(to_unsigned(integer(rand_num * 16.0), 4));

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | InData_A: " & integer'image(to_integer(unsigned(i_data_a)))
            & " | InData_B: " & integer'image(to_integer(unsigned(i_data_b)))
            & " | InMode: " & integer'image(to_integer(unsigned(i_mode)))
            & " | OutData: " & integer'image(to_integer(unsigned(o_data)))
            & " | OutCarry: " & std_logic'image(o_carry)
            severity note;

            wait for T;
        end loop;

        report "end simulation" severity note;

        -- finish simulation
        std.env.stop; -- $finish
    end process main_loop ;

end architecture behaviour;
