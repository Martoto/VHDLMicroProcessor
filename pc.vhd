library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
    -- pc interface
    port (
        clk, rst, wr_en : in std_logic;
        dt_in  : in unsigned(11 downto 0);
        dt_out : out unsigned(11 downto 0)
    );
end entity;

architecture a_pc of pc is
    signal pc_dt : unsigned(11 downto 0) := "000000000000";
begin
    process (clk, rst, wr_en)
    begin
        if rst = '1' then
            pc_dt <= "000000000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                pc_dt <= dt_in;
            end if;
        end if;
    end process;
    dt_out <= pc_dt;
end architecture;