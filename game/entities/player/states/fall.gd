extends State

## States ##
@export var idle_state: State
@export var run_state: State

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
	
	# Handle fall
	if !parent.is_on_floor():
		# Add the gravity
		parent.velocity.y += gravity * delta
		
		parent.move_and_slide()
	else:
		# Handle state transitions
		if no_vertical_movement && horizontal_direction == 0:
			return idle_state
		if no_vertical_movement && horizontal_direction != 0:
			return run_state

	return null
