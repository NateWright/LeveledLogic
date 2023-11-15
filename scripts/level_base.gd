extends Node2D

@export var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !GlobalState.paused:
		if Input.is_action_just_pressed("pause"):
			GlobalState.paused = true
			var child = preload("res://scenes/levels/pause_menu.tscn").instantiate()
			child.position = self.get_window().size / 2
			self.add_child(child)

func _on_level_solved():
	GlobalState.paused = true
	var child = preload("res://scenes/levels/solved_menu.tscn").instantiate()
	child.position = self.get_window().size / 2
	child.next_level = next_level
	self.add_child(child)


func _on_lamp_logic_changed(state: bool, _id: int):
	if state:
		_on_level_solved.call_deferred()
