library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.uniform;

entity tb_edge_detector is
end entity tb_edge_detector;

architecture behaviour of tb_edge_detector is
    -- declare parameters
    constant CLK_PERIOD : time := 5 ns;
    constant T : time := 2 ns;

    -- create IO signals for DUT
    signal clk : std_logic;
    signal rst_n : std_logic := '0';
    signal i_edge : std_logic := '0';
    signal o_posedge : std_logic;
    signal o_negedge : std_logic;

begin

    -- instantiate DUT
    INST_edge_detector: entity work.edge_detector
    port map (
        clk         => clk,
        rst_n       => rst_n,
        i_edge      => i_edge,
        o_posedge   => o_posedge,
        o_negedge   => o_negedge
    );

    -- clock generator
    clk_gen: process
    begin
        wait for T; clk <= '1';
        wait for T; clk <= '0';
    end process clk_gen;

    -- main tb loop
    main_tb_loop: process

        variable seed_min, seed_max : positive := 1;
        variable rand_val : real;
        variable rand_int : integer;

    begin
        for i in 0 to 4 loop
            rst_n <= '0';
            i_edge <= '0';

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | Rst: " & std_logic'image(rst_n)
            & " | InEdge: " & std_logic'image(i_edge)
            & " | OutPosedge : " & std_logic'image(o_posedge)
            & " | OutNegedge: " & std_logic'image(o_negedge)
            severity note;
            wait for T;
        end loop;
        for i in 0 to 4 loop
            rst_n <= '0';
            i_edge <= '1';

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | Rst: " & std_logic'image(rst_n)
            & " | InEdge: " & std_logic'image(i_edge)
            & " | OutPosedge : " & std_logic'image(o_posedge)
            & " | OutNegedge: " & std_logic'image(o_negedge)
            severity note;
            wait for T;
        end loop;
        for i in 0 to 4 loop
            rst_n <= '1';
            i_edge <= '0';

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | Rst: " & std_logic'image(rst_n)
            & " | InEdge: " & std_logic'image(i_edge)
            & " | OutPosedge : " & std_logic'image(o_posedge)
            & " | OutNegedge: " & std_logic'image(o_negedge)
            severity note;
            wait for T;
        end loop;
        for i in 0 to 4 loop
            rst_n <= '1';
            i_edge <= '1';

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | Rst: " & std_logic'image(rst_n)
            & " | InEdge: " & std_logic'image(i_edge)
            & " | OutPosedge : " & std_logic'image(o_posedge)
            & " | OutNegedge: " & std_logic'image(o_negedge)
            severity note;
            wait for T;
        end loop;

        for i in 0 to 19 loop
            -- assign random values to inputs
            uniform(seed_min, seed_max, rand_val);
            rand_int := integer(rand_val * 2.0);
            rst_n <= '0' when rand_int = 0 else '1';

            uniform(seed_min, seed_max, rand_val);
            rand_int := integer(rand_val * 2.0);
            i_edge <= '0' when rand_int = 0 else '1';

            -- print output equivalent to $display
            report "| Time: " & integer'image(now / 1 ns) & " ns"
            & " | Rst: " & std_logic'image(rst_n)
            & " | InEdge: " & std_logic'image(i_edge)
            & " | OutPosedge : " & std_logic'image(o_posedge)
            & " | OutNegedge: " & std_logic'image(o_negedge)
            severity note;
            wait for T;
        end loop;

        -- end simulation
        std.env.stop; -- $finish;
    end process main_tb_loop;

end architecture behaviour;

