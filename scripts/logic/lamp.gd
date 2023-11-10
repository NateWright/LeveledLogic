extends LogicReceiver

const LAMP_OFF = preload("res://assets/programmer_art/lamp_off.png")
const LAMP_ON  = preload("res://assets/programmer_art/lamp_on.png")

func _on_logic_changed(state: bool, _id: int):
	if state:
		$Sprite2D.texture = LAMP_ON
	else:
		$Sprite2D.texture = LAMP_OFF

func _on_logic_error():
	pass # Replace with function body.
