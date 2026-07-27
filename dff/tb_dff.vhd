library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_dff is
end entity tb_dff;

architecture behaviour of tb_dff is
    -- declare parameters
    constant DATA_WIDTH : integer := 8;
    constant CLK_PERIOD : time := 5 ns;
    constant T : time := 5 ns;

    -- create all the IO signals for the DUT
    signal clk      : std_logic;
    signal rst_n    : std_logic;
    signal in_data          : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal out_no_rst       : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal out_sync_rst     : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal out_async_rst    : std_logic_vector(DATA_WIDTH-1 downto 0);

    -- declare the DUT
    component dff is
        port (
            clk     : in std_logic;
            rst_n   : in std_logic;
            in_data         : in std_logic_vector(DATA_WIDTH-1 downto 0);
            out_no_rst      : out std_logic_vector(DATA_WIDTH-1 downto 0);
            out_sync_rst    : out std_logic_vector(DATA_WIDTH-1 downto 0);
            out_async_rst   : out std_logic_vector(DATA_WIDTH-1 downto 0)
        );
    end component dff;
begin

    -- instantiate the DUT
    INST_DFF : dff
    port map (
        clk         => clk,
        rst_n       => rst_n,
        in_data     => in_data,
        out_no_rst      => out_no_rst,
        out_sync_rst    => out_sync_rst,
        out_async_rst   => out_async_rst
    );

    -- create and provide stimulli to inputs
    clocking_block : process is
        begin
            wait for T; clk <= '1';
            wait for T; clk <= '0';
        end process clocking_block;

    -- create and provide stimulli to inputs
    testbench : process is
    begin
        report "begin simulation" severity note;
        wait for T; rst_n <= '1';
        wait for T; in_data <= x"aa";
        wait for T; rst_n <= '0';
        wait for T; in_data <= x"55";
        wait for T; rst_n <= '1';
        wait for T; in_data <= x"55";
        wait for T; rst_n <= '0';
        wait for T; in_data <= x"aa";
        report "end simulation" severity note;

        -- finish the simulation
        std.env.stop;
    end process testbench;

end architecture behaviour;
