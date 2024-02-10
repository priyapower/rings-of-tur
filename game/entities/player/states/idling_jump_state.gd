class_name IdlingJumpState
extends State


## BEHAVIORS
func enter() -> void:
	super()
	## Reset velocity when entering the state
	parent.velocity.x = 0


func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	## Save if player inputs "up" command
	var is_jump_just_pressed: bool = move_component.wants_upward_movement()

	## Add gravity and movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	## Handle transitions
	if parent.is_on_floor():
		if is_jump_just_pressed:
			transitioned.emit("JumpingJumpState", self)
	else:
		if (parent.velocity.y > 0) && !parent.is_on_ceiling():
			transitioned.emit("FallingJumpState", self)

	return null
