class_name LogicSender extends Area2D

var last_state = false

func send_logic_update(state: bool, signal_id: int):
	if (state != last_state):
		last_state = state
		var areas = get_overlapping_areas()
		for area in areas:
			if area is LogicReceiver:
				area.logic_update(state, signal_id)
