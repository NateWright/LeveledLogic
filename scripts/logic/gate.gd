class_name Gate extends Node
enum GATE {NONE, LEVER, LAMP, NOT, OR, AND, XOR, NAND, NOR, XNOR}
var _gate = GATE.NONE
var _gateBody: StaticBody2D
var _inputs = []
var _output: bool = false

var _outputList: Array[OutputSignal] = []

var _last_signal: int = 0
var _last_output: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gateSet():
	return _gate != GATE.NONE

func setGate(gate: GATE) -> StaticBody2D:
	_gate = gate
	match _gate:
		GATE.LEVER:
			_gateBody = preload("res://scenes/elements/logic/lever.tscn").instantiate()
			_gateBody.update(_output)
		GATE.LAMP:
			_inputs = [false]
			_gateBody = preload("res://scenes/elements/logic/lamp.tscn").instantiate()
			_gateBody.update(_output)
		GATE.NOT:
			_inputs = [false]
			_gateBody = preload("res://scenes/elements/logic/not_gate.tscn").instantiate()
		GATE.OR:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/or_gate.tscn").instantiate()
		GATE.AND:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/and_gate.tscn").instantiate()
		GATE.XOR:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/xor_gate.tscn").instantiate()
		GATE.NAND:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/nand_gate.tscn").instantiate()
		GATE.NOR:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/nor_gate.tscn").instantiate()
		GATE.XNOR:
			_inputs = [false, false]
			_gateBody = preload("res://scenes/elements/logic/xnor_gate.tscn").instantiate()
	return _gateBody
			
func getGateBody():
	return _gateBody

func connectOutput(out: OutputSignal):
	_outputList.append(out)
	out.output.emit(out.id, _output, randi())

func connectInput(posY: int):
	var out = OutputSignal.new()
	var offset = 0
	match _gate:
		GATE.LEVER:
			out.id = -1
		GATE.AND, GATE.OR, GATE.XOR, GATE.NAND, GATE.NOR, GATE.XNOR: # Gates with two inputs
			out.output.connect(_setInput)
			if posY < GlobalState.gridSize / 2:
				out.id = 0
				offset = GlobalState.gridSize / 4
			else:
				out.id = 1
				offset = GlobalState.gridSize * 3 / 4
		GATE.NOT, GATE.LAMP:
			out.output.connect(_setInput)
			out.id = 0
			offset = GlobalState.gridSize / 2
	return [out, offset]

func _setInput(id: int, value: bool, signal_id: bool):
	_inputs[id] = value
	match _gate:
		GATE.LAMP:
			_output = value
			_gateBody.update(_output)
		GATE.NOT:
			_output = !value
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
	_notify(signal_id)

func interact():
	if _gate == GATE.LEVER:
		_output = !_output
		_gateBody.update(_output)
		_notify(randi())
	return

func _notify(signal_id: int):
	if signal_id == _last_signal and _output != _last_output:
		push_warning("Signaling loop detected; skipping signal")
		return
	_last_signal = signal_id
	_last_output = _output
	for out in _outputList:
		out.output.emit(out.id, _output, signal_id)

func _getOutput():
	return _output
