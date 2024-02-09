class_name IdlingJumpState
extends State


## BEHAVIORS
func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	## Save if player inputs "up" command
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("up")

	## Add the gravity and movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	## Handle transitions
	if is_jump_just_pressed:
		if parent.is_on_floor():
			transitioned.emit("JumpingJumpState", self)

	return null
