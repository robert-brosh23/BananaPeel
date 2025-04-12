class_name Enemy extends CharacterBody2D

signal Defeated(experience)

@export var max_health: int
@export var experience_given: int
@export var attack_cooldown = 1.0

@onready var state_machine = $StateMatchine
@onready var enemy_follow_state = $StateMatchine/EnemyFollowState
@onready var attack_animation_player = $Attack/Sprite2D/AnimationPlayer
@onready var hurtbox = $Attack/Hurtbox
@onready var attack = $Attack
@onready var spriteBody = $Sprite2D

var health: int
var speed = 100
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$Hitbox.Damaged.connect(TakeDamage)
	health = max_health
	print(modulate)

func _physics_process(delta: float) -> void:
	move_and_slide()

func TakeDamage(damaged: int) -> void:
	play_take_damage_visual_effect()
	print("Damaged! ", damaged)
	health -= damaged
	if health <= 0:
		emit_signal("Defeated", experience_given)
		queue_free()
		
func try_attack():
	if !attack_animation_player || !hurtbox:
		print("The animation player or hurtbox is misconfigured.")
		return
	var attack_speed = calculate_attack_speed()
	direct_weapon()
	attack_animation_player.speed_scale = attack_speed
	hurtbox.setId(Time.get_unix_time_from_system() * 1000 + (randi() % 1000))
	attack_animation_player.play("attack")
	
func direct_weapon():
	var direction = (player.position - position).angle()
	attack.rotation = direction + PI/2
	
func calculate_attack_speed():
	# Attack animation should take up 3/10 of the total attack cooldown.
	return .3 / (attack_cooldown * 3 / 10)

func play_take_damage_visual_effect():
	spriteBody.modulate = Color(255,255,1.0,1.0)
	var timer = Timer.new()
	timer.wait_time = .05  # seconds
	timer.one_shot = true
	timer.timeout.connect(_on_damage_flash_timer_timeout)
	add_child(timer)
	timer.start()

func _on_damage_flash_timer_timeout():
	spriteBody.modulate = Color(1.0, 1.0, 1.0, 1.0)
