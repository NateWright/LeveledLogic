extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[true], [true], [true], [false]]
	GlobalState.instructionsTitle = "DeMorgan's Law – Or"
	GlobalState.instructionsContent = "
	
	";
	showInstructions()
