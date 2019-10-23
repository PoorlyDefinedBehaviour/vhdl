library ieee;
use ieee.std_logic_1164.all;
use work.alert;

entity alert_with_sensor is
	port(
		door: in std_logic;
		ignition: in std_logic;
		seat_belt: in std_logic;
		sensor: in std_logic;
		s: out std_logic
	);
end alert_with_sensor;

architecture alert_with_sensor_behaviour of alert_with_sensor is
	signal s0: std_logic;
begin
	t: alert
		port map(door => door,
					ignition => ignition,
					seat_belt => seat_belt,
					s => s0);
	s <= s0 or (not sensor and ignition);
end alert_with_sensor_behaviour;