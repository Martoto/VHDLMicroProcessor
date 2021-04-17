library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cu_toplvl_tb is
end entity;

architecture a_cu_toplvl_tb of cu_toplvl_tb is
    component cu_toplvl
        port (clk, 
        rst : in std_logic);
    end component;
    signal clk, rst : std_logic;
begin
    cu_c : cu_toplvl port map( clk, rst );
    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
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
