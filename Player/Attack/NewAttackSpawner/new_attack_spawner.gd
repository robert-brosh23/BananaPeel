class_name NewAttackSpawner extends Node2D

signal AttackMissed
signal AttackHit
signal DoAttack

@export var attack_scene: PackedScene

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta: float) -> void:
	global_position = player.global_position

func prepare_attack(attack_damage: int):
	var attack = attack_scene.instantiate()
	add_child(attack)
	attack.connect("AttackConnected", _attack_connected)
	attack.connect("AttackMissed", _attack_missed)
	DoAttack.emit()
	do_attack(attack, attack_damage, 1.0, (get_global_mouse_position() - player.global_position).angle() + PI/2)
	
func direct_weapon():
	var direction = (get_global_mouse_position() - global_position).angle()
	rotation = direction + PI/2
	
func do_attack(attack: player_attack, attack_damage: int, animation_speed: float, rotation: float = 0):
	attack.rotation = rotation
	attack.attack(animation_speed, attack_damage)
	
func _attack_connected():
	AttackHit.emit()
	
func _attack_missed():
	AttackMissed.emit()
