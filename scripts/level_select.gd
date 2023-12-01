extends Control

const _LEVELS = [
	["res://scenes/levels/level1.tscn", "Level 1"],
	["res://scenes/main_menu/main_menu.tscn", "Back to Main Menu"]
]

var _button = preload("res://scenes/level_select/menu_entry.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(_LEVELS.size()):
		var level = _LEVELS[i]
		var button = _button.instantiate()
		button.text = level[1]
		button.pressed.connect(_on_level_select.bind(level[0]))
		$MarginContainer/CenterContainer/VBoxContainer.add_child(button)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_level_select(level: String):
	get_tree().change_scene_to_packed(load(level))


func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/levels/main_menu.tscn")) # Replace with function body.
