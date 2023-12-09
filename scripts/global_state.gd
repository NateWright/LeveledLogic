extends Node

# true when the player is loaded, and a menu that pauses the game is open.
var paused = false;
const gridSize = 64

const LEVELS = [
	["res://scenes/levels/tutorials/tutorial_wire.tscn", "Tutorial 0: Wires"],
	["res://scenes/levels/tutorials/tutorial_not.tscn", "Tutorial 1: NOT"],
	["res://scenes/levels/tutorials/tutorial_and.tscn", "Tutorial 2: AND"],
	["res://scenes/levels/tutorials/tutorial_or.tscn", "Tutorial 3: OR"],
	["res://scenes/levels/comparator.tscn", "Comparator"],
	["res://scenes/levels/demorgans_and.tscn", "De Morgan's Law: AND"],
	["res://scenes/levels/demorgans_or.tscn", "De Morgan's Law: OR"],
	["res://scenes/levels/tutorials/tutorial_xor.tscn", "Tutorial 4: XOR"],
	["res://scenes/levels/binary_encoder.tscn", "Binary Encoder"],
	["res://scenes/levels/binary_decoder.tscn", "Binary Decoder"],
	["res://scenes/levels/adder_half.tscn", "Half Adder"],
	["res://scenes/levels/adder_full.tscn", "Full Adder"],
	["res://scenes/levels/tutorials/tutorial_nand.tscn", "Tutorial 5: NAND"],
	["res://scenes/levels/nand_and.tscn", "NAND Completeness: AND"],
	["res://scenes/levels/nand_or.tscn", "NAND Completeness: OR"],
	["res://scenes/levels/nand_xor.tscn", "NAND Completeness: XOR"],
	["res://scenes/levels/tutorials/tutorial_nor.tscn", "Tutorial 6: NOR"],
	["res://scenes/levels/tutorials/tutorial_xnor.tscn", "Tutorial 7: XNOR"],
	["res://scenes/levels/latch_sr.tscn", "SR Latch"],
	["res://scenes/levels/latch_d.tscn", "D Latch"],
]
var curLevel: int = 0

var instructionsContent = ""
var instructionsTitle = ""
