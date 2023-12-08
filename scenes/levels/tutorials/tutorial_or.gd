extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[true], [true], [true], [false]]
	GlobalState.instructionsTitle = "Or"
	GlobalState.instructionsContent = "
	This level will teach you about the OR gate.
	The OR gate emits a true signal whenever either of its inputs is true.
	Remember to press 'space' to test your solution.
	";
	showInstructions()
