extends Node

# true when the player is loaded, and a menu that pauses the game is open.
var paused = false;
const gridSize = 64

const LEVELS = [
	["res://scenes/levels/tutorial_and.tscn", "Tutorial 1: AND"],
	["res://scenes/main_menu/main_menu.tscn", "Back to Main Menu"]
]
var curLevel: int = 0
