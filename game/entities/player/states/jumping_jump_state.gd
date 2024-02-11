class_name JumpingJumpState
extends State


## BEHAVIORS
func enter() -> void:
	super()
	## Apply velocity to jump only once when entering the state
	parent.velocity.y = -jump_velocity


func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	## Capture if player inputs "up" command
	var is_jump_just_pressed: bool = move_component.wants_upward_movement()
	## Capture horizontal axis integer
	var horizontal_direction = move_component.get_horizontal_movement()

	## Add gravity and movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	## Handle horizontal velocity
	if horizontal_direction != 0:
		parent.velocity.x = horizontal_direction * run_speed
	else:
		parent.velocity.x = 0
		#parent.velocity.x = lerp(parent.velocity.x, 0.0, 0.9)
		#parent.velocity.x = move_toward(parent.velocity.x, 0, run_speed)

	## Handle transitions
	if parent.is_on_floor():
		transitioned.emit("IdlingJumpState", self)
	else:
		if is_jump_just_pressed and parent.velocity.y < jump_velocity:
			transitioned.emit("DoubleJumpingJumpState", self)
		if (parent.velocity.y > 0) && !parent.is_on_ceiling():
			transitioned.emit("FallingJumpState", self)

	return null
