library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cu is
    port (
        clk, rst : in std_logic;
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
    end cu;

architecture cu_a of cu is
    signal opcode       : unsigned(3 downto 0) := "0000";
    signal no_op_s      : std_logic := '0';
    signal jmp_op_s      : std_logic := '0';
    signal flag_s         : std_logic := '0';
    signal wr_en_s        : std_logic := '1';
    begin
        opcode <= dt_in(15 downto 12);

        no_op_s  <= '1' when opcode = "0000" else
                 '0';
        jmp_op_s <= '1' when opcode = "1001" else
                 '0';
        flag_s     <= '0' when opcode = "0000" or
                        opcode = "1001" 
                        else '1'; 
        
    no_op <= no_op_s;
    jmp_op <= jmp_op_s;
    flag <= flag_s;
    wr_en <= wr_en_s;
        
   
end architecture;