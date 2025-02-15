library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use std.textio.all;

library vunit_lib;
context vunit_lib.vunit_context;


entity tb_logic_gates is
    generic (runner_cfg : string);      -- vunit runner
end entity tb_logic_gates;

architecture behaviour of tb_logic_gates is

    -- declare IO signals for DUT
    signal in_sigA          : std_logic := '0';
    signal in_sigB          : std_logic := '0';
    signal out_sig_notA     : std_logic;
    signal out_sig_notB     : std_logic;
    signal out_sig_and      : std_logic;
    signal out_sig_or       : std_logic;
    signal out_sig_xor      : std_logic;
    signal out_sig_nand     : std_logic;
    signal out_sig_nor      : std_logic;
    signal out_sig_xnor     : std_logic;

begin
    -- instantiate DUT and map ports
    INST_logic_gates : entity work.logic_gates
    -- generic map ();
    port map (
        i_dataA     => in_sigA,
        i_dataB     => in_sigB,
        o_data_notA => out_sig_notA,
        o_data_notB => out_sig_notB,
        o_data_and  => out_sig_and,
        o_data_nand => out_sig_or,
        o_data_or   => out_sig_xor,
        o_data_nor  => out_sig_nand,
        o_data_xor  => out_sig_nor,
        o_data_xnor => out_sig_xnor
    );

    -- provide stimulii to the ports and observe outputs
    main_tb : process is
    begin
        -- initialize test runner
        test_runner_setup(runner, runner_cfg);

        -- start simulation
        report "begin simulation" severity note;
        wait for 10 ns;
        in_sigA <= '0'; in_sigB <= '0';

        wait for 10 ns;
        report "| in_sigA: " & std_logic'image(in_sigA) & "| in_sigB: " & std_logic'image(in_sigB);
        in_sigA <= '0'; in_sigB <= '1';
        
        wait for 10 ns;
        report "| in_sigA: " & std_logic'image(in_sigA) & "| in_sigB: " & std_logic'image(in_sigB);
        in_sigA <= '1'; in_sigB <= '0';
        
        wait for 10 ns;
        report "| in_sigA: " & std_logic'image(in_sigA) & "| in_sigB: " & std_logic'image(in_sigB);
        in_sigA <= '1'; in_sigB <= '1';
        
        wait for 10 ns;
        report "| in_sigA: " & std_logic'image(in_sigA) & "| in_sigB: " & std_logic'image(in_sigB);
        report "end simulation" severity note;

        -- end test runner
        test_runner_cleanup(runner);
        -- finish the simulation
        wait;
    end process main_tb;

end architecture behaviour;

