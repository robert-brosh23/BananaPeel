extends Control

var codeBlocks: Array[CodeBlock] = []
@export var vboxContainer: VBoxContainer

func _ready() -> void:
	var starterBlock = add_code_block(preload("res://UI_Components/CodeBlocks/StarterBlock/starter_block.tscn").instantiate(), 0)
	var numEnemiesPresentBlock = add_code_block(preload("res://UI_Components/CodeBlocks/CondionalBlock/NumEnemiesPresentCondionalBlock/num_enemies_present_conditional_block.tscn").instantiate(), 0, starterBlock)
	var slashAttackBlock = add_code_block(preload("res://UI_Components/CodeBlocks/ActionBlock/SlashAttackActionBlock/slash_attack_action_block.tscn").instantiate(), 0, numEnemiesPresentBlock)
	

func add_code_block(codeBlock: CodeBlock, indexRelativeToParent: int, parent: CodeBlock = null) -> CodeBlock:
	
	# if it's a first order (starting block)
	if parent == null:
		codeBlocks.append(codeBlock)
		vboxContainer.add_child(codeBlock)
		return codeBlock
		
	var indexOfParent = vboxContainer.get_children().find(parent)
	if indexRelativeToParent + indexOfParent + 1 > vboxContainer.get_children().size():
		print("Error: inserted a codeblock at an index past the list of code blocks. Skipping.")
		return
		
	vboxContainer.add_child(codeBlock)
	vboxContainer.move_child(codeBlock, indexOfParent + indexRelativeToParent + 1)
	
	parent.childBlocks.insert(indexRelativeToParent, codeBlock)
	codeBlock.order = parent.order + 1
	
	return codeBlock
