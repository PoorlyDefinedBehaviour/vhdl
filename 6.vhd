library ieee;
use ieee.std_logic_1164.all;

entity gray is
  port (
  i_CLK: in std_logic;
  i_GCNT: in std_logic;
  o_X: out std_logic;
  o_Y: out std_logic;
  o_Z: out std_logic
  );
end gray;

architecture gray_behaviour of gray is 
  type t_STATE is (s_FIRST, s_SECOND, s_THIRD, s_FOURTH, s_FIFTH, s_SIXTH, s_SEVENTH, s_EIGTH);
  signal v_CURRENT_STATE: t_STATE := s_FIRST;
  signal v_NEXT_STATE: t_STATE;
begin
  p_UPDATE_CURRENT_STATE: process(i_CLK, i_GCNT)
    begin
	   if(rising_edge(i_CLK) and i_GCNT = '1') then
		  v_CURRENT_STATE <= v_NEXT_STATE;
		end if;
	 end process p_UPDATE_CURRENT_STATE;
	 
  p_UPDATE_NEXT_STATE: process(v_CURRENT_STATE)
    begin
	   case v_CURRENT_STATE is
		  when s_FIRST => v_NEXT_STATE <= s_SECOND;
		  when s_SECOND => v_NEXT_STATE <= s_THIRD;
		  when s_THIRD => v_NEXT_STATE <= s_FOURTH;
		  when s_FOURTH => v_NEXT_STATE <= s_FIFTH;
		  when s_FIFTH => v_NEXT_STATE <= s_SIXTH;
		  when s_SIXTH => v_NEXT_STATE <= s_SEVENTH;
		  when s_SEVENTH => v_NEXT_STATE <= s_EIGTH;
		  when s_EIGTH => v_NEXT_STATE <= s_FIRST;
		  when others => v_NEXT_STATE <= s_FIRST;
		end case;
	 end process p_UPDATE_NEXT_STATE;	
	 
  o_X <= '1' when (v_CURRENT_STATE = s_FIFTH or
						 v_CURRENT_STATE = s_SIXTH or
					    v_CURRENT_STATE = s_SEVENTH or
						 v_CURRENT_STATE = s_EIGTH) else '0';
  o_Y <= '1' when (v_CURRENT_STATE = s_SECOND or
						 v_CURRENT_STATE = s_THIRD or
					    v_CURRENT_STATE = s_SIXTH or
						 v_CURRENT_STATE = s_SEVENTH) else '0';
  o_Z <= '1' when (v_CURRENT_STATE = s_THIRD or
						 v_CURRENT_STATE = s_FOURTH or
					    v_CURRENT_STATE = s_FIFTH or
						 v_CURRENT_STATE = s_SIXTH) else '0';
end gray_behaviour;