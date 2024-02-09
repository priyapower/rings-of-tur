class_name IdlingJumpState
extends State


## BEHAVIORS
func enter() -> void:
	print("IDLING (enter)")
	super()


func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("up")
	#print("IDLING (process_physics) is_jump_just_pressed: ", is_jump_just_pressed)

	## Add the gravity
	parent.velocity.y += gravity * delta
#
	## Handle idle
	parent.move_and_slide()

	if is_jump_just_pressed:
		print("IDLING (is_jump_just_pressed) condition")
		if parent.is_on_floor():
			print("IDLING (is_on_floor) condition")
			print("IDLING (transitioning) jump")
			transitioned.emit("JumpingJumpState", self)
		#else:
			#transitioned.emit("DoubleJumpingJumpState", self)

	return null
