extends StaticBody2D

func _on_logic_receiver_logic_changed(state: bool, signal_id: int):
	$LogicSender.send_logic_update(!state, signal_id)

func _on_logic_receiver_logic_error():
	print("Circular logic detected in a NOT gate")
