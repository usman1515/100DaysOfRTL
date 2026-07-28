library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
    generic (
        constant DATA_WIDTH : integer := 8
    );
    port (
        -- input ports
        i_data_a    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_data_b    : in std_logic_vector(DATA_WIDTH-1 downto 0);
        i_mode      : in std_logic_vector(3 downto 0);
        -- output ports
        o_data      : out std_logic_vector(DATA_WIDTH-1 downto 0);
        o_carry     : out std_logic
    );
end entity alu;

architecture behavioral of alu is

    -- constants
    constant MODE0 : std_logic_vector(3 downto 0) := x"0";
    constant MODE1 : std_logic_vector(3 downto 0) := x"1";
    constant MODE2 : std_logic_vector(3 downto 0) := x"2";
    constant MODE3 : std_logic_vector(3 downto 0) := x"3";
    constant MODE4 : std_logic_vector(3 downto 0) := x"4";
    constant MODE5 : std_logic_vector(3 downto 0) := x"5";
    constant MODE6 : std_logic_vector(3 downto 0) := x"6";
    constant MODE7 : std_logic_vector(3 downto 0) := x"7";
    constant MODE8 : std_logic_vector(3 downto 0) := x"8";
    constant MODE9 : std_logic_vector(3 downto 0) := x"9";
    constant MODE10 : std_logic_vector(3 downto 0) := x"a";
    constant MODE11 : std_logic_vector(3 downto 0) := x"b";
    constant MODE12 : std_logic_vector(3 downto 0) := x"c";
    constant MODE13 : std_logic_vector(3 downto 0) := x"d";
    constant MODE14 : std_logic_vector(3 downto 0) := x"e";
    constant MODE15 : std_logic_vector(3 downto 0) := x"f";

    -- signals
    signal alu_result : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal temp : std_logic_vector(DATA_WIDTH downto 0);

begin

    alu_modes : process(all)
    begin
        case i_mode is
            when MODE0 => alu_result <= std_logic_vector(unsigned(i_data_a) + unsigned(i_data_b));
            when MODE1 => alu_result <= std_logic_vector(unsigned(i_data_a) - unsigned(i_data_b));
            when MODE2 => alu_result <= std_logic_vector(resize(unsigned(i_data_a) *  unsigned(i_data_b), alu_result'length));
            when MODE3 => alu_result <= std_logic_vector(unsigned(i_data_a) / unsigned(i_data_b));
            when MODE4 => alu_result <= std_logic_vector(shift_left(unsigned(i_data_a), 1));
            when MODE5 => alu_result <= std_logic_vector(shift_right(unsigned(i_data_a), 1));
            when MODE6 => alu_result <= i_data_a(DATA_WIDTH-2 downto 0) & i_data_a(DATA_WIDTH-1);
            when MODE7 => alu_result <= i_data_b(DATA_WIDTH-1) & i_data_b(DATA_WIDTH-2 downto 0);
            when MODE8 => alu_result <= i_data_a and i_data_b;
            when MODE9 => alu_result <= i_data_a or i_data_b;
            when MODE10 => alu_result <= i_data_a xor i_data_b;
            when MODE11 => alu_result <= i_data_a nand i_data_b;
            when MODE12 => alu_result <= i_data_a nor i_data_b;
            when MODE13 => alu_result <= i_data_a xnor i_data_b;
            when MODE14 => alu_result <= (others => '1') when i_data_a > i_data_b else (others => '0');
            when MODE15 => alu_result <= (others => '1') when i_data_a = i_data_b else (others => '0');
            when others => alu_result <= (others => '0');
       end case;
    end process alu_modes;

    o_data <= alu_result;
    temp <= std_logic_vector(unsigned('0' & i_data_a) + unsigned('0' & i_data_b));
    o_carry <= temp(DATA_WIDTH);

end architecture behavioral;

