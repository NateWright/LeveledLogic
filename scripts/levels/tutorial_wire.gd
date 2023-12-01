extends BaseLevel

var time = 0
var output = false
var level_solved = false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	
	time += delta
	
	if time > 1:
		time -= 1
		output = !output
		getSource(0)._setOutput(output, randi())
		var out = getSink(0).getOutput()
		#_on_level_solved.call_deferred()
		if out == true and level_solved == false:
			_on_level_solved.call_deferred()
			level_solved = true
		
