extends Control

@export var level = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menubackground/MarginContainer/CenterContainer/PanelContainer/CenterContainer/VBoxContainer/ButtonResume.grab_focus.call_deferred()


func _on_button_resume_pressed():
	GlobalState.paused = false
	self.queue_free()


func _on_button_main_menu_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn"))


func _on_button_restart_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load(level))


func _on_button_instructions_pressed():
	var child = preload("res://scenes/levels/instructions_level.tscn").instantiate()
	child.position = self.position
	get_parent().add_child(child)
	self.queue_free()
