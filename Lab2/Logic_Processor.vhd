library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Logic_Processor is port (
   
   pb					: in	std_logic_vector(2 downto 0); 
   hex_A	   		: in  std_logic_vector(3 downto 0); 
   hex_B	 		   : in  std_logic_vector(7 downto 4);
	Logic_Func		: out std_logic_vector(3 downto 0)

); 
end Logic_Processor;

architecture Behavioral of Logic_Processor is

begin	
	with pb select						      
	Logic_Func 				    <= hex_A AND hex_B when "110",    
										 hex_A OR hex_B when "101", 
										 hex_A XOR hex_B when "011";    
	
end architecture Behavioral; 