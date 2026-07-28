library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic_gates is
    port (
        -- input ports
        i_dataA     : in std_logic;
        i_dataB     : in std_logic;
        -- output ports
        o_data_notA : out std_logic;
        o_data_notB : out std_logic;
        o_data_and  : out std_logic;
        o_data_nand : out std_logic;
        o_data_or   : out std_logic;
        o_data_nor  : out std_logic;
        o_data_xor  : out std_logic;
        o_data_xnor : out std_logic
    );
end entity logic_gates;

architecture rtl of logic_gates is
    -- constants
    -- signals
begin

    o_data_notA <= not i_dataA;
    o_data_notB <= not i_dataB;
    o_data_and  <= i_dataA and i_dataB;
    o_data_nand <= i_dataA nand i_dataB;
    o_data_or   <= i_dataA or i_dataB;
    o_data_nor  <= i_dataA nor i_dataB;
    o_data_xor  <= i_dataA xor i_dataB;
    o_data_xnor <= i_dataA xnor i_dataB;

end architecture rtl;
