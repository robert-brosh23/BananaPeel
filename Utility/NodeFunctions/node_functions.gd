class_name NodeFunctions

static func search_for_child_of_type(node: Node, type_ref):
	for child in node.get_children():
		if is_instance_of(child, type_ref):
			return child
	return null
