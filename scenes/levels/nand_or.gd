extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[true], [true], [true], [false]]
	GlobalState.instructionsTitle = "Completeness"
	GlobalState.instructionsContent = "
	Yet again, this requires implementing an OR gate.
	However, the only gate available is a NAND gate.
	This demonstrates the functional completeness of the NAND gate.
	";
	showInstructions()
