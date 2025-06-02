class_name NumEnemiesPresentConditionalBlock extends ConditionalBlock

const NUM_ENEMIES = 6
const MULTIPLIER = 2

func process_block(multiplier: float):
	if get_tree().get_nodes_in_group("enemy").size() < NUM_ENEMIES:
		return
	
	multiplier *= MULTIPLIER
	for child in childBlocks:
		child.process_block(multiplier)
	super(multiplier)
