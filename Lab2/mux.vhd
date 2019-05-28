library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is port (
   
   pb_3 				: in	std_logic; 
   sum				: in	std_logic_vector(7 downto 0); 
   input				: in	std_logic_vector(7 downto 0); 
   mux_out			: out	std_logic_vector(7 downto 0) 


); 
end mux;

architecture Behavioral of mux is

begin	
	with pb_3 select						      
	mux_out 				    <= sum when '0',
									input when '1';
   
	
end architecture Behavioral; 