extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[true], [false], [false], [false]]
	GlobalState.instructionsTitle = "And"
	GlobalState.instructionsContent = "
	This level will teach you about the AND gate. The AND gate takes in two inputs and if they are both true, then it produces a true signal.
	This behavior can be looked up on the main menu where you can click on TRUTH TABLES to see how each gate reacts to diffrerent inputs.
	Remember to press 'space' to test your solution.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block

