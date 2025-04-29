class_name Player extends CharacterBody3D

@export var moveSpeed: float = 6.0
@export var gravity: float = 8.0

@export var states: Node = null

var fallingMomentum: float = 0.0

func _physics_process(delta: float) -> void:
	var direction: Vector3 = Vector3.ZERO
	
	# handle moving forward or backward
	if (Input.is_action_pressed(&"move_forward") && !Input.is_action_pressed(&"move_backward")):
		direction.z = -1
	elif (Input.is_action_pressed(&"move_backward") && !Input.is_action_pressed(&"move_forward")):
		direction.z = 1
	else:
		direction.z = 0
	
	# handle moving left or right
	if (Input.is_action_pressed(&"move_left") && !Input.is_action_pressed(&"move_right")):
		direction.x = -1
	elif (Input.is_action_pressed(&"move_right") && !Input.is_action_pressed(&"move_left")):
		direction.x = 1
	else:
		direction.x = 0
	
	# normalize the direction,
	# multiply it by player's move speed
	# assign the product to velocity
	velocity = direction.normalized() * moveSpeed
	
	# handle fall momentum
	if (is_on_floor()):
		fallingMomentum = 0
	else:
		fallingMomentum += gravity * delta
	
	velocity.y = -fallingMomentum
	
	# move the body
	move_and_slide()
