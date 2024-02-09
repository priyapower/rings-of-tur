class_name DoubleJumpingJumpState
extends State


## CUSTOMIZABLE VARS
@export var double_jump_velocity_scale: float = 0.8


## BEHAVIORS
func enter() -> void:
	print("DOUBLE JUMP")
	super()
	parent.velocity.y = -(jump_velocity * double_jump_velocity_scale)


func process_input(event: InputEvent) -> State:
	## Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null


func process_physics(delta) -> State:
	## Add the gravity and movement
	parent.velocity.y += gravity * delta
	parent.move_and_slide()

	## Handle transitions
	if parent.is_on_floor():
		transitioned.emit("IdlingJumpState", self)
	else:
		if (parent.velocity.y > 0) && !parent.is_on_ceiling():
			transitioned.emit("FallingJumpState", self)

	return null
