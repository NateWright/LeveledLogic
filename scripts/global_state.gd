extends Node

# true when the player is loaded, and a menu that pauses the game is open.
var paused = false;
const gridSize = 64

const LEVELS = [
	["res://scenes/levels/tutorial_wire.tscn", "Tutorial 0: Wires"],
	["res://scenes/levels/tutorial_not.tscn", "Tutorial 1: NOT"],
	["res://scenes/levels/tutorial_and.tscn", "Tutorial 2: AND"],
	["res://scenes/levels/tutorial_or.tscn", "Tutorial 3: OR"],
	["res://scenes/levels/tutorial_xor.tscn", "Tutorial 4: XOR"],
	["res://scenes/levels/tutorial_nand.tscn", "Tutorial 5: NAND"],
	["res://scenes/levels/tutorial_nor.tscn", "Tutorial 6: NOR"],
	["res://scenes/levels/tutorial_xnor.tscn", "Tutorial 7: XNOR"]
	
]
var curLevel: int = 0

var instructionsContent = ""
var instructionsTitle = ""
