extends player_attack

const DEFAULT_ANIMATION_TIME = 0.3

func attack():
	super.attack()
	
func calculate_attack_speed():
	# Attack animation should take up 3/10 of the total attack cooldown.
	return DEFAULT_ANIMATION_TIME / (attack_cooldown * 3 / 10)
