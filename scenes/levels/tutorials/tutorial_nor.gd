extends BaseLevel


func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[false], [false], [false], [true]]
	GlobalState.instructionsTitle = "Nor"
	GlobalState.instructionsContent = "
	This level will teach you about the NOR gate.
	The NOR gate is similar to a NAND gate, but with a OR and NOT Gate.
	";
	showInstructions()
