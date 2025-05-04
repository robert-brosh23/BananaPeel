extends Node

const ATTACK_MULTIPLIER_BONUS = 0.1

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
	
	var increase = attack_spawner.attack_speed * ATTACK_MULTIPLIER_BONUS
	attack_spawner.attack_speed += increase
	bonus_tracker += increase

func reset_attack_speed():
	stacks = 0
	attack_spawner.attack_speed -= bonus_tracker
	bonus_tracker = 0
	
