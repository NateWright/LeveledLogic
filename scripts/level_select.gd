extends Control

var _button = preload("res://scenes/level_select/menu_entry.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(GlobalState.LEVELS.size()):
		var level = GlobalState.LEVELS[i]
		var button = _button.instantiate()
		button.text = level[1]
		button.pressed.connect(_on_level_select.bind(i))
		$ScrollContainer/CenterContainer/VBoxContainer.add_child(button)
		print(level[1])
	$ScrollContainer/CenterContainer/VBoxContainer.get_child(0).grab_focus.call_deferred()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("back"):
		_on_button_main_menu_pressed()


func _on_level_select(level: int):
	GlobalState.curLevel = level
	get_tree().change_scene_to_packed(load(GlobalState.LEVELS[level][0]))


func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn")) # Replace with function body.
