extends State

@export var idleState: State = null
@export var walkingState: State = null

func _update(delta: float) -> void:
	# handle fall momentum
	if (player.is_on_floor()):
		player.fallingMomentum = 0
		isActive = false
		idleState.isActive = true
		return
	
	# apply falling momentum
	player.fallingMomentum += player.gravity * delta
	
	# add the falling momentum to velocity
	player.velocity.y = -player.fallingMomentum
	
	# walking state should be active when moving midair
	if (player.input != Vector2.ZERO):
		walkingState.isActive = true
	else:
		walkingState.isActive = false
