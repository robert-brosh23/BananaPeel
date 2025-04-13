class_name enemy_attack extends Node2D

@export var attack_animation_player: AnimationPlayer
@export var hurtbox = Area2D
@export var attack_cooldown = 1.0
@export var enemy: Enemy

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func attack():
	if !attack_animation_player || !hurtbox:
		print("The animation player or hurtbox is misconfigured.")
		return
	var attack_speed = calculate_attack_speed()
	direct_weapon()
	attack_animation_player.speed_scale = attack_speed
	hurtbox.setId(Time.get_unix_time_from_system() * 1000 + (randi() % 1000))
	attack_animation_player.play("attack")
	
func direct_weapon():
	var direction = (player.position - enemy.position).angle()
	rotation = direction + PI/2
	
# Override with real attack speed
func calculate_attack_speed():
	# Attack animation should take up 3/10 of the total attack cooldown.
	return 1.0
	# return .3 / (attack_cooldown * 3 / 10)
