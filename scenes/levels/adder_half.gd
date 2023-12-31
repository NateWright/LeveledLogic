extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[true, false], [false, true], [false, false], [false, true]]
	GlobalState.instructionsTitle = "Half Adder"
	GlobalState.instructionsContent = "
	The half adder is part of a circuit to calculate the sum of two binary numbers.
	The output is the sum of the two 1-bit inputs, with the most significant bit at the top.
	Two of these combine to make a full adder.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block


