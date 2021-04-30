library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity;

architecture a_processor_tb of processor_tb is
    component processor
     port (
            clk, rst : in std_logic
    );
    end component;
    signal clk, rst : std_logic := '0';
    signal state : unsigned(1 downto 0) := "00";
begin
    -- connects processor
    processor_c : processor port map ( 
        clk, rst 
    );
    process
    begin
        clk <= '1';
        wait for 50 ns;
        clk <= '0';
        wait for 50 ns;
    end process;

    process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;
end architecture;

