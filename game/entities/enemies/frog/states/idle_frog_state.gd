class_name IdlingFrogState
extends State


## BEHAVIORS
func enter() -> void:
	super()
	## Reset velocity when entering the state
	parent.velocity.x = 0


func process_physics(_delta) -> State:
	## Capture if playable_body has entered collision 
	## detection and which directino to begin moving
	var is_horizontal_movement: float = move_component.get_horizontal_movement()

	## Handle transitions
	if move_component.dead == true:
		transitioned.emit("DyingFrogState", self)
	else:
		if is_horizontal_movement != 0:
			transitioned.emit("AttackingFrogState", self)

	return null
