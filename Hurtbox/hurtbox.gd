class_name HurtBox extends Area2D

@export var damage : int = 1

var id: int = 0

func _ready() -> void:
	area_entered.connect(AreaEntered)
	
	
func _process(delta: float) -> void:
	pass
	

func setId(id: int):
	self.id = id


func AreaEntered(a: Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(id, damage)
