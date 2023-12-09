extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setTable(title, outputs):
	if outputs.size() == 2:
		_setOutputs2(title, outputs)
	else:
		_setOutputs4(title, outputs)


func _setOutputs2(title, outputs):
	$OneInput.visible = true
	$TwoInput.visible = false
	$OneInput/TITLE.text = title
	$OneInput/Output/Out1.text = outputs[0]
	$OneInput/Output/Out2.text = outputs[1]

func _setOutputs4(title, outputs):
	$OneInput.visible = false
	$TwoInput.visible = true
	$TwoInput/TITLE.text = title
	$TwoInput/Output/Out1.text = outputs[0]
	$TwoInput/Output/Out2.text = outputs[1]
	$TwoInput/Output/Out3.text = outputs[2]
	$TwoInput/Output/Out4.text = outputs[3]
