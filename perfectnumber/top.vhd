library ieee;
use ieee.std_logic_1164.all;

entity mdc_top is
  port (
    i_CLK     : in  std_logic; 
	  i_GO   	  : in std_logic;
	 
    i_A    	  : in std_logic_vector (3 downto 0);
	 
    o_PERFECT : out std_logic;
	  o_DONE    : out std_logic
  );
end mdc_top;

architecture mdc_top_behaviour of mdc_top is
  signal w_DONE      : std_logic := '0';
  signal w_SETUP     : std_logic := '0';
  signal w_CALCULATE : std_logic := '0';
begin
  u_fsm: entity work.mdc_fsm
	 port map (
      i_CLK       => i_CLK,
		  i_GO  	    => i_GO,
		
	  	o_SETUP     => w_SETUP,
	    i_DONE      => w_DONE,
		  o_DONE 	    => o_DONE,
		  o_CALCULATE => w_CALCULATE
  );
  
  u_datapath: entity work.mdc_datapath
    port map (
      i_CLK       => i_CLK,
	    i_A     	  => i_A,
	 
	    i_SETUP     => w_SETUP,
		  i_CALCULATE => w_CALCULATE,
	    o_DONE      => w_DONE,
	    o_PERFECT   => o_PERFECT
  );
end mdc_top_behaviour;

