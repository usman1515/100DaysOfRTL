library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_mux_2x1 is
end entity tb_mux_2x1;

architecture behavioural of tb_mux_2x1 is
    -- declare parameters
    constant DATA_WIDTH : integer := 8;
    constant T : time := 10 ns;
    constant MIN_VAL : integer := 0;
    constant MAX_VAL : integer := 255;
    constant VAL_RANGE : integer := MAX_VAL - MIN_VAL + 1;

    -- declare IO signals for the DUT
    signal i_dataA : std_logic_vector(DATA_WIDTH-1 downto 0) := x"00";
    signal i_dataB : std_logic_vector(DATA_WIDTH-1 downto 0) := x"00";
    signal i_sel   : std_logic := '0';
    signal o_data : std_logic_vector(DATA_WIDTH-1 downto 0);

begin
    -- instantiate the DUT
    INST_mux_2x1: entity work.mux_2x1
    generic map (
        DATA_WIDTH => DATA_WIDTH
    )
    port map (
        i_dataA => i_dataA,
        i_dataB => i_dataB,
        i_sel   => i_sel,
        o_data  => o_data
    );

    -- give stimulii to input and observe outputs
    main_tb_loop: process is
    begin
        report "begin simulation" severity note;

        wait for T; i_dataA <= x"aa"; i_dataB <= x"ff"; i_sel <='0';
        wait for T; i_dataA <= x"bb"; i_dataB <= x"ee"; i_sel <='1';
        wait for T; i_dataA <= x"cc"; i_dataB <= x"dd"; i_sel <='0';
        wait for T; i_dataA <= x"dd"; i_dataB <= x"cc"; i_sel <='1';
        wait for T; i_dataA <= x"ee"; i_dataB <= x"bb"; i_sel <='0';
        wait for T; i_dataA <= x"ff"; i_dataB <= x"aa"; i_sel <='1';
        wait for T;

        report "end simulation" severity note;

        -- finish the simulation
        std.env.stop;
    end process main_tb_loop;

end architecture behavioural;

