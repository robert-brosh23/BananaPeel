extends Choice

var player: Player
@export var on_hit_buff: PackedScene

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void:
	var buff : Hulk = on_hit_buff.instantiate()
	buff.size_multiplier += .2
	player.add_child(buff)
	super._on_pressed()
