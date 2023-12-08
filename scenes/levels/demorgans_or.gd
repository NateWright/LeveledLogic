extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[true], [true], [true], [false]]
	GlobalState.instructionsTitle = "De Morgan's Law – Or"
	GlobalState.instructionsContent = "
	This level demonstrates an important relationship between the AND gate and the OR gate.
	The OR gate can be created with a combination of NOT gates and AND gates.
	This relationship is known as De Morgan's Law.
	";
	showInstructions()
