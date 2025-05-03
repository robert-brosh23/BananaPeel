extends Node2D

@export var player: Player
@export var animation_tree: AnimationTree

var last_facing_direction := Vector2(0, -1)

func _physics_process(delta: float) -> void:
	var idle = !player.velocity
	
	if !idle:
		last_facing_direction = player.velocity.normalized()
	
	animation_tree.set("parameters/PlayerStates/run/blend_position", last_facing_direction)
	animation_tree.set("parameters/PlayerStates/idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/TimeScale/scale",  player.speed / 40.0)
