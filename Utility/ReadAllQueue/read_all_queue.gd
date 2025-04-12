class_name ReadAllQueue extends Node

@export var size: int

var values: Array[int]

# store the x most recent values
func _ready():
	for i in range(size):
		values.push_back(0)
	

func push(value: int) -> void:
	values.push_back(value)
	values.pop_front()
	
func checkForMatch(value: int) -> bool:
	for i in values.size():
		if value == values[i]:
			return true
	return false

func printAll() -> void:
	for i in values.size():
		print(values[i])
	print()
		
