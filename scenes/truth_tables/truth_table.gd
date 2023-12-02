extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func setTitle(title: String):
	$TITLE.text = title

func setOutputs(outputs):
	if outputs.size() == 2:
		_setOutputs2(outputs)
	else:
		_setOutputs4(outputs)


func _setOutputs2(outputs):
	$HBoxContainer/Input1.visible = false
	$HBoxContainer/Input2.visible = false
	$HBoxContainer/Output.visible = false
	$HBoxContainer/Output/Out1.text = outputs[0]
	$HBoxContainer/Output/Out2.text = outputs[1]

func _setOutputs4(outputs):
	$HBoxContainer/TwoInput.visible = false
	$HBoxContainer/TwoOutput.visible = false
	$HBoxContainer/Output/Out1.text = outputs[0]
	$HBoxContainer/Output/Out2.text = outputs[1]
	$HBoxContainer/Output/Out3.text = outputs[2]
	$HBoxContainer/Output/Out4.text = outputs[3]
