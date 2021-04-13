library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- registers interface
entity registers is
    port (
        -- control
        clk : in std_logic;
        rst : in std_logic;
        wr_en : in std_logic;
        -- address selection
        rd0 : in unsigned(2 downto 0);
        rd1 : in unsigned(2 downto 0);
        wr : in unsigned(2 downto 0);
        -- data input
        data_in : in unsigned(15 downto 0);
        -- data output
        dt_out0 : out unsigned(15 downto 0);
        dt_out1 : out unsigned(15 downto 0)
    );
end entity;

architecture a_registers of registers is
    -- reg16 interface 
    component reg16
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;
   
    -- signals
    signal wr_enablers : unsigned(7 downto 0) := "00000000";
    signal reg_data0 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data1 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data2 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data3 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data4 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data5 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data6 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data7 : unsigned(15 downto 0) := "0000000000000000";
begin

    wr_enablers <= "00000010" when wr = "001" else
                   "00000100" when wr = "010" else 
                   "00001000" when wr = "011" else 
                   "00010000" when wr = "100" else 
                   "00100000" when wr = "101" else 
                   "01000000" when wr = "110" else 
                   "10000000" when wr = "111"; 
    
    -- connects registers 
    reg0 : reg16 port map (
        data_in => data_in,
        wr_en => '0',
        clk => clk,
        rst => rst,
        data_out => reg_data0
    );
    reg1 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(1),
        clk => clk,
        rst => rst,
        data_out => reg_data1
    );
    reg2 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(2),
        clk => clk,
        rst => rst,
        data_out => reg_data2
    );
    reg3 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(3),
        clk => clk,
        rst => rst,
        data_out => reg_data3
    );
    reg4 : reg16 port map (
        data_in => data_in, 
        wr_en => wr_enablers(4),
        clk => clk,
        rst => rst,
        data_out => reg_data4
    );
    reg5 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(5),
        clk => clk,
        rst => rst,
        data_out => reg_data5
    );
    reg6 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(6),
        clk => clk,
        rst => rst,
        data_out => reg_data6
    );
    reg7 : reg16 port map (
        data_in => data_in,
        wr_en => wr_enablers(7),
        clk => clk,
        rst => rst,
        data_out => reg_data7
    );

    dt_out0   <= reg_data0  when rd0 = "000" else
                 reg_data1  when rd0 = "001" else
                 reg_data2  when rd0 = "010" else
                 reg_data3  when rd0 = "011" else
                 reg_data4  when rd0 = "100" else
                 reg_data5  when rd0 = "101" else
                 reg_data6  when rd0 = "110" else
                 reg_data7  when rd0 = "111" else
                 "0000000000000000";

    dt_out1   <= reg_data0  when rd1 = "000" else
                 reg_data1  when rd1 = "001" else
                 reg_data2  when rd1 = "010" else
                 reg_data3  when rd1 = "011" else
                 reg_data4  when rd1 = "100" else
                 reg_data5  when rd1 = "101" else
                 reg_data6  when rd1 = "110" else
                 reg_data7  when rd1 = "111" else
                 "0000000000000000";

end architecture;