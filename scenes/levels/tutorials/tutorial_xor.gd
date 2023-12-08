extends BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[false], [true], [true], [false]]
	GlobalState.instructionsTitle = "Xor"
	GlobalState.instructionsContent = "
	This level will teach you about the Xor gate.
	A XOR gate only emits a true signal when only one of the inputs is true.
	";
	showInstructions()
