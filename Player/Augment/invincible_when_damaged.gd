extends Node

const INVINCIBILITY_TIME = 1.5

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	player.hitbox.connect("Damaged", make_invincible)
	print("Connected:", player.hitbox.is_connected("Damaged", make_invincible))

func make_invincible(damage: int) -> void:
	print("here")
	player.become_invincible(INVINCIBILITY_TIME, false, true)
