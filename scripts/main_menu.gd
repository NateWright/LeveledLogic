extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/PlayButton.grab_focus.call_deferred()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_play_button_pressed():
	GlobalState.curLevel = 0
	get_tree().change_scene_to_packed(load(GlobalState.LEVELS[GlobalState.curLevel][0]))

func _on_level_select_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/level_select/level_select.tscn"))

func _on_controls_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/controls/controls_menu.tscn"))

func _on_truth_table_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/truth_tables/truth_tables.tscn"))

func _on_credits_button_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/credits/credits.tscn"))

func _on_exit_button_pressed():
	get_tree().quit()

