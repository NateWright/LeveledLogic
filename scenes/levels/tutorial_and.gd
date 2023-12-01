extends BaseLevel

var time = 0
var output = false
var array= [[true, true],[true,false],[false,false],[false,true]]
var level_solved = false

var index = 0

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
		getSource(0)._setOutput(array[index][0], randi())
		getSource(1)._setOutput(array[index][1], randi())
		var out = false#getSink(0).getOutput()
		var in1 = getSource(0).getOutput()
		var in2 = getSource(1).getOutput()
		#_on_level_solved.call_deferred()
		index += 1
		index = index % array.size()
		
		if out == true and level_solved == false :
			_on_level_solved.call_deferred()
			level_solved = true
		
