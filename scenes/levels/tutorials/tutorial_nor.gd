extends BaseLevel


func _ready():
	super._ready()
	providedInput = [[true, true],[true, false],[false, true],[false, false]]
	expectedOutput = [[false], [false], [false], [true]]
