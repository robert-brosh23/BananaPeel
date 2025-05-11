class_name EnemyDamageLabel extends Control

@export var damage_label: Label

func playDamageAnimation(damage: int) -> void:
	damage_label.text = str(damage)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	var color = Color(1,1,1,0)
	var delay_time = 0.3
	var fade_time = 0.2
	tween.finished.connect(_on_tween_finished)
	
	tween.tween_property(damage_label, "modulate", color, fade_time).set_delay(delay_time)

func _on_tween_finished():
	queue_free()
