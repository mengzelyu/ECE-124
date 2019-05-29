library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component Adder port (
   sum	   	:  out  std_logic_vector(7 downto 0); 
   add_inpA	   :  in  std_logic_vector(7 downto 0); 
   add_inpB	   :  in  std_logic_vector(7 downto 0)
   ); 
   end component;
	
	component Logic_Processor port (
   pb					: in	std_logic_vector(2 downto 0); 
   hex_A	   		: in  std_logic_vector(3 downto 0); 
   hex_B	 		   : in  std_logic_vector(7 downto 4);
	Logic_Func		: out std_logic_vector(3 downto 0)
   ); 
   end component;
	
   component mux port (
   pb_3 				: in	std_logic; 
   sum				: in	std_logic_vector(7 downto 0); 
   input				: in	std_logic_vector(7 downto 0); 
   mux_out			: out	std_logic_vector(7 downto 0)
   ); 
   end component;
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal hex_A		: std_logic_vector(3 downto 0);
	
	signal hex_B		: std_logic_vector(7 downto 4);
	signal seg7_B		: std_logic_vector(6 downto 0);

	signal pb_3			: std_logic;
	signal pd 			: std_logic_vector(2 downto 0);
	
	signal mux_sepA	: std_logic_vector(3 downto 0);
	signal mux_sepb	: std_logic_vector(3 downto 0);
	
	signal sum			: std_logic_vector(7 downto 0);
	signal mux_out_1		: std_logic_vector(7 downto 0);
	signal mux_out_2		: std_logic_vector(7 downto 0);
	signal input		: std_logic_vector(7 downto 0);
	signal add_inpA	: std_logic_vector(7 downto 0);
	signal add_inpB	: std_logic_vector(7 downto 0);
	
	signal Logic_Func		: std_logic_vector(3 downto 0);

-- Here the circuit begins
component segment7_mux port (
		clk		: in std_logic := '0';
		DIN2		: in std_logic_vector(6 downto 0);
		DIN1		: in std_logic_vector(6 downto 0);
		DOUT		: out std_logic_vector(6 downto 0);
		DIG2		: out std_logic;
		DIG1		: out std_logic
);
end component;

begin

	hex_A <= sw(7 downto 4);
	hex_B <= sw(3 downto 0);
	--seg7_data <= seg7_A;

--COMPONENT HOOKUP
--
-- generate the seven segment coding
	INST1: Adder port map(sum, "0000"&hex_A, "0000"& hex_B);
	
	INST2: mux port map(pb(3), sum, hex_B & hex_A, mux_out_1);
		
	leds <= mux_out_1;
	
	INST3: SevenSegment port map(mux_out_1(3 downto 0), seg7_A);
	
	INST4: SevenSegment port map(mux_out_1(7 downto 4), seg7_B);
--	
	INST5: segment7_mux port map(Clkin_50, seg7_A, seg7_B, seg7_data,seg7_char1, seg7_char2 );
	
	--- led output path
	
	INST6: Logic_Processor port map(pd, hex_B, hex_A, Logic_Func );
	
	INST7: mux port map(pb(3), sum, "0000" & Logic_Func, mux_out_2);

	leds <= mux_out_2;
 
end SimpleCircuit;

