class_name Player extends CharacterBody2D

@export var speed = 50.0
@export var exp_needed_for_level = 100
@export var attack: player_attack
@export var max_hitpoints := 100

@onready var level_up_menu = get_tree().get_first_node_in_group("LevelUpMenu")
@onready var game_over_menu = get_tree().get_first_node_in_group("GameOverMenu")

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
		
	if attack:
		attack.attack()
	
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
