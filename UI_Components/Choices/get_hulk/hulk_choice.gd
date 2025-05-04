extends Choice

const SCALE_INCREASE = 0.1

var player: Player
@export var on_hit_buff: PackedScene

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_pressed() -> void: 
	var hulk : Hulk = NodeFunctions.search_for_child_of_type(player, Hulk)
	if hulk:
		hulk.size_multiplier += SCALE_INCREASE
		
	var buff : Hulk = on_hit_buff.instantiate()
	buff.size_multiplier += SCALE_INCREASE
	player.add_child(buff)
	super._on_pressed()
