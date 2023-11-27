extends Node2D

@export var next_level: PackedScene
var _mapSize = Vector2i(30 * 2, 17 * 2) # count of 64 length units
var _gates = [] # index y, x

var _output: Gate = null
var _outputGateIndex: Vector2i
var _outputGateLoc: Vector2i

var _linePaths = []
var _lineOccupation = []

var _aStar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Placement.position.x = snapped(round($Player.position.x), 32) + 32
	$Placement.position.y = snapped(round($Player.position.y), 32)
	
	_aStar.reserve_space(_mapSize.y * _mapSize.x)
	for y in range(_mapSize.y):
		var row: Array[Gate] = []
		var rowLine: Array[int] = []
		for x in range(_mapSize.x):
			row.append(Gate.new())
			rowLine.append(0)
			_aStar.add_point((y*_mapSize.x) + x, Vector2(x, y))
			if x > 0:
				_aStar.connect_points((y*_mapSize.x) + x, (y*_mapSize.x) + x - 1)
			if y > 0:
				_aStar.connect_points((y*_mapSize.x) + x, ((y - 1)*_mapSize.x) + x)
		
		_gates.append(row)
		_lineOccupation.append(rowLine)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalState.paused:
		return
	if Input.is_action_just_pressed("pause"):
		GlobalState.paused = true
		var child = preload("res://scenes/levels/pause_menu.tscn").instantiate()
		child.position = self.get_window().content_scale_size / 2
		self.add_child(child)
		return
	
	var dir = $Player.get_last_motion()
	var i = 0
	if dir != Vector2.ZERO:
		if dir.x != Vector2.ZERO.x:
			if dir.x > 0:
				i = 1
			elif dir.x < 0:
				i = -1
			$Placement.position.x = snapped(round($Player.position.x), 32) + i * 32

		$Placement.position.y = snapped(round($Player.position.y), 32)
	
		
	if Input.is_action_just_pressed("place_lever"):
		_placeGate(Gate.GATE.LEVER)
	elif Input.is_action_just_pressed("place_lamp"):
		_placeGate(Gate.GATE.LAMP)
	elif Input.is_action_just_pressed("place_not"):
		_placeGate(Gate.GATE.NOT)
	elif Input.is_action_just_pressed("place_and"):
		_placeGate(Gate.GATE.AND)
	elif Input.is_action_just_pressed("select_output"):
		_selectOutput()
	elif Input.is_action_just_pressed("select_input"):
		if _output != null:
			_selectInput()
	elif Input.is_action_just_pressed("activate"):
		_activateGate()

func _selectOutput():
	var vec = Vector2i()
	var placement = $Placement.position

	vec.x = int(placement.x) / 32
	vec.y = int(placement.y) / 32
	var gate: Gate = _gates[vec.y][vec.x]
	if !gate.gateSet():
		_output = null
		return
	
	if vec.x + 1 >= len(_gates[vec.y]) or _gates[vec.y][vec.x + 1].gateSet():
		_output = null
		print("Gate Output Blocked")
		return
	
	_outputGateIndex = vec
	_output = gate
	
	_outputGateLoc = vec * 32
	_outputGateLoc.x += 16
	
func _selectInput():
	var vec = Vector2i()
	var placement = $Placement.position

	vec.x = int(placement.x) / 32
	vec.y = int(placement.y) / 32
	var gate: Gate = _gates[vec.y][vec.x]
	if !gate.gateSet():
		print("No Gate Here")
		return
	
	if vec.x - 1 < 0 or _gates[vec.y][vec.x - 1].gateSet():
		print("Gate Input Blocked")
		return
	
	var r = gate.connectInput(int($Player.position.y)%32)
	if r[0].id == -1:
		return
	var path = _aStar.get_point_path(_outputGateIndex.y * _mapSize.x + _outputGateIndex.x + 1, vec.y * _mapSize.x + vec.x - 1)
	var line = Line2D.new()
	line.add_point(_outputGateLoc)
	for p in path:
		line.add_point(p*32)
		_lineOccupation[p.y][p.x] += 1
	
	_output.connectOutput(r[0])
	
	var inputLoc = vec * 32
	inputLoc.x -= 16
	inputLoc.y += (r[1] - 16)
	
	line.add_point(inputLoc)
	line.width = 5
	_linePaths.append(line)
	self.add_child(line)


func _placeGate(type: Gate.GATE):
	var vec = Vector2i()
	var placement = $Placement.position
	
	vec.x = int(placement.x) / 32
	vec.y = int(placement.y) / 32
	var gate: Gate = _gates[vec.y][vec.x]
	if gate.gateSet() or _lineOccupation[vec.y][vec.x] != 0:
		return
	
	_aStar.set_point_disabled((vec.y * _mapSize.x) + vec.x)
	
	_gates[vec.y][vec.x]
	var gateBody = gate.setGate(type)
	gateBody.position = placement
	self.add_child(gateBody)

func _activateGate():
	var vec = Vector2i()
	var placement = $Placement.position
	
	vec.x = int(placement.x) / 32
	vec.y = int(placement.y) / 32
	var gate: Gate = _gates[vec.y][vec.x]
	gate.interact()

func _on_level_solved():
	GlobalState.paused = true
	var child = preload("res://scenes/levels/solved_menu.tscn").instantiate()
	child.position = self.get_window().content_scale_size / 2
	child.next_level = next_level
	self.add_child(child)

func _on_lamp_logic_changed(state: bool, _id: int):
	if state:
		_on_level_solved.call_deferred()
