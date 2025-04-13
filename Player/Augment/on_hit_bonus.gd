extends Node

const ATTACK_COOLDOWN_REDUCTION = .9

var player
var attack_cooldown_ratio = 1.0
var stacks = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.attack.get_node("Hurtbox").connect("OnHitConnect", buff_attack_speed)
	player.attack.AttackMissed.connect(reset_attack_speed)
	
func buff_attack_speed():
	if stacks >= 6:
		return
	stacks+=1
	player.attack.attack_cooldown *= ATTACK_COOLDOWN_REDUCTION
	attack_cooldown_ratio *= ATTACK_COOLDOWN_REDUCTION

func reset_attack_speed():
	stacks = 0
	player.attack.attack_cooldown /= attack_cooldown_ratio
	attack_cooldown_ratio = 1.0
	
