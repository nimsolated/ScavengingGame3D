extends Interactable

@onready var sign_label: Label3D = %SignLabel
@export var text: String = "This is a sign!"
@export var cooldown: float = 2.0

@onready var cdTimer: Timer = %CooldownTimer

func _ready() -> void:
	cdTimer.one_shot = true
	cdTimer.connect("timeout", _on_cdTimer_timeout)
	sign_label.text = text
	sign_label.hide()

func _interact() -> void:
	sign_label.show()
	cdTimer.start(cooldown)

func _on_cdTimer_timeout() -> void:
	sign_label.hide()
