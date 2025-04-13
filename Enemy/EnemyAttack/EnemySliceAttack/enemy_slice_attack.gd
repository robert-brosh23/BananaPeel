extends enemy_attack

const DEFAULT_ANIMATION_TIME = 0.3

var animation_time

func _ready() -> void:
	super._ready()
	animation_time = DEFAULT_ANIMATION_TIME

func attack():
	super.attack()
	
func calculate_attack_speed():
	# Attack animation should take up 3/10 of the total attack cooldown.
	return animation_time / (attack_cooldown * 3 / 10)
