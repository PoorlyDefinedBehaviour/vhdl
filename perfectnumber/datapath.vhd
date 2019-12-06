library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

entity mdc_datapath is
  port (
    i_CLK		    : in std_logic; 
	  i_A			    : in std_logic_vector(3 downto 0);
	  i_SETUP		  : in std_logic;
	  i_CALCULATE : in std_logic;
	 
	  o_PERFECT   : out std_logic;
	  o_DONE		  : out std_logic
  );
end mdc_datapath;

architecture mdc_datapath_behaviour of mdc_datapath is
	signal r_P       : std_logic_vector(3 downto 0);
	signal r_COUNTER : std_logic_vector(3 downto 0);
	
begin
	p_MAIN: process(i_CLK)
	  variable x : integer;
	  variable i : integer;
	  
	  begin
	    if(rising_edge(i_CLK)) then
		   if(i_SETUP = '1') then
			  r_P <= "0000";
			  r_COUNTER <= "0001";
   	   elsif(i_CALCULATE = '1') then
			  x := to_integer(unsigned(i_A));
			  i := to_integer(unsigned(r_COUNTER));
			  if(x mod i = 0) then
             r_P <= r_P + r_COUNTER;
			  end if;
			  r_COUNTER <= r_COUNTER + '1';
			end if;
		 end if;
	  end process p_MAIN; 
  
  o_DONE 	  <= '1' when r_COUNTER = i_A or r_P = i_A else '0';
  o_PERFECT <= '1' when r_P = i_A       			       else '0';
end mdc_datapath_behaviour;

