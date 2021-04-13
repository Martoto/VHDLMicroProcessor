library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regTopLevel_tb is
end entity;

architecture a_regTopLevel_tb of regTopLevel_tb is
    component regTopLevel is
        port (
        cnst : in std_logic;
        cnst_dt : in unsigned(15 downto 0);
        -- control
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        op : in unsigned(1 downto 0);
        -- address selection
        rd0 : in unsigned(2 downto 0);
        rd1 : in unsigned(2 downto 0);
        wr : in unsigned(2 downto 0);
        -- data input
        dt_in : in unsigned(15 downto 0);
        -- data output
        dt_out : out unsigned(15 downto 0)
    );
    end component;
    signal clk, rst, wr_en, cnst : std_logic := '0';
    signal op : unsigned(1 downto 0) := "00";
    signal rd0, rd1, wr:
        unsigned(2 downto 0) := "000";
    signal cnst_dt, dt_in, dt_out:
        unsigned(15 downto 0) := "0000000000000000";
begin
    uut : regTopLevel port map (
        cnst, cnst_dt, clk, rst, wr_en, op,      
        rd0, rd1, wr, 
        dt_in, dt_out
    );
    process
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process
    begin
        wait for 100 ns;


        wr_en <= '1';
        cnst <= '0';
        --escrita
        wr <= "001";
        dt_in <= "0000000000000001";
        wait for 50 ns;
        wr <= "010";
        dt_in <= "0000000000000001";
        wait for 50 ns;

        wr_en <= '0';
        --leitura
        rd1 <= "001";
        rd0 <= "010";
        op <= "00";


        
        wait;
    end process;
end architecture;