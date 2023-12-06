class_name llPlayer extends CharacterBody2D

@export var speed = 200
enum TOOL { BLOCK, WIRE }
var _tool: TOOL = TOOL.BLOCK
var _position = Vector2()
var _lastXMotion = 0
var _gate: Gate = null

var _selectedGate = 0
var _selectedWireTool = 0

var wirePlacement = preload("res://assets/programmer_art/crate_pink.png")
var wirePlacmentInvalid = preload("res://assets/programmer_art/lever_off.png")


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var modifier = 1
	if Input.is_action_pressed("sprint"):
		modifier = 2
	velocity = input_direction * speed * modifier

func _physics_process(_delta):
	if GlobalState.paused:
		return
	get_input()
	move_and_slide()

func _process(_delta):
	if GlobalState.paused:
		return
	
	_setLookingAtBlock()
	_setLookingAtWire()

func _ready():
	$GatePlacement.visible = true
	$WirePlacement.visible = false

# pos is center of gate
func setLookingAt(pos: Vector2, gate: Gate):
	_position = pos
	_gate = gate
func setSelectedGate(num: int):
	_selectedGate = num
func setSelectedWireTool(num: int):
	_selectedWireTool = num

func toggleTool():
	if _tool == TOOL.BLOCK:
		_tool = TOOL.WIRE
		$GatePlacement.visible = false
		$WirePlacement.visible = true
	else:
		_tool = TOOL.BLOCK
		$GatePlacement.visible = true
		$WirePlacement.visible = false

func placing() -> bool:
	return _tool == TOOL.BLOCK

func _setLookingAtBlock():
	$GatePlacement.position = _position

func _setLookingAtWire():
	$WirePlacement.position.y = _position.y
	if !_gate or !_gate.gateSet():
		$WirePlacement.texture = wirePlacement
		$WirePlacement.position = $GatePlacement.position
		return
	var dir = get_last_motion()
	if dir != Vector2.ZERO:
		if dir.x != Vector2.ZERO.x:
			if dir.x > 0:
				_lastXMotion = -1
			elif dir.x < 0:
				_lastXMotion = 1
	
	# Adjust wire positon in up and down
	if _selectedWireTool == 1 or _selectedWireTool == 2:
		if !_gate.hasInput():
			$WirePlacement.texture = wirePlacmentInvalid
			$WirePlacement.position = _position
		else:
			var output = _gate.getInputLocation(int(position.y) % GlobalState.gridSize)
			if output['id'] == -1 or _gate.checkIntputConnected(output['id']):
				$WirePlacement.texture = wirePlacmentInvalid
			else:
				$WirePlacement.texture = wirePlacement
			var offset = output['offset']
			$WirePlacement.position.y += offset - GlobalState.gridSize/2
			$WirePlacement.position.x = _position.x - GlobalState.gridSize/2
	else:
		if !_gate.hasOutput():
			$WirePlacement.texture = wirePlacmentInvalid
			$WirePlacement.position = _position
		else:
			$WirePlacement.texture = wirePlacement
			$WirePlacement.position.y = $GatePlacement.position.y
			$WirePlacement.position.x = _position.x + GlobalState.gridSize/2
