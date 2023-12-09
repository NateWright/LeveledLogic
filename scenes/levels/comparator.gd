extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[false, true, false], [true, false, false], [false, true, false], [false, false, true]]
	GlobalState.instructionsTitle = "Comparator"
	GlobalState.instructionsContent = "
	A comparator signals how the first number compares to the second.
	The top output is active if the first is larger than the second, the bottom if the second is larger, and the middle if the two are equal.
	This level only features 1-bit inputs, but larger input circuits are possible.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block


