library ieee;
use ieee.std_logic_1164.all;

entity fsm is
  port (
  i_CLK: in std_logic;
  o_X: out std_logic;
  o_Y: out std_logic;
  o_Z: out std_logic
  );
end fsm;

architecture fsm_behaviour of fsm is 
  type t_STATE is (s_FIRST, s_SECOND, s_THIRD, s_FOURTH);
  signal s_CURRENT: t_STATE := s_FIRST;
  signal s_NEXT: t_STATE;
begin
  p_ATUAL: process(i_CLK)
    begin
	   if(rising_edge(i_CLK)) then
			s_CURRENT <= s_NEXT;
		end if;
    end process p_ATUAL;
	 
  p_NEXT: process(s_CURRENT)
    begin
	   case s_CURRENT is
	     when s_FIRST => s_NEXT <= s_SECOND;
		  when s_SECOND => s_NEXT <= s_THIRD;
		  when s_THIRD => s_NEXT <= s_FOURTH;
		  when s_FOURTH => s_NEXT <= s_FIRST;
		  when others => s_NEXT <= s_FIRST;
		end case;
	 end process p_NEXT;
	 
  o_X <= '1' when s_CURRENT = s_FOURTH else '0';
  o_Y <= '1' when s_CURRENT = s_THIRD else '0';
  o_Z <= '1' when s_CURRENT = s_SECOND else '0';
         
end fsm_behaviour;