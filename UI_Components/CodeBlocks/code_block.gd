class_name CodeBlock extends Control

const ORDER_OFFSET = 25

@export var colorRect: ColorRect

var childBlocks: Array[CodeBlock] = []
var order = 0:
	set(value):
		colorRect.position.x += ORDER_OFFSET * (value - order)
		colorRect.size.x -= ORDER_OFFSET * (value - order)
		order = value

func process_block(multiplier: float):
	play_process_visual_effect()

func getSizeWithChildren() -> int:
	if childBlocks.size() == 0:
		return 1
	
	var size = 1
	for child in childBlocks:
		size += child.getSizeWithChildren()
		
	return size
	
func play_process_visual_effect():
	colorRect.modulate = Color(255,255,1.0,1.0)
	var timer = Timer.new()
	timer.wait_time = .05  # seconds
	timer.one_shot = true
	timer.timeout.connect(_on_damage_flash_timer_timeout)
	add_child(timer)
	timer.start()
	timer.timeout.connect(timer.queue_free)

func _on_damage_flash_timer_timeout():
	colorRect.modulate = Color(1.0, 1.0, 1.0, 1.0)
