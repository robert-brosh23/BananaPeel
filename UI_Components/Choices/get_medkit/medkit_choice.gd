extends Choice

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	player.hitpoints += player.max_hitpoints * 0.25
	super._on_pressed()
