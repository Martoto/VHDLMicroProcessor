library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cu_toplvl is
    port (
        clk, rst : in std_logic
    );
    end cu_toplvl;

architecture cu_toplvl_a of cu_toplvl is
    component pc is
        port (
            clk, rst, wr_en : in std_logic;
            dt_in  : in unsigned(11 downto 0);
            dt_out : out unsigned(11 downto 0)
        );
    end component;
    component stt_machine is
         -- sttmachine interface
        port (
        clk, rst: in std_logic;
        stt : out unsigned (0 downto 0)
        );
    end component;
    component rom is 
        port ( 
        clk      : in std_logic;
        rd : in unsigned(6 downto 0);
        dt_out     : out unsigned(15 downto 0) 
        ); 
    end component;
    component cu is 
        port (
            clk, rst : in std_logic;
            stt : in unsigned (0 downto 0);
            --para 16bits tlg
            dt_in : in unsigned (15 downto 0);
            --para exceptions
            flag  : out std_logic; 
            --operations
            no_op  : out std_logic; 
            jmp_op : out std_logic;
            --controle
            wr_en : out std_logic
        );
    end component;
    signal dt_in_s  : unsigned(15 downto 0) := "0000000000000000"; 
    signal pc_in  : unsigned(11 downto 0) := "000000000000";
    signal pc_out : unsigned(11 downto 0) := "000000000000";
    signal stt_s  : unsigned (0 downto 0) := "0";
    
    signal no_op_s      : std_logic := '0';
    signal jmp_op_s     : std_logic := '0';
    signal wr_en_s      : std_logic := '1';
    signal excpt_s      : std_logic := '0';

    begin
        pc_c : pc port map (
            clk => clk,
            rst => rst,
            wr_en => wr_en_s,
            dt_in => pc_in,
            dt_out => pc_out
        );

        stt_machine_c : stt_machine port map (
            clk, rst, stt_s
        );

        rom_c : rom port map (
            clk => clk,
            rd => pc_out(6 downto 0),
            dt_out => dt_in_S
        );

        cu_c : cu port map (
            stt => stt_s,
            dt_in => dt_in_s,
            clk => clk,
            rst => rst, 
            no_op => no_op_s,
            jmp_op => jmp_op_s,
            flag => excpt_s,
            wr_en => wr_en_s
        );

        pc_in <= dt_in_s(11 downto 0) when jmp_op_s = '1' else
                pc_out + 1;
   
end architecture;