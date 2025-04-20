class_name Player extends CharacterBody2D

@export var speed = 50.0
@export var exp_needed_for_level = 100
@export var attack_spawner: AttackSpawner
@export var max_hitpoints := 100
@export var hitbox: Area2D

@onready var level_up_menu = get_tree().get_first_node_in_group("LevelUpMenu")
@onready var game_over_menu = get_tree().get_first_node_in_group("GameOverMenu")
@onready var spriteBody = $AnimatedSprite2D

var experience
var hitpoints: int = max_hitpoints:
	set(value):
		if value < hitpoints:
			pass
		if value > max_hitpoints:
			value = max_hitpoints
		hitpoints = value
		print(hitpoints)
		if hitpoints <= 0:
			game_over_menu.game_over()


func _ready() -> void:
	experience = 0
	hitbox.Damaged.connect(TakeDamage)

func _physics_process(delta: float) -> void:
	process_controls()
	move_and_slide()
	
	
func process_controls():
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	elif Input.is_action_pressed("move_down"):
		velocity.y = speed
	else:
		velocity.y = 0
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	if velocity.x != 0 and velocity.y != 0:
		velocity.x *= 0.7071
		velocity.y *= 0.7071
		
func GainExperience(experience: int):
	self.experience += experience
	if self.experience >= exp_needed_for_level:
		level_up()
	
	
func level_up() -> void:
	experience = experience % exp_needed_for_level
	exp_needed_for_level = exp_needed_for_level + 50
	level_up_menu.level_up()
	
func TakeDamage(damaged: int) -> void:
	play_take_damage_visual_effect()
	hitpoints -= damaged
		
func play_take_damage_visual_effect():
	spriteBody.modulate = Color(255,255,1.0,1.0)
	var timer = Timer.new()
	timer.wait_time = .05  # seconds
	timer.one_shot = true
	timer.timeout.connect(_on_damage_flash_timer_timeout)
	add_child(timer)
	timer.start()
	timer.timeout.connect(timer.queue_free)

func _on_damage_flash_timer_timeout():
	spriteBody.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func become_invincible(seconds: float, visible: bool = false, start: bool = false) -> void:
	if start:
		hitbox.set_deferred("monitorable", false)
	var flash_time = .1
	if !visible and seconds <= flash_time*2:
		hitbox.set_deferred("monitorable", true)
		return
	var tween = get_tree().create_tween()
	var color = Color(1,1,1,1) if visible else Color(1,1,1,0)
	
	# Tween the 'modulate' property to make it flash
	tween.tween_property(spriteBody, "modulate", color, flash_time)
	tween.tween_callback(become_invincible.bind(seconds - flash_time, !visible))
