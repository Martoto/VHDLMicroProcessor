library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;

entity ula is 
    port ( 
    a  :  in unsigned(15 downto 0);
    b  :  in unsigned(15 downto 0);
    op:  in unsigned(1 downto 0);
    ula_out:  out unsigned(15 downto 0)
    );
    end ula;

    architecture a_ula of ula is
        signal sum_res:
            unsigned(15 downto 0) := "0000000000000000";
        signal sub_res:
            unsigned(15 downto 0) := "0000000000000000";
        signal maiorq_res:
            unsigned(15 downto 0) := "0000000000000000";
        signal eq_res:
            unsigned (15 downto 0):= "0000000000000000";
        signal result: 
            unsigned (15 downto 0);
        
        begin
          -- Soma
           sum_res <= a + b ; 
          -- Subtracao
           sub_res <= a - b ;
          -- Maior que
            maiorq_res <= "0000000000000001" when (a>b)
           else
            "0000000000000000" ;
           -- Igual   
            eq_res <= "0000000000000001" when (a=b)
           else
            "0000000000000000" ;

           result <= sum_res when op = "00" else -- add
                     sub_res when op = "01" else -- sub
                     maiorq_res when op = "10" else -- maiorq
                     eq_res when op = "11" else -- igual
                     "0000000000000000";
         ula_out <= result;
    end a_ula;