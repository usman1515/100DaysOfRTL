library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dff is
    generic (
        DATA_WIDTH : integer := 8
    );
    port (
        clk     : in std_logic;
        rst_n   : in std_logic;
        in_data : in std_logic_vector(DATA_WIDTH-1 downto 0);
        out_no_rst      : out std_logic_vector(DATA_WIDTH-1 downto 0);
        out_sync_rst    : out std_logic_vector(DATA_WIDTH-1 downto 0);
        out_async_rst   : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity dff;

architecture rtl of dff is

begin
    -- FF with no reset
    no_reset: process(clk)
    begin
        if rising_edge(clk) then
            out_no_rst <= in_data;
        end if;
    end process no_reset;

    -- FF with clk and sync reset
    sync_reset: process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '1' then
                out_sync_rst <= x"00"; 
            else
                out_sync_rst <= in_data;
            end if;
        end if;
    end process sync_reset;

    -- FF with clk and async reset
    async_reset: process(clk, rst_n)
    begin
        if rst_n = '1' then
            out_async_rst <= x"00"; 
        elsif rising_edge(clk) then
            out_async_rst <= in_data;
        end if;
    end process async_reset;

end architecture rtl;
