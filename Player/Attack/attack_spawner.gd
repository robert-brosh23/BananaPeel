class_name AttackSpawner extends Node2D

signal AttackMissed
signal AttackHit

@export var attack_scene: PackedScene

# input for decay function
@export var attack_speed: float = 1.0

var attack_timer: Timer

var minimum_animation_time = .4
var starting_animation_time = .5
var minimum_attack_time = .4
var starting_attack_time = 1.5

func _ready() -> void:
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	attack()

func _physics_process(delta: float) -> void:
	pass

func attack():
	var attack_time = calculate_attack_time()
	var animation_time = calculate_animation_time(attack_time)
	var animation_speed = calculate_animation_speed(animation_time)
	
	attack_timer.wait_time = attack_time
	print("attack time", attack_time)
	print("animation_time", animation_time)
	attack_timer.start()
	var attack = attack_scene.instantiate()
	add_child(attack)
	attack.connect("AttackConnected", _attack_connected)
	attack.connect("AttackMissed", _attack_missed)
	attack.attack(animation_speed)
	
func calculate_attack_time() -> float:
	return MathFunctions.asymptotic_decay_equation(attack_speed, .15, .05)
	
func calculate_animation_time(attack_time: float) -> float:
	var y_min = minimum_attack_time
	var y_max = starting_attack_time
	var new_min = minimum_animation_time
	var new_max = starting_animation_time
	var t = (attack_time - y_min) / (y_max - y_min)
	return lerp(new_min, new_max, t)
	
# Override with real attack speed
func calculate_animation_speed(animation_time: float):
	# Attack animation should take up 3/10 of the total attack cooldown.
	return animation_time / starting_animation_time
	
func _on_attack_timer_timeout():
	attack()
	
func _attack_connected():
	AttackHit.emit()
	
func _attack_missed():
	AttackMissed.emit()
