class_name CodeBlockContainer extends Control

@export var code_block: CodeBlock:
	set(value):
		if value != null:
			value.mouse_filter = MOUSE_FILTER_IGNORE
		code_block = value

func _ready() -> void:
	if code_block != null:
		code_block.mouse_filter = MOUSE_FILTER_IGNORE

func put_code_block(code_block: CodeBlock):
	add_child(code_block)
	self.code_block = code_block
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	print("dragging2")
	return data is CodeBlock
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	code_block = data
