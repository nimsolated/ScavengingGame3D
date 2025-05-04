extends State

@export var idleState: State = null

func _update(delta: float) -> void:
	if (Input.is_action_just_released(&"interact")):
		isActive = false
		idleState.isActive = true
		return
	
	var interactedNode: Interactable = getClosestInteractable()
	if interactedNode:
		interactedNode._interact()
		SignalBus.emit_signal(&"interactedNode", interactedNode)

func getClosestInteractable() -> Interactable:
	if (player.interact_area.get_overlapping_bodies().is_empty()):
		return null
	
	var temp: Interactable = player.interact_area.get_overlapping_bodies()[0]
	
	for i: Interactable in player.interact_area.get_overlapping_bodies():
		if (distanceTo(i) < distanceTo(temp)):
			temp = i
	
	return temp

func distanceTo(node: Interactable):
	return abs(player.position.direction_to(node.position))
