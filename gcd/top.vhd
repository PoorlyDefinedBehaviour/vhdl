library ieee;
use ieee.std_logic_1164.all;

entity mdc_top is
  port (
    i_CLK  : in  std_logic; 
	  i_GO   : in std_logic;
	 
    i_A    : in std_logic_vector (3 downto 0);
	  i_B    : in std_logic_vector (3 downto 0);
	 
    o_DATA : out std_logic_vector (3 downto 0);
	  o_DONE : out std_logic
  );
end mdc_top;

architecture mdc_top_behaviour of mdc_top is
   signal w_A_EQUALS_B		    : std_logic := '0';
   signal w_A_BIGGER_THAN_B	  : std_logic := '0';
	signal w_B_BIGGER_THAN_A	  : std_logic := '0';

	signal w_SETUP					    : std_logic := '0';
   signal w_SUBTRACT_B_FROM_A : std_logic := '0';
   signal w_SUBTRACT_A_FROM_B : std_logic := '0';	
begin
  u_fsm: entity work.mdc_fsm
	 port map (
      i_CLK               => i_CLK,
		  i_GO  				      => i_GO,
		
	    i_A_EQUALS_B     	  => w_A_EQUALS_B,
      i_A_BIGGER_THAN_B   => w_A_BIGGER_THAN_B,
	  	i_B_BIGGER_THAN_A   => w_B_BIGGER_THAN_A,
		
		  o_SETUP             => w_SETUP,
	    o_SUBTRACT_B_FROM_A => w_SUBTRACT_B_FROM_A,
      o_SUBTRACT_A_FROM_B => w_SUBTRACT_A_FROM_B,
		  o_DONE 				      => o_DONE
  );
  
  u_datapath: entity work.mdc_datapath
    port map (
      i_CLK   					   => i_CLK,
	    i_A     					   => i_A,
	    i_B    				       => i_B,
	 
	    i_SETUP => w_SETUP,
	    i_SUBSTRACT_B_FROM_A => w_SUBTRACT_B_FROM_A,
      i_SUBSTRACT_A_FROM_B => w_SUBTRACT_A_FROM_B,
	 
	    o_A_BIGGER_THAN_B    => w_A_BIGGER_THAN_B,
		  o_B_BIGGER_THAN_A    => w_B_BIGGER_THAN_A,
	    o_A_EQUALS_B         => w_A_EQUALS_B,
		  o_DATA 					     => o_DATA
  );
end mdc_top_behaviour;

