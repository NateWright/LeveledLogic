extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/level1.tscn"))

func _on_level_select_button_pressed():
	get_tree().change_scene_to_packed(preload("res://scenes/level_select/level_select.tscn"))

func _on_options_button_pressed():
	get_tree().change_scene_to_packed(preload("res://scenes/levels/controls_menu.tscn"))


func _on_credits_button_pressed():
	get_tree().change_scene_to_packed(preload("res://scenes/levels/credits.tscn"))

func _on_exit_button_pressed():
	get_tree().quit()

