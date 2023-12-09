extends BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true], [false]]
	expectedOutput = [[false], [true]]
	GlobalState.instructionsTitle = "Not"
	GlobalState.instructionsContent = "
	This next level features your first logic gate called the NOT Gate. The not gate inverts the signal the input signal as the output.
	This means if no input is provided, then a 1 or True will come out.
	If a 1 is sent into the gate, then a 0 or False will come out.
	Use a not gate by selecting '3' on the hotbar to place the gate.
	Then hook it up with wires.
	Finally, press space to test your solution.
	";
	showInstructions()
# Wire the NOT gate and match the expected output to finish the level
# Press 2 to select the NOT gate
# Press E to place the gate onto the cursor
# Now, by pressing TAB, you will go into the wire hotbar, with wire input being default
# you can press E to make a connection on a source block
# you can complete the connection by press 2 to select wire output and then
# pressing E on what you want to connect to.
