class_name Player extends CharacterBody3D

@export_group("Stats")
@export var money: int = 0
@export var luck: int = 0

@export_group("Properties")
@export var moveSpeed: float = 1.0
@export var gravity: float = 4.0

@onready var mesh_inst: MeshInstance3D = $MeshInst
@onready var interact_area: Area3D = $InteractArea

var canInteract: bool = false

var facingAngle: float
var fallingMomentum: float = 0.0

var input: Vector2
var dir: Vector3

func _physics_process(delta: float) -> void:
	input = Input.get_vector(&"move_left", &"move_right", &"move_forward", &"move_backward")
	dir = Vector3(input.x, 0, input.y)
	
	# rotate model to facing direction
	mesh_inst.rotation.y = lerp_angle(mesh_inst.rotation.y, facingAngle, 0.25)
	
	if (!interact_area.get_overlapping_bodies().is_empty()):
		canInteract = true
	else:
		canInteract = false
	
	# move the body
	move_and_slide()
