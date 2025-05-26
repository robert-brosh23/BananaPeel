class_name LevelUpMenu extends Control

@onready var choice_1_container = $VBoxContainer/HBoxContainer/Container
@onready var choice_2_container = $VBoxContainer/HBoxContainer/Container2
@onready var choice_3_container = $VBoxContainer/HBoxContainer/Container3

var upgrades = []
var upgrades_recurring = []
var replacement_upgrades = []
var gameplay_ui: GameplayUi

func _ready() -> void:
	visible = false
	gameplay_ui = get_tree().get_first_node_in_group("GameplayUi")
	initializeUpgrades()

func level_up() -> void:
	gameplay_ui.experience_bar.value = 100.0
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
	replaceRecurringUpgrades()
	visible = false
	get_tree().paused = false
	
func initializeUpgrades() -> void:
	upgrades.append(preload("res://UI_Components/Choices/get_focus.tscn"))
	upgrades.append(preload("res://UI_Components/Choices/get_adapt.tscn"))
	upgrades.append(preload("res://UI_Components/Choices/get_overload/overload_choice.tscn"))
	upgrades.append(preload("res://UI_Components/Choices/get_max_hp/max_hp_choice.tscn"))
	
	upgrades_recurring.append(preload("res://UI_Components/Choices/get_speed.tscn"))
	upgrades_recurring.append(preload("res://UI_Components/Choices/get_hulk/hulk_choice.tscn"))
	upgrades_recurring.append(preload("res://UI_Components/Choices/get_attack_speed/attack_speed_choice.tscn"))
	upgrades_recurring.append(preload("res://UI_Components/Choices/get_attack_damage/attack_damage_choice.tscn"))
	upgrades_recurring.append(preload("res://UI_Components/Choices/get_medkit/get_medkit_choice.tscn"))
	
func loadRandomUpgrade() -> Choice:
	var numUpgrades = upgrades.size() + upgrades_recurring.size()
	if numUpgrades == 0:
		return preload("res://UI_Components/Choice.tscn").instantiate()
	
	var index = randi() % numUpgrades
	var choice
	if index < upgrades.size():
		choice = upgrades[index].instantiate()
		upgrades.remove_at(index)
	else:
		choice = upgrades_recurring[index - upgrades.size()].instantiate()
		replacement_upgrades.append(upgrades_recurring[index - upgrades.size()])
		upgrades_recurring.remove_at(index - upgrades.size())
		
	return choice
	
func replaceRecurringUpgrades() -> void:
	for upgrade in replacement_upgrades:
		print("replace ", upgrade)
		upgrades_recurring.append(upgrade)
	replacement_upgrades.clear()
