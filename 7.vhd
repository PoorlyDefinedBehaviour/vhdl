library ieee;
use ieee.std_logic_1164.all;

entity laser is
  port (
  i_CLK: in std_logic;
  i_B: in std_logic;
  o_X: out std_logic
  );
end laser;

architecture laser_behaviour of laser is 
  type t_STATE is (s_WAITING, s_FIRST, s_SECOND, s_THIRD);
  signal v_CURRENT_STATE: t_STATE := s_WAITING;
  signal v_NEXT_STATE: t_STATE;
begin
  p_UPDATE_CURRENT_STATE: process(i_CLK, i_B)
    begin 
	   if(rising_edge(i_CLK)) then
		  if(v_CURRENT_STATE = s_WAITING and i_B = '1') then
			 v_CURRENT_STATE <= s_FIRST;
		  else
		    v_CURRENT_STATE <= v_NEXT_STATE;
		  end if;
		end if;
	 end process p_UPDATE_CURRENT_STATE;

  p_UPDATE_NEXT_STATE: process(v_CURRENT_STATE)
    begin
	   case v_CURRENT_STATE is
		  when S_FIRST => v_NEXT_STATE <= s_SECOND;
		  when s_SECOND => v_NEXT_STATE <= s_THIRD;
		  when s_THIRD => v_NEXT_STATE <= s_WAITING;
		  when others => v_NEXT_STATE <= s_WAITING;
		end case;
	 end process p_UPDATE_NEXT_STATE;
	 
  o_X <= '0' when (v_CURRENT_STATE = s_WAITING) else '1';
end laser_behaviour;