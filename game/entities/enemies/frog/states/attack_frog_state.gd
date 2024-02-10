class_name AttackingFrogState
extends State


## BEHAVIORS
#func enter() -> void:
	#super()
	#var horizontal_direction = move_component.get_horizontal_movement()
	### Begin moving towards playable_body
	#parent.velocity.x = horizontal_direction * run_speed


func process_physics(_delta) -> State:
	var horizontal_direction = move_component.get_horizontal_movement()
	## Begin moving towards playable_body
	parent.velocity.x = horizontal_direction * run_speed

	if parent.chase == true:
		## Handle horizontal_direction of enemy movement/animation
		if horizontal_direction > 0:
			## Flip right
			parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
		else:
			## Flip left
			parent.sprite.scale.x = abs(parent.sprite.scale.x)
			
	else:
		## Handle transitions
		parent.velocity.x = 0
		if parent.dead == true:
			transitioned.emit("DyingFrogState", self)
		else:
			transitioned.emit("IdlingFrogState", self)

	return null
