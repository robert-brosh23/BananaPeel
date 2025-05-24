class_name Enemy extends CharacterBody2D

signal Defeated(experience)

@export var max_health: int
@export var experience_given: int
@export var attack: enemy_attack
@export var damage_label_scene: PackedScene

@onready var state_machine = $StateMatchine
@onready var enemy_follow_state = $StateMatchine/EnemyFollowState
@onready var spriteBody = $Sprite2D

var health: int
var speed = 30
var player: Player
var attacking: bool = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	$Hitbox.Damaged.connect(TakeDamage)
	health = max_health

func _physics_process(delta: float) -> void:
	if state_machine.active_state is EnemyAttackState:
		attacking = true
	else:
		attacking = false
	
	move_and_slide()

func TakeDamage(damaged: int) -> void:
	damaged = calculateDamageTaken(damaged)
	play_take_damage_visual_effect(damaged)
	health -= damaged
	if health <= 0:
		emit_signal("Defeated", experience_given)
		queue_free()
		
func calculateDamageTaken(damaged: int) -> int:
	return damaged * (.8 + .1 * randi_range(0,4))
		
func get_attack_cooldown() -> float:
	return attack.attack_cooldown
	
func try_attack():
	attack.attack()

func play_take_damage_visual_effect(damaged: int):
	var damage_label: EnemyDamageLabel = damage_label_scene.instantiate()
	get_tree().root.add_child(damage_label)
	damage_label.position = position
	damage_label.playDamageAnimation(damaged)
	
	spriteBody.modulate = Color(255,255,1.0,1.0)
	var timer = Timer.new()
	timer.wait_time = .05  # seconds
	timer.one_shot = true
	timer.timeout.connect(_on_damage_flash_timer_timeout)
	add_child(timer)
	timer.start()

func _on_damage_flash_timer_timeout():
	spriteBody.modulate = Color(1.0, 1.0, 1.0, 1.0)
