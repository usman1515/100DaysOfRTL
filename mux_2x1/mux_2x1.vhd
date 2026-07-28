library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2x1 is
    generic (
        DATA_WIDTH : integer := 8
    );
    port (
        i_dataA    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_dataB    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_sel      : in std_logic;
        o_data    : out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity mux_2x1;

architecture rtl of mux_2x1 is

begin
    -- mux_2x1_behav1: process(all) -- works only on VHDL 2008
    mux_2x1_behav1: process(i_sel)
    begin
        if i_sel = '0' then
            o_data <= i_dataA;
        else
            o_data <= i_dataB;
        end if;
    end process mux_2x1_behav1;

    -- mux_2x1_behav2: process(i_sel)
    -- begin
        -- o_data <= (i_sel = '0') when i_dataA else i_dataB;
    -- end process mux_2x1_behav2;

end architecture rtl;

