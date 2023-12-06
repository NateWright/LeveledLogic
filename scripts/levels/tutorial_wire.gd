extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true], [false]]
	expectedOutput = [[true], [false]]
	GlobalState.instructionsTitle = "Wire"
	GlobalState.instructionsContent = "
	Press tab to switch to the wire hotbar.
	Then select the output of the source on the left with 'e'.
	Then press '1' to switch to selecing inputs.
	Then walk over to the 'sink' on the right and press 'e' on the input.
	Get back to this menu by pressing escape then selecting INSTRUCTIONS.
	";
	showInstructions()
