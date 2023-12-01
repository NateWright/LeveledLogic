extends Control

var _button = preload("res://scenes/level_select/menu_entry.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(GlobalState.LEVELS.size()):
		var level = GlobalState.LEVELS[i]
		var button = _button.instantiate()
		button.text = level[1]
		button.pressed.connect(_on_level_select.bind(i))
		$MarginContainer/CenterContainer/VBoxContainer.add_child(button)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_level_select(level: int):
	GlobalState.curLevel = level
	get_tree().change_scene_to_packed(load(GlobalState.LEVELS[level][0]))


func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/main_menu.tscn")) # Replace with function body.
