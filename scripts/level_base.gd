extends Node2D

@export var next_level: PackedScene
var _mapSize = Vector2i(30, 17) # count of 64 length units
var _gates = [] # index y, x
var _gridSelection = Vector2i(0, 0) # position in _gates array
var _placementVec = Vector2() # Position of placement guide releative to player

var _output: Gate = null
var _outputGateIndex: Vector2i # index in gate array
var _outputGateLoc: Vector2i # position of ouput on map

var _linePaths = {}
var _lineOccupation = [] # index y, x

var _aStar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize grid and search
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
	
	var count = 0
	for i in range(17):
		if i % 2:
			_placeGate(Gate.GATE.LEVER, Vector2i(0, i))
			count+= 1
#	#TODO: Add other tiles
	var tileMap: TileMap = $Level

	var cells = tileMap.get_used_cells(0)
	for cell in cells:
		var pos = cell*GlobalState.gridSize
		pos.x += GlobalState.gridSize/2
		pos.y += GlobalState.gridSize/2
		var vec = tileMap.get_cell_atlas_coords(0, cell)
		_placeGate(Gate.GATE.AND, cell)
	
	# Initialize current selection
	_gridSelection.x = $Player.position.x / GlobalState.gridSize
	_gridSelection.y = $Player.position.y / GlobalState.gridSize
	_placementVec.x = _gridSelection.x * GlobalState.gridSize + 1 * GlobalState.gridSize + GlobalState.gridSize/2 - $Player.position.x
	_placementVec.y = _gridSelection.y * GlobalState.gridSize + GlobalState.gridSize/2 - $Player.position.y
	$Player.setLookingAt(_placementVec, _gates[_gridSelection.y][_gridSelection.x])
	$Hotbar.selected_gate_changed.connect($Player.setSelectedGate)
	$Hotbar.selected_wire_tool_changed.connect($Player.setSelectedWireTool)

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
	if dir != Vector2.ZERO:
		if dir.x != Vector2.ZERO.x:
			var i = 0
			if dir.x > 0:
				i = 1
			elif dir.x < 0:
				i = -1
			_gridSelection.x = $Player.position.x / GlobalState.gridSize + i
			_placementVec.x = _gridSelection.x * GlobalState.gridSize + GlobalState.gridSize/2 - $Player.position.x
		_gridSelection.y = $Player.position.y / GlobalState.gridSize
		_placementVec.y = _gridSelection.y * GlobalState.gridSize + GlobalState.gridSize/2 - $Player.position.y
		$Player.setLookingAt(_placementVec, _gates[_gridSelection.y][_gridSelection.x])
	
	if Input.is_action_just_pressed("interact"):
		if $Player.placing():
			var gates = [
				Gate.GATE.NONE,
				Gate.GATE.LEVER,
				Gate.GATE.LAMP,
				Gate.GATE.NOT,
				Gate.GATE.AND
			]
			_placeGate(gates[$Hotbar.selectedGate], _gridSelection)
		else:
			if $Hotbar.selectedWireTool == 0:
				_selectOutput()
			elif _output != null:
				_selectInput()
	elif Input.is_action_just_pressed("switch_tool"):
		if $Player.placing():
			$Hotbar.showWireHotbar()
		else:
			$Hotbar.showGateHotbar()
		$Player.toggleTool()
			
#	elif Input.is_action_just_pressed("select_output"):
#		_selectOutput()
#	elif Input.is_action_just_pressed("select_input"):
#		if _output != null:
#			_selectInput()
	elif Input.is_action_just_pressed("activate"):
		_activateGate()

func _selectOutput():
	var vec = _gridSelection
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
	
	_outputGateLoc = vec * GlobalState.gridSize
	_outputGateLoc.y += GlobalState.gridSize/2
	_outputGateLoc.x += GlobalState.gridSize
	
func _selectInput():
	var vec = _gridSelection
	var gate: Gate = _gates[vec.y][vec.x]

	if !gate.gateSet():
		print("No Gate Here")
		return
	
	if vec.x - 1 < 0 or _gates[vec.y][vec.x - 1].gateSet():
		print("Gate Input Blocked")
		return
	
	var r = gate.connectInput(int($Player.position.y)%GlobalState.gridSize)
	if r[0].id == -1:
		return
	var path = _aStar.get_point_path(_outputGateIndex.y * _mapSize.x + _outputGateIndex.x + 1, vec.y * _mapSize.x + vec.x - 1)
	if path.size() == 0:
		return
	var line = Line2D.new()
	line.add_point(_outputGateLoc)
	for p in path:
		var pos = p*GlobalState.gridSize
		pos.x += GlobalState.gridSize/2
		pos.y += GlobalState.gridSize/2
		line.add_point(pos)
		_lineOccupation[p.y][p.x] += 1
	
	_output.connectOutput(r[0])
	
	var inputLoc = vec * GlobalState.gridSize
#	inputLoc.x -= GlobalState.gridSize
	inputLoc.y += r[1]
	
	line.add_point(inputLoc)
	line.width = 5
	if _outputGateIndex not in _linePaths:
		_linePaths[_outputGateIndex] = {}
	if vec not in _linePaths:
		_linePaths[vec] = {}
	_linePaths[_outputGateIndex][vec] = line
	_linePaths[vec][_outputGateIndex] = line
	self.add_child(line)


func _placeGate(type: Gate.GATE, placement: Vector2i):
	if type == Gate.GATE.NONE:
		_removeGate(placement)
		return
	var vec = placement
	var gate: Gate = _gates[vec.y][vec.x]

	if gate.gateSet() or _lineOccupation[vec.y][vec.x] != 0:
		return
	
	_aStar.set_point_disabled((vec.y * _mapSize.x) + vec.x)
	
	var gateBody = gate.setGate(type)
	gateBody.position.x = placement.x * GlobalState.gridSize + GlobalState.gridSize/2
	gateBody.position.y = placement.y * GlobalState.gridSize + GlobalState.gridSize/2
	self.add_child(gateBody)

func _removeGate(location: Vector2i):
	var vec = location
	var gate: Gate = _gates[vec.y][vec.x]

	if !gate.gateSet():
		return
	print("removing gate")
	
	_aStar.set_point_disabled((vec.y * _mapSize.x) + vec.x, false)
	self.remove_child(gate.getGateBody())
	var outLocation = location
	outLocation.x += 1
	var inLocation = location
	inLocation.x -= 1
	if location in _linePaths:
		for val in _linePaths[location]:
			var line:Line2D = _linePaths[location][val]
			for i in range(1, line.get_point_count() - 1):
				var l: Vector2i = line.get_point_position(i) / GlobalState.gridSize
				_lineOccupation[l.y][l.x] -= 1
			if val != location:
				_linePaths[val].erase(location)
			_linePaths[location].erase(val)
			self.remove_child(line)
	_gates[vec.y][vec.x].disconnectOutputs()
	_gates[vec.y][vec.x] = Gate.new()
	
func _activateGate():
	var vec = _gridSelection
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
