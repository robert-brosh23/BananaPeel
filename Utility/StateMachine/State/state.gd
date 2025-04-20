class_name State extends Node

signal Transitioned
signal Enter
signal Exit

func enter() -> void:
	emit_signal("Enter")
	
func exit() -> void:
	emit_signal("Exit")

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
