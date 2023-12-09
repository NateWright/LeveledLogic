extends BaseLevel


func _ready():
	super._ready()
	providedInput = [[true, true],[true,false],[false,false],[false,true]]
	expectedOutput = [[false], [true], [true], [true]]
	GlobalState.instructionsTitle = "Nand"
	GlobalState.instructionsContent = "
	This level will teach you about the NAND gate.
	The NAND gate is a combination of an AND gate followed by an NOT gate.
	Try completing this level with both a NAND gate and a combination of an AND gate and a NOT gate.
	";
	showInstructions()
