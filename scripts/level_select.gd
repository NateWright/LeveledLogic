extends Control

const LEVELS = [
	preload("res://scenes/levels/level_test.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_level_select(level):
	get_tree().change_scene_to_packed(LEVELS[level])
