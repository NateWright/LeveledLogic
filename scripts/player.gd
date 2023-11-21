extends CharacterBody2D

@export var speed = 200

var picked_up: PhysicsBody2D = null

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed

func _physics_process(delta):
	if GlobalState.paused:
		return
	get_input()
	move_and_slide()

func _process(_delta):
	if GlobalState.paused:
		return
	# Check if player should start moving
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Placing and Picking Up Objects
	if input_direction == Vector2.ZERO:
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
