extends CharacterBody2D

enum PlayerState {
	MOVING,
	STANDING
}

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var state: PlayerState = PlayerState.STANDING
var direction: Direction = Direction.DOWN

var moving_timer = 0

const MOVE_TIMER = 32

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _direction_vector(d: Direction):
	match d:
		Direction.UP:
			return Vector2.UP
		Direction.DOWN:
			return Vector2.DOWN
		Direction.LEFT:
			return Vector2.LEFT
		Direction.RIGHT:
			return Vector2.RIGHT


func _process(_delta):
	var move_vector = Vector2.ZERO
	if state == PlayerState.STANDING:
		if Input.is_action_pressed("move_up"):
			_try_start_move(Direction.UP)
		elif Input.is_action_pressed("move_down"):
			_try_start_move(Direction.DOWN)
		elif Input.is_action_pressed("move_left"):
			_try_start_move(Direction.LEFT)
		elif Input.is_action_pressed("move_right"):
			_try_start_move(Direction.RIGHT)
	
	if state == PlayerState.MOVING:
		move_vector += _direction_vector(direction)
		moving_timer -= 1
		if moving_timer == 0:
			state = PlayerState.STANDING
	
	if move_vector.length() > 0:
		position = position.round()
		move_vector = move_vector.normalized()
		var mac = move_and_collide(move_vector, false, -0.0001)
		if mac != null:
			push_warning("player's intermediate move triggered a collider")

func _try_start_move(dir: Direction):
	var dir_vec = _direction_vector(dir)
	var vec32 = dir_vec * 32
	var test_mac = move_and_collide(vec32, true, 0)
	if test_mac == null:
		direction = dir
		state = PlayerState.MOVING
		moving_timer = MOVE_TIMER
	else:
		print("preventing movement")
