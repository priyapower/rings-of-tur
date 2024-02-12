class_name MoveInterface
extends Node


## Return the desired direction of movement for the entity
## in the range [-1, 1], where positive values indicate a desire
## to move to the right and negative values to the left.
func get_horizontal_movement() -> float:
	return 0.0


## Returns a boolean indicating if the entity wants horizontal movement (left/right)
func is_horizontal_movement() -> bool:
	return false


## Return a boolean indicating if the entity wants upward movement (jump/climb)
## This function does not decide if the entity actually can jump or climb
func is_upward_movement() -> bool:
	return false
