# Running state
extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State

func process_input(event: InputEvent) -> State:
	# Handle sprite direction
	if event.is_action_pressed("left"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x) * -1
	if event.is_action_pressed("right"):
		parent.sprite.scale.x = abs(parent.sprite.scale.x)

	return null

func process_physics(delta: float) -> State:
	var horizontal_direction = Input.get_axis('left', 'right')
	var no_vertical_movement = parent.velocity.y == 0
	
	# Add the gravity
	parent.velocity.y += gravity * delta
	
	# Handle jump
	if horizontal_direction != 0:
		parent.velocity.x = horizontal_direction * run_speed
		parent.move_and_slide()
	
	# Handle state transitions
	if (no_vertical_movement && horizontal_direction == 0):
		move_toward(parent.velocity.x, 0, run_speed)
		return idle_state
	if Input.is_action_just_pressed('jump'):
		return jump_state
	if !parent.is_on_floor() && parent.velocity.y > 0:
		return fall_state
	
	return null
