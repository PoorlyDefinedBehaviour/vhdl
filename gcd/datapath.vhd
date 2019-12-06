library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mdc_datapath is
  port (
    i_CLK					 			 : in  std_logic; 
	  i_A								   : in std_logic_vector(3 downto 0);
	  i_B 						 	   : in std_logic_vector(3 downto 0);
	 
	  i_SETUP					     : in std_logic;
	  i_SUBSTRACT_B_FROM_A : in std_logic;
    i_SUBSTRACT_A_FROM_B : in std_logic;
	 
	  o_A_BIGGER_THAN_B	   : out std_logic;
	  o_B_BIGGER_THAN_A    : out std_logic;
	  o_A_EQUALS_B			   : out std_logic;
	  o_DATA					     : out std_logic_vector(3 downto 0)
  );
end mdc_datapath;

architecture mdc_datapath_behaviour of mdc_datapath is
	signal r_A: std_logic_vector(3 downto 0);
	signal r_B: std_logic_vector(3 downto 0);
begin
	p_MAIN: process(i_CLK)
	  begin
	    if(rising_edge(i_CLK)) then
		   if(i_SETUP = '1') then
			  r_A <= i_A;
			  r_B <= i_B;
   	   elsif(i_SUBSTRACT_B_FROM_A = '1') then
           r_A <= r_A - r_B;
	      elsif(i_SUBSTRACT_A_FROM_B = '1') then	
  		     r_B <= r_B - r_A;
			end if;
		 end if;
	  end process p_MAIN; 
	  
  o_DATA <= r_A;
  o_A_BIGGER_THAN_B <= '1' when r_A > r_B(3 downto 0) else '0';
  o_B_BIGGER_THAN_A <= '1' when r_A < r_B(3 downto 0) else '0';
  o_A_EQUALS_B      <= '1' when r_A = r_B(3 downto 0) else '0'; 
end mdc_datapath_behaviour;

