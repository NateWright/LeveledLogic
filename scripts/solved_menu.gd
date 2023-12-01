extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalState.curLevel == GlobalState.LEVELS.size() - 1:
		$Menubackground/MarginContainer/CenterContainer/PanelContainer/MarginContainer/VBoxContainer/ButtonNextLevel.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_next_level_pressed():
	GlobalState.paused = false
	GlobalState.curLevel += 1
	get_tree().change_scene_to_packed(load(GlobalState.LEVELS[GlobalState.curLevel][0]))


func _on_button_level_select_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/level_select/level_select.tscn"))


func _on_button_main_menu_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn"))


func _on_button_restart_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load(GlobalState.LEVELS[GlobalState.curLevel][0]))
