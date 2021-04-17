library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers_tb is
end entity;

architecture a_registers_tb of registers_tb is
    component registers is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            read_reg0 : in unsigned(2 downto 0);
            read_reg1 : in unsigned(2 downto 0);
            write_reg : in unsigned(2 downto 0);
            dt_in : in unsigned(15 downto 0);
            read_dt0 : out unsigned(15 downto 0);
            read_dt1 : out unsigned(15 downto 0)
        );
    end component;
    signal clk, rst, wr_en : std_logic := '0';
    signal read_reg0, read_reg1, write_reg:
        unsigned(2 downto 0) := "000";
    signal dt_in, read_dt0, read_dt1:
        unsigned(15 downto 0) := "0000000000000000";
begin
    uut : registers port map (
        clk, rst, wr_en, 
        read_reg0, read_reg1, write_reg, 
        dt_in, read_dt0, read_dt1
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
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait;
    end process;
    process
    begin
        wait for 100 ns;
        
        wr_en <= '0';
        read_reg0 <= "001";
        read_reg1 <= "001";
        wait for 100 ns; 
        read_reg0 <= "010";
        read_reg1 <= "010";
        wait for 100 ns; 
        read_reg0 <= "011";
        read_reg1 <= "011";
        wait for 100 ns; 
        read_reg0 <= "100";
        read_reg1 <= "100";
        wait for 100 ns; 
        read_reg0 <= "101";
        read_reg1 <= "101";
        wait for 100 ns; 
        read_reg0 <= "110";
        read_reg1 <= "110";
        wait for 100 ns; 
        read_reg0 <= "111";
        read_reg1 <= "111";
        wait for 100 ns;

        wr_en <= '1';
        read_reg0 <= "000";
        read_reg1 <= "000";
        write_reg <= "000";
        dt_in <= "0000000000000001";
        wait for 100 ns;
        write_reg <= "001";
        dt_in <= "0000000000000010";
        wait for 100 ns;
        write_reg <= "010";
        dt_in <= "0000000000000011";
        wait for 100 ns;
        write_reg <= "011";
        dt_in <= "0000000000000100";
        wait for 100 ns;
        write_reg <= "100";
        dt_in <= "0000000000000101";
        wait for 100 ns;
        write_reg <= "101";
        dt_in <= "0000000000000110";
        wait for 100 ns;
        write_reg <= "110";
        dt_in <= "0000000000000111";
        wait for 100 ns;
        write_reg <= "111";
        dt_in <= "0000000000001000";
        wait for 100 ns;

        write_reg <= "000";
        dt_in <= "0000000000000000";
        wr_en <= '0';
        read_reg0 <= "000";
        read_reg1 <= "000";
        wait for 100 ns; 
        read_reg0 <= "001";
        read_reg1 <= "001";
        wait for 100 ns; 
        read_reg0 <= "010";
        read_reg1 <= "010";
        wait for 100 ns; 
        read_reg0 <= "011";
        read_reg1 <= "011";
        wait for 100 ns; 
        read_reg0 <= "100";
        read_reg1 <= "100";
        wait for 100 ns; 
        read_reg0 <= "101";
        read_reg1 <= "101";
        wait for 100 ns; 
        read_reg0 <= "110";
        read_reg1 <= "110";
        wait for 100 ns; 
        read_reg0 <= "111";
        read_reg1 <= "111";
        wait for 100 ns; 
        wait;
    end process;
end architecture;