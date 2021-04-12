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
        -- register selectors
        read_reg0 : in unsigned(2 downto 0);
        read_reg1 : in unsigned(2 downto 0);
        write_reg : in unsigned(2 downto 0);
        -- data input
        data_in : in unsigned(15 downto 0);
        -- data output
        read_data0 : out unsigned(15 downto 0);
        read_data1 : out unsigned(15 downto 0)
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
   
end architecture;