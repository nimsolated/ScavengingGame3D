class_name State extends Node

@export var isActive: bool = false

func _update() -> void:
	print("[ State::_update() ] <= override this function.")
