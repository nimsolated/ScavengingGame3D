extends State

@export var idleState: State = null
@export var airborneState: State = null

func _update(delta: float) -> void:
	if (player.input == Vector2.ZERO):
		isActive = false
		idleState.isActive = true
		return
	if (!player.is_on_floor()):
		airborneState.isActive = true
		return
	
	# move the player
	player.velocity = player.dir.normalized() * player.moveSpeed
	
	# set facing direction
	if player.input.length() > 0:
		player.facingAngle = Vector2(-player.input.y, -player.input.x).angle()
