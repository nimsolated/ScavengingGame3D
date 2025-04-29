class_name StateMachine extends Node

func enterState(stateName: StringName) -> bool:
	if get_children().is_empty():
		return false
	
	var success: bool = false
	
	for child in get_children():
		if (child is State && child.name == stateName):
			child.enabled = true
			SignalBus.emit_signal(&"stateEntered", child.name)
			success = true
			break
	
	return success

func exitState(stateName: StringName) -> bool:
	if get_children().is_empty():
		return false
	
	var success: bool = false
	
	for child in get_children():
		if (child is State && child.name == stateName):
			child.enabled = false
			SignalBus.emit_signal(&"stateExitted", child.name)
			success = true
			break
	
	return success

func clearStates() -> void:
	if get_children().is_empty():
		return
	
	for child in get_children():
		if child is State && child.enabled:
			child.enabled = false
			SignalBus.emit_signal(&"stateExitted", child.name)
