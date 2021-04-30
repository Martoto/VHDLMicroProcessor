library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16 is
    -- reg16 interface
    port (
        clk, rst, wr_en : in std_logic;
        dt_in  : in unsigned(15 downto 0);
        dt_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_reg16 of reg16 is
    -- signals
    signal reg_dt : unsigned(15 downto 0) := "0000000000000000";
begin
    process (clk, rst, wr_en)
    begin
        if rst = '1' then
            reg_dt <= "0000000000000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                reg_dt <= dt_in;
            end if;
        end if;
    end process;
    dt_out <= reg_dt;
end architecture;