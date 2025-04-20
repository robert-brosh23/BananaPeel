extends Node

const ATTACK_BONUS = 1.0

var player: Player
var attack_spawner: AttackSpawner
var bonus_tracker: float
var stacks = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	attack_spawner = player.attack_spawner
		
	attack_spawner.AttackHit.connect(buff_attack_speed)
	attack_spawner.AttackMissed.connect(reset_attack_speed)
	bonus_tracker = 0
	
func buff_attack_speed():
	if stacks >= 6:
		return
	stacks+=1
	attack_spawner.attack_speed += ATTACK_BONUS
	bonus_tracker += ATTACK_BONUS
	print("attack speed: ", attack_spawner.attack_speed)

func reset_attack_speed():
	stacks = 0
	attack_spawner.attack_speed -= bonus_tracker
	bonus_tracker = 0
	
