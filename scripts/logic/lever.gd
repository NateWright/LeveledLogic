extends StaticBody2D

const TEX_OFF = preload("res://assets/programmer_art/lever_off.png")
const TEX_ON  = preload("res://assets/programmer_art/lever_on.png")

#var lever_state = false

#var rng = RandomNumberGenerator.new()

func update(b: bool):
	if b:
		$Sprite2D.texture = TEX_ON
	else:
		$Sprite2D.texture = TEX_OFF

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
#	if Input.is_action_just_pressed("activate"):
#		var bodies = get_overlapping_bodies()
#		for body in bodies:
#			if body is CharacterBody2D:
#				if lever_state:
#					lever_state = false
#					$Sprite2D.texture = TEX_OFF
#				else:
#					lever_state = true
#					$Sprite2D.texture = TEX_ON
#				var signal_id = rng.randi()
#				send_logic_update(lever_state, signal_id)
