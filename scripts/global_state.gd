extends Node

# true when the player is loaded, and a menu that pauses the game is open.
var paused = false;
const gridSize = 64

const LEVELS = [
	["res://scenes/levels/tutorial_wire.tscn", "Tutorial 0: Wires"],
	["res://scenes/levels/tutorial_and.tscn", "Tutorial 1: AND"],
	["res://scenes/levels/tutorial_or.tscn", "Tutorial 2: OR"],
	["res://scenes/levels/tutorial_nand.tscn", "Tutorial 3: NAND"],
	["res://scenes/levels/tutorial_nor.tscn", "Tutorial 4: NOR"],
	["res://scenes/levels/tutorial_xor.tscn", "Tutorial 5: XOR"],
	["res://scenes/levels/tutorial_xnor.tscn", "Tutorial 6: XNOR"]
	
]
var curLevel: int = 0
