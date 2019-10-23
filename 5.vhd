library ieee;
use ieee.std_logic_1164.all;

entity watch is
  port (
  i_CLK: in std_logic;
  i_B: in std_logic;
  o_S0: out std_logic;
  o_S1: out std_logic
  );
end watch;

architecture watch_behaviour of watch is 
  type t_STATE is (s_CURRENT_TIME, s_ALARM, s_TIMER, s_DATE);
  signal v_CURRENT_STATE, v_NEXT_STATE: t_STATE ;
  signal v_B_IS_PRESSED: std_logic := '0';
begin
  p_UPDATE_CURRENT_STATE: process(i_CLK, i_B, v_B_IS_PRESSED)
    begin
	   if(rising_edge(i_CLK) and i_B = '1' and v_B_IS_PRESSED = '0') then
		  v_CURRENT_STATE <= v_NEXT_STATE;
		  v_B_IS_PRESSED <= '1';
		end if;
		
		if(rising_edge(i_CLK) and i_B = '0') then
			v_B_IS_PRESSED <= '0';
		end if;
	 end process p_UPDATE_CURRENT_STATE;
	 
  p_UPDATE_NEXT_STATE: process(v_CURRENT_STATE)
    begin
		case v_CURRENT_STATE is
		  when s_CURRENT_TIME => v_NEXT_STATE <= s_ALARM;
		  when s_ALARM => v_NEXT_STATE <= s_TIMER;
		  when s_TIMER => v_NEXT_STATE <= s_DATE;
		  when s_DATE => v_NEXT_STATE <= s_CURRENT_TIME;
		  when others => v_NEXT_STATE <= s_CURRENT_TIME;
		end case;
	 end process p_UPDATE_NEXT_STATE;
	 
  o_S0 <= '1' when (v_CURRENT_STATE = s_ALARM or v_CURRENT_STATE = s_DATE) else '0';
  o_S1 <= '1' when (v_CURRENT_STATE = s_CURRENT_TIME or v_CURRENT_STATE = s_DATE) else '0';

end watch_behaviour;