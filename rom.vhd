library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is 
    port ( 
     clk        : in std_logic;
     rd         : in unsigned(6 downto 0);
     dt_out     : out unsigned(15 downto 0) 
    ); 
    end entity; 
    
architecture a_rom of rom is 
    type mem is array (0 to 127) of unsigned(15 downto 0);
    constant rom_dt : mem := (      
    -- caso rd => conteudo
    0  => "0000000000000000",
    1  => "1001000000000010",
    2  => "1001000000000001",
    3  => "0000000000000000",
    4  => "1000000000000000",
    5  => "0000000000100000",
    6  => "1111000000110000",
    7  => "0000000000100000",
    8  => "0000000000100000",
    9  => "0000000000000000",
    10 => "0000000000000000",
    -- abaixo: casos omissos => (zero em todos os bits)
    others => (others=>'0')
    );
    begin process(clk)
    begin 
        if(rising_edge(clk)) then dt_out <= rom_dt(to_integer(rd));
        else dt_out <= "0000000000000000";
        end if;
    end process;
    end architecture;