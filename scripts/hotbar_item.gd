extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func setIcon(text: Texture2D):
	$MarginContainer/TextureRect.texture_normal = text

func connect_button(onclick: Callable):
	$MarginContainer/TextureRect.connect("pressed", onclick)
