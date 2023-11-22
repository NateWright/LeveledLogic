extends Node2D

@export var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalState.paused:
		return
	if Input.is_action_just_pressed("pause"):
		GlobalState.paused = true
		var child = preload("res://scenes/levels/pause_menu.tscn").instantiate()
		child.position = self.get_window().content_scale_size / 2
		self.add_child(child)
		return
	
	var dir = $Player.get_last_motion()
	var i = 0
	if dir.x > 0:
		i = 1
	elif dir.x < 0:
		i = -1
	
	i = 0
	$Placement.position.x = snapped(floor($Player.position.x), 32) + i * 32
	if dir.y > 0:
		i = 1
	elif dir.y < 0:
		i = -1
	$Placement.position.y = snapped(floor($Player.position.y), 32) + i * 32
	

func _on_level_solved():
	GlobalState.paused = true
	var child = preload("res://scenes/levels/solved_menu.tscn").instantiate()
	child.position = self.get_window().content_scale_size / 2
	child.next_level = next_level
	self.add_child(child)

func _on_lamp_logic_changed(state: bool, _id: int):
	if state:
		_on_level_solved.call_deferred()
