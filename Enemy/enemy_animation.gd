extends Node2D

@export var enemy: Enemy
@export var animation_tree: AnimationTree

var last_facing_direction := Vector2(0, -1)

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	if enemy.velocity:
		last_facing_direction = enemy.velocity.normalized()
		
	if enemy.attacking:
		animation_tree.set("parameters/TimeScale/scale", 1.0 / enemy.attack.attack_cooldown)
	else:
		animation_tree.set("parameters/TimeScale/scale", 1.0)
	
	animation_tree.set("parameters/AnimationNodeStateMachine/move_blend/blend_position", last_facing_direction)
	animation_tree.set("parameters/AnimationNodeStateMachine/attack_blend/blend_position", last_facing_direction)
