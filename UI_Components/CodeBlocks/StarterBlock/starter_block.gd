class_name StarterBlock extends CodeBlock

var timer: Timer


func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	order = 0
	
func _on_timer_timeout():
	process_block(1.0)
	for child in childBlocks:
		child.process_block(1)

func play_process_visual_effect():
	colorRect.color = Color(1,1,1,1.0)
	var timer = Timer.new()
	timer.wait_time = .05  # seconds
	timer.one_shot = true
	timer.timeout.connect(_on_damage_flash_timer_timeout)
	add_child(timer)
	timer.start()
	timer.timeout.connect(timer.queue_free)

func _on_damage_flash_timer_timeout():
	colorRect.color = Color(0, 0, 0, 1.0)
