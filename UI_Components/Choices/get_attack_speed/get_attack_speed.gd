extends Choice

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	player.attack_spawner.attack_speed += 0.2
	super._on_pressed()
