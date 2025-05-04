extends State

@export var walkingState: State = null
@export var airborneState: State = null
@export var usingState: State = null
@export var interactingState: State = null

func _update(delta: float) -> void:
	if (player.input != Vector2.ZERO):
		_switchToState(walkingState)
		return
	if (!player.is_on_floor()):
		_switchToState(airborneState)
		return
	if (Input.is_action_pressed(&"use")):
		_switchToState(usingState)
		return
	elif (Input.is_action_pressed(&"interact") && player.canInteract):
		_switchToState(interactingState)
		return
	
	# stop the player
	player.velocity = Vector3(0, player.velocity.y, 0)

func _switchToState(state: State) -> void:
	isActive = false
	state.isActive = true
