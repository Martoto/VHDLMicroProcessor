library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regTopLevel is
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
        dt_out0 : out unsigned(15 downto 0);
        dt_out1 : out unsigned(15 downto 0);
        ula_out:  out unsigned(15 downto 0)    
        );
end regTopLevel;


architecture a_regTopLevel of regTopLevel is
    component registers is
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
        dt_in : in unsigned(15 downto 0);
        -- data output
        dt_out0 : out unsigned(15 downto 0);
        dt_out1 : out unsigned(15 downto 0);
        ula_out:  out unsigned(15 downto 0)
        );
    end component;
    
    component ula is 
        port ( 
            --os dois operandos
            a  :  in unsigned(15 downto 0);
            b  :  in unsigned(15 downto 0);
            --operação
            op:  in unsigned(1 downto 0);
            ula_out:  out unsigned(15 downto 0)
        );
    end component;

    signal reg_data0 : unsigned(15 downto 0) := "0000000000000000";
    signal reg_data1 : unsigned(15 downto 0) := "0000000000000000";
    signal ula_mux   : unsigned(15 downto 0) := "0000000000000000";

    begin


    reg : registers port map (
        clk => clk,
        dt_in => dt_in,
        rst => rst,
        wr_en => wr_en,
        rd0 => rd0,
        rd1 => rd1,
        wr => wr,
        dt_out0 => reg_data0,
        dt_out1 => reg_data1
    );    
    ula_mux <= reg_data1 when cnst = '0' else
            cnst_dt;
    alu : ula port map (
        a => reg_data0,
        b => ula_mux,
        op => op,    
        ula_out => ula_out
    );

end a_regTopLevel;