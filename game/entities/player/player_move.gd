class_name PlayerMove
extends MoveInterface

## Return the desired direction of movement for the character
## in the range [-1, 1], where positive values indicate a desire
## to move to the right and negative values to the left.
func get_horizontal_movement() -> float:
	return Input.get_axis('left', 'right')


## Returns a boolean indicating if the entity wants horizontal movement (left/right)
func is_horizontal_movement() -> bool:
	return Input.is_action_just_pressed('left') or Input.is_action_just_pressed('right')


## Return a boolean indicating if the entity wants upward movement (jump/climb)
func is_upward_movement() -> bool:
	return Input.is_action_just_pressed('up')
