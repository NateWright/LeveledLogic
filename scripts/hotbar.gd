extends Control

const GATES = 10
const WIRE_TOOLS = 3

@export var selected_style: StyleBox

@export_range(0, GATES - 1) var selectedGate: int = 0
signal selected_gate_changed(selectedGate)
@export_range(0, WIRE_TOOLS - 1) var selectedWireTool: int = 0
signal selected_wire_tool_changed(selectedWireTool)

@export var keybinds: Array[String] = [
	"hotbar1",
	"hotbar2",
	"hotbar3",
	"hotbar4",
	"hotbar5",
	"hotbar6",
	"hotbar7",
	"hotbar8",
	"hotbar9",
	"hotbar10"
];

var _hotbarItem = preload("res://scenes/hotbar/hotbar_item.tscn")

@export_subgroup("Unlocked Gates")
@export var _remove_unlocked = true;
@export var _and_unlocked = true;
@export var _or_unlocked = true;
@export var _not_unlocked = true;
@export var _xor_unlocked = true;
@export var _nand_unlocked = true;
@export var _nor_unlocked = true;
@export var _xnor_unlocked = true;
@export var _lever_unlocked = true;
@export var _lamp_unlocked = true;

@export_subgroup("Enabled Gates")
@export var _remove_enabled = true;
@export var _and_enabled = true;
@export var _or_enabled = true;
@export var _not_enabled = true;
@export var _xor_enabled = true;
@export var _nand_enabled = true;
@export var _nor_enabled = true;
@export var _xnor_enabled = true;
@export var _lever_enabled = true;
@export var _lamp_enabled = true;

var unlocked_array: Array[bool]
var enabled_array: Array[bool]
var gate_icons = [
	preload("res://assets/ui/hotbar/remove_gate.png"),
	preload("res://assets/gates/and.png"),
	preload("res://assets/gates/or.png"),
	preload("res://assets/gates/not.png"),
	preload("res://assets/gates/xor.png"),
	preload("res://assets/gates/nand.png"),
	preload("res://assets/gates/nor.png"),
	preload("res://assets/gates/xnor.png"),
	preload("res://assets/programmer_art/lever_on.png"),
	preload("res://assets/programmer_art/lamp_on.png"),
]
var gate_icons_disabled = [
	preload("res://assets/ui/hotbar/remove_gate.png"),
	preload("res://assets/gates/disabled/and.png"),
	preload("res://assets/gates/disabled/or.png"),
	preload("res://assets/gates/disabled/not.png"),
	preload("res://assets/gates/disabled/xor.png"),
	preload("res://assets/gates/disabled/nand.png"),
	preload("res://assets/gates/disabled/nor.png"),
	preload("res://assets/gates/disabled/xnor.png"),
	preload("res://assets/programmer_art/lever_on.png"),
	preload("res://assets/programmer_art/lamp_on.png"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	_initGateHotbar()
	_initWireToolHotbar()
	showGateHotbar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in keybinds.size():
		if ($CenterContainer/PanelContainer/WireTool.visible or (enabled_array[i] and unlocked_array[i])) and Input.is_action_just_pressed(keybinds[i]):
			_on_item_selected(i)
			return

func _on_item_selected(index: int):
	if $CenterContainer/PanelContainer/Gates.visible == true and selectedGate != index and index < GATES:
		var container = $CenterContainer/PanelContainer/Gates
		var selected_panel: PanelContainer = container.get_children()[selectedGate]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selectedGate = index
		selected_gate_changed.emit(index)
	elif $CenterContainer/PanelContainer/WireTool.visible == true and selectedWireTool != index and index < WIRE_TOOLS:
		var container = $CenterContainer/PanelContainer/WireTool
		var selected_panel: PanelContainer = container.get_children()[selectedWireTool]
		selected_panel.set("theme_override_styles/panel", null)
		var new_panel = container.get_children()[index]
		new_panel.set("theme_override_styles/panel", selected_style)
		selectedWireTool = index
		selected_wire_tool_changed.emit(index)

func showGateHotbar():
	$CenterContainer/PanelContainer/WireTool.visible = false
	$CenterContainer/PanelContainer/Gates.visible = true
func showWireHotbar():
	$CenterContainer/PanelContainer/Gates.visible = false
	$CenterContainer/PanelContainer/WireTool.visible = true

func _initGateHotbar():
	unlocked_array = [
		_remove_unlocked,
		_and_unlocked,
		_or_unlocked,
		_not_unlocked,
		_xor_unlocked,
		_nand_unlocked,
		_nor_unlocked,
		_xnor_unlocked,
		_lever_unlocked,
		_lamp_unlocked,
	]
	enabled_array = [
		_remove_enabled,
		_and_enabled,
		_or_enabled,
		_not_enabled,
		_xor_enabled,
		_nand_enabled,
		_nor_enabled,
		_xnor_enabled,
		_lever_enabled,
		_lamp_enabled,
	]
	
	var container = $CenterContainer/PanelContainer/Gates
	for i in GATES:
		var gate = _hotbarItem.instantiate()
		gate.setIcon(gate_icons[i])
		gate.setDisabledIcon(gate_icons_disabled[i])
		gate.setVisible(unlocked_array[i])
		gate.setEnabled(enabled_array[i] and unlocked_array[i])
		gate.connect_button(_on_item_selected.bind(i))
		container.add_child(gate)
		
	var new_panel = container.get_children()[selectedGate]
	new_panel.set("theme_override_styles/panel", selected_style)
	var scale_size = get_window().content_scale_size
	position.x = scale_size.x / 2
	position.y = scale_size.y

func _initWireToolHotbar():
	var container = $CenterContainer/PanelContainer/WireTool
	var icons = [
		preload("res://assets/ui/hotbar/add_wire_flipped.png"),
		preload("res://assets/ui/hotbar/add_wire.png"),
		preload("res://assets/ui/hotbar/remove_wire.png"),
	]
	for i in icons.size():
		var gate = _hotbarItem.instantiate()
		gate.setIcon(icons[i])
		gate.connect_button(_on_item_selected.bind(i))
		container.add_child(gate)
		
	var new_panel = container.get_children()[selectedWireTool]
	new_panel.set("theme_override_styles/panel", selected_style)
	var scale_size = get_window().content_scale_size
	position.x = scale_size.x / 2
	position.y = scale_size.y
