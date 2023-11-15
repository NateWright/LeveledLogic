extends Control

@export var next_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_next_level_pressed():
	get_tree().change_scene_to_packed(next_level)


func _on_button_level_select_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/level_select.tscn"))


func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/main_menu.tscn"))


func _on_button_restart_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/level_test.tscn"))
