extends BaseLevel


func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[false], [false], [false], [true]]
