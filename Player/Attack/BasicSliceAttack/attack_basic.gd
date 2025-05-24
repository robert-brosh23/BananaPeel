extends player_attack

func _ready() -> void:
	super._ready()

func attack(animation_speed: float, damage: int):
	super.attack(animation_speed, damage)
