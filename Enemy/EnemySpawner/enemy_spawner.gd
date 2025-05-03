extends Node

@export var player: CharacterBody2D
var enemy_scene: Resource

func _ready() -> void:
	enemy_scene = preload("res://Enemy/basic_enemy.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("spawn_enemy"):
		SpawnEnemy()

func SpawnEnemy():
	var x_pos = randi_range(20, 30)
	if randi_range(0,1) == 1:
		x_pos *= -1
	x_pos += player.position.x
	var y_pos = randi_range(20, 30)
	if randi_range(0,1) == 1:
		y_pos *= -1
	y_pos += player.position.y
		
	var enemy = enemy_scene.instantiate()
	enemy.connect("Defeated", _on_enemy_defeated)
	enemy.position = Vector2(x_pos, y_pos)
	add_child(enemy)
	
func _on_enemy_defeated(experience: int):
	player.GainExperience(experience)
