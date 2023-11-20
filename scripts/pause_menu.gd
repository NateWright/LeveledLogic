extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		GlobalState.paused = false
		self.queue_free()


func _on_button_resume_pressed():
	GlobalState.paused = false
	self.queue_free()


func _on_button_main_menu_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/levels/main_menu.tscn"))


func _on_button_restart_pressed():
	GlobalState.paused = false
	get_tree().change_scene_to_packed(load("res://scenes/levels/level_test.tscn"))
