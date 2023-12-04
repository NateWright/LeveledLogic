class_name llPlayer extends CharacterBody2D

@export var speed = 200
enum TOOL { BLOCK, WIRE }
var _tool: TOOL = TOOL.BLOCK
var _position = Vector2()
var _lastXMotion = 0
var _gate: Gate = null

var _selectedGate = 0
var _selectedWireTool = 0


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

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
		var offset = _gate.getInputLocation(int(position.y)%GlobalState.gridSize)['offset']
		$WirePlacement.position.y += offset - GlobalState.gridSize/2
		$WirePlacement.position.x = _position.x - GlobalState.gridSize/2
	else:
		$WirePlacement.position.y = $GatePlacement.position.y
		$WirePlacement.position.x = _position.x + GlobalState.gridSize/2
