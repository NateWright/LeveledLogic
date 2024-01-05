extends TextureRect

const _table = preload("res://scenes/truth_tables/truth_table.tscn")
var _GATES = [
	["NOT", ["T", "F"]],
	["AND", ["T", "F", "F", "F"]],
	["OR", ["T", "T", "T", "F"]],
	["XOR", ["F", "T", "T", "F"]],
	["NAND", ["F", "T", "T", "T"]],
	["NOR", ["F", "F", "F", "T"]],
	["XNOR", ["T", "F", "F", "T"]]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AspectRatioContainer/ButtonMainMenu.grab_focus.call_deferred()
	for g in _GATES:
		var t = _table.instantiate()
		t.setTable(g[0], g[1])
		$ScrollContainer/CenterContainer/Container.add_child(t)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("back"):
		_on_button_main_menu_pressed()

func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn"))
