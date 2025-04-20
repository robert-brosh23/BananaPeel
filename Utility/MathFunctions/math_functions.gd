class_name MathFunctions extends Node

# x is the input x, y is what the function approaches
static func asymptotic_decay_equation(x: float, y: float, k: float = 1.0) -> float:
	return y + (1.0 - y) * exp(-k * (x - 1.0))
