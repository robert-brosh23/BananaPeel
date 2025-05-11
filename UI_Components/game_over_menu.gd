class_name GameOverMenu extends Control

var gameplay_ui: GameplayUi

func _ready() -> void:
	visible = false
	gameplay_ui = get_tree().get_first_node_in_group("GameplayUi")

func game_over() -> void:
	gameplay_ui.health_bar.value = 0.0
	get_tree().paused = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
