library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity edge_detector is
    port (
        clk         : in std_logic;
        rst_n       : in std_logic;
        i_edge      : in std_logic;
        o_posedge   : out std_logic;
        o_negedge   : out std_logic
    );
end entity edge_detector;

architecture rtl of edge_detector is
    -- constants
    -- signals
    signal temp_edge : std_logic := '0';

begin

    edge_detect : process(clk)
    begin
        if rising_edge(clk) then
            if rst_n = '1' then
                temp_edge <= '0';
            else
                temp_edge <= i_edge;
            end if;
        end if;
    end process edge_detect;

    o_posedge <= i_edge and (not temp_edge);
    o_negedge <= (not i_edge) and temp_edge;

end architecture rtl;

