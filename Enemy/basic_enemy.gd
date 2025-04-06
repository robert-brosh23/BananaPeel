extends CharacterBody2D

signal Defeated(experience)

@export var max_health: int
@export var experience_given: int
var health: int

func _ready() -> void:
	$Hitbox.Damaged.connect(TakeDamage)
	health = max_health

func TakeDamage(damaged: int) -> void:
	print("Damaged! ", damaged)
	health -= damaged
	if health <= 0:
		emit_signal("Defeated", experience_given)
		queue_free()
