extends StaticBody2D

@export var state = false

var _sprite: AnimatedSprite2D

func _ready():
	_sprite = $AnimatedSprite2D
	
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
