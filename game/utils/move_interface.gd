class_name MoveInterface
extends Node


## Return the desired direction of movement for the character
## in the range [-1, 1], where positive values indicate a desire
## to move to the right and negative values to the left.
func get_horizontal_movement() -> float:
	return 0.0


## Return a boolean indicating if the character wants to jump.
## This function does not decide if the player actually can jump.
func wants_upward_movement() -> bool:
	return false
