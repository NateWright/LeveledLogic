extends Control

@export var selected_style: StyleBox

@export var selectedGate = 0
@export var selectedWireTool = 0
@export var keybinds: Array[String] = [
	"hotbar1",
	"hotbar2",
	"hotbar3",
	"hotbar4"
];

var _hotbarItem = preload("res://scenes/hotbar/hotbar_item.tscn")

@export_subgroup("Enabled")
@export var _lever = true;
@export var _lamp = true;
@export var _not = true;
@export var _and = true;

var enabled_array


# Called when the node enters the scene tree for the first time.
func _ready():
	_initGateHotbar()
	_initWireToolHotbar()
	showGateHotbar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in keybinds.size():
		if enabled_array[i] and Input.is_action_just_pressed(keybinds[i]):
			_on_item_selected(i)
			return

func _on_item_selected(index: int):
	if $CenterContainer/PanelContainer/Gates.visible == true and selectedGate != index:
		var container = $CenterContainer/PanelContainer/Gates
		var selected_panel: PanelContainer = container.get_children()[selectedGate]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selectedGate = index
	elif $CenterContainer/PanelContainer/WireTool.visible == true and selectedWireTool != index:
		var container = $CenterContainer/PanelContainer/WireTool
		var selected_panel: PanelContainer = container.get_children()[selectedWireTool]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selectedWireTool = index

func showGateHotbar():
	$CenterContainer/PanelContainer/WireTool.visible = false
	$CenterContainer/PanelContainer/Gates.visible = true
func showWireHotbar():
	$CenterContainer/PanelContainer/Gates.visible = false
	$CenterContainer/PanelContainer/WireTool.visible = true

func _initGateHotbar():
	var container = $CenterContainer/PanelContainer/Gates
	var icons = [
		preload("res://assets/programmer_art/delete.png"),
		preload("res://assets/programmer_art/lever_on.png"),
		preload("res://assets/programmer_art/lamp_on.png"),
		preload("res://assets/gates/or.png"),
		preload("res://assets/gates/and.png"),
	]
	for val in icons:
		var gate = _hotbarItem.instantiate()
		gate.setIcon(val)
		container.add_child(gate)
		
	var new_panel = container.get_children()[selectedGate]
	new_panel.set("theme_override_styles/panel", selected_style)
	var scale_size = get_window().content_scale_size
	position.x = scale_size.x / 2
	position.y = scale_size.y
	
	enabled_array = [
		_lever,
		_lamp,
		_not,
		_and
	]
	
	for i in enabled_array.size():
		var button: TextureButton = $CenterContainer/PanelContainer/Gates.get_child(i).get_child(0).get_child(0)
		button.disabled = true

func _initWireToolHotbar():
	var container = $CenterContainer/PanelContainer/WireTool
	var icons = [
		preload("res://assets/programmer_art/lever_on.png"),
		preload("res://assets/programmer_art/lever_off.png"),
	]
	for val in icons:
		var gate = _hotbarItem.instantiate()
		gate.setIcon(val)
		container.add_child(gate)
		
	var new_panel = container.get_children()[selectedWireTool]
	new_panel.set("theme_override_styles/panel", selected_style)
	var scale_size = get_window().content_scale_size
	position.x = scale_size.x / 2
	position.y = scale_size.y
	
	enabled_array = [
		_lever,
		_lamp,
		_not,
		_and
	]
	
	for i in enabled_array.size():
		var button: TextureButton = $CenterContainer/PanelContainer/Gates.get_child(i).get_child(0).get_child(0)
		button.disabled = true
