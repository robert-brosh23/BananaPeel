class_name EnemyDamageLabel extends Control

@export var damage_label: Label

func playDamageAnimation(damage: int) -> void:
	damage_label.text = str(damage)
	var fade_tween = get_tree().create_tween()
	var color = Color(1,1,1,0)
	var delay_time = 0.3
	var fade_time = 0.2
	fade_tween.finished.connect(_on_tween_finished)
	
	var move_tween = get_tree().create_tween()
	move_tween.set_ease(Tween.EASE_IN)
	var position = Vector2(damage_label.position.x, damage_label.position.y - 10)
	var move_time = 0.5
	
	fade_tween.tween_property(damage_label, "modulate", color, fade_time).set_delay(delay_time)
	move_tween.tween_property(damage_label, "position", position, move_time)

func _on_tween_finished():
	queue_free()
