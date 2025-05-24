class_name AttackSpawner extends Node2D

signal AttackMissed
signal AttackHit
signal DoAttack

@export var attack_scene: PackedScene

# input for decay function
@export var attack_speed: float = 1.0
@export var attack_damage: int = 1

var attack_timer: Timer

var player
var minimum_animation_time = .4
var starting_animation_time = .5
var minimum_attack_time = .02
var starting_attack_time = 1.5

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_on_attack_timer_timeout)
	add_child(attack_timer)
	prepare_attack()

func _physics_process(delta: float) -> void:
	pass

func prepare_attack():
	var attack_time = calculate_attack_time()
	var animation_time = calculate_animation_time(attack_time)
	var animation_speed = calculate_animation_speed(animation_time)
	
	attack_timer.wait_time = attack_time
	print("attack time", attack_time)
	print("animation_time", animation_time)
	attack_timer.start()
	var overload: Overload = NodeFunctions.search_for_child_of_type(player, Overload)
	if overload != null:
		do_overload_attack(animation_speed, overload.num_attacks)
		return
	
	var attack = attack_scene.instantiate()
	add_child(attack)
	attack.connect("AttackConnected", _attack_connected)
	attack.connect("AttackMissed", _attack_missed)
	DoAttack.emit()
	do_attack(attack, animation_speed, (get_global_mouse_position() - player.global_position).angle() + PI/2)
	
func calculate_attack_time() -> float:
	return 1.0 / attack_speed
	
func direct_weapon():
	var direction = (get_global_mouse_position() - global_position).angle()
	rotation = direction + PI/2
	
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
	
func do_attack(attack: player_attack, animation_speed: float, rotation: float = 0):
	attack.rotation = rotation
	attack.attack(animation_speed, attack_damage)
	
func do_overload_attack(animation_speed: float, num_attacks: int):
	for i in range(num_attacks):
		var attack = attack_scene.instantiate()
		add_child(attack)
		attack.connect("AttackConnected", _attack_connected)
		attack.connect("AttackMissed", _attack_missed)
		DoAttack.emit()
		do_attack(attack, animation_speed, randf_range(0.0, 2*PI))
	
func _on_attack_timer_timeout():
	prepare_attack()
	
func _attack_connected():
	AttackHit.emit()
	
func _attack_missed():
	AttackMissed.emit()
