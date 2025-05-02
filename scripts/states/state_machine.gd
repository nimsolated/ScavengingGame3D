class_name StateMachine extends Node

func _physics_process(delta: float) -> void:
	for i: State in get_children():
		if i.isActive:
			i._update()

func enterState(stateName: StringName) -> bool:
	if get_children().is_empty():
		return false
	
	var success: bool = false
	
	for child: State in get_children():
		if (child is State && child.name == stateName):
			child.isActive = true
			SignalBus.emit_signal(&"stateEntered", child.name)
			success = true
			break
	
	return success

func exitState(stateName: StringName) -> bool:
	if get_children().is_empty():
		return false
	
	var success: bool = false
	
	for child: State in get_children():
		if (child is State && child.name == stateName):
			child.isActive = false
			SignalBus.emit_signal(&"stateExitted", child.name)
			success = true
			break
	
	return success

func isInState(stateName: StringName) -> bool:
	for child: State in get_children():
		if child.name == stateName && child.isActive:
			return true
	
	return false

func clearStates() -> void:
	if get_children().is_empty():
		return
	
	for child: State in get_children():
		if child is State && child.isActive:
			child.isActive = false
			SignalBus.emit_signal(&"stateExitted", child.name)
