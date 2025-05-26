extends Choice

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	player.max_hitpoints += 50
	player.hitpoints += 50
	super._on_pressed()
