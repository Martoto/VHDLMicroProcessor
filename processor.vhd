library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
    port (
        clk, rst : in std_logic
    );
    end processor;

architecture processor_a of processor is
    component pc is
        port (
            clk, rst, wr_en : in std_logic;
            dt_in  : in unsigned(11 downto 0);
            dt_out : out unsigned(11 downto 0)
        );
    end component;
    component maq_estados is 
    port                ( 
        clk,rst: in std_logic;
        estado: out unsigned(1 downto 0)
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
        stt :  in unsigned(1 downto 0) := "00";
        clk, rst : in std_logic;
        --para 16bits tlg
        dt_in : in unsigned (15 downto 0);
        --para exceptions
        flag  : out std_logic; 
        --operations
        no_op, 
        jmp_op, 
        add_op, 
        sub_op,
        and_op,
        eq_op,
        ld_op,
        mov_op  : out std_logic; 
       
        --controle
        reg_wr_en : out std_logic;
        pc_wr_en  : out std_logic
    );
    end component;
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
            dt_out0 : out unsigned(15 downto 0);
            dt_out1 : out unsigned(15 downto 0);
            ula_out:  out unsigned(15 downto 0)    
        );
    end component;
    --data signals
    signal reg_in_s  : unsigned(15 downto 0) := "0000000000000000"; 
    signal reg_a_s : unsigned(2 downto 0) := "000";
    signal reg_b_s : unsigned(2 downto 0) := "000";
    signal reg_out_a_s  : unsigned(15 downto 0) := "0000000000000000"; 
    signal reg_out_b_s  : unsigned(15 downto 0) := "0000000000000000"; 
    signal ula_out_s    : unsigned(15 downto 0) := "0000000000000000"; 
    signal reg_wr_s : unsigned(2 downto 0) := "000";
    signal dt_in_s  : unsigned(15 downto 0) := "0000000000000000"; 
    signal pc_in  : unsigned(11 downto 0) := "000000000000";
    signal pc_out_s : unsigned(11 downto 0) := "000000000000";
    signal stt_s  : unsigned (1 downto 0) := "00";
    signal const_dt_s : unsigned (15 downto 0) := "0000000000000000";
    --op signals
    signal const_s      : std_logic := '0';
    signal no_op_s      : std_logic := '0';
    signal jmp_op_s     : std_logic := '0';
    signal add_op_s     : std_logic := '0';
    signal sub_op_s     : std_logic := '0';
    signal mov_op_s     : std_logic := '0';
    signal and_op_s     : std_logic := '0';
    signal eq_op_s      : std_logic := '0';
    signal ld_op_s      : std_logic := '0';    
    --control signals
    signal ula_op_s     : unsigned (1 downto 0) := "00";
    signal pc_wr_en_s      : std_logic := '1';
    signal reg_wr_en_s      : std_logic := '1';
    signal excpt_s      : std_logic := '0';

    signal rd, rr, rs : unsigned(2 downto 0) := "000";

    begin

        ula_op_s <= "00" when add_op_s = '1' else
                    "01" when sub_op_s = '1' else
                    "10" when and_op_s = '1' else
                    "11" when eq_op_s  = '1' else
                    "00";
        const_s <= '1' when ld_op_s = '1' else
            '0';

        pc_c : pc port map (
            clk => clk,
            rst => rst,
            wr_en => pc_wr_en_s,
            dt_in => pc_in,
            dt_out => pc_out_s
        );

        maq_estados_c : maq_estados port map (
            clk, rst, stt_s
        );

        rom_c : rom port map (
            clk => clk,
            rd => pc_out_s(6 downto 0),
            dt_out => dt_in_s
        );

        cu_c : cu port map (
            stt => stt_s,
            dt_in => dt_in_s,
            clk => clk,
            rst => rst, 
            no_op => no_op_s,
            jmp_op => jmp_op_s,
            add_op => add_op_s,
            mov_op => mov_op_s,
            sub_op => sub_op_s,
            and_op => and_op_s,
            ld_op => ld_op_s,
            eq_op => eq_op_s,
            flag => excpt_s,
            pc_wr_en => pc_wr_en_s
        );

        reg_toplvl_c : regTopLevel port map (
            cnst => const_s,
            cnst_dt => const_dt_s,
            clk => clk,
            rst => rst,
            wr_en => reg_wr_en_s,
            op => ula_op_s,
            rd0 => reg_a_s,
            rd1 => reg_b_s,
            wr => reg_wr_s,
            dt_in => reg_in_s,
            dt_out0 => reg_out_a_s,
            dt_out1 => reg_out_b_s,
            ula_out => ula_out_s
        );

        rd <= dt_in_s(12 downto 10);
        rr <= dt_in_s(9 downto 7);
        rs <= dt_in_s(7 downto 5);

        reg_a_s <= rd when add_op_s = '1' or mov_op_s = '1' or ld_op_s = '1' else
                rr when sub_op_s = '1' else
                "000";
        reg_b_s <= rr when add_op_s = '1' else
                rd when sub_op_s = '1' or jmp_op_s = '1' else
                "000";
        pc_in <= dt_in_s(11 downto 0) when jmp_op_s = '1' else
                pc_out_s + 1;

        reg_wr_s <= rd when const_s = '1' else
            rr when mov_op_s = '1' or add_op_s = '1' or sub_op_s = '1' or ld_op_s = '1' else
            "000";

        reg_in_s <= reg_out_a_s when mov_op_s = '1' else
            B"0000_0000" & dt_in_s(9 downto 2) when const_s = '1' else
            ula_out_s when add_op_s = '1' or sub_op_s = '1' else
            B"0000_0000_0000_0000";
   
end architecture;