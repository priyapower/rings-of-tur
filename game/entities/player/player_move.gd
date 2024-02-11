class_name PlayerMove
extends MoveInterface

## Return the desired direction of movement for the character
## in the range [-1, 1], where positive values indicate a desire
## to move to the right and negative values to the left.
func get_horizontal_movement() -> float:
	return Input.get_axis('left', 'right')


## Return a boolean indicating if the character wants to upward
func wants_upward_movement() -> bool:
	return Input.is_action_just_pressed('up')
