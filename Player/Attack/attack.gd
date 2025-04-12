class_name player_attack extends Node2D

@export var attack_cooldown = 2.0
@export var attack_animation_player: AnimationPlayer
@export var hurtbox = Area2D

var attack_timer: Timer

func _ready() -> void:
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.wait_time = attack_cooldown
	add_child(attack_timer)

func _physics_process(delta: float) -> void:
	pass

func attack():
	if !attack_timer.is_stopped():
		return
	if !attack_animation_player || !hurtbox:
		print("The animation player or hurtbox is misconfigured.")
		return
	var attack_speed = calculate_attack_speed()
	direct_weapon()
	attack_timer.wait_time = attack_cooldown
	attack_animation_player.speed_scale = attack_speed
	attack_timer.start()
	hurtbox.setId(Time.get_unix_time_from_system() + (randi() % 1000))
	attack_animation_player.play("attack")
	
func direct_weapon():
	var direction = (get_global_mouse_position() - global_position).angle()
	rotation = direction + PI/2
	
func calculate_attack_speed():
	# Attack animation should take up 3/10 of the total attack cooldown.
	return 1.0
	
