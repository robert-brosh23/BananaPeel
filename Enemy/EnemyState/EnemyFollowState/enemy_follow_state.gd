class_name EnemyFollowState extends State

@export var enemy: Enemy

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func physics_update(delta: float) -> void:
	var direction = (player.position - enemy.position).normalized()
	enemy.velocity = direction * enemy.speed
	
	if player.position.distance_to(enemy.position) < 50:
		Transitioned.emit(self, "enemyattackstate")
