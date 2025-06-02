class_name NewSliceAttackSpawner extends NewAttackSpawner

var attackNumber:int = 0

func do_attack(attack: player_attack, attack_damage: int, animation_speed: float, rotation: float = 0):
	attackNumber += 1
	if attackNumber % 2 == 0:
		attack.scale.x *= -1
	super.do_attack(attack, attack_damage, animation_speed, rotation)
	
