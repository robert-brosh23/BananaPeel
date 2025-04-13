class_name Choice extends Button

func _on_pressed() -> void:
	var level_up_menu: LevelUpMenu = get_tree().get_first_node_in_group("LevelUpMenu")
	level_up_menu.upgradeChosen()
