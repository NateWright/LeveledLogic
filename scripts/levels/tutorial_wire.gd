extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	providedInput = [[true], [false]]
	expectedOutput = [[true], [false]]
	GlobalState.instructionsTitle = "Wire"
	GlobalState.instructionsContent = "
	Welcome to Leveled Logic.
	
	This first level is designed to get you familiar with some of the controls and terms.
	This is the instructions panel which will show up at the beggining of some levels and can be brought up by pressing 'escape' and then clicking 'INSTRUCTIONS'
	Move your character with the arrow keys or WASD and sprint by holding SHIFT.
	
	On your left is a source block which will change from on to off showing you a sample input. On your right is a sink block which takes in the input and to the right of the sink block shows the expected output you are to create.
	To begin, press tab to switch to the wire tool hotbar.
	The first icon can be accessed by clicking on it or pressing '1'. This tool allows you to select an output like the source on your left. By walking over to it and pressing 'e' the souce block will be highlighted.
	Then, you can press '2' to switch to the input selection tool. Walk over to sink block on the right to and press 'e' on it to connect the two blocks together with a wire.
	If you want to disconnect an input this can be done with '3' on the wire tool hotbar and pressing 'e' on the input you want removed.
	After connectings the blocks together, you can press 'space' to check your solution.
	";
	showInstructions()
