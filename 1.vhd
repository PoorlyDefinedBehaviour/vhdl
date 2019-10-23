library ieee;
use ieee.std_logic_1164.all;

entity alert is 
	port(
		door: in std_logic;
		ignition: in std_logic;
		seat_belt: in std_logic;
		s: out std_logic
	);	
end alert;

architecture alert_behaviour of alert is
begin
	s <= ((not door) and ignition) and ((not seat_belt) and ignition);
end alert_behaviour;
