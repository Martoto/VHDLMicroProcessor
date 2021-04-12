library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;


ENTITY ula_tb is 
END ula_tb;

architecture a_ula_tb of ula_tb is

    component ula 
        port ( 
        a  :  in unsigned(15 downto 0);
        b  :  in unsigned(15 downto 0);
        op:  in unsigned(1 downto 0);
        ula_out:  out unsigned(15 downto 0)
        );
    end component;

    signal a : unsigned(15 downto 0) := (others => '0');
    signal b : unsigned(15 downto 0) := (others => '0');
    signal op : unsigned(1 downto 0) := (others => '0');

    signal ula_out : unsigned(15 downto 0);

    begin 

        uut: ula port map (
            a => a,
            b => b,
            op => op,
            ula_out => ula_out
        );

    process begin
        a <= "0000000000000110";
        b <= "0000000000000110";
        op <= "00";
        wait for 50 ns;
        a <= "1000000000000000";
        b <= "1000000000000000";
        op <= "00";
        wait for 50 ns;
        a <= "1000000000000110";
        b <= "1000000000000111";
        op <= "01";
        wait for 50 ns;
        a <= "0000000000000110";
        b <= "0000000000000110";
        op <= "01";
        wait for 50 ns;
        a <= "0000000000000110";
        b <= "0000000000000110";
        op <= "10";
        wait for 50 ns;
        a <= "0000000000000110";
        b <= "0000000000000110";
        op <= "11";
        wait for 50 ns; 
    end process;
    end architecture;

