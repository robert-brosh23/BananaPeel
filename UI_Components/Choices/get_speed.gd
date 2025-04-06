extends Choice

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	player.speed += 100.0
	super._on_pressed()
