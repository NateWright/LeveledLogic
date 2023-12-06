extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	setTitle()
	setContent()
	pass # Replace with function body.

func setTitle():
	$MarginContainer/CenterContainer/Panel/Title.text = GlobalState.instructionsTitle

func setContent():
	$MarginContainer/CenterContainer/Panel/ScrollContainer/Content.text = GlobalState.instructionsContent
	
func _on_button_pressed():
	GlobalState.paused = false
	self.queue_free()
