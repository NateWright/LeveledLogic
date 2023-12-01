extends Node

# true when the player is loaded, and a menu that pauses the game is open.
var paused = false;
const gridSize = 64

const LEVELS = [
	["res://scenes/levels/level1.tscn", "Level 1"],
	["res://scenes/main_menu/main_menu.tscn", "Back to Main Menu"]
]
var curLevel: int = 0
