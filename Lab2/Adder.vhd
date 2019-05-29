library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder is port (
   
   sum	   :  out  std_logic_vector(7 downto 0); 
   add_inpA	   :  in  std_logic_vector(7 downto 0); 
   add_inpB	   :  in  std_logic_vector(7 downto 0) 

); 
end Adder;

architecture Behavioral of Adder is

begin	
	sum			<=std_logic_vector(unsigned(add_inpA) + unsigned(add_inpB));
end architecture Behavioral; 