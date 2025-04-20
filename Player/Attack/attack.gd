class_name player_attack extends Node2D

signal AttackMissed
signal AttackConnected

@export var attack_animation_player: AnimationPlayer
@export var hurtbox = Area2D

var attack_connected = false

func _ready() -> void:
	if !hurtbox:
		print("Player's attack hurtbox is misconfigured.")
		return
	get_node("Hurtbox").connect("OnHitConnect", _attack_connected)
	
	attack_animation_player.connect("animation_finished", _on_animation_finished)

func _physics_process(delta: float) -> void:
	pass

func attack(animation_speed: float):
	if !attack_animation_player || !hurtbox:
		print("The animation player or hurtbox is misconfigured.")
		return
		
	direct_weapon()
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
