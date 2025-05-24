class_name player_attack extends Node2D

signal AttackMissed
signal AttackConnected

@export var attack_animation_player: AnimationPlayer
@export var hurtbox: HurtBox

var player
var attack_connected = false

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if !hurtbox:
		print("Player's attack hurtbox is misconfigured.")
		return
	get_node("Hurtbox").connect("OnHitConnect", _attack_connected)
	
	attack_animation_player.connect("animation_finished", _on_animation_finished)

func _physics_process(delta: float) -> void:
	pass

func attack(animation_speed: float, damage: int):
	if !attack_animation_player || !hurtbox:
		print("The animation player or hurtbox is misconfigured.")
		return
	
	hurtbox.damage = damage
	apply_hulk_multiplier()
	
	attack_animation_player.speed_scale = animation_speed
	hurtbox.setId(Time.get_unix_time_from_system() + (randi() % 1000))
	attack_animation_player.play("attack")
	
func direct_weapon():
	var direction = (get_global_mouse_position() - global_position).angle()
	rotation = direction + PI/2
	
func _on_animation_finished(animation_name: String):
	if attack_connected:
		AttackConnected.emit()
	else:
		AttackMissed.emit()
	if (animation_name == "attack"):
		queue_free()

func _attack_connected():
	attack_connected = true
	
func apply_hulk_multiplier():
	var hulk : Hulk = NodeFunctions.search_for_child_of_type(player, Hulk)
	if hulk != null:
		var is_x_flipped = get_attack_is_x_flipped()
		scale = Vector2(hulk.size_multiplier, hulk.size_multiplier)
		if is_x_flipped:
			scale.x *= -1

func get_attack_is_x_flipped():
	return scale.x < 0
