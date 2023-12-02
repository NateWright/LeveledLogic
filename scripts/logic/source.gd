extends StaticBody2D

@export var state = false

var _sprite: AnimatedSprite2D

func _ready():
	_sprite = $AnimatedSprite2D
	
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

func update(b: bool):
	if b == state:
		return
	if b:
#		$Sprite2D.texture.set_speed_scale(100)
		_sprite.play("turn_on")
	else:
		_sprite.play("turn_off")
#		$Sprite2D.texture.set_speed_scale(-100)
	state = b
