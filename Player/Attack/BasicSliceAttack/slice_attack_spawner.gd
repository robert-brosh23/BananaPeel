class_name SliceAttackSpawner extends AttackSpawner

var attackNumber:int = 0

func do_attack(attack: player_attack, animation_speed: float):
	attackNumber += 1
	if attackNumber % 2 == 0:
		attack.scale.x *= -1
	attack.attack(animation_speed)
