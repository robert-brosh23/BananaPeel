extends Choice

var player: Player
@export var invincible_when_damaged_scene: PackedScene

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	var buff = invincible_when_damaged_scene.instantiate()
	player.add_child(buff)
	super._on_pressed()
