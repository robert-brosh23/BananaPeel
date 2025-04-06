class_name HitBox extends Area2D

signal Damaged(damage: int)

@export var read_all_queue: ReadAllQueue		


func TakeDamage(idOfHurtbox: int, damage: int) -> void:
	if (read_all_queue.checkForMatch(idOfHurtbox)):
		return
	read_all_queue.push(idOfHurtbox)
	read_all_queue.printAll()
	Damaged.emit(damage)
	
