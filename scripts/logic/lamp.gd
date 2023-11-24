extends StaticBody2D

const LAMP_OFF = preload("res://assets/programmer_art/lamp_off.png")
const LAMP_ON  = preload("res://assets/programmer_art/lamp_on.png")

func update(b: bool):
	if b:
		$Sprite2D.texture = LAMP_ON
	else:
		$Sprite2D.texture = LAMP_OFF
