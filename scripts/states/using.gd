extends State

@export var idleState: State = null

func _update(delta: float) -> void:
	if (Input.is_action_just_released(&"use")):
		isActive = false
		idleState.isActive = true
		return
