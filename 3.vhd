library ieee;
use ieee.std_logic_1164.all;

entity clock_50hz is
  port (
  i_CLK: in std_logic;
  o_CLK50hz: out std_logic
  );
end clock_50hz;

architecture clock_50hz_behaviour of clock_50hz is 
  signal v_COUNTER: integer := 0;
begin
  p_UPDATE_COUNTER: process(i_CLK)
    begin
	   if(rising_edge(i_CLK)) then
		  if(v_COUNTER <= 50) then
		    v_COUNTER <= v_COUNTER + 1;
		  else
		    v_COUNTER <= 0;
		  end if;
		end if;
    end process p_UPDATE_COUNTER;
	 
  o_CLK50hz <= '1' when v_COUNTER = 50 else '0';
         
end clock_50hz_behaviour;