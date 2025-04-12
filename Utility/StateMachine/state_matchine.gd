class_name StateMachine extends Node

@export var ready_state: State

var active_state
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if !ready_state:
		print("error: configure ready state")
		return
	active_state = ready_state
	active_state.enter()
	
func _process(delta: float) -> void:
	if active_state:
		active_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if active_state:
		active_state.physics_update(delta)

func on_child_transition(state: State, new_state_name: String):
	if state != active_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if active_state:
		active_state.exit()
	new_state.enter()
	active_state = new_state
