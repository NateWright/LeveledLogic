extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true], [false]]
	expectedOutput = [[true], [false]]
