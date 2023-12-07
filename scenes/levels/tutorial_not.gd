extends BaseLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true], [false]]
	expectedOutput = [[false], [true]]

# Wire the NOT gate and match the expected output to finish the level
# Press 2 to select the NOT gate
# Press E to place the gate onto the cursor
# Now, by pressing TAB, you will go into the wire hotbar, with wire input being default
# you can press E to make a connection on a source block
# you can complete the connection by press 2 to select wire output and then
# pressing E on what you want to connect to.
