library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.uniform;


entity tb_logic_gates is
end entity tb_logic_gates;

architecture behaviour of tb_logic_gates is

    -- constants
    constant T : time := 1 ns;

    -- declare IO signals for DUT
    signal i_sigA          : std_logic := '0';
    signal i_sigB          : std_logic := '0';
    signal o_sig_notA     : std_logic;
    signal o_sig_notB     : std_logic;
    signal o_sig_and      : std_logic;
    signal o_sig_or       : std_logic;
    signal o_sig_xor      : std_logic;
    signal o_sig_nand     : std_logic;
    signal o_sig_nor      : std_logic;
    signal o_sig_xnor     : std_logic;

begin
    -- instantiate DUT and map ports
    INST_logic_gates : entity work.logic_gates
    -- generic map ();
    port map (
        i_dataA     => i_sigA,
        i_dataB     => i_sigB,
        o_data_notA => o_sig_notA,
        o_data_notB => o_sig_notB,
        o_data_and  => o_sig_and,
        o_data_nand => o_sig_or,
        o_data_or   => o_sig_xor,
        o_data_nor  => o_sig_nand,
        o_data_xor  => o_sig_nor,
        o_data_xnor => o_sig_xnor
    );

    -- provide stimulii to the ports and observe outputs
    main_tb : process is
        -- generate random numbers
        variable seed_min, seed_max : positive := 1;
        variable rand_num : real;
        variable rand_int : integer;

    begin

        report "begin simulation" severity note;

        for i in 1 to 19 loop
            -- assign random value to input signals
            uniform(seed_min, seed_max, rand_num);  -- generate rand num [0,1]
            rand_int := integer(rand_num * 2.0);    -- convert value to integer
            i_sigA <= '0' when rand_int = 0 else '1';

            uniform(seed_min, seed_max, rand_num);  -- generate rand num [0,1]
            rand_int := integer(rand_num * 2.0);    -- convert value to integer
            i_sigB <= '1' when rand_int = 0 else '1';

            -- print outputs
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & "| sigA: " & std_logic'image(i_sigA)
            & "| sigB: " & std_logic'image(i_sigB)
            & "| notA: " & std_logic'image(o_sig_notA)
            & "| notB: " & std_logic'image(o_sig_notB)
            & "| and: " & std_logic'image(o_sig_and)
            & "| or: " & std_logic'image(o_sig_or)
            & "| xor: " & std_logic'image(o_sig_xor)
            & "| nand: " & std_logic'image(o_sig_nand)
            & "| nor: " & std_logic'image(o_sig_nor)
            & "| xnor: " & std_logic'image(o_sig_xnor);

            wait for T;
        end loop;

        report "end simulation" severity note;

        -- finish the simulation
        std.env.stop;
    end process main_tb;

end architecture behaviour;

