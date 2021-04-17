library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sttmchne is
    -- sttmchne interface
    port (
        clk, rst: in std_logic;
        stt : out unsigned (0 downto 0)
    );
end entity;

architecture a_sttmchne of sttmchne is
    signal stt_s : unsigned (0 downto 0);

begin
    process (clk, rst)
    begin
        if rst = '1' then
            stt_s <= "0";
        else
            if rising_edge(clk) then
                if (stt_s = "1") then
                    stt_s <= "0";
                else
                    stt_s <= stt_s + 1;
                end if;
            end if;
        end if;
    end process;
    stt <= stt_s;
end architecture;