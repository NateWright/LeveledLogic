extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[true], [false], [false], [false]]
# This level is designed for you to be familiar with AND Gates
# While in gate tool hotbar, Press 2 to select the AND gate
# Now press E to place the gate onto the cursor.
# The AND gate will not turn on unless both of its inputs are also on.

