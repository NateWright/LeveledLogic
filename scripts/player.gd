class_name llPlayer extends CharacterBody2D

@export var speed = 200
enum TOOL { BLOCK, WIRE }
var _tool: TOOL = TOOL.BLOCK
var _position = Vector2()
var _gate: Gate = null


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
	$GatePlacement.position = _position
	$WirePlacement.position.y = _position.y
	# Inputs
	var dir = get_last_motion()
	if dir != Vector2.ZERO:
		if dir.x != Vector2.ZERO.x:
			var i = 0
			if dir.x > 0:
				i = -1
			elif dir.x < 0:
				i = 1
			$WirePlacement.position.x = _position.x + i * GlobalState.gridSize/2

func _ready():
	$GatePlacement.visible = true
	$WirePlacement.visible = false

# pos is center of gate
func setLookingAt(pos: Vector2, gate: Gate):
	_position = pos
	_gate = gate

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
