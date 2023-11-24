class_name Gate extends Node
enum GATE {NONE, LEVER, NOT, AND, OR, LAMP}
var _gate = GATE.NONE
var _gateBody: StaticBody2D
var _inputs = []
var _output: bool = false

var _outputList: Array[OutputSignal] = []
signal output_changed(output_id: int, value: bool)

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
		GATE.AND, GATE.OR:
			_inputs = [false, false]
			_gateBody = preload("res://assets/programmer_art/not_gate.png").instantiate()
		GATE.LAMP:
			_inputs = [false]
			_gateBody = preload("res://scenes/elements/logic/lamp.tscn").instantiate()
			_gateBody.update(_output)
		GATE.NOT:
			_inputs = [false]
			_gateBody = preload("res://scenes/elements/logic/not_gate.tscn").instantiate()
	return _gateBody
			

func connectOutput(out: OutputSignal):
	_outputList.append(out)
	out.output.emit(out.id, _output)
func connectInput(posY: int):
	var out = OutputSignal.new()
	var offset = 0
	match _gate:
		GATE.AND, GATE.OR:
			out.output.connect(_setInput)
			if posY < 16:
				out.id = 0
				offset = 8
			else:
				out.id = 1
				offset = 24
		GATE.NOT,GATE.LAMP:
			out.output.connect(_setInput)
			out.id = 0
			offset = 16
	return [out, offset]

func _setInput(id: int, value: bool):
	match _gate:
		GATE.NOT:
			_inputs[id] = value
			_output = !value
			_notify()
		GATE.AND:
			_inputs[id] = value
			_output = _inputs[0] and _inputs[1]
			_notify()
		GATE.OR:
			_inputs[id] = value
			_output = _inputs[0] or _inputs[1]
			_notify()
		GATE.LAMP:
			_inputs[id] = value
			_output = value
			_gateBody.update(_output)
			_notify()

func interact():
	if _gate == GATE.LEVER:
		_output = !_output
		_gateBody.update(_output)
		_notify()
	return

func _notify():
	for out in _outputList:
		out.output.emit(out.id, _output)

func _getOutput():
	return _output
