extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/ButtonMainMenu.grab_focus.call_deferred()
	pass
#	add_names_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_button_main_menu_pressed():
	get_tree().change_scene_to_packed(load("res://scenes/main_menu/main_menu.tscn"))


func _on_button_website_pressed():
	var url = "https://natewright.github.io/LeveledLogicWebsite/"
	OS.shell_open(url)


#func add_names_label():
#	var names_label = Label.new()
#	var developers = ["Johnathan Kang", "Connor Klein", "Gabriel Shahrouzi", "Eric Ta", "Nathan Wright"]
#	names_label.text = "Developed by: "
#	for dev in developers:
#		names_label.text += dev + ', '
#	$MarginContainer/CenterContainer/VBoxContainer.add_child(names_label)
