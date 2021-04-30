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
    0  => B"1110_011_0000_0101_0",
    1  => B"1110_100_0000_1000_0",
    2  => B"1110_110_0000_0001_0",
    3  => B"0001_011_100_0000_00",
    4  => B"1110_101_0000_0000_0",
    5  => B"0001_101_011_0000_00",
    6  => B"0011_101_110_0000_00",
    7  => B"1001_0000_00_010100",
    20 => B"0100_011_101_0000_00",
    21 => B"1001_0000_00_000011",
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