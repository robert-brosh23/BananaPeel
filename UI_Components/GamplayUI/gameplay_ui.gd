class_name GameplayUi extends Control

@export var health_bar: ProgressBar
@export var experience_bar: ProgressBar

var player: Player
var gameover_menu: GameOverMenu
var levelup_menu: LevelUpMenu

func _ready() -> void:
	visible = true
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	health_bar.value = 100.0 * player.hitpoints / player.max_hitpoints
	experience_bar.value = 100.0 * player.experience / player.exp_needed_for_level
