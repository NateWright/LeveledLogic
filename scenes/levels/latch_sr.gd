extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, false],[false,false],[true,false],[false,false],[false,true],[false,false],[false,true],[false,false]]
	expectedOutput = [[false,true], [false,true], [false,true], [false,true],[true,false],[true,false],[true,false],[true,false]]
	GlobalState.instructionsTitle = "SR Latch"
	GlobalState.instructionsContent = "
	An SR latch will update its outputs whenever one of its inputs updates.
	When neither input is high, the latch will remember its previous state.
	This circuit is the basis of most state-based circuits.
	";
	showInstructions()
# Wire the AND gate and match the expected output to complete the level
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 3 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate accepts two inputs and makes one output
# The AND gate will not turn on unless both of its inputs are also on.
# Wire the AND gate from both source blocks and into the sink block


