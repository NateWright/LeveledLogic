extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[false, false, false, true],[false, false, true,false],[false,true, false, false],[true, false, false,false]]
	expectedOutput = [[false, false], [false, true], [true, false], [true, true]]
	GlobalState.instructionsTitle = "Binary Encoder"
	GlobalState.instructionsContent = "
	A binary decoder outputs the index of the selected input as a binary number.
	Binary decoders can be made to support arbitrarily-large numbers.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block


