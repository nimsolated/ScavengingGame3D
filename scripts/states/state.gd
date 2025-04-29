class_name State extends Node

@export var enabled: bool = false

func _update() -> void:
	print("[ State::_update() ] <= override this function.")
