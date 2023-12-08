extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [
		[true, true],
		[true,false],
		[false,false],
		[false,true],
		[false, false],
		[true, false],
	]
	expectedOutput = [
		[true, false], 
		[true, false], 
		[true, false], 
		[false, true], 
		[false, true], 
		[false, true]
	]
	GlobalState.instructionsTitle = "D Latch"
	GlobalState.instructionsContent = "
	A D latch will update its output to match its input whenever the clock line transitions high.
	When the clock line is low, the latch will save its current state.
	The input line is the top input, and the clock line is the bottom input.
	This circuit is a very common state-based circuit.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block


