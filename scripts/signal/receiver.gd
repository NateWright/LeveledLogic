class_name LogicReceiver extends Area2D

# Signals that the state of the logic has changed;
# This should be used to send logic to a sender with the same id
signal logic_changed(bool, int)

# Signals that recursive logic has been detected;
# This should be used to cause an error
signal logic_error()

var last_id = 0
var activated = false

func logic_update(state: bool, signal_id: int):
	if (state != activated):
		if (signal_id == last_id):
			logic_error.emit()
		else:
			activated = state
			last_id = signal_id
			logic_changed.emit(state, signal_id)
	
