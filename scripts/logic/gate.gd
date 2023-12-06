class_name Gate extends Node
enum GATE {NONE, LEVER, LAMP, NOT, OR, AND, XOR, NAND, NOR, XNOR, SOURCE, SINK, INDICATOR}
var _gate = GATE.NONE
var _gateBody: StaticBody2D
var _inputs = []
var _inputsConnected: Array[bool] = []

var _output: bool = false


var _last_signal: int = 0
var _last_output: bool = false

var removable: bool = true

signal output(output: bool, signal_id: int)
signal disconnectOutput()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func gateSet():
	return _gate != GATE.NONE

func setGate(gate: GATE) -> StaticBody2D:
	_gate = gate
	match _gate:
		GATE.NONE:
			_inputs = []
			_gateBody = null
		GATE.LEVER:
			_gateBody = preload("res://scenes/elements/logic/lever.tscn").instantiate()
			_gateBody.update(_output)
		GATE.LAMP:
			_inputs = [false]
			_inputsConnected = [false]
			_gateBody = preload("res://scenes/elements/logic/lamp.tscn").instantiate()
			_gateBody.update(_output)
		GATE.NOT:
			_inputs = [false]
			_inputsConnected = [false]
			_gateBody = preload("res://scenes/elements/logic/not_gate.tscn").instantiate()
		GATE.OR:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/or_gate.tscn").instantiate()
		GATE.AND:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/and_gate.tscn").instantiate()
		GATE.XOR:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/xor_gate.tscn").instantiate()
		GATE.NAND:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/nand_gate.tscn").instantiate()
		GATE.NOR:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/nor_gate.tscn").instantiate()
		GATE.XNOR:
			_inputs = [false, false]
			_inputsConnected = [false, false]
			_gateBody = preload("res://scenes/elements/logic/xnor_gate.tscn").instantiate()
		GATE.SOURCE:
			_inputs = []
			_inputsConnected = []
			_gateBody = preload("res://scenes/elements/logic/source.tscn").instantiate()
		GATE.SINK:
			_inputs = [false]
			_inputsConnected = [false]
			_gateBody = preload("res://scenes/elements/logic/lamp.tscn").instantiate()
			_gateBody.update(_output)
		GATE.INDICATOR:
			_inputs = []
			_inputsConnected = []
			_gateBody = preload("res://scenes/elements/logic/lamp.tscn").instantiate()
	_updateOutput()
	return _gateBody
			
func getGateBody():
	return _gateBody

func hasOutput() -> bool:
	match _gate:
		GATE.SINK:
			return false
		GATE.INDICATOR:
			return false
	return true

func hasInput() -> bool:
	return bool(_inputs.size())

func connectOutput():
	output.emit(_output, randi())

func disconnectOutputs():
	disconnectOutput.emit()

func connectInput(posY: int, sig, sigDisconnect):
	var loc = getInputLocation(posY)
	var id = loc['id']
	
	if id == -1 or _inputsConnected[id] == true:
		id = -1
	else:
		_inputsConnected[id] = true
		sigDisconnect.connect(disconnectInput.bind(id, sig, sigDisconnect))
		sig.connect(_setInput.bind(id))
	return loc

func disconnectInput(id: int, sig: Signal, sigDisconnect: Signal):
	for con in sig.get_connections():
		if con['callable'].get_object() == self:
			con['signal'].disconnect(con['callable'])
	for con in sigDisconnect.get_connections():
		if con['callable'].get_object() == self:
			con['signal'].disconnect(con['callable'])
	_inputsConnected[id] = false
	_setInput(false, randi(), id)

func getInputLocation(posY: int):
	var offset = 0
	var id = -1
	match _gate:
		GATE.LEVER:
			id = -1
		GATE.AND, GATE.OR, GATE.XOR, GATE.NAND, GATE.NOR, GATE.XNOR: # Gates with two inputs
			if posY < GlobalState.gridSize / 2:
				id = 0
				offset = GlobalState.gridSize / 4
			else:
				id = 1
				offset = GlobalState.gridSize * 3 / 4
		GATE.NOT, GATE.LAMP:
			id = 0
			offset = GlobalState.gridSize / 2
		GATE.SOURCE:
			id = -1
		GATE.SINK:
			id = 0
			offset = GlobalState.gridSize / 2
		GATE.INDICATOR:
			id = -1
	return { 'id': id, 'offset': offset}

func checkIntputConnected(id: int):
	return _inputsConnected[id]

func _setInput(value: bool, signal_id: int, id: int):
	_inputs[id] = value
	_updateOutput()
	_notify(signal_id)

func _updateOutput():
	match _gate:
		GATE.LAMP:
			_output = _inputs[0]
			_gateBody.update(_output)
		GATE.NOT:
			_output = !_inputs[0]
		GATE.OR:
			_output = _inputs[0] or _inputs[1]
		GATE.AND:
			_output = _inputs[0] and _inputs[1]
		GATE.XOR:
			_output = _inputs[0] != _inputs[1]
		GATE.NAND:
			_output = not (_inputs[0] and _inputs[1])
		GATE.NOR:
			_output = not (_inputs[0] or _inputs[1])
		GATE.XNOR:
			_output = _inputs[0] == _inputs[1]
		GATE.SOURCE:
			_gateBody.update(_output)
		GATE.SINK:
			_output = _inputs[0]
			_gateBody.update(_output)
		GATE.INDICATOR:
			_gateBody.update(_output)
	

func setOutput(value: bool, signal_id: int):
	_output = value
	_gateBody.update(value)
	_notify(signal_id)

func interact():
	if _gate == GATE.LEVER:
		_output = !_output
		_gateBody.update(_output)
		var rand = randi()
		_notify(rand)
	return

func _notify(signal_id: int):
	if signal_id == _last_signal:
		if _output != _last_output:
			push_warning("Signaling loop detected; skipping signal")
		return    
	_last_signal = signal_id
	_last_output = _output
	output.emit(_output, signal_id)

func getOutput():
	return _output

