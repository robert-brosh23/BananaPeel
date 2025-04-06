class_name LevelUpMenu extends Control

@onready var choice_1_container = $VBoxContainer/HBoxContainer/Container
@onready var choice_2_container = $VBoxContainer/HBoxContainer/Container2
@onready var choice_3_container = $VBoxContainer/HBoxContainer/Container3

var upgrades = []

func _ready() -> void:
	visible = false
	initializeUpgrades()

func level_up() -> void:
	get_tree().paused = true
	choice_1_container.add_child(loadRandomUpgrade())
	choice_2_container.add_child(loadRandomUpgrade())
	choice_3_container.add_child(loadRandomUpgrade())
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func upgradeChosen() -> void:
	choice_1_container.get_children()[0].queue_free()
	choice_2_container.get_children()[0].queue_free()
	choice_3_container.get_children()[0].queue_free()
	visible = false
	get_tree().paused = false
	
func initializeUpgrades() -> void:
	upgrades.append(preload("res://UI_Components/Choices/get_speed.tscn"))
	
func loadRandomUpgrade() -> Choice:
	var numUpgrades = upgrades.size()
	if numUpgrades == 0:
		return preload("res://UI_Components/Choice.tscn").instantiate()
	var index = randi() % numUpgrades
	var choice = upgrades[index].instantiate()
	upgrades.remove_at(index)
	return choice
	
