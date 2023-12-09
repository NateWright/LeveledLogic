class_name llPlayer extends CharacterBody2D

@export var speed = 200
enum TOOL { BLOCK, WIRE }
var _tool: TOOL = TOOL.BLOCK
var _position = Vector2()
var _lastXMotion = 0
var _gate: Gate = null

var _selectedGate = 0
var _selectedWireTool = 0
var gateIcons

var wirePlacement = preload("res://assets/player/cursor_connect.png")
var wireRemove = preload("res://assets/player/cursor_disconnect.png")
var wirePlacmentInvalid = preload("res://assets/player/cursor_blank.png")

var _playerFront = preload("res://assets/player/player_front.png")
var _playerBack = preload("res://assets/player/player_back.png")
var _playerLeft = preload("res://assets/player/player_left.png")
var _playerRight = preload("res://assets/player/player_right.png")


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	match int(input_direction.x):
		1:
			$Sprite2D.texture = _playerRight
		0:
			$Sprite2D.texture = _playerFront
		-1:
			$Sprite2D.texture = _playerLeft
	match int(input_direction.y):
		-1:
			$Sprite2D.texture = _playerBack
		
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
	$GatePlacement.texture = gateIcons[_selectedGate]
	
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
		$WirePlacement.texture = wirePlacmentInvalid
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
	
	match _selectedWireTool:
		0: # Select Output
			if _gate.hasOutput():
				$WirePlacement.texture = wirePlacement
				$WirePlacement.position.y = $GatePlacement.position.y
				$WirePlacement.position.x = _position.x + GlobalState.gridSize/2
			else:
				$WirePlacement.texture = wirePlacmentInvalid
				$WirePlacement.position = _position
		1: # Select Input
			if _gate.hasInput():
				var output = _gate.getInputLocation(int(position.y) % GlobalState.gridSize)
				if output['id'] == -1 or _gate.checkIntputConnected(output['id']):
					$WirePlacement.texture = wirePlacmentInvalid
				else:
					$WirePlacement.texture = wirePlacement
				var offset = output['offset']
				$WirePlacement.position.y += offset - GlobalState.gridSize/2
				$WirePlacement.position.x = _position.x - GlobalState.gridSize/2
			else:
				$WirePlacement.texture = wirePlacmentInvalid
				$WirePlacement.position = _position
		2: # Disconnect Input
			if _gate.hasInput():
				var output = _gate.getInputLocation(int(position.y) % GlobalState.gridSize)
				if output['id'] == -1:
					$WirePlacement.texture = wirePlacmentInvalid
				elif _gate.checkIntputConnected(output['id']):
					$WirePlacement.texture = wireRemove
				else:
					$WirePlacement.texture = wirePlacmentInvalid
				var offset = output['offset']
				$WirePlacement.position.y += offset - GlobalState.gridSize/2
				$WirePlacement.position.x = _position.x - GlobalState.gridSize/2
			else:
				$WirePlacement.texture = wirePlacmentInvalid
				$WirePlacement.position = _position
