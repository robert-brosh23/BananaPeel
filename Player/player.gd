class_name Player extends CharacterBody2D

@export var speed = 50.0
@export var exp_needed_for_level = 100
@export var attack: player_attack
@export var max_hitpoints := 100

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
	$Hitbox.Damaged.connect(TakeDamage)

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
	print("exp gained: ", self.experience)
	if self.experience >= exp_needed_for_level:
		level_up()
	
	
func level_up() -> void:
	experience = experience % exp_needed_for_level
	exp_needed_for_level = exp_needed_for_level + 50
	printt("level up!\nexp: ", experience, "/", exp_needed_for_level)
	level_up_menu.level_up()
	
func TakeDamage(damaged: int) -> void:
	play_take_damage_visual_effect()
	print("Player damaged! ", damaged)
	hitpoints -= damaged
		
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
