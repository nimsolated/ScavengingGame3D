class_name Player extends CharacterBody3D

@export var states: StateMachine = null
@export_group("Stats")
@export var money: int = 0
@export var luck: int = 0

@export_group("Properties")
@export var moveSpeed: float = 6.0
@export var gravity: float = 8.0

@onready var mesh_inst: MeshInstance3D = $MeshInst
@onready var interact_area: Area3D = $InteractArea

var facingAngle: float

var fallingMomentum: float = 0.0

func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	var dir: Vector3 = Vector3(input.x, 0, input.y)
	
	# handle fall momentum
	if (is_on_floor()):
		fallingMomentum = 0
		states.exitState(&"Airborne")
	else:
		fallingMomentum += gravity * delta
		states.enterState(&"Airborne")
		states.exitState(&"Idle")
		states.exitState(&"Walking")
	
	# handle switching between idle and walking
	if (input == Vector2.ZERO && !states.isInState(&"Airborne")):
		states.enterState(&"Idle")
		states.exitState(&"Walking")
	elif (input != Vector2.ZERO):
		if (!states.isInState(&"Using") && !states.isInState(&"Interacting")):
			states.enterState(&"Walking")
			states.exitState(&"Idle")
	
	# handle movement input and direction
	if (states.isInState(&"Walking")):
		# normalize the direction,
		# multiply it by player's move speed
		# assign the product to velocity
		velocity = dir.normalized() * moveSpeed
	else:
		velocity = Vector3(0, velocity.y, 0)
	
	# set facing direction
	if input.length() > 0:
		facingAngle = Vector2(-input.y, -input.x).angle()
	
	# rotate model to facing direction
	mesh_inst.rotation.y = lerp_angle(mesh_inst.rotation.y, facingAngle, 0.25)
	
	# handle using
	if (Input.is_action_pressed(&"use")):
		if (!states.isInState(&"Walking") && !states.isInState(&"Interacting")):
			states.enterState(&"Using")
	else:
		states.exitState(&"Using")
	
	# interact
	if (Input.is_action_pressed(&"interact")):
		if (!states.isInState(&"Walking") && !states.isInState(&"Using")):
			states.enterState(&"Interacting")
			var interactedNode: Interactable = getClosestInteractable()
			if interactedNode:
				interactedNode._interact()
	else:
		states.exitState(&"Interacting")
	
	# add the falling momentum to velocity
	velocity.y = -fallingMomentum
	
	# move the body
	move_and_slide()

func getClosestInteractable() -> Interactable:
	if (interact_area.get_overlapping_bodies().is_empty()):
		return null
	
	var temp: Interactable = interact_area.get_overlapping_bodies()[0]
	
	for i: Interactable in interact_area.get_overlapping_bodies():
		if (distanceTo(i) < distanceTo(temp)):
			temp = i
	
	return temp

func distanceTo(node: Interactable):
	return abs(position.direction_to(node.position))
