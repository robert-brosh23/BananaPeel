class_name SlashAttackActionBlock extends ActionBlock

@export var slice_attack_spawner_scene: PackedScene

var player
var slice_attack_spawner
var attack_timer: Timer

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_up_spawner()
	
func _on_attack_timer_timeout():
	process_block(1)

func process_block(multiplier: float):
	slice_attack_spawner.prepare_attack(10.0 * multiplier)
	super(multiplier)

func set_up_spawner():
	slice_attack_spawner = slice_attack_spawner_scene.instantiate()
	player.call_deferred("add_child", slice_attack_spawner)
