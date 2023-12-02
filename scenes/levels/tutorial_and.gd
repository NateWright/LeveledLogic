extends BaseLevel

var time = 0

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[true], [false], [false], [false]]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
	time += delta
	
	if time > 1:
		time -= 1
		getSource(0)._setOutput(providedInput[index][0], randi())
		getSource(1)._setOutput(providedInput[index][1], randi())
		index += 1
		index = index % providedInput.size()
		
