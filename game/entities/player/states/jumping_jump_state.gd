class_name JumpingJumpState
extends State


## BEHAVIORS
func enter() -> void:
	print("JUMPING (enter)")
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


func process_physics(delta):
	var is_jump_just_pressed: bool = Input.is_action_just_pressed("up")

	## Add the gravity
	parent.velocity.y += gravity * delta

	parent.move_and_slide()

	#if is_jump_just_pressed and parent.velocity.y > jump_velocity:
		#transitioned.emit("DoubleJumpingJumpState", self)

	if parent.is_on_floor():
		print("JUMPING (is_on_floor) condition")
		print("JUMPING (transitioning) idling")
		transitioned.emit("IdlingJumpState", self)
