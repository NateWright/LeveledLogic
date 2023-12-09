extends BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[true], [false], [false], [true]]
	GlobalState.instructionsTitle = "Xnor"
	GlobalState.instructionsContent = "
	This level will teach you about the Xnor gate.
	Similar to NAND and NOR gate this gate is effectively a NOT gate and a XOR gate combined.
	Try completing the level with both!
	";
	showInstructions()
