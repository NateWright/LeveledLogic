extends Control

var _item = preload("res://scenes/controls/controls_item.tscn")
const binds = [
	["move up", "w | up arrow"],
	["move down", "s | down arrow"],
	["move left", "a | left arrow"],
	["move right", "d | right arrow"],
	["Sprint", "SHIFT"],
	["Switch tool", "tab"],
	["Pick hotbar", "1 - 9"],
	["Place / Select", "E"],
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for b in binds:
		var action = _item.instantiate()
		action.text = b[0]
		$HBoxContainer/Action.add_child(action)
		var control = _item.instantiate()
		control.text = b[1]
		$HBoxContainer/Control.add_child(control)
	$AspectRatioContainer/ButtonMainMenu.grab_focus.call_deferred()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("back"):
		_on_button_main_menu_pressed()


func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn"))
