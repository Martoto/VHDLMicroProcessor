library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cu is
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
    end cu;

architecture cu_a of cu is
    signal opcode       : unsigned(3 downto 0) := "0000";
    signal no_op_s      : std_logic := '0';
    signal jmp_op_s     : std_logic := '0';
    signal add_op_s     : std_logic := '0';
    signal sub_op_s     : std_logic := '0';
    signal and_op_s     : std_logic := '0';
    signal eq_op_s      : std_logic := '0';
    signal ld_op_s      : std_logic := '0';
    signal mov_op_s     : std_logic := '0';


    signal flag_s         : std_logic := '0';
    signal pc_wr_en_s     : std_logic := '0';
    signal reg_wr_en_s    : std_logic := '1';
    begin
        opcode <= dt_in(15 downto 12);

        no_op_s  <= '1' when opcode = "0000"
        else '0';
        jmp_op_s <= '1' when opcode = "1001"
        else '0';
        add_op_s <= '1' when opcode = "0001"
        else '0';
        sub_op_s <= '1' when opcode = "0011"
        else '0';
        and_op_s <= '1' when opcode = "0010"
        else '0';
        ld_op_s  <= '1' when opcode = "1110"
        else '0';
        mov_op_s  <= '1' when opcode = "0100"
        else '0';


        flag_s     <= '0' when opcode = "0000" or
                        opcode = "1001" 
                        else '1'; 
        
    no_op <= no_op_s;
    jmp_op <= jmp_op_s;
    add_op <= add_op_s;
    and_op <= and_op_s;
    ld_op <= ld_op_s; 
    mov_op <= mov_op_s;
    flag <= flag_s;
    reg_wr_en <= reg_wr_en_s;
        
   
end architecture;