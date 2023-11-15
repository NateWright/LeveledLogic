extends Control

@export var selected_style: StyleBox

@export var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var container = $CenterContainer/PanelContainer/HBoxContainer
	var new_panel = container.get_children()[selected]
	new_panel.set("theme_override_styles/panel", selected_style)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_item_selected(index: int):
	if selected != index:
		var container = $CenterContainer/PanelContainer/HBoxContainer
		var selected_panel: PanelContainer = container.get_children()[selected]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selected = index
