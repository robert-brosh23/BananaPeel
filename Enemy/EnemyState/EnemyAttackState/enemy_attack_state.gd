class_name EnemyAttackState extends State

@export var enemy: Enemy

var attack_delay_timer: Timer
var attack_recoil_timer: Timer
var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	attack_delay_timer = Timer.new()
	attack_delay_timer.one_shot = true
	attack_delay_timer.wait_time = enemy.get_attack_cooldown()*.66
	add_child(attack_delay_timer)
	
	attack_recoil_timer = Timer.new()
	attack_recoil_timer.one_shot = true
	attack_recoil_timer.wait_time = enemy.get_attack_cooldown()*.33
	attack_recoil_timer.timeout.connect(recoil_finished)
	add_child(attack_recoil_timer)

func physics_update(delta: float) -> void:
	if attack_recoil_timer.is_stopped() && attack_delay_timer.is_stopped():
		enemy.try_attack()
		attack_recoil_timer.start()

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	enemy.attack.direct_weapon()
	attack_delay_timer.start()
	
func recoil_finished():
	if player.position.distance_to(enemy.position) > 50:
		Transitioned.emit(self, "enemyfollowstate")
		return
		
	enter()
	
