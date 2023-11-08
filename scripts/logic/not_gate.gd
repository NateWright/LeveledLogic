extends Area2D

func _on_logic_receiver_logic_changed(state: bool, signal_id: int):
	$LogicSender.send_logic_update(!state, signal_id)

func _on_logic_receiver_logic_error():
	pass # Replace with function body.
