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

const MOVE_TIMER = 32


var state: PlayerState = PlayerState.STANDING
var direction: Direction = Direction.DOWN

var moving_timer = 0

var picked_up: PhysicsBody2D = null

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
	# Check if player should start moving
	if state == PlayerState.STANDING:
		if Input.is_action_pressed("move_up"):
			_try_start_move(Direction.UP)
		elif Input.is_action_pressed("move_down"):
			_try_start_move(Direction.DOWN)
		elif Input.is_action_pressed("move_left"):
			_try_start_move(Direction.LEFT)
		elif Input.is_action_pressed("move_right"):
			_try_start_move(Direction.RIGHT)
	
	# Handle player movement
	if state == PlayerState.MOVING:
		var move_vector = _direction_vector(direction)
		moving_timer -= 1
		if moving_timer == 0:
			state = PlayerState.STANDING
		position = position.round()
		move_vector = move_vector.normalized()
		var mac = move_and_collide(move_vector, false, -0.0001)
		if mac != null:
			push_warning("player's intermediate move triggered a collider")
	
	# Placing and Picking Up Objects
	if state == PlayerState.STANDING:
		if Input.is_action_just_pressed("pick_up"):
			var colliding: Array[Node2D] = $Area2D.get_overlapping_bodies()
			if (colliding.size() > 1):
				push_warning("Overlapping tiles")
			if picked_up == null and colliding.size() > 0:
				var colliding_object = colliding[0]
				picked_up = colliding_object
				get_parent().remove_child(colliding_object)
		elif Input.is_action_just_pressed("place", true):
			var colliding: Array[Node2D] = $Area2D.get_overlapping_bodies()
			if picked_up != null and colliding.is_empty():
				get_parent().add_child(picked_up)
				picked_up.position = position
				picked_up = null

func _try_start_move(dir: Direction):
	var dir_vec = _direction_vector(dir)
	var vec32 = dir_vec * 32
	var test_mac = move_and_collide(vec32, true, 0)
	if test_mac == null:
		direction = dir
		state = PlayerState.MOVING
		moving_timer = MOVE_TIMER
