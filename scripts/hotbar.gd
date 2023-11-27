extends Control

@export var selected_style: StyleBox

@export var selected = 0

@export var keybinds: Array[String] = [
	"place_lever",
	"place_lamp",
	"place_not",
	"place_and"
];

# Called when the node enters the scene tree for the first time.
func _ready():
	var container = $CenterContainer/PanelContainer/HBoxContainer
	var new_panel = container.get_children()[selected]
	new_panel.set("theme_override_styles/panel", selected_style)
	var scale_size = get_window().content_scale_size
	position.x = scale_size.x / 2
	position.y = scale_size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in keybinds.size():
		if Input.is_action_just_pressed(keybinds[i]):
			_on_item_selected(i)
			return


func _on_item_selected(index: int):
	if selected != index:
		var container = $CenterContainer/PanelContainer/HBoxContainer
		var selected_panel: PanelContainer = container.get_children()[selected]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selected = index
