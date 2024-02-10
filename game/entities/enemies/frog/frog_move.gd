class_name FrogMove
extends MoveInterface


@onready var parent = self.get_parent()
var playable_body: CharacterBody2D


## Returns the direction of movement towards the playable_body 
## that has entered the detection collision. This value will be
## in the range [-1, 1], where positive values indicate a desire
## to move to the right and negative values to the left.
func get_horizontal_movement() -> float:
	if playable_body:
		return (playable_body.position - parent.position).normalized().x
	else:
		return 0
	#return (playable_body.position - parent.position).normalized().x


## Return a boolean indicating if the character wants to upward
func wants_upward_movement() -> bool:
	return false
