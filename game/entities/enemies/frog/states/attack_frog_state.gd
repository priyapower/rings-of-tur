class_name AttackingFrogState
extends State


## BEHAVIORS
func process_physics(_delta) -> State:
	var horizontal_direction = move_component.get_horizontal_movement()

	## Handle moving towards playable_body
	parent.velocity.x = horizontal_direction * run_speed

	## Handle sprite flipping
	if horizontal_direction > 0:
		## Flip right
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	else:
		## Flip left
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	## Handle transitions
	if !parent.chase:
		parent.velocity.x = 0
		if parent.dead == true:
			transitioned.emit("DyingFrogState", self)
		else:
			transitioned.emit("IdlingFrogState", self)

	return null
