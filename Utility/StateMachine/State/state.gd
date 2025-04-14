class_name State extends Node

signal Transitioned
signal Enter
signal Exit

func enter() -> void:
	print("Entered state")
	emit_signal("Enter")
	
func exit() -> void:
	print("Exit state")
	emit_signal("Exit")

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
