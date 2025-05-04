class_name State extends Node

@export var player: Player = null
@export var isActive: bool = false

func _update(delta: float) -> void:
	print("[ State::_update() ] <= override this function.")
