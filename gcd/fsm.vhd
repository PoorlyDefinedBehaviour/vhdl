library ieee;
use ieee.std_logic_1164.all;

entity mdc_fsm is
  port (
    i_CLK               : in  std_logic;
	  i_GO                : in std_logic;
	 
	  i_A_EQUALS_B        : in std_logic;
    i_A_BIGGER_THAN_B   : in std_logic;
	  i_B_BIGGER_THAN_A   : in std_logic;
	 
	  o_SETUP             : out std_logic;
	  o_SUBTRACT_B_FROM_A : out std_logic;
    o_SUBTRACT_A_FROM_B : out std_logic;
	 
	  o_DONE              : out std_logic
  );
end mdc_fsm;

architecture mdc_fsm_behaviour of mdc_fsm is
  type t_STATE is (WAITING, SETUP, A_EQUALS_B, SUBTRACT_A_FROM_B, SUBTRACT_B_FROM_A, PROCESSING, DONE);
  signal w_CURRENT_STATE: t_STATE;
  signal w_NEXT_STATE: t_STATE;
begin
  p_UPDATE_CURRENT_STATE: process(i_CLK, i_GO)
	 begin
	   if(rising_edge(i_CLK)) then
		  if(i_GO = '1') then
	       w_CURRENT_STATE <= w_NEXT_STATE;
		  else
		    w_CURRENT_STATE <= WAITING;
		  end if;
		end if;
	 end process p_UPDATE_CURRENT_STATE;
	 
  p_UPDATE_NEXT_STATE: process(w_CURRENT_STATE, i_A_BIGGER_THAN_B, i_A_EQUALS_B) 
    begin
	   case(w_CURRENT_STATE) is 
		  when WAITING => 
			  w_NEXT_STATE <= SETUP;
			 
		  when PROCESSING => 
		    if(i_A_BIGGER_THAN_B = '1') then
			   w_NEXT_STATE <= SUBTRACT_B_FROM_A;
			 elsif(i_B_BIGGER_THAN_A = '1') then
			   w_NEXT_STATE <= SUBTRACT_A_FROM_B;
			 elsif(i_A_EQUALS_B = '1') then
			   w_NEXT_STATE <= DONE;
			 end if;
			 
		  when DONE => w_NEXT_STATE <= DONE;
		  
		  when others => 
			 w_NEXT_STATE <= PROCESSING;
		end case;
	 end process p_UPDATE_NEXT_STATE;
	
  o_SETUP             <= '1' when w_CURRENT_STATE = SETUP             else '0';
  o_SUBTRACT_B_FROM_A <= '1' when w_CURRENT_STATE = SUBTRACT_B_FROM_A else '0';
  o_SUBTRACT_A_FROM_B <= '1' when w_CURRENT_STATE = SUBTRACT_A_FROM_B else '0';
  o_DONE              <= '1' when w_CURRENT_STATE = DONE 				      else '0';
end mdc_fsm_behaviour;

